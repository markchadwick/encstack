include_recipe 'account::default'

account_user 'mchadwick' do
  public_key  'ssh/keys/mchadwick.pub'
  shell       '/bin/bash'
  password    '$1$meO.HbBi$IDdn73F3UIHQGa6qK3ShB0'
end
