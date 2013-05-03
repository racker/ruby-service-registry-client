require 'fog/core/model'

module Fog
  module Rackspace
    class ServiceRegistry
      class Service < Fog::Model

        class Heartbeater
          def initialize(service, initial_token)
            @service = service
            @running = true
            @next_token = initial_token
          end

          def stop
            @running = false
          end

          def start
            interval = @service.heartbeat_timeout
            if interval < 15
              interval = interval * 0.6
            else
              interval = interval * 0.8
            end

            loop do
              break if not @running
              sleep(interval) if @next_token
              result = @service.service.send_heartbeat(@service.identity, @next_token)
              @next_token = result.body['token']
            end 
          end
        end

        identity :id
        attribute :heartbeat_timeout
        attribute :metadata
        attribute :tags
        attribute :last_seen

        def start_heartbeat(initial_token)
          #TODO: ensure heartbeat hasn't already started
          return false unless @heartbeat.nil?
          @heartbeat = hb = Heartbeater.new(self, initial_token)
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
          begin
            requires :identity
            #TODO: assert that data is not empty?
            service.update_service(identity, data)
          rescue Excon::Errors::NotFound
            requires :identity, :heartbeat_timeout
            data[:heartbeat_timeout] = heartbeat_timeout
            data[:id] = identity
            result = service.create_service(data)
            start_heartbeat(result.body['token'])
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

