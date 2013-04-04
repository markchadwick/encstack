
action :add do
  name    = new_resource.name
  user    = name
  approot = '/applications'
  homedir = "#{approot}/#{user}"
  srcdir  = "#{homedir}/src"
  envdir  = "#{homedir}/environment"

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

  bash "init-#{name}-virtualenv" do
    code    "virtualenv --no-site-packages #{envdir}"
    user    user
    group   user
    not_if  { ::File.directory?(envdir) }
  end

  bash "update-#{name}-virtualenv" do
    code    "#{envdir}/bin/pip install -r #{srcdir}/requirements.txt"
    user        user
    action      :nothing
  end

  git srcdir do
    repository  new_resource.repository
    reference   new_resource.reference
    action      :sync
    user        user
    group       group
    notifies    :run, "bash[update-#{name}-virtualenv]"
  end

  # ---------------------------------------------------------------------------
  # Bluepill Service
  # ---------------------------------------------------------------------------

  # serivce name do
  #   provider  bluepill_serivce
  #   action    [:enable, :start, :stop]
  # end

  bluepill_serivce name do
    action    [:enable, :start, :stop]
  end
end
