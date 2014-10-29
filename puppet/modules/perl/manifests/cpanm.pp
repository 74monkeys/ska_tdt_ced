class perl::cpanm {
  require perl

  $exe = "/usr/bin/cpanm"

  case $::osfamily {
      'RedHat': {
        $perl_cpanm_packages = [ 'cpanminus' ]
      }
      'Debian': {
        $perl_cpanm_packages = [ 'cpanminus' ]
      }
      default: {
        warning("Class['perl_cpanm']: Unsupported osfamily: ${::osfamily}")
        $perl_cpanm_packages = ""
      }
  }
  if($perl_cpanm_packages != "" ) {
      ensure_packages($perl_cpanm_packages)
  }
}
