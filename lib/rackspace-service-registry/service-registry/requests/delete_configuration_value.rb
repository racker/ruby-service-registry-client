module Fog
  module Rackspace
    class ServiceRegistry
      class Real

        def delete_configuration_value(configurationId)
          request(
            :expects  => [204],
            :method   => 'DELETE',
            :path     => "configuration/#{configurationId}"
          )
        end

      end
    end
  end
end
