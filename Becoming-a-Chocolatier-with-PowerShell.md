## Becoming a Chocolatier with PowerShell.
When it comes to building [Chocolatey] Packages with PowerShell there are many places you can read about how to use Windows `cmd.exe` to build, configure, and maintain them. Personally, I **try** to avoid the Windows Command Prompt simply because I feel that Powershell provides more *power* and functionality on Windows. My newly found interest in [Chocolately] and love for PowerShell prompted me to write this article.

## The Basics
As far as I know, there are basically 2 different ways to build [Chocolatey] packages.
1. Manually building and maintaining packages.
2. Automatically building and maintaining packages.

In this article, I will be focusing on the 2nd way, automatically. I also make the assumption you are using PowerShell v4.

## Gathering the Ingredients (Prerequisites)
You'll need a few things to become a chocolatier.
1. [Chocolatey]. - The apt-get style package manager for Windows. You are making packages for use with Chocolatey.
2. [Git]. - If you're not using version control, you shouldn't be a maintainer.
3. [PSReadLine]. - This adds a lot of great functionality to PowerShell.
4. [Posh-Git]. - This allows you to manage your git repository from PowerShell.
5. [WarmUp]. - This helps you define templates and change them as you become a better chocolatier.
6. [Chocolatey Templates].

## Setting up your kitchen. (Environment)
1. **Install Chocolatey**.

  Open a PowerShell window **As an Administrator**.

  Set your ExecutionPolicy to RemoteSigned and install Chocolatey.
  ```powershell
  Set-ExecutionPolicy RemoteSigned
  Invoke-Expression ((New-Object Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
  ```
2. **Install Git**:

  Close and re-open your PowerShell window **As an Administrator**.

  Install git.
  ```powershell
  chocolatey install git
  ```
3. **Install PSReadLine** (Note To Self: Make Chocolatey Package for this if possible.)

  
<!-- Links -->
[Chocolatey]: https://chocolatey.org/
[PSReadLine]: https://github.com/lzybkr/PSReadLine
[Git]: http://git-scm.com/
[Posh-Git]: https://github.com/dahlbyk/posh-git
[WarmUp]: https://github.com/chucknorris/warmup
[Chocolatey Templates]: https://github.com/chocolatey/chocolateytemplates
[]:


<!-- Information -->
Id CommandLine
-- -----------
D:\projects\chocolatey-packages\chocolateytemplates\_templates
 1 cd D:\projects\chocolatey-packages\
 2 clear
 3 warmup addTextReplacement __CHOCO_PKG_MAINTAINER_NAME__ "Alex Lutz"
 4 warmup addTextReplacement __CHOCO_PKG_MAINTAINER_REPO__ "alexinslc/chocolatey-packages/rvtools"
 5 git clone https://github.com/chocolatey/chocolateytemplates.git
 6 git status
 7 clear
 8 git status
 9 git add chocolateytemplates/*
10 git status
11 cd .\chocolateytemplates\_templates
12 clear
13 pwd
14 (pwd).Path
15 warmup addTemplateFolder chocolatey ((pwd).Path + "\chocolatey")
16 warmup addTemplateFolder chocolatey3 ((pwd).Path + "\chocolatey3")
17 warmup addTemplateFolder chocolateyauto ((pwd).Path + "\chocolateyauto")
18 warmup addTemplateFolder chocolateyauto3 ((pwd).Path + "\chocolateyauto3")
19 choco update atom
20 history
21 Get-ExecutionPolicy
22 git
23 clear
