openssl_versions = {
  "humble" => "1_1_1L",
  "iron" => "1_1_1L",
  "jazzy" => nil,  # OpenSSL is installed via choco
  "rolling" => nil,  # OpenSSL is installed via choco
}.freeze

openssl_version = openssl_versions[node["ros2_windows"]["ros_distro"]]

if !openssl_version.nil?
  openssl_conf_dir = 'C:\\Program Files\\OpenSSL-Win64'

  windows_package 'openssl' do
    source "https://ftp.osuosl.org/pub/ros/download.ros.org/downloads/openssl/Win64OpenSSL-#{openssl_version}.exe"
    options '/VERYSILENT'
  end

  windows_env 'OPENSSL_CONF' do
    key_name 'OPENSSL_CONF'
    value "#{openssl_conf_dir}\\bin\\openssl.cfg"
    action :create
  end

  windows_env 'PATH' do
    key_name 'PATH'
    value "#{openssl_conf_dir}\\bin"
    delim ';'
    action :modify
  end
end
