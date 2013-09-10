require 'minitest/spec'

describe_recipe 'sonar::default' do

  it "installs the files to the correct folder" do
    directory("#{node['sonar']['dir']}-#{node['sonar']['version']}").must_exist
  end

  it "symlinks to extracted directory" do
    link(node['sonar']['dir']).must_exist.with(
      :link_type, :symbolic).and(:to, "#{node['sonar']['dir']}-#{node['sonar']['version']}")
  end

  it "creates symlink from init.d to init script" do
    link("/etc/init.d/sonar").must_exist.with(
      :link_type, :symbolic).and(:to, "#{node['sonar']['dir']}/bin/#{node['sonar']['os_kernel']}/sonar.sh")
  end

  it "is currently running as a daemon" do
    service("sonar").must_be_running
  end

  it "boots on startup" do
    service("sonar").must_be_enabled
  end

  # TODO: Verify that Sonar application is actually working (hit
  # the URL and make sure we get a 200 response code).
  # it "is accessible via direct Sonar standalone app" do
  # end
end
