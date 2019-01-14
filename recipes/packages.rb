#
# Cookbook:: uyuni-basic
# Recipe:: packages
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

# ensure we're up2date
execute 'zypper_update' do
  command 'zypper up -y'
end

# Uyuni zypper repository
zypper_repository 'uyuni' do
  baseurl       'https://download.opensuse.org/repositories/systemsmanagement:/Uyuni:/Stable/images/repo/Uyuni-Server-4.0-POOL-x86_64-Media1/'
  description   'Uyuni Server Stable'
  gpgkey        'https://download.opensuse.org/repositories/systemsmanagement:/Uyuni:/Stable/images/repo/Uyuni-Server-4.0-POOL-x86_64-Media1/media.1/products.key'
  repo_name     'uyuni-server-stable'
end

# Uyuni packages
zypper_package 'uyuni_packages' do
  package_name 'patterns-uyuni_server'
  retries 5
end
