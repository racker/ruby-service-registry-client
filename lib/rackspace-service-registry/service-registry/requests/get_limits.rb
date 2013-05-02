module Fog
  module Rackspace
    class ServiceRegistry
      class Real

        def get_limits()
          request(
            :expects  => [200],
            :method   => 'GET',
            :path     => "limits"
          )
        end

      end
    end
  end
end

