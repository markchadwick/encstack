include_recipe 'application'


application_circus 'transcoder' do
 repository 'https://github.com/markchadwick/flask-empty.git'
end
