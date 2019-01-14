#
# Cookbook:: uyuni-basic
# Recipe:: uyuni
#
# Copyright:: 2019,  Christian Stankowic
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# stage the environment file

template '/root/setup_env.sh' do
  source 'setup_env.sh.erb'
  variables( :uyuni => node['uyuni'])
  owner  'root'
  group  'root'
  mode   '0644'
end

# setup Uyuni database
execute 'uyuni_setup' do
 command '/usr/lib/susemanager/bin/mgr-setup -s'
 creates '/root/.MANAGER_SETUP_COMPLETE'
end

# create initial organization and user
template '/root/uyuni_initial_setup.sh' do
  source 'uyuni_initial_setup.sh.erb'
  variables( :uyuni => node['uyuni'])
  owner  'root'
  group  'root'
  mode   '0700'
  not_if { ::File.exist?('/root/.MANAGER_INITIALIZATION_COMPLETE') }
end
execute 'uyuni_initial_setup' do
  command '/root/uyuni_initial_setup.sh'
  creates '/root/.MANAGER_INITIALIZATION_COMPLETE'
end

# remove script
file '/root/uyuni_initial_setup.sh' do
  action [ :delete ]
end

# TODO: additional customization such as
# activation keys, repositories,...
