include_recipe 'chocolatey'
include_recipe 'seven_zip'
include_recipe 'ros2_windows::python'
include_recipe 'ros2_windows::opencv'
include_recipe 'ros2_windows::openssl'
include_recipe 'ros2_windows::visual_studio'
include_recipe 'ros2_windows::qt5'
include_recipe 'ros2_windows::pip_installs'
include_recipe 'ros2_windows::chocolatey_installs'

if node['ros2_windows']['install_connext'] do
  include_recipe 'ros2_windows::rti_connext'
end

if node['ros2_windows']['install_opensplice'] do
  include_recipe 'ros2_windows::opensplice'
end

if !node['ros2_windows']['development'] do
  include_recipe 'ros2_windows::ros2_binaries'
  return
end

include_recipe 'ros2_windows::xmllint'

directory 'ros2_ws' do
  path node['ros2_windows']['ros2_ws']
  action :create
  recursive true
end

if !node['ros2_windows']['download_sources'] do
  return
end

ros2_src_dir = File.join(node['ros2_windows']['ros2_ws'], 'src')
directory 'ros2_ws_src' do
  path ros2_src_dir
  action :create
  recursive true
end

ros2_repos_path = File.join(node['ros2_windows']['ros2_ws'], 'ros2.repos')
remote_file 'ros2.repos' do
  source 'https://raw.githubusercontent.com/ros2/ros2/%s/ros2.repos' % node['ros2_windows']['ros2.repos']
  path ros2_repos_path
  action :create
end

execute 'vcs_import' do
  command 'vcs import --input %s %s' % [ros2_repos_path, ros2_src_dir]
end
