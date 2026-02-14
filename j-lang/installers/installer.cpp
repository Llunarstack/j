// J Language Installer - Windows Native Executable
// Compile with Visual Studio: cl installer.cpp /Fe:j-installer.exe

#include <windows.h>
#include <shlobj.h>
#include <iostream>
#include <string>
#include <filesystem>
#include <fstream>

namespace fs = std::filesystem;

// Function to get Local AppData path
std::wstring GetLocalAppDataPath() {
    wchar_t path[MAX_PATH];
    if (SUCCEEDED(SHGetFolderPathW(NULL, CSIDL_LOCAL_APPDATA, NULL, 0, path))) {
        return std::wstring(path);
    }
    return L"";
}

// Function to add to PATH
bool AddToPath(const std::wstring& pathToAdd) {
    HKEY hKey;
    if (RegOpenKeyExW(HKEY_CURRENT_USER, L"Environment", 0, KEY_READ | KEY_WRITE, &hKey) != ERROR_SUCCESS) {
        return false;
    }

    wchar_t currentPath[32767];
    DWORD size = sizeof(currentPath);
    DWORD type;

    if (RegQueryValueExW(hKey, L"Path", NULL, &type, (LPBYTE)currentPath, &size) != ERROR_SUCCESS) {
        currentPath[0] = L'\0';
    }

    std::wstring pathStr(currentPath);
    if (pathStr.find(pathToAdd) == std::wstring::npos) {
        if (!pathStr.empty() && pathStr.back() != L';') {
            pathStr += L";";
        }
        pathStr += pathToAdd;

        if (RegSetValueExW(hKey, L"Path", 0, REG_EXPAND_SZ, (LPBYTE)pathStr.c_str(), 
            (DWORD)((pathStr.length() + 1) * sizeof(wchar_t))) != ERROR_SUCCESS) {
            RegCloseKey(hKey);
            return false;
        }
    }

    RegCloseKey(hKey);
    
    // Notify system of environment change
    SendMessageTimeoutW(HWND_BROADCAST, WM_SETTINGCHANGE, 0, (LPARAM)L"Environment",
        SMTO_ABORTIFHUNG, 5000, NULL);
    
    return true;
}

// Function to create file association
bool CreateFileAssociation(const std::wstring& installDir) {
    HKEY hKey;
    std::wstring iconPath = installDir + L"\\J_lang_logo.ico";
    std::wstring exePath = installDir + L"\\bin\\j.exe";

    // Create .j extension key
    if (RegCreateKeyExW(HKEY_CURRENT_USER, L"Software\\Classes\\.j", 0, NULL, 0, 
        KEY_WRITE, NULL, &hKey, NULL) == ERROR_SUCCESS) {
        RegSetValueExW(hKey, NULL, 0, REG_SZ, (LPBYTE)L"JSourceFile", 
            (DWORD)((wcslen(L"JSourceFile") + 1) * sizeof(wchar_t)));
        RegCloseKey(hKey);
    }

    // Create JSourceFile key
    if (RegCreateKeyExW(HKEY_CURRENT_USER, L"Software\\Classes\\JSourceFile", 0, NULL, 0,
        KEY_WRITE, NULL, &hKey, NULL) == ERROR_SUCCESS) {
        RegSetValueExW(hKey, NULL, 0, REG_SZ, (LPBYTE)L"J Source File",
            (DWORD)((wcslen(L"J Source File") + 1) * sizeof(wchar_t)));
        RegCloseKey(hKey);
    }

    // Set icon
    if (RegCreateKeyExW(HKEY_CURRENT_USER, L"Software\\Classes\\JSourceFile\\DefaultIcon", 0, NULL, 0,
        KEY_WRITE, NULL, &hKey, NULL) == ERROR_SUCCESS) {
        RegSetValueExW(hKey, NULL, 0, REG_SZ, (LPBYTE)iconPath.c_str(),
            (DWORD)((iconPath.length() + 1) * sizeof(wchar_t)));
        RegCloseKey(hKey);
    }

    // Set open command
    std::wstring command = L"\"" + exePath + L"\" run \"%1\"";
    if (RegCreateKeyExW(HKEY_CURRENT_USER, L"Software\\Classes\\JSourceFile\\shell\\open\\command", 0, NULL, 0,
        KEY_WRITE, NULL, &hKey, NULL) == ERROR_SUCCESS) {
        RegSetValueExW(hKey, NULL, 0, REG_SZ, (LPBYTE)command.c_str(),
            (DWORD)((command.length() + 1) * sizeof(wchar_t)));
        RegCloseKey(hKey);
    }

    return true;
}

// Function to copy file
bool CopyFileWithProgress(const fs::path& source, const fs::path& dest) {
    try {
        fs::create_directories(dest.parent_path());
        fs::copy_file(source, dest, fs::copy_options::overwrite_existing);
        return true;
    }
    catch (...) {
        return false;
    }
}

// Function to copy directory recursively
bool CopyDirectory(const fs::path& source, const fs::path& dest) {
    try {
        fs::create_directories(dest);
        for (const auto& entry : fs::recursive_directory_iterator(source)) {
            const auto& path = entry.path();
            auto relativePath = fs::relative(path, source);
            auto destPath = dest / relativePath;

            if (fs::is_directory(path)) {
                fs::create_directories(destPath);
            }
            else {
                fs::copy_file(path, destPath, fs::copy_options::overwrite_existing);
            }
        }
        return true;
    }
    catch (...) {
        return false;
    }
}

int main() {
    // Set console to UTF-8
    SetConsoleOutputCP(CP_UTF8);

    std::wcout << L"\n";
    std::wcout << L"==================================================\n";
    std::wcout << L"  J Programming Language Installer v0.1.0\n";
    std::wcout << L"==================================================\n";
    std::wcout << L"\n";

    // Get installation directory
    std::wstring localAppData = GetLocalAppDataPath();
    if (localAppData.empty()) {
        std::wcerr << L"ERROR: Could not get LocalAppData path\n";
        std::wcout << L"\nPress Enter to exit...";
        std::cin.get();
        return 1;
    }

    std::wstring installDir = localAppData + L"\\J";
    std::wstring binDir = installDir + L"\\bin";
    std::wstring examplesDir = installDir + L"\\examples";

    std::wcout << L"Install directory: " << installDir << L"\n\n";

    // Find J executable
    std::wcout << L"Looking for J executable...\n";
    
    fs::path exePath;
    std::vector<std::wstring> searchPaths = {
        L"..\\dist\\j-windows-x86_64.exe",
        L"dist\\j-windows-x86_64.exe",
        L"..\\target\\release\\j.exe",
        L"target\\release\\j.exe"
    };

    for (const auto& path : searchPaths) {
        if (fs::exists(path)) {
            exePath = path;
            std::wcout << L"Found: " << path << L"\n";
            break;
        }
    }

    if (exePath.empty()) {
        std::wcerr << L"\nERROR: J executable not found!\n";
        std::wcerr << L"\nPlease build first:\n";
        std::wcerr << L"  cd ..\n";
        std::wcerr << L"  cargo build --release\n";
        std::wcout << L"\nPress Enter to exit...";
        std::cin.get();
        return 1;
    }

    // Create directories
    std::wcout << L"\nCreating directories...\n";
    try {
        fs::create_directories(binDir);
        fs::create_directories(examplesDir);
    }
    catch (const std::exception& e) {
        std::wcerr << L"ERROR: Could not create directories\n";
        std::wcout << L"\nPress Enter to exit...";
        std::cin.get();
        return 1;
    }

    // Copy executable
    std::wcout << L"Installing J executable...\n";
    fs::path destExe = fs::path(binDir) / L"j.exe";
    if (!CopyFileWithProgress(exePath, destExe)) {
        std::wcerr << L"ERROR: Could not copy executable\n";
        std::wcout << L"\nPress Enter to exit...";
        std::cin.get();
        return 1;
    }
    std::wcout << L"Installed: " << destExe.wstring() << L"\n";

    // Copy icon
    std::wcout << L"Copying icon...\n";
    if (fs::exists(L"..\\J_lang_logo.ico")) {
        CopyFileWithProgress(L"..\\J_lang_logo.ico", fs::path(installDir) / L"J_lang_logo.ico");
    }

    // Copy examples
    std::wcout << L"Copying examples...\n";
    if (fs::exists(L"..\\examples")) {
        CopyDirectory(L"..\\examples", examplesDir);
        std::wcout << L"Copied examples to: " << examplesDir << L"\n";
    }

    // Add to PATH
    std::wcout << L"\nAdding to PATH...\n";
    if (AddToPath(binDir)) {
        std::wcout << L"Added to PATH\n";
    }
    else {
        std::wcout << L"Already in PATH or could not add\n";
    }

    // Create file association
    std::wcout << L"Creating file association...\n";
    if (CreateFileAssociation(installDir)) {
        std::wcout << L"File association created (.j files)\n";
    }

    // Verify installation
    std::wcout << L"\nVerifying installation...\n";
    std::wstring verifyCmd = L"\"" + binDir + L"\\j.exe\" --version";
    FILE* pipe = _wpopen(verifyCmd.c_str(), L"r");
    if (pipe) {
        char buffer[128];
        if (fgets(buffer, sizeof(buffer), pipe) != NULL) {
            std::wcout << L"SUCCESS! J is installed\n";
            std::cout << "Version: " << buffer;
        }
        _pclose(pipe);
    }

    // Success message
    std::wcout << L"\n";
    std::wcout << L"==================================================\n";
    std::wcout << L"  Installation Complete!\n";
    std::wcout << L"==================================================\n";
    std::wcout << L"\n";
    std::wcout << L"Next steps:\n";
    std::wcout << L"\n";
    std::wcout << L"1. Restart your terminal\n";
    std::wcout << L"\n";
    std::wcout << L"2. Verify installation:\n";
    std::wcout << L"   j --version\n";
    std::wcout << L"\n";
    std::wcout << L"3. Start the REPL:\n";
    std::wcout << L"   j repl\n";
    std::wcout << L"\n";
    std::wcout << L"4. Run an example:\n";
    std::wcout << L"   j run \"" << examplesDir << L"\\basic.j\"\n";
    std::wcout << L"\n";
    std::wcout << L"Installation directory: " << installDir << L"\n";
    std::wcout << L"\n";

    std::wcout << L"Press Enter to exit...";
    std::cin.get();

    return 0;
}
