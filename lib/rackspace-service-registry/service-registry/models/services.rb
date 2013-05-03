require 'fog/core/collection'
require 'rackspace-service-registry/service-registry/models/service'

module Fog
  module Rackspace
    class ServiceRegistry
      class Services < Fog::Collection

        model Fog::Rackspace::ServiceRegistry::Service

        def all(tag=nil)
          data = connection.list_services(tag).body['values']
          #TODO: add support for pagination
          load(data)
        end

        def get(serviceId)
          data = connection.get_service(serviceId).body
          new(data)
        rescue Excon::Errors::NotFound
          nil
        end

        def create(attributes = {})
          super({ :_not_persisted => true }.merge!(attributes))
        end

      end
    end
  end
end
