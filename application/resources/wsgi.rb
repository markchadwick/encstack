actions         :add
default_action  :add

attribute :name, :regex => Chef::Config[:user_valid_regex], :name_attribute => true

# -----------------------------------------------------------------------------
# Application startup params
# -----------------------------------------------------------------------------

attribute :app,  :kind_of => String,  :default => 'main:app'
attribute :port, :kind_of => Integer, :default => 8080
attribute :port, :kind_of => Integer, :default => 4

# -----------------------------------------------------------------------------
# Source configuration
# -----------------------------------------------------------------------------

attribute :repository, :kind_of => String
