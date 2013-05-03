module Fog
  module Rackspace
    class ServiceRegistry
      class Real

        def create_service(options = {})
          data = options.dup
          request(
            :body     => Fog::JSON.encode(data),
            :expects  => [204],
            :method   => 'POST',
            :path     => "services"
          )
        end

      end
    end
  end
end
