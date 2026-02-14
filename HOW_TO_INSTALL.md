# How to Install J Language

Simple guide to install J on your computer.

---

## 🚀 Easy Installation (Windows)

### Method 1: Double-click the Batch File (Easiest)

1. Open File Explorer
2. Navigate to: `j-lang\installers\`
3. **Double-click:** `install.bat`
4. Follow the on-screen instructions
5. Press any key when done

**That's it!** J is now installed.

---

### Method 2: Run PowerShell Script

1. Open PowerShell
2. Navigate to installers:
   ```powershell
   cd j-lang\installers
   ```
3. Run installer:
   ```powershell
   .\install.ps1
   ```
4. Press any key when done

---

## ✅ Verify Installation

Open a **NEW** PowerShell window and run:

```powershell
j --version
```

You should see: `j 0.1.0`

---

## 🎮 Try J

### Start the REPL

```powershell
j repl
```

Try some commands:

```j
> int | x -> 42
> out(x)
42

> str | greeting -> "Hello, J!"
> out(greeting)
Hello, J!
```

Type `exit` to quit.

### Run an Example

```powershell
j run "%LOCALAPPDATA%\J\examples\basic.j"
```

### Create Your First Program

Create a file called `hello.j`:

```j
str | message -> "Hello from J!"
out(message)
```

Run it:

```powershell
j run hello.j
```

---

## 🎨 File Icons

All `.j` files now have the J icon! Look at any `.j` file in File Explorer to see it.

---

## 🐛 Troubleshooting

### "j is not recognized"

**Solution:** Restart your terminal or run:

```powershell
$env:Path = [System.Environment]::GetEnvironmentVariable('Path','User')
```

### Window closes immediately

**Solution:** Use `install.bat` instead of `install.ps1`

### "Execution policy" error

**Solution:** Run PowerShell as Administrator and run:

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

Then try again.

---

## 🗑️ Uninstall

To uninstall J:

```powershell
cd j-lang\installers
.\install.ps1 -Uninstall
```

---

## 📚 Next Steps

- Read: `GET_STARTED.md` for a complete tutorial
- Check: `j-lang\examples\` for more examples
- Visit: Documentation in `docs\` folder

---

## 🎯 What Gets Installed

**Location:** `%LOCALAPPDATA%\J\`

```
J\
├── bin\
│   └── j.exe          ← The J compiler/interpreter
├── examples\
│   ├── basic.j
│   ├── math_utils.j
│   └── ...
└── J_lang_logo.ico    ← Icon for .j files
```

**PATH:** `%LOCALAPPDATA%\J\bin` is added to your PATH

**File Association:** `.j` files are associated with J and show the J icon

---

**Version:** 0.1.0  
**Last Updated:** February 13, 2026

**Enjoy coding with J!** 🚀
