## Becoming a Chocolatier with PowerShell.
When it comes to building [Chocolatey] Packages with PowerShell there are many places you can read about how to use Windows `cmd.exe` to build, configure, and maintain them. Personally, I **try** to avoid the Windows Command Prompt simply because I feel that Powershell provides more *power* and functionality on Windows. My newly found interest in [Chocolatey] and love for PowerShell prompted me to write this article.

## The Basics
As far as I know, there are basically 2 different ways to build [Chocolatey] packages.
1. Manually building and maintaining packages using [Chocolatey Templates].
2. Automatically building and maintaining packages using [Chocolatey Package Updater].

In this article, I will cover both manually and automatically. I also make the assumption you are using PowerShell v4.

## Gathering the Ingredients (Prerequisites)
You'll need a few things to become a chocolatier.

1. [Chocolatey]. - The apt-get style package manager for Windows. You are making packages for use with Chocolatey.
2. [Git]. - If you're not using version control, you shouldn't be a maintainer.
3. [Posh-Git]. - This allows you to manage your git repository from PowerShell.
4. [WarmUp]. - This helps you define templates and change them as you become a better chocolatier.
5. [Chocolatey Templates].
6. [Chocolatey Package Updater].

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
6. **Install Chocolatey Package Updater**:

  ```powershell
  # Install Chocolatey Package Updater.
  chocolatey install chocolateypackageupdater

  # Configure Chocolatey Package Updater.
  # Open the file C:\tools\ChocolateyPackageUpdater\chocopkgup.exe.config
  # Edit the PackagesFolder to point to your chocolatey repo. Ex: C:\projects\chocolatey-packages
  <add key="PackagesFolder" value="Path\To\Your\Chocolatey\Repo"/>

  # Create new scheduled task for Ketarin to pull updates for your packages. This will create a task  
  # called ChocolateyUpdater that runs once a day at 9AM.
  $Action = New-ScheduledTaskAction -Execute "C:\tools\chocolateypackageupdater\ketarinupdate.cmd"
  $Trigger = New-ScheduledTaskTrigger -Daily -At 9am
  $Settings = New-ScheduledTaskSettingsSet
  $Task = New-ScheduledTask -Action $Action -Trigger $Trigger -Settings $Settings
  Register-ScheduledTask ChocolateyUpdater -InputObject $Task
  ```
7. **Setup and Configure Ketarin for all packages we create**.

  1. Download the [Ketarin Chocolatey Template] to your computer.
  2. Open Ketarin. Choose `File` => `Settings`
  3. Add the Version column to the Ketarin View (Custom Column).
    * On the **General Tab**, click `Add...`
    * In the **Column Name**, enter `Version`
    * In the **Column Value**, enter `{version}`
  4. Click `OK`. This will add the column.
  5. Select the **Commands Tab**.
  6. Set **Edit command for event** to `Before updating an application`
  7. In the **Editor Window** where it has line `1` enter the following:
    ```batch
    chocopkgup /p {appname} /v {version} /u "{preupdate-url}" /u64 "{url64}" /pp "{file}"
    REM /disablepush
    ```

  8. **NOTE:** the commented out `/disablepush`. This is so you can create a few packages and test that everything is working well before actually pushing packages up to chocolatey. You may want to add that to the end of the above command for testing.
  9. Make sure the bottom left button is set to **Command**.
  10. Click `OK`.


## Molding and Tempering. (Creating your packages.)

### Creating an Automatic Package

1. Open Ketarin. Choose `File` => `Import...`
2. Choose the [Ketarin Chocolatey Template] `KetarinChocolateyTemplate.xml`you saved earlier.
3. **IMPORTANT - The name of the job needs to match the name of the package folder EXACTLY.**
4. Right-Click the new job and select `Edit`.
5. The _Download source_ section contains a **URL** field. This is the URL your source file is downloaded from.
   * `https://d13itkw33a7sus.cloudfront.net/dist/1P/win/1Password-{version}.exe`
   * We will gather the `{version}` from the variables.
6. **Set the URL** appropriately. Don't use FileHippo! Try to use the author's original site if possible.
7. Click on `Variables` on the **right** of the URL.
   * On the left side you should see a variable for **version** and one for **url64**.
   * Click **version** and select the appropriate method. **Content from URL (start/end)**.
   * Enter the URL for versioning information.
   * **Breakdown**: We are downloading an HTML page and searching it for a version. #KetarinIsAwesome
   * In the content itself, highlight enough good information before a version to uniquely select it.
   * Click **Use selection as start**
   * Do the same thing with the ending part.
   * Click **Use selection as end**
   * If you have a 64-bit url you want also, do the same for **url64**.
   * Click `OK`
   * Click `OK`

### Testing ChocolateyPackageUpdater / Ketarin

1. Enable the `/disablepush` in Ketarin so we know it won't go to [Chocolatey.org] just yet.
2. Navigate to `C:\ProgramData\chocolateypackgeupdater`.
3. Open **Ketarin**, locate your job, **Right-Click** => **Update**.
4. This _should_ add a chocolatey package to the chocopkgup folder.
5. Verify the package looks good.
6. Verify your scheduled task works correctly.



. Using your new templates generate your chocolatey package

  ```powershell
  # Use warmup to create a new package template.
  # TemplateName: (chocolatey|chocolatey3|chocolateyauto|chocolateyauto3)
  # Ex: warmup chocolatey Skype
  warmup templateName packageName
  ```
. Setup your installation files.  

. Use Chocolatey to create your package.
   ```powershell
   # Change directory to where your .nuspec file is.
   cd Path\To\The\package\.nuspec

   # Create your package file using Chocolatey. This will create a .nupkg file. This is your package!
   chocolatey pack
   ```

## Boxing. (Submitting your package(s) to [Chocolatey.org])

1. Create an account on [Chocolatey.org] and login.
2. On the [Chocolatey Account Page], you should see an **API Key** section, this is where you'll
find **your** Chocolatey community feed key to identify you when maintaining packages.
3. Configure nuget.exe to use your API key and pushing your package to [Chocolatey.org]
  ```powershell
  # Configure nuget to use your API Key.
  nuget setApiKey <Your_API_Key> -Source https://chocolatey.org/

  # Change directory to where your .nupkg file is.
  cd Path\To\The\package\.nupkg

  # Push / Upload your Chocolatey Package to Chocolatey.org
  chocolatey push Your-Package-Name.nupkg
  ```



<!-- Links -->
[Chocolatey]: https://chocolatey.org/
[Chocolatey.org]: https://chocolatey.org/
[Git]: http://git-scm.com/
[Posh-Git]: https://github.com/dahlbyk/posh-git
[WarmUp]: https://github.com/chucknorris/warmup
[Chocolatey Templates]: https://github.com/chocolatey/chocolateytemplates
[Chocolatey Package Updater]: https://chocolatey.org/packages/ChocolateyPackageUpdater
[Ketarin Chocolatey Template]: https://raw.githubusercontent.com/chocolatey/chocolateytemplates/master/_templates/KetarinChocolateyTemplate.xml
[Chocolatey Account Page]: https://chocolatey.org/account
