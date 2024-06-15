# tech Issues
collect the problems met for hardware and software and solutions

# Windows and software Installation
- need install my msi mpg x670e carbon wifi motherboard driver and AMD 7900x cpu chipset driver
- Winget source problem (couldn't fetch from winget source) and error `Failed in attempting to update the source: winget`. It's due to the shipped ms store (App Installer -> Microsoft.AppInstaller) is too old, update to the newest one solves the problem.
  - First reinstall the source `https://cdn.winget.microsoft.com/cache/source.msix` will let the winget list the files from winget source, but still get the above error
  - Now just update the msstore by winget `winget install Microsoft.AppInstaller`
