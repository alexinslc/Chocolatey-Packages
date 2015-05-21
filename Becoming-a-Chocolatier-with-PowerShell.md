## Becoming a Chocolatier with PowerShell.
When it comes to building [Chocolatey] Packages with PowerShell there are many places you can read about how to use Windows `cmd.exe` to build, configure, and maintain them. Personally, I **try** to avoid the Windows Command Prompt simply because I feel that Powershell provides more *power* and functionality on Windows. My newly found interest in [Chocolatey] and love for PowerShell prompted me to write this article.

## The Basics
As far as I know, there are basically 2 different ways to build [Chocolatey] packages.
1. Manually building and maintaining packages using [choco new].
2. Automatically building and maintaining packages using [Chocolatey Package Updater].

In this article, I've outlined how to get started with Chocolatey (choco) using PowerShell. I also make the assumption you are using PowerShell v4.

## Gathering the Ingredients (Prerequisites)
You'll need a few things to become a chocolatier.

1. [Chocolatey]. - The apt-get style package manager for Windows. You are making packages for use with Chocolatey.
2. [Git]. - If you're not using version control, you shouldn't be a maintainer.
3. [Posh-Git]. - This allows you to manage your git repository from PowerShell.
4. [Chocolatey Package Updater].

## Setting up your kitchen. (Environment)
1. **Install Chocolatey**.
  ```powershell
  # Open a PowerShell window **As an Administrator**.
  # Set your ExecutionPolicy to RemoteSigned
  Set-ExecutionPolicy RemoteSigned

  # Install Chocolatey
  Invoke-Expression ((New-Object Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
  ```
2. **Install Git**:

  ```powershell
  # Close and re-open your PowerShell window **As an Administrator**.

  # Install git.
  choco install git -y

  # Add git/bin to your system PATH.
  # You may want to enter these commands one at a time. (Will try to fix later.)
  $RegPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Environment\"
  $Current = (Get-ItemProperty $RegPath).Path
  $New = ($Current + ';C:\Program Files (x86)\Git\bin')
  Set-ItemProperty $RegPath -Name Path -Value $New
  ```

3. **Install Posh-Git**:
  ```powershell
  choco install poshgit -y
  ```

4. **Install Chocolatey Package Updater**:

  ```powershell
  # Install Chocolatey Package Updater.
  choco install chocolateypackageupdater -y
  ```

## Start making packages!
1. [Creating Packages - Manually]
2. [Creating Packages - Automatically]

<!-- Links -->
[Chocolatey]: https://chocolatey.org/
[Git]: http://git-scm.com/
[Posh-Git]: https://github.com/dahlbyk/posh-git
[choco new]: https://github.com/chocolatey/choco/wiki/CreatePackagesQuickStart
[Creating Packages - Manually]: https://github.com/chocolatey/choco/wiki/CreatePackagesQuickStart
[Chocolatey Package Updater]: https://github.com/chocolatey/choco/wiki/AutomaticPackages
[Chocolatey Account Page]: https://chocolatey.org/account
[Creating Packages - Automatically]: https://github.com/chocolatey/choco/wiki/AutomaticPackages
