actions         :add
default_action  :add

attribute :name, :regex => Chef::Config[:user_valid_regex], :name_attribute => true

# -----------------------------------------------------------------------------
# Source configuration
# -----------------------------------------------------------------------------

attribute :repository, :kind_of => String
attribute :reference,  :kind_of => String, :default => 'master'

attribute :app,     :kind_of => String,   :default => 'main.app'
attribute :port,    :kind_of => Integer,  :default => 8888
attribute :workers, :kind_of => Integer,  :default => 3
attribute :host,    :kind_of => String,   :default => '0.0.0.0'
