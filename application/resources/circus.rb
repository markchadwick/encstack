actions         :add
default_action  :add

attribute :name, :regex => Chef::Config[:user_valid_regex], :name_attribute => true

# -----------------------------------------------------------------------------
# Source configuration
# -----------------------------------------------------------------------------

attribute :repository, :kind_of => String
attribute :reference,  :kind_of => String, :default => 'master'
