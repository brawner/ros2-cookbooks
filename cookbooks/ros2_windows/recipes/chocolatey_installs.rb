%w[git curl vcredist2013 vcredist140 patch winflexbison3].each do |pkg|
  chocolatey_package pkg do
    options "--debug"
    list_options "--debug"
    retries 20
    retry_delay 10
  end
end

chocolatey_package 'cmake' do
  version '3.24.3'
  options "--debug"
  list_options "--debug"
  retries 20
  retry_delay 10
end

chocolatey_package 'cppcheck' do
  version '1.90'
end

windows_env 'PATH' do
  key_name 'PATH'
  value 'C:\\Program Files\\Git\\cmd;C:\\Program Files\\CMake\\bin'
  delim ';'
  action :modify
end

custom_chocolatey_packages = {
  'asio' => 'asio.1.12.1',
  'bullet' => 'bullet.3.17',
  'cunit' => 'cunit.2.1.3',
  'eigen' => 'eigen.3.3.4',
  'tinyxml2' => 'tinyxml2.6.0.0'
}

chocolatey_tinyxml_dependency = {
  "humble" => {"tinyxml-usestl" => "tinyxml-usestl.2.6.2"},
  "iron" => {"tinyxml-usestl" => "tinyxml-usestl.2.6.2"},
  "jazzy" => {},
  "rolling" => {},
}.freeze

custom_chocolatey_packages.merge!(chocolatey_tinyxml_dependency[node["ros2_windows"]["ros_distro"]])

custom_chocolatey_packages.each do |name, pkg|
  remote_file "#{pkg}.nupkg" do
    source "https://github.com/ros2/choco-packages/releases/download/2022-03-15/#{pkg}.nupkg"
  end

  chocolatey_package 'custom_packages' do
    package_name "#{name}"
    source '.\\'
  end
end
