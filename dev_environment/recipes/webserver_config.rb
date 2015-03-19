# set up nginx
template "/etc/nginx/sites-available/webserver" do
  source node['node']['webserver_template']
  cookbook "rails-config"
  mode "0644"
end

link "/etc/nginx/sites-enabled/webserver" do
  to "/etc/nginx/sites-available/webserver"
  action :create
end

#remove the default Nginx template
file "/etc/nginx/sites-available/default" do
  action :delete
end
file "/etc/nginx/sites-enabled/default" do
  action :delete
end

service "nginx" do
  action :restart
end