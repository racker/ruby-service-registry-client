require 'fog/core/model'

module Fog
  module Rackspace
    class ServiceRegistry
      class Service < Fog::Model

        class Heartbeater
          def initialize(service)
            @service = service
            @running = true
            @next_token = nil
          end
          def stop
            @running = false
          end
          def heartbeat
            interval = @service.heartbeat_timeout

            return if not @running

            if @next_token
              sleep(interval)
            end

            result = @service.connection.send_heartbeat(@service.identity, @next_token)
            @next_token = result.body['token']
            heartbeat
          end
        end

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
            connection.update_service(identity, data)
          else
            data[:heartbeat_timeout] = heartbeat_timeout if heartbeat_timeout
            connection.create_service(data)
          end
          true #???
        end

        def delete
          connection.delete_service(identity)
        end
      end
    end
  end
end

