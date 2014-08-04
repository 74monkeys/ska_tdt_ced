class python::numpy {
  require python

  case $::osfamily {
    'RedHat': {
      $python_numpy_packages = [ 'python_numpy' ]
    }
    'Debian': {
      $python_numpy_packages = [ 'python-numpy' ]
    }
    default: {
      fail("Class['python::numpy']: Unsupported osfamily: ${::osfamily}")
    }
  }

  ensure_packages($python_numpy_packages)
}
