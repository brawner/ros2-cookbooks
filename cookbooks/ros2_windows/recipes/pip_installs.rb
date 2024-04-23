required_pip_packages = %w[
  pydot==1.4.2
  PyQt5==5.15.0
  argcomplete==1.8.1
  vcstool
  colcon-common-extensions
  catkin_pkg
  cryptography
  EmPy
  jsonschema
  lark-parser
  lxml
  numpy
  opencv-python
  pyparsing
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
