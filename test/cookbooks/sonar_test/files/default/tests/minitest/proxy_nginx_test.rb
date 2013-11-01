require 'minitest/spec'

describe_recipe 'sonar::proxy_nginx' do
  it "sonar site is enabled" do
    site_enabled = "#{node['nginx']['dir']}/sites-enabled/sonar_server.conf"
    site_available = "#{node['nginx']['dir']}/sites-available/sonar_server.conf"
    link(site_enabled).must_exist.with(:link_type, :symbolic).and(
      :to, site_available)
  end

  # TODO: Verify that Sonar application is actually working (hit
  # the proxy URL and make sure we get a 200 response code).
  # it "is accessible via nginx proxy" do
  # end
end
