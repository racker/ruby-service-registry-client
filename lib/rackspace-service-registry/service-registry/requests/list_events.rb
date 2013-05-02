module Fog
  module Rackspace
    class ServiceRegistry
      class Real

        def list_events()
          request(
            :expects  => [200],
            :method   => 'GET',
            :path     => 'events'
          )
        end

      end
    end
  end
end

