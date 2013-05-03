require 'fog/core/collection'
require 'rackspace-service-registry/service-registry/models/service'

module Fog
  module Rackspace
    class ServiceRegistry
      class Services < Fog::Collection

        model Fog::Rackspace::ServiceRegistry::Service

        def all(tag=nil)
          data = service.list_services(tag).body['values']
          #TODO: add support for pagination
          load(data)
        end

        def get(serviceId)
          data = service.get_service(serviceId).body
          new(data)
        rescue Excon::Errors::NotFound
          nil
        end

      end
    end
  end
end
