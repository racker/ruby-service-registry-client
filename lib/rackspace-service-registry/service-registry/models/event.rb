require 'fog/core/model'

module Fog
  module Rackspace
    class ServiceRegistry
      class Service < Fog::Model

        identity :id
        attribute :timestamp
        attribute :type
        attribute :payload

      end
    end
  end
end

