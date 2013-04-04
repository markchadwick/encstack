
action :add do
  approot = '/applications'
  homedir = "#{approot}/#{new_resource.name}"
  srcdir  = "#{homedir}/src"

  # ---------------------------------------------------------------------------
  # Applications setup
  # ---------------------------------------------------------------------------

  directory approot do
    action :create
  end

  account_user new_resource.name do
    home  home
  end

  # ---------------------------------------------------------------------------
  # Source Checkout
  # ---------------------------------------------------------------------------

  deploy srcdir do
    repository  new_resource.repository
  end

end
