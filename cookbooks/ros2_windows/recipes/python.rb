python_versions = {
  "humble" => "3.8.3",
  "iron" => "3.8.3",
  "jazzy" => "3.8.3",
  "rolling" => "3.8.3",
}.freeze

python_version = python_versions[node["ros2_windows"]["ros_distro"]]
python_dir = "C:\\Python#{python_version.split('.')[0..1].join}"

# Add this value to the chef run state for use in the pip_installs recipe.
node.run_state[:python_dir] = python_dir

windows_package 'python' do
  source "https://www.python.org/ftp/python/#{python_version}/python-#{python_version}-amd64.exe"
  options "/quiet TargetDir=#{python_dir} PrependPath=1 Include_debug=1 Include_symbols=1"
end
