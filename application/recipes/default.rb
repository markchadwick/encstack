package 'python-dev'

python_pip 'circus' do
  version '0.6.0'
end

template '/etc/init.d/circusd' do
  mode    0755
  source  'circusd.erb'
  action  :create
end

directory '/etc/circus/config.d' do
  action    :create
  recursive true
end

template '/etc/circus/circus.ini' do
  source      'circus.ini.erb'
  variables   :configs_path => '/etc/circus/config.d'
end

service 'circusd' do
  supports  [:start, :stop, :status, :restart]
  action    :start
end
