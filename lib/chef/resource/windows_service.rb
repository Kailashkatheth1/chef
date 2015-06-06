#
# Author:: Bryan McLellan <btm@loftninjas.org>
# Copyright:: Copyright (c) 2014 Chef Software, Inc.
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require 'chef/resource/service'

class Chef
  class Resource
    class WindowsService < Chef::Resource::Service

      # Until #1773 is resolved, you need to manually specify the windows_service resource
      # to use action :configure_startup and attribute startup_type

      use_automatic_resource_name
      provides :windows_service, os: "windows"
      provides :service, os: "windows"

      allowed_actions :configure_startup

      identity_attr :service_name
      state_attrs :enabled, :running
      # Set-Service arguments are automatic and manual
      # Win32::Service returns 'auto start' or 'demand start' respectively, which the provider currently uses
      property :startup_type, [ :automatic, :manual, :disabled ], default: :automatic
      property :run_as_user, String, default: ""
      property :run_as_password, String, default: ""
    end
  end
end
