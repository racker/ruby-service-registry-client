module Fog
  module Rackspace
    class ServiceRegistry
      class Real

        def list_services(tag=nil)
          path = "services"
          path += "?tag=%s" % [tag] unless tag.nil?
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

