openssl_versions = {
  "humble" => "1_1_1L",
  "iron" => "1_1_1L",
  "jazzy" => "1_1_1L",
  "rolling" => "1_1_1L",
}.freeze

openssl_version = openssl_versions[node["ros2_windows"]["ros_distro"]]

# The default installation location changed for the 1.1.1 releases. However if
# 1.0.2 was installed previously then some state persists and a 1.1.1
# installation will use the 1.0.2 location. To be correct in every situation
# we would either need to specifiy the installation path for whatever we
# install or retrieve whatever it is before configuring.
openssl_conf_dir = if openssl_version == "1_0_2u"
                     'C:\\OpenSSL-Win64'
                   else
                     'C:\\Program Files\\OpenSSL-Win64'
                   end


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
