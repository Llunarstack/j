# J Language - Homebrew Formula
# Install with: brew install j-lang.rb

class JLang < Formula
  desc "J Programming Language - Modern, safe, fast, and productive"
  homepage "https://github.com/j-lang/j"
  version "0.1.0"
  
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/j-lang/j/releases/download/v0.1.0/j-macos-aarch64"
      sha256 "REPLACE_WITH_ACTUAL_SHA256"
    else
      url "https://github.com/j-lang/j/releases/download/v0.1.0/j-macos-x86_64"
      sha256 "REPLACE_WITH_ACTUAL_SHA256"
    end
  end
  
  on_linux do
    if Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://github.com/j-lang/j/releases/download/v0.1.0/j-linux-aarch64"
        sha256 "REPLACE_WITH_ACTUAL_SHA256"
      else
        url "https://github.com/j-lang/j/releases/download/v0.1.0/j-linux-arm"
        sha256 "REPLACE_WITH_ACTUAL_SHA256"
      end
    else
      if Hardware::CPU.is_64_bit?
        url "https://github.com/j-lang/j/releases/download/v0.1.0/j-linux-x86_64"
        sha256 "REPLACE_WITH_ACTUAL_SHA256"
      else
        url "https://github.com/j-lang/j/releases/download/v0.1.0/j-linux-i686"
        sha256 "REPLACE_WITH_ACTUAL_SHA256"
      end
    end
  end

  def install
    bin.install Dir["*"].first => "j"
    
    # Install examples if available
    if File.directory?("examples")
      (share/"j/examples").install Dir["examples/*"]
    end
    
    # Install documentation
    doc.install "README.md" if File.exist?("README.md")
    doc.install "LICENSE" if File.exist?("LICENSE")
  end

  test do
    assert_match "J Programming Language", shell_output("#{bin}/j --version")
  end

  def caveats
    <<~EOS
      J has been installed!
      
      Get started:
        j repl              # Start interactive REPL
        j run file.j        # Run a J file
        j jolt init myapp   # Create new project
      
      Documentation: https://github.com/j-lang/j
      Examples: #{share}/j/examples
    EOS
  end
end
