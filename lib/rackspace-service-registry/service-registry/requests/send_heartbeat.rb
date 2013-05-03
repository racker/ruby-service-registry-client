module Fog
  module Rackspace
    class ServiceRegistry
      class Real

        def send_heartbeat(serviceId, token)
          request(
            :body     => Fog::JSON.encode(:token => token),
            :expects  => [200],
            :method   => 'POST',
            :path     => "services/#{serviceId}/heartbeat"
          )
        end

      end
    end
  end
end
