xmllint_url = node['ros2_windows']['xmllint']['xmllint_download_url']
seven_zip_archive 'libxml2' do
  path 'C:\\xmllint'
  source xmllint_url + '/libxml2-2.9.3-win32-x86_64.7z'
  overwrite true
end

seven_zip_archive 'zlib' do
  path 'C:\\xmllint'
  source xmllint_url + '/zlib-1.2.8-win32-x86_64.7z'
  overwrite true
end

seven_zip_archive 'iconv' do
  path 'C:\\xmllint'
  source xmllint_url + '/iconv-1.14-win32-x86_64.7z'
  overwrite true
end

windows_env 'PATH' do
  key_name 'PATH'
  value 'C:\\xmllint\\bin'
  delim ';'
  action :modify
end
