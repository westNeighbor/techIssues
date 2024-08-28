# tech Issues
collect the problems met for hardware and software and solutions

# Windows and software Installation
- need install my msi mpg x670e carbon wifi motherboard driver and AMD 7900x cpu chipset driver
- Winget source problem (couldn't fetch from winget source) and error `Failed in attempting to update the source: winget`. It's due to the shipped ms store (App Installer -> Microsoft.AppInstaller) is too old, update to the newest one solves the problem.
  - First reinstall the source `https://cdn.winget.microsoft.com/cache/source.msix` will let the winget list the files from winget source, but still get the above error
  - Now just update the msstore by winget `winget install Microsoft.AppInstaller`
- To use command in shell (e.g `vim`) and `PowerShell` script, need add the path to the path enviroment.
- magick couldn't render when using font with Chinese characters in the name. Using Unicode utf-8 for the system can solve the problem. `Start -> Region (Control Panel) -> Administrative -> Change system locale -> Use Unicode UTF-8 for worldwide language support`, notice: search `Region` in the `Start` and select the one that is `Control panel`

  Or `Settings -> Time & language -> Language & region -> Related settings -> Administrative language settings`

- Stable Diffusion & ComfyUI
  - `Install` or `Update` the needed packages (e.g. CUDA, CNDNN, extensions dependents) to their own python packages, so they will not depend on the OS.
  - ComfyUI failed to install package and giving messages like this: 
    !!

              ********************************************************************************
              As setuptools moves its configuration towards `pyproject.toml`,
              `setuptools.config.parse_configuration` became deprecated.

              For the time being, you can use the `setuptools.config.setupcfg` module
              to access a backward compatible API, but this module is provisional
              and might be removed in the future.

              To read project metadata, consider using
              ``build.util.project_wheel_metadata`` (https://pypi.org/project/build/).
              For simple scenarios, you can also try parsing the file directly
              with the help of ``configparser``.
              ********************************************************************************
    For example, the package `insightface`, choose the version from your python. For example, my python was 3.11.8 I downloaded "insightface-0.7.3-cp311-cp311-win_amd64.whl" and copy on Root comfyUI
    
    |-- ComfyUI
    
    |--- insightface-0.7.3-cp311-cp311-win_amd64.whl
    
    In the termial, execute `.\python_embeded\python.exe -m pip install "your path \insightface-0.7.3-cp311-cp311-win_amd64.whl" onnxruntime`, if shows no perssion, go to the folder, right click -> Properties -> Security -> Edit, gives `Users` `full control` permission
  - Version of `mmcv`, `torch`, etc, need to make sure the compatible versions, [mmcv installation](https://mmcv.readthedocs.io/en/latest/get_started/installation.html) and [torch installation](https://pytorch.org/get-started/previous-versions/)
  - Make sure `onnxruntime-gpu` compatible with `CUDA` and `CUDNN` versions, [onnxruntime -> CUDA -> CUDNN version match](https://onnxruntime.ai/docs/execution-providers/CUDA-ExecutionProvider.html), also install the version with url to make cuda work noramlly, `pip install onnxruntime-gpu==1.18.0 --extra-index-url https://aiinfra.pkgs.visualstudio.com/PublicPackages/_packaging/onnxruntime-cuda-12/pypi/simple/`
    
# Linux and MacOS
- ![Homebrew](https://brew.sh/) to install and manage MacOS softwares
- ![Oh My Zsh](https://ohmyz.sh/) as default shell
- ![Vundle](https://github.com/VundleVim/Vundle.vim) to install and manage `vim` plugins. ![YouCompleteMe](https://github.com/ycm-core/YouCompleteMe) as `C/C++` and `Python` development engine.
- To use multiple versions of software in MacOS, say `Blender`:
  1. Go to `Applications` Folder, copy `Blender` and rename the copy (`Blender copy`), say `Blender4.1`. Now you have `Blender` and `Blender4.1`. Don't delete `Blender` here, when you install new version by `homebrew`, it will automatically cover it.
  2. Install a new version of `Blender` by `brew install Blender` or `brew upgrade Blender`, say the new version is `Blender4.2.1`
  3. Go to `/opt/homebrew/Caskroom/blender`, you should have a folder `4.2.1`, make a new directory `4.1.1`, then go to `4.1.1` by `cd 4.1.1`, now make a link by `ln -s /Applications/Blender4.1.app Blender4.1.app` (this is what you just reanamed in step 1) and copy a file by `cp ../4.2.1/blender.wrapper.sh`; change the second line to `'/Applications/Blender4.1.app/Contents/MacOS/Blender' "$@"`
  4. Last, go to `/opt/homebrew/bin/` and make a link by `ln -s /opt/homebrew/Caskroom/blender/4.1.1/blender.wrapper.sh blender4.1`. Now open a new terminal, you can type `blender4.1` to open it.
