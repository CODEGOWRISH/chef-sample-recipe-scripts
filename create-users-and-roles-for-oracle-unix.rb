# User and roles creation for Oracle installation

# Create groups - begin
# https://docs.chef.io/resource_group.html

# Common install role for all oracle related user
group 'oinstall' do
  action :create
  comment 'Oracle software install group'
  gid '501'
end

# ASM administrator - for grid user
group 'asmadm' do
  action :create
  comment 'For ASM Administrators - like grid user'
  gid '502'
end

# ASM user  - for DB create user (like oracle) and for grid user
group 'asmdba' do
  action :create
  comment 'For DB create user like oracle and for grid user'
  gid '503'
end

# For OEM software owner
group 'oemadm' do
  action :create
  comment 'For OEM software owner'
  gid '504'
end
# Create groups - end

# Create users - begin
# https://docs.chef.io/resource_user.html

# Create oracle user
user 'oracle' do
  comment 'Oracle DB and Client software owner'
  uid '91'
  gid '501'
  home '/home/oracle'
  shell '/bin/bash'
  password 'oracle'
end

user 'grid' do
  comment 'Oracle grid software owner'
  uid '92'
  gid '502'
  home '/home/oracle'
  shell '/bin/bash'
  password 'oracle'
end

user 'oem' do
  comment 'Oracle OEM software owner'
  uid '93'
  gid '503'
  home '/home/oracle'
  shell '/bin/bash'
  password 'oracle'
end

# Create users - end

# Add users to additional groups
group 'asmdba' do
  members 'oracle'
  members 'grid'
  append true
end

# Create directory - begin
# https://docs.chef.io/resource_directory.html
directory '/u01/app' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

directory '/u01/app/oracle' do
  owner 'oracle'
  group 'oinstall'
  mode '0755'
  action :create
end

directory '/u01/app/grid' do
  owner 'grid'
  group 'oinstall'
  mode '0755'
  action :create
end

directory '/u01/app/oem' do
  owner 'oem'
  group 'oinstall'
  mode '0755'
  action :create
end

# Create directory - end
