#
#  construct a suitable configuration from git
#
define jenkins::configuration (
    $repo = undef,
    $config_dir = '/var/lib/jenkins',
    $group = 'jenkins'
)
{
    require git::client

    if $repo {
        vcsrepo { "$config_dir":
          ensure   => present,
          provider => git,
          source   => "$repo",
          group => $group,
          force => 'true'
        }
    }
}
