
action :add do
  name    = new_resource.name
  user    = name
  approot = '/applications'
  homedir = "#{approot}/#{user}"
  srcdir  = "#{homedir}/src"
  envdir  = "#{homedir}/environment"
  conf    = "#{homedir}/#{name}.ini"

  # ---------------------------------------------------------------------------
  # Applications setup
  # ---------------------------------------------------------------------------

  package 'git'
  package 'python-virtualenv'

  directory approot do
    action :create
  end

  account_user user do
    home  homedir
  end

  # ---------------------------------------------------------------------------
  # Source/Environment Setup
  # ---------------------------------------------------------------------------

  directory srcdir do
    user      user
    group     user
  end

  python_virtualenv envdir do
    owner   user
    group   user
    options '--no-site-packages'
  end

  bash "update-#{name}-virtualenv" do
    code    "#{envdir}/bin/pip install -r #{srcdir}/requirements.txt"
    user    user
    action  :nothing
  end

  git srcdir do
    repository  new_resource.repository
    reference   new_resource.reference
    action      :sync
    user        user
    group       group
    notifies    :run, "bash[update-#{name}-virtualenv]"
  end

  template conf do
    source    'application.ini.erb'
    cookbook  'application'
    notifies  :restart, 'service[circusd]'
    owner     user
    group     user
    mode      0660

    variables({
      :name     => name,
      :srcdir   => srcdir,
      :envdir   => envdir,
      :user     => user,
      :app      => new_resource.app,
      :host     => new_resource.host,
      :port     => new_resource.port,
      :workers  => new_resource.workers
    })
  end

  link "/etc/circus/config.d/#{name}.ini" do
    to conf
  end
end
