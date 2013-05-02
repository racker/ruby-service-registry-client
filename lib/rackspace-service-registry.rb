require 'fog'
require 'fog/rackspace'

module Fog
  module Rackspace
    class ServiceRegistry < Fog::Service
      include Fog::Rackspace::Errors

      class ServiceError < Fog::Rackspace::Errors::ServiceError; end
      class InternalServerError < Fog::Rackspace::Errors::InternalServerError; end
      class BadRequest < Fog::Rackspace::Errors::BadRequest; end

      ENDPOINT = 'https://dfw.registry.api.rackspacecloud.com/v1.0'

      requires :rackspace_username, :rackspace_api_key
      recognizes :rackspace_endpoint
      recognizes :rackspace_auth_url
      recognizes :rackspace_auth_token

      model_path  'rackspace-service-registry/service-registry/models'
      model       :service
      collection  :services
      model       :configuration
      collection  :configurations
      model       :event
      collection  :events

      request_path 'rackspace-service-registry/service-registry/requests'
      request     :create_service
      request     :update_service
      request     :delete_service
      request     :list_services
      request     :get_service
      request     :set_configuration_value
      request     :delete_configuration_value
      request     :get_configuration_value
      request     :list_configuration_values
      request     :list_events

      class Mock

        #TODO: Proper mocks for testing
        def request
          Fog::Mock.not_implemented
        end

      end

      class Real < Fog::Rackspace::Service
        def initialize(options={})
          ## TODO: Pretty sure this will break for UK users
          @rackspace_api_key = options[:rackspace_api_key]
          @rackspace_username = options[:rackspace_username]
          @rackspace_auth_url = options[:rackspace_auth_url] || US_AUTH_ENDPOINT
          @connection_options = options[:connection_options] || {}

          @rackspace_endpoint = options[:rackspace_endpoint] || ENDPOINT

          authenticate

          @persistent = options[:persistent] || false

          @connection = Fog::Connection.new(@rackspace_endpoint, @persistent, @connection_options)
        end

        def reload
          @connection.reset
        end

        def request(params)
          begin
            response = @connection.request(params.merge({
              :headers  => {
                'Content-Type' => 'application/json',
                'X-Auth-Token' => @auth_token
              }.merge!(params[:headers] || {}),
              :host     => @host,
              :path     => "#{@path}/#{params[:path]}"
            }))
          rescue Excon::Errors::HTTPStatusError => error
            raise error
          end
          unless response.body.empty?
            begin
              response.body = Fog::JSON.decode(response.body)
            rescue Fog::JSON::LoadError
              response.body = {}
            end
          end
          response
        end

        private

        def authenticate
          options = {
            :rackspace_api_key  => @rackspace_api_key,
            :rackspace_username => @rackspace_username,
            :rackspace_auth_url => @rackspace_auth_url
          }
          super(options)
        end
      end
    end
  end
end
