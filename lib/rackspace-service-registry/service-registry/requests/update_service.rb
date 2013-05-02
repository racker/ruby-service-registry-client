module Fog
  module Rackspace
    class ServiceRegistry
      class Real

        def update_service(serviceId, options = {})
          data = options.dup
          request(
            :body     => Fog::JSON.encode(data),
            :expects  => [204],
            :method   => 'PUT',
            :path     => "services/#{serviceId}"
          )
        end

      end
    end
  end
end
