include_recipe 'chocolatey'

# Using seven_zip also for general zip files because it can download and extract in a single resource
include_recipe 'seven_zip'
include_recipe 'ros2_windows::visual_studio'
include_recipe 'ros2_windows::python'
include_recipe 'ros2_windows::pip_installs'
include_recipe 'ros2_windows::opencv'
include_recipe 'ros2_windows::chocolatey_installs'
include_recipe 'ros2_windows::qt5'
include_recipe 'ros2_windows::xmllint'
include_recipe 'ros2_windows::conda'
