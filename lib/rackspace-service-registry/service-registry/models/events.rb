require 'fog/core/collection'
require 'rackspace-service-registry/service-registry/models/event'

module Fog
  module Rackspace
    class ServiceRegistry
      class Events < Fog::Collection

        model Fog::Rackspace::ServiceRegistry::Event

        def all
          data = service.list_events.body['values']
          #TODO: add support for pagination
          load(data)
        end

      end
    end
  end
end
