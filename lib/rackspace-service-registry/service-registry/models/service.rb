require 'fog/core/model'

module Fog
  module Rackspace
    class ServiceRegistry
      class Service < Fog::Model

        identity :id
        attribute :heartbeat_timeout
        attribute :metadata
        attribute :tags

        def save
          data = {
            :tags => tags,
            :metadata => metadata
          }
          if identity
            service.update_service(identity, data)
          else
            data[:heartbeat_timeout] = heartbeat_timeout if heartbeat_timeout
            service.create_service(data)
          end
          true #???
        end

        def delete
          service.delete_service(identity)
        end
      end
    end
  end
end

