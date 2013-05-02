module Fog
  module Rackspace
    class ServiceRegistry
      class Real

        def get_service(serviceId)
          request(
            :expects  => [200],
            :method   => 'GET',
            :path     => "services/#{serviceId}"
          )
        end

      end
    end
  end
end

