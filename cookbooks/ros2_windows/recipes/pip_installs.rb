required_pip_packages = %w[
  pydot==1.4.2
  PyQt5==5.15.0
  argcomplete==1.8.1
  vcstool
  catkin_pkg
  colcon-bash
  colcon-cmake
  colcon-core
  colcon-defaults
  colcon-library-path
  colcon-metadata
  colcon-mixin
  colcon-output
  colcon-package-information
  colcon-package-selection
  colcon-parallel-executor
  colcon-pkg-config
  colcon-powershell
  colcon-python-setup-py
  colcon-recursive-crawl
  colcon-ros
  colcon-ros-domain-id-coordinator
  colcon-test-result
  colcon-zsh
  cryptography
  EmPy==3.3.4
  fastjsonschema==2.19.0
  jsonschema
  lark-parser
  lxml
  numpy
  opencv-python
  pyyaml
  pytest
  pytest-mock
  coverage
  mock
  psutil
]

ros2cli_network_dependency = {
  "humble" => "netifaces",
  "iron" => "netifaces",
  "jazzy" => "psutil",
  "rolling" => "psutil",
}.freeze
required_pip_packages << ros2cli_network_dependency[node["ros2_windows"]["ros_distro"]]

pyparsing_dependency = {
  "humble" => "pyparsing==2.4.7",
  "iron" => "pyparsing==2.4.7",
  "jazzy" => "pyparsing==3.1.1",
  "rolling" => "pyparsing==3.1.1",
}
required_pip_packages << pyparsing_dependency[node["ros2_windows"]["ros_distro"]]

pyqt5_sip_dependency = {
  "humble" => "PyQt5-sip==12.9.1",
  "iron" => "PyQt5-sip==12.9.1",
  "jazzy" => "PyQt5-sip==12.13.0",
  "rolling" => "PyQt5-sip==12.13.0",
}
required_pip_packages << pyqt5_sip_dependency[node["ros2_windows"]["ros_distro"]]

development_pip_packages = %w[
  flake8
  flake8-blind-except
  flake8-builtins
  flake8-class-newline
  flake8-comprehensions
  flake8-deprecated
  flake8-docstrings
  flake8-import-order
  flake8-quotes
  mypy==0.942
  pep8
  pydocstyle
]

# Use explicit location because python may not be on the PATH if chef-solo has not been run before
#
execute 'pip_update' do
  command lazy {
    "#{node.run_state[:python_dir]}\\python.exe -m pip install -U pip setuptools==59.6.0"
  }
end

execute 'pip_required' do
  command lazy {
    "#{node.run_state[:python_dir]}\\python.exe -m pip install -U #{required_pip_packages.join(' ')}"
  }
end

if node['ros2_windows']['development'] == true
  execute 'pip_additional' do
    command lazy {
      "#{node.run_state[:python_dir]}\\python.exe -m pip install -U #{development_pip_packages.join(' ')}"
    }
  end
end
