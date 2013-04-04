actions         :add
default_action  :add

attribute :name, :regex => Chef::Config[:user_valid_regex], :name_attribute => true

attribute :public_key,  :kind_of => String
attribute :shell,       :kind_of => String, :default => '/bin/false'
attribute :password,    :kind_of => String
attribute :home,        :kind_of => String
