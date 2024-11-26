# ROS 2 Windows Cookbook

This cookbook configures a host machine for ROS 2 development or binary installation.
This README describes how to install all the prerequisites and how to run chef-solo with this cookbook.
Due to license encumberances on the Chef binaries, this README recommends installing Cinc for their binary distributions of the Chef software.

## Windows Install

This walkthrough will install the following:
* chef/chef-solo with the cinc distribution
* chocolatey
* git
* chefdk
* ros2_windows cookbook

In powershell, install Cinc's chef distribution:
```
> . { iwr -useb https://omnitruck.cinc.sh/install.ps1 } | iex; install
```

In same shell, install chocolatey, git and the chefdk tools (primarily for `berks`).
```
> Set-ExecutionPolicy Bypass -Scope Process -Force;. { iwr -useb https://chocolatey.org/install.ps1 } | iex
> choco install -y git chef-workstation
> restart-computer
```

After the computer restarts, in the cmd shell (not powershell) clone this repo:
```
> git clone https://github.com/ros-infrastructure/ros2-cookbooks
```

Run `berks` to get the cookbook dependencies
```
cd ros2-cookbooks/cookbooks/ros2_windows
berks vendor ..
```

Run chef-solo to configure machine.
```
> c:\cinc-project\cinc\bin\cinc-solo -c ros2-cookbooks\.chef\solo.rb -j ros2_windows.json
```

Type yes to accept the standard Chef licenses.

Debug any issues that arise until running chef-solo completes successfully.

## Configuration options

The file `ros2_windows.json` may be modified for your own installation.
Please check the available attributes in [cookbooks/ros2_windows/attributes](cookbooks/ros2_windows/attributes)

For example, the following will configure the installation to setup the machine for development with Connext.

Adjust the `rti_connext` parameters to match your installation files.

```json
{
  "default_attributes": {
    "ros2_windows": {
      "download_sources": "false",
      "vs_version": "buildtools",
      "ros2_ws": "C:/ci",
      "install_connext": "true",
      "rti_connext": {
        "target_platform": "x64Win64",
        "min_vs_version": "2017",
        "license_file": "C:\\TEMP\\rticonnextdds-license\\rti_license.dat",
        "installer_dir": "C:\\TEMP\\rticonnextdds-src",
        "version": "5.3.1",
        "edition": "pro",
        "openssl_version": "1.0.2n"
      }
    }
  },
  "run_list": [
    "role[ros2-development]",
    "recipe[ros2_windows::ros2_sources]"
  ]
}
```

## Automating Qt installation

For the most part the Qt installation is fully automated.
However, downloading Qt binaries requires creating a login.
This login email and password can be set by suppling the chef attributes
```
node['ros2']['qt_account_email']
node['ros2']['qt_account_password']
```
If you skip this step, the Qt installer will pause and require you to create a login before continuing.
Importantly, on a headless setup, you will not be able to see this GUI feedback and your installation will pause indefinitely.
