module Fog
  module Rackspace
    class ServiceRegistry
      class Real

        def create_service(serviceId, options = {})
          data = options.dup
          request(
            :body     => JSON.encode(data)
            :expects  => [204],
            :method   => 'POST',
            :path     => "services/#{serviceId}"
          )
        end

      end
    end
  end
end