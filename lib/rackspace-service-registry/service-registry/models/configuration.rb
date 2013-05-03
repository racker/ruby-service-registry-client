require 'fog/core/model'

module Fog
  module Rackspace
    class ServiceRegistry
      class Configuration < Fog::Model

        identity :id
        attribute :value

        def save
          requires :id, :value
          service.set_configuration_value(identity, value)
          true
        end

        def delete
          service.delete_configuration_value(identity)
        end
      end
    end
  end
end

