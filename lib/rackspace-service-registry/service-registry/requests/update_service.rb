module Fog
  module Rackspace
    class ServiceRegistry
      class Real

        def update_service(serviceId)
          request(
            :expects  => [204],
            :method   => 'PUT',
            :path     => "services/#{serviceId}"
          )
        end

      end
    end
  end
end
