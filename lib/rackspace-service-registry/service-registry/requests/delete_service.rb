module Fog
  module Rackspace
    class ServiceRegistry
      class Real

        def delete_service(serviceId)
          request(
            :expects  => [204],
            :method   => 'DELETE',
            :path     => "services/#{serviceId}"
          )
        end

      end
    end
  end
end
