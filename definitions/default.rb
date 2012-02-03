define :sonar_plugin, :version => "1.0" do
 remote_file "#{node[:sonar][:dir]}/#{node[:sonar][:plugins_dir]}/#{params[:name]}-#{params[:version]}.jar" do
    source "#{node[:sonar][:plugins_repo]}/#{params[:name]}/#{params[:version]}/#{params[:name]}-#{params[:version]}.jar"
    owner "root"
    group "root"
    mode 0755
    notifies :restart, resources(:service => "sonar")
    not_if "test -f #{node[:sonar][:dir]}/#{node[:sonar][:plugins_dir]}/#{params[:name]}-#{params[:version]}.jar"
 end
end
