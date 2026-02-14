#include <windows.h>
#include <shlobj.h>
#include <iostream>
#include <string>
#include <filesystem>
#include <vector>

namespace fs = std::filesystem;

// Link with system libraries
#pragma comment(lib, "shell32.lib")
#pragma comment(lib, "advapi32.lib")
#pragma comment(lib, "user32.lib")

// Helper to add directory to User PATH
bool AddToPath(const std::wstring& binDir) {
    HKEY hKey;
    if (RegOpenKeyExW(HKEY_CURRENT_USER, L"Environment", 0, KEY_READ | KEY_WRITE, &hKey) != ERROR_SUCCESS) {
        return false;
    }

    DWORD type;
    DWORD size = 0;
    RegQueryValueExW(hKey, L"Path", nullptr, &type, nullptr, &size);

    std::vector<wchar_t> pathData(size / sizeof(wchar_t) + 1);
    if (RegQueryValueExW(hKey, L"Path", nullptr, &type, (LPBYTE)pathData.data(), &size) != ERROR_SUCCESS) {
        RegCloseKey(hKey);
        return false;
    }

    std::wstring currentPath(pathData.data());
    if (currentPath.find(binDir) == std::wstring::npos) {
        if (!currentPath.empty() && currentPath.back() != L';') {
            currentPath += L";";
        }
        currentPath += binDir;

        if (RegSetValueExW(hKey, L"Path", 0, REG_EXPAND_SZ, (const BYTE*)currentPath.c_str(), (currentPath.size() + 1) * sizeof(wchar_t)) == ERROR_SUCCESS) {
            RegCloseKey(hKey);
            // Broadcast change so open windows know about it
            SendMessageTimeoutW(HWND_BROADCAST, WM_SETTINGCHANGE, 0, (LPARAM)L"Environment", SMTO_ABORTIFHUNG, 5000, nullptr);
            return true;
        }
    }

    RegCloseKey(hKey);
    return true; // Already in path
}

// Helper to register .j file extension
bool RegisterFileAssociation(const std::wstring& binPath, const std::wstring& iconPath) {
    HKEY hKey;
    
    // 1. Map .j to JSourceFile
    if (RegCreateKeyExW(HKEY_CURRENT_USER, L"Software\\Classes\\.j", 0, nullptr, 0, KEY_WRITE, nullptr, &hKey, nullptr) == ERROR_SUCCESS) {
        const wchar_t* val = L"JSourceFile";
        RegSetValueExW(hKey, nullptr, 0, REG_SZ, (const BYTE*)val, (wcslen(val) + 1) * sizeof(wchar_t));
        RegCloseKey(hKey);
    }

    // 2. Describe JSourceFile
    if (RegCreateKeyExW(HKEY_CURRENT_USER, L"Software\\Classes\\JSourceFile", 0, nullptr, 0, KEY_WRITE, nullptr, &hKey, nullptr) == ERROR_SUCCESS) {
        const wchar_t* val = L"J Source File";
        RegSetValueExW(hKey, nullptr, 0, REG_SZ, (const BYTE*)val, (wcslen(val) + 1) * sizeof(wchar_t));
        RegCloseKey(hKey);
    }

    // 3. Set Icon
    if (RegCreateKeyExW(HKEY_CURRENT_USER, L"Software\\Classes\\JSourceFile\\DefaultIcon", 0, nullptr, 0, KEY_WRITE, nullptr, &hKey, nullptr) == ERROR_SUCCESS) {
        RegSetValueExW(hKey, nullptr, 0, REG_SZ, (const BYTE*)iconPath.c_str(), (iconPath.size() + 1) * sizeof(wchar_t));
        RegCloseKey(hKey);
    }

    // 4. Set Open Command: "path\to\j.exe" run "%1"
    if (RegCreateKeyExW(HKEY_CURRENT_USER, L"Software\\Classes\\JSourceFile\\shell\\open\\command", 0, nullptr, 0, KEY_WRITE, nullptr, &hKey, nullptr) == ERROR_SUCCESS) {
        std::wstring cmd = L"\"" + binPath + L"\" run \"%1\"";
        RegSetValueExW(hKey, nullptr, 0, REG_SZ, (const BYTE*)cmd.c_str(), (cmd.size() + 1) * sizeof(wchar_t));
        RegCloseKey(hKey);
    }

    return true;
}

int main() {
    std::wcout << L"Installing J Language..." << std::endl;

    // 1. Determine Install Paths (%LOCALAPPDATA%\J)
    wchar_t localAppData[MAX_PATH];
    if (SHGetFolderPathW(nullptr, CSIDL_LOCAL_APPDATA, nullptr, 0, localAppData) != S_OK) {
        std::wcerr << L"Failed to get LocalAppData" << std::endl;
        return 1;
    }

    fs::path installDir = fs::path(localAppData) / "J";
    fs::path binDir = installDir / "bin";
    fs::path examplesDir = installDir / "examples";

    try {
        fs::create_directories(binDir);
        fs::create_directories(examplesDir);
    } catch (const std::exception& e) {
        std::cerr << "Error creating directories: " << e.what() << std::endl;
        return 1;
    }

    // 2. Find and Copy Binary
    // Look in ../target/release/j.exe relative to this installer
    fs::path sourceBin = fs::current_path().parent_path() / "target" / "release" / "j.exe";
    if (!fs::exists(sourceBin)) sourceBin = "j.exe"; // Fallback

    if (fs::exists(sourceBin)) {
        try {
            fs::copy_file(sourceBin, binDir / "j.exe", fs::copy_options::overwrite_existing);
            std::wcout << L"✅ Copied binary to " << (binDir / "j.exe").c_str() << std::endl;
        } catch (const std::exception& e) {
            std::cerr << "Error copying binary: " << e.what() << std::endl;
            return 1;
        }
    } else {
        std::wcerr << L"❌ Could not find j.exe to install. Build it first!" << std::endl;
        std::cin.get();
        return 1;
    }

    // 3. Copy Examples
    fs::path sourceExamples = fs::current_path().parent_path() / "examples";
    if (fs::exists(sourceExamples)) {
        try {
            fs::copy(sourceExamples, examplesDir, fs::copy_options::overwrite_existing | fs::copy_options::recursive);
            std::wcout << L"✅ Copied examples." << std::endl;
        } catch (...) {}
    }

    // 3b. Copy Icon
    fs::path sourceIcon = fs::current_path().parent_path().parent_path() / "J_lang_logo.ico";
    std::wstring finalIconPath = (binDir / "j.exe").wstring() + L",0"; // Default to exe icon

    if (fs::exists(sourceIcon)) {
        try {
            fs::copy_file(sourceIcon, installDir / "J_lang_logo.ico", fs::copy_options::overwrite_existing);
            finalIconPath = (installDir / "J_lang_logo.ico").wstring();
            std::wcout << L"✅ Copied icon." << std::endl;
        } catch (...) {}
    }

    // 4. Add to PATH
    if (AddToPath(binDir.wstring())) std::wcout << L"✅ Added to PATH." << std::endl;

    // 5. Register File Associations
    RegisterFileAssociation((binDir / "j.exe").wstring(), finalIconPath);
    std::wcout << L"✅ Registered .j file extension." << std::endl;

    std::wcout << L"\nInstallation Complete! Press Enter to exit..." << std::endl;
    std::cin.get();
    return 0;
}