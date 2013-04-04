action :add do

  user new_resource.name do
    home      "/home/#{new_resource.name}"
    supports  :manage_home => true
  end

end
