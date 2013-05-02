module Fog
  module Rackspace
    class ServiceRegistry
      class Real

        def set_configuration_value(configurationId, options = {})
          data = options.dup
          request(
            :body     => Fog::JSON.encode(data)
            :expects  => [204],
            :method   => 'PUT',
            :path     => "configuration/#{configurationId}"
          )
        end

      end
    end
  end
end
