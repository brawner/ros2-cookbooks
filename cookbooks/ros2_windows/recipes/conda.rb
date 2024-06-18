conda_versions = {
    "humble" => nil,
    "iron" => nil,
    "jazzy" => nil,
    "rolling" => "2024.02-1",
}.freeze

conda_version = conda_versions[node["ros2_windows"]["ros_distro"]]

conda_dir = "C:\\Miniforge3"

if conda_version != nil
    windows_package 'conda' do
        source "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Windows-x86_64.exe"
        options "/S /InstallType=JustMe /RegisterPython=0 /AddToPath=1 /D=#{conda_dir}"
    end
end

windows_env 'PATH' do
    key_name 'PATH'
    value 'C:\\Miniforge3\\condabin'
    delim ';'
    action :modify
end

conda_packages = {
    "qt6-main" => nil
}.freeze

packages_to_install = ""

conda_packages.each do |package_name, package_version|
    packages_to_install += package_name
    if package_version != nil
        packages_to_install += "=" + package_version
    end
    packages_to_install += " "
end

execute 'conda_update' do
    command lazy {
      "conda update conda "
    }
end

execute 'conda_install' do
    command lazy {
      "conda install -c conda-forge #{packages_to_install}"
    }
end

