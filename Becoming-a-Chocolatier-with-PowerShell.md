## Becoming a Chocolatier with PowerShell.
When it comes to building [Chocolatey] Packages with PowerShell there are many places you can read about how to use Windows `cmd.exe` to build, configure, and maintain them. Personally, I **try** to avoid the Windows Command Prompt simply because I feel that Powershell provides more *power* and functionality on Windows. My newly found interest in [Chocolatey] and love for PowerShell prompted me to write this article.

## The Basics
As far as I know, there are basically 2 different ways to build [Chocolatey] packages.
1. Manually building and maintaining packages.
2. Automatically building and maintaining packages using templates.

In this article, I will be focusing on the 2nd way, automatically. I also make the assumption you are using PowerShell v4.

## Gathering the Ingredients (Prerequisites)
You'll need a few things to become a chocolatier.

1. [Chocolatey]. - The apt-get style package manager for Windows. You are making packages for use with Chocolatey.
2. [Git]. - If you're not using version control, you shouldn't be a maintainer.
3. [Posh-Git]. - This allows you to manage your git repository from PowerShell.
4. [WarmUp]. - This helps you define templates and change them as you become a better chocolatier.
5. [Chocolatey Templates].

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
  chocolatey install git

  # Add git/bin to your system PATH.
  # You may want to enter these commands one at a time. (Will try to fix later.)
  $RegPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Environment\"
  $Current = (Get-ItemProperty $RegPath).Path
  $New = ($Current + ';C:\Program Files (x86)\Git\bin')
  Set-ItemProperty $RegPath -Name Path -Value $New
  ```

3. **Install Posh-Git**:
  ```powershell
  chocolatey install poshgit
  ```
4. **Install Warmup**:
  ```powershell
  # Install Warmup
  chocolatey install warmup

  # Configure Warmup. (Set your Package Maintainer Name and Repository)
  warmup addTextReplacement __CHOCO_PKG_MAINTAINER_NAME__ "Your Name"
  warmup addTextReplacement __CHOCO_PKG_MAINTAINER_REPO__ "your/repo" #Ex: "alexinslc/chocolatey-packages"
  ```

5. **Install the Chocolatey Templates**:

   ```powershell
   # Change to your Chocolatey Repo, Ex: cd C:\projects\chocolatey-packages
   cd Path\To\Your\Chocolatey\Repo

   # Download the Chocolatey Templates
   git clone https://github.com/chocolatey/chocolateytemplates.git

   #Enter the _templates Directory
   cd .\chocolateytemplates\_templates

   # Configure templates. This essentially creates some nice symlinks for you.
   warmup addTemplateFolder chocolatey ((pwd).Path + "\chocolatey")
   warmup addTemplateFolder chocolatey3 ((pwd).Path + "\chocolatey3")
   warmup addTemplateFolder chocolateyauto ((pwd).Path + "\chocolateyauto")
   warmup addTemplateFolder chocolateyauto3 ((pwd).Path + "\chocolateyauto3")
   ```

## Molding and Tempering. (Creating your package.)

1. Using your new templates generate your chocolatey package

  ```powershell
  # Use warmup to create a new package template.
  # TemplateName: (chocolatey|chocolatey3|chocolateyauto|chocolateyauto3)
  # Ex: warmup chocolatey Skype
  warmup templateName packageName
  ```
2. Setup your installation files.  

3. Use Chocolatey to create your package.
   ```powershell
   # Change directory to where your .nuspec file is.
   cd Path\To\The\package\.nuspec

   # Create your package file using Chocolatey. This will create a .nupkg file. This is your package!
   chocolatey pack
   ```
## Boxing. (Submitting your package(s) to [Chocolatey.org])

1. Create an account on [Chocolatey.org] and login.
2. 










<!-- Links -->
[Chocolatey]: https://chocolatey.org/
[Chocolatey.org]: https://chocolatey.org/
[Git]: http://git-scm.com/
[Posh-Git]: https://github.com/dahlbyk/posh-git
[WarmUp]: https://github.com/chucknorris/warmup
[Chocolatey Templates]: https://github.com/chocolatey/chocolateytemplates
