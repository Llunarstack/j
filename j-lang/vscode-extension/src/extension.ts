import * as vscode from 'vscode';
import * as path from 'path';
import { exec } from 'child_process';
import { promisify } from 'util';

const execAsync = promisify(exec);

let outputChannel: vscode.OutputChannel;
let diagnosticCollection: vscode.DiagnosticCollection;

export function activate(context: vscode.ExtensionContext) {
    console.log('J Language extension is now active!');

    outputChannel = vscode.window.createOutputChannel('J Language');
    diagnosticCollection = vscode.languages.createDiagnosticCollection('j');

    // Register commands
    context.subscriptions.push(
        vscode.commands.registerCommand('j-lang.runFile', runFile),
        vscode.commands.registerCommand('j-lang.runREPL', runREPL),
        vscode.commands.registerCommand('j-lang.checkSyntax', checkSyntax),
        vscode.commands.registerCommand('j-lang.buildProject', buildProject),
        vscode.commands.registerCommand('j-lang.newProject', newProject),
        vscode.commands.registerCommand('j-lang.formatDocument', formatDocument)
    );

    // Register document formatting provider
    context.subscriptions.push(
        vscode.languages.registerDocumentFormattingEditProvider('j', {
            provideDocumentFormattingEdits(document: vscode.TextDocument): vscode.TextEdit[] {
                return formatDocumentEdits(document);
            }
        })
    );

    // Register hover provider
    context.subscriptions.push(
        vscode.languages.registerHoverProvider('j', {
            provideHover(document, position, token) {
                return provideHover(document, position);
            }
        })
    );

    // Register completion provider
    context.subscriptions.push(
        vscode.languages.registerCompletionItemProvider('j', {
            provideCompletionItems(document, position, token, context) {
                return provideCompletionItems(document, position);
            }
        }, '.', '|', '>')
    );

    // Watch for file saves
    context.subscriptions.push(
        vscode.workspace.onDidSaveTextDocument(document => {
            if (document.languageId === 'j') {
                const config = vscode.workspace.getConfiguration('j-lang');
                if (config.get('enableLinting')) {
                    checkSyntaxForDocument(document);
                }
            }
        })
    );

    // Initial syntax check for open documents
    vscode.workspace.textDocuments.forEach(document => {
        if (document.languageId === 'j') {
            checkSyntaxForDocument(document);
        }
    });
}

async function runFile() {
    const editor = vscode.window.activeTextEditor;
    if (!editor || editor.document.languageId !== 'j') {
        vscode.window.showErrorMessage('No J file is currently open');
        return;
    }

    const filePath = editor.document.fileName;
    const config = vscode.workspace.getConfiguration('j-lang');
    const jPath = config.get<string>('executablePath') || 'j';

    outputChannel.clear();
    if (config.get('showOutputOnRun')) {
        outputChannel.show();
    }

    outputChannel.appendLine(`Running: ${filePath}`);
    outputChannel.appendLine('─'.repeat(50));

    try {
        const { stdout, stderr } = await execAsync(`"${jPath}" run "${filePath}"`);
        if (stdout) {
            outputChannel.appendLine(stdout);
        }
        if (stderr) {
            outputChannel.appendLine('Errors:');
            outputChannel.appendLine(stderr);
        }
        outputChannel.appendLine('─'.repeat(50));
        outputChannel.appendLine('✓ Execution completed');
    } catch (error: any) {
        outputChannel.appendLine('❌ Execution failed:');
        outputChannel.appendLine(error.message);
        vscode.window.showErrorMessage(`Failed to run J file: ${error.message}`);
    }
}

async function runREPL() {
    const config = vscode.workspace.getConfiguration('j-lang');
    const jPath = config.get<string>('executablePath') || 'j';

    const terminal = vscode.window.createTerminal('J REPL');
    terminal.sendText(`${jPath} repl`);
    terminal.show();
}

async function checkSyntax() {
    const editor = vscode.window.activeTextEditor;
    if (!editor || editor.document.languageId !== 'j') {
        vscode.window.showErrorMessage('No J file is currently open');
        return;
    }

    await checkSyntaxForDocument(editor.document);
}

async function checkSyntaxForDocument(document: vscode.TextDocument) {
    const config = vscode.workspace.getConfiguration('j-lang');
    const jPath = config.get<string>('executablePath') || 'j';
    const filePath = document.fileName;

    try {
        const { stdout, stderr } = await execAsync(`"${jPath}" check "${filePath}"`);
        
        // Clear diagnostics if no errors
        if (stdout.includes('No syntax errors')) {
            diagnosticCollection.set(document.uri, []);
        } else if (stderr) {
            // Parse errors and create diagnostics
            const diagnostics: vscode.Diagnostic[] = [];
            const errorLines = stderr.split('\n');
            
            for (const line of errorLines) {
                // Simple error parsing - can be enhanced
                const match = line.match(/line (\d+)/i);
                if (match) {
                    const lineNum = parseInt(match[1]) - 1;
                    const diagnostic = new vscode.Diagnostic(
                        new vscode.Range(lineNum, 0, lineNum, 1000),
                        line,
                        vscode.DiagnosticSeverity.Error
                    );
                    diagnostics.push(diagnostic);
                }
            }
            
            diagnosticCollection.set(document.uri, diagnostics);
        }
    } catch (error: any) {
        // Error checking syntax
        console.error('Syntax check failed:', error);
    }
}

async function buildProject() {
    const workspaceFolder = vscode.workspace.workspaceFolders?.[0];
    if (!workspaceFolder) {
        vscode.window.showErrorMessage('No workspace folder open');
        return;
    }

    const config = vscode.workspace.getConfiguration('j-lang');
    const jPath = config.get<string>('executablePath') || 'j';

    outputChannel.clear();
    outputChannel.show();
    outputChannel.appendLine('Building project...');

    try {
        const { stdout, stderr } = await execAsync(`"${jPath}" build main.j`, {
            cwd: workspaceFolder.uri.fsPath
        });
        
        if (stdout) {
            outputChannel.appendLine(stdout);
        }
        if (stderr) {
            outputChannel.appendLine(stderr);
        }
        
        vscode.window.showInformationMessage('Build completed successfully');
    } catch (error: any) {
        outputChannel.appendLine(`Build failed: ${error.message}`);
        vscode.window.showErrorMessage(`Build failed: ${error.message}`);
    }
}

async function newProject() {
    const projectName = await vscode.window.showInputBox({
        prompt: 'Enter project name',
        placeHolder: 'my-project'
    });

    if (!projectName) {
        return;
    }

    const folderUri = await vscode.window.showOpenDialog({
        canSelectFiles: false,
        canSelectFolders: true,
        canSelectMany: false,
        openLabel: 'Select folder for new project'
    });

    if (!folderUri || folderUri.length === 0) {
        return;
    }

    const config = vscode.workspace.getConfiguration('j-lang');
    const jPath = config.get<string>('executablePath') || 'j';
    const parentFolder = folderUri[0].fsPath;

    try {
        const { stdout } = await execAsync(`"${jPath}" jolt init ${projectName}`, {
            cwd: parentFolder
        });
        
        vscode.window.showInformationMessage(`Project '${projectName}' created successfully`);
        
        // Ask to open the new project
        const openProject = await vscode.window.showInformationMessage(
            'Open new project?',
            'Yes',
            'No'
        );
        
        if (openProject === 'Yes') {
            const projectPath = path.join(parentFolder, projectName);
            vscode.commands.executeCommand('vscode.openFolder', vscode.Uri.file(projectPath));
        }
    } catch (error: any) {
        vscode.window.showErrorMessage(`Failed to create project: ${error.message}`);
    }
}

async function formatDocument() {
    const editor = vscode.window.activeTextEditor;
    if (!editor || editor.document.languageId !== 'j') {
        return;
    }

    const edits = formatDocumentEdits(editor.document);
    const workspaceEdit = new vscode.WorkspaceEdit();
    edits.forEach(edit => {
        workspaceEdit.replace(editor.document.uri, edit.range, edit.newText);
    });
    
    await vscode.workspace.applyEdit(workspaceEdit);
}

function formatDocumentEdits(document: vscode.TextDocument): vscode.TextEdit[] {
    const edits: vscode.TextEdit[] = [];
    
    // Simple formatting: fix indentation
    for (let i = 0; i < document.lineCount; i++) {
        const line = document.lineAt(i);
        const text = line.text;
        
        // Skip empty lines
        if (text.trim().length === 0) {
            continue;
        }
        
        // Calculate proper indentation
        const openBraces = (text.match(/\{/g) || []).length;
        const closeBraces = (text.match(/\}/g) || []).length;
        
        // This is a simple formatter - can be enhanced
        const trimmed = text.trim();
        const currentIndent = text.search(/\S/);
        
        // Keep existing indentation for now
        // A full formatter would need to track scope depth
    }
    
    return edits;
}

function provideHover(document: vscode.TextDocument, position: vscode.Position): vscode.Hover | undefined {
    const range = document.getWordRangeAtPosition(position);
    if (!range) {
        return undefined;
    }

    const word = document.getText(range);
    
    // Built-in function documentation
    const builtins: { [key: string]: string } = {
        'out': 'Print output to console\n\nUsage: `out(value)`',
        'len': 'Get length of a collection\n\nUsage: `len(list)`',
        'sum': 'Sum all elements in a list\n\nUsage: `sum(numbers)`',
        'max': 'Get maximum value\n\nUsage: `max(list)`',
        'min': 'Get minimum value\n\nUsage: `min(list)`',
        'range': 'Create a range of numbers\n\nUsage: `range(start, end)`',
        'map': 'Apply function to all elements\n\nUsage: `list.map(function)`',
        'filter': 'Filter elements by predicate\n\nUsage: `list.filter(predicate)`',
        'group_by': 'Group elements by key function\n\nUsage: `group_by(list, key_fn)`',
        'partition': 'Split list by predicate\n\nUsage: `partition(list, predicate)`'
    };

    if (builtins[word]) {
        return new vscode.Hover(new vscode.MarkdownString(builtins[word]));
    }

    return undefined;
}

function provideCompletionItems(document: vscode.TextDocument, position: vscode.Position): vscode.CompletionItem[] {
    const items: vscode.CompletionItem[] = [];

    // Type completions after |
    const linePrefix = document.lineAt(position).text.substr(0, position.character);
    if (linePrefix.endsWith('|')) {
        const types = ['int', 'float', 'str', 'bool', 'list', 'dict', 'set', 'tuple', 'counter', 'grid'];
        types.forEach(type => {
            const item = new vscode.CompletionItem(type, vscode.CompletionItemKind.TypeParameter);
            item.detail = `${type} type`;
            items.push(item);
        });
    }

    // Built-in functions
    const builtins = ['out', 'print', 'len', 'sum', 'max', 'min', 'range', 'map', 'filter', 'reduce'];
    builtins.forEach(fn => {
        const item = new vscode.CompletionItem(fn, vscode.CompletionItemKind.Function);
        item.detail = 'Built-in function';
        items.push(item);
    });

    // Keywords
    const keywords = ['if', 'else', 'while', 'for', 'fn', 'class', 'trait', 'module', 'import', 'async', 'await'];
    keywords.forEach(kw => {
        const item = new vscode.CompletionItem(kw, vscode.CompletionItemKind.Keyword);
        items.push(item);
    });

    return items;
}

export function deactivate() {
    if (outputChannel) {
        outputChannel.dispose();
    }
    if (diagnosticCollection) {
        diagnosticCollection.dispose();
    }
}
