module Fog
  module Rackspace
    class ServiceRegistry
      class Real

        def get_configuration_value(configurationId)
          data = options.dup
          request(
            :body     => JSON.encode(data)
            :expects  => [200],
            :method   => 'GET',
            :path     => "configuration/#{configurationId}"
          )
        end

      end
    end
  end
end
