module Fog
  module Rackspace
    class ServiceRegistry
      class Real

        def set_configuration_value(configurationId, value)
          request(
            :body     => Fog::JSON.encode(:value => value),
            :expects  => [204],
            :method   => 'PUT',
            :path     => "configuration/#{configurationId}"
          )
        end

      end
    end
  end
end
