module Fog
  module Rackspace
    class ServiceRegistry
      class Real

        def list_configuration_values(prefix=nil)
          path = 'configuration'
          path += '/%s/' % [prefix.gsub(/^\/*|\/*$/, "")] unless prefix.nil?
          request(
            :expects  => [200],
            :method   => 'GET',
            :path     => path
          )
        end

      end
    end
  end
end

