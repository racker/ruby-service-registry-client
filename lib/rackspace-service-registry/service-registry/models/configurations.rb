require 'fog/core/collection'
require 'rackspace-service-registry/service-registry/models/configuration'

module Fog
  module Rackspace
    class ServiceRegistry
      class Configurations < Fog::Collection

        model Fog::Rackspace::ServiceRegistry::Configuration

        def all(prefix=nil)
          data = service.list_configuration_values(prefix).body['values']
          #TODO: add support for pagination
          load(data)
        end

        def get(key)
          data = service.get_configuration_value(key).body
          new(data)
        rescue Excon::Errors::NotFound
          nil
        end

      end
    end
  end
end
