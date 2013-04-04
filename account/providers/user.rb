action :add do

  username  = new_resource.name
  homedir   = new_resource.home || "/home/#{username}"
  ssh_dir   = "#{homedir}/.ssh"


  user username do
    home      homedir
    shell     new_resource.shell
    supports  :manage_home => true

    password  new_resource.password if new_resource.password
  end

  # Make a group for each user with the same name.
  group username do
    members username
    append  true
  end

  directory homedir do
    owner     username
    group     username
    action    :create
    recursive true
  end

  # Automatically set up some basic SSH defaults
  directory ssh_dir do
    owner   username
    group   username
    mode    0770
    action  :create
  end

  # If an ssh key has been provded, drop it down in authorized keys.
  if new_resource.public_key
    cookbook_file "#{ssh_dir}/config" do
      source  'ssh/config'
      owner   username
      group   username
      mode    0660
    end

    cookbook_file "#{ssh_dir}/authorized_keys" do
      source  new_resource.public_key
      owner   username
      group   username
      mode    0660
    end
  end
end
