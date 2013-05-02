module Fog
  module Rackspace
    class ServiceRegistry
      class Real

        def list_configuration_values(*namespaces)
          path = 'configuration'
          unless namespaces.empty?
            path += '/%s/' + [namespaces.map {|s| s.gsub(/^\/*|\/*$/, "")}.join('/')]
          end
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

