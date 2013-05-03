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

          def start
            interval = @service.heartbeat_timeout
            #TODO: change interval to something slightly less than the timeout to account for network lag
            #TODO: get a HTTP 1.1 connection

            loop do
              break if not @running
              sleep(interval) if @next_token
              result = @service.connection.send_heartbeat(@service.identity, @next_token)
              @next_token = result.body['token']
            end 
          end
        end

        identity :id
        attribute :heartbeat_timeout
        attribute :metadata
        attribute :tags
        attribute :last_seen

        def start_heartbeat
          #TODO: ensure heartbeat hasn't already started
          return false unless @heartbeat.nil?
          @heartbeat = hb = Heartbeater.new self
          @hb_thread = Thread.new do
            hb.start
          end
          true
        end

        def stop_heartbeat
          return false if @heartbeat.nil?
          @heartbeat.stop
          @hb_thread.join
          @hb_thread = nil
          @heartbeat = nil
          true
        end

        def save
          #TODO: determine and handle behavior when tags is not set
          #TODO: determine and handle behavior when metadata is not set
          data = {}
          data[:tags] = tags if tags
          data[:metadata] = metadata if metadata
          unless attributes[:_not_persisted]
            requires :identity
            #TODO: assert that data is not empty?
            service.update_service(identity, data)
          else
            requires :identity, :heartbeat_timeout
            data[:heartbeat_timeout] = heartbeat_timeout
            data[:id] = identity
            service.create_service(data)
          end
          true
        end

        def delete
          service.delete_service(identity)
        end
      end
    end
  end
end

