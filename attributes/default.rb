# Setup node names
set['set_fqdn'] = '*.mturkgrind.com'

# Default application user
default[:mh][:app_user] = 'mtg'

# Chef-client
default[:chef_client][:interval] = 1800  # Run chef-client every 30 minutes
default[:chef_client][:splay]    = 300   # Splay chef runs by a random number of seconds up to 300

# Postfix
default[:postfix][:main].merge!(
    :mydomain  => 'mturkgrind.com',
    :myorigin  => 'mturkgrind.com',
    :sender_canonical_map_entries => {},
    :mail_type => 'leaf',
    :relayhost => ''
  )

# nginx default config details for core and cms.
default[:mtg] = {
      :app_id => 'mturkgrind',
      :nginx => {
            :docroot => '/var/www/mturkgrind',
            :socket_path => '/var/run/php-fpm-www.sock',
            :port => '8080',
            :options => '',
            :max_upload => '1m'
      }
   }

# Varnish Overrides
node.set['varnish']['version'] = '3.0' # TODO: 4.0 requires VCL changes
node.set['varnish']['listen_port'] = ':80' 
node.set['varnish']['storage'] = 'malloc'
node.set['varnish']['storage_size'] = '256M'
node.set['varnish']['vcl_source'] = 'varnish.vcl.erb'
node.set['varnish']['vcl_cookbook'] = 'mturkgrind'
node.set['varnish']['vcl_generated'] = true
node.set['varnish']['conf_source'] = 'varnish_default.erb'
node.set['varnish']['conf_cookbook'] = 'mturkgrind'

# NGINX Overrides
node.default['nginx']['default_site_enabled'] = false 
