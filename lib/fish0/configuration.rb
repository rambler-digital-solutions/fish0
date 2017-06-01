module Fish0
  ##
  # Fish0::Configuration
  #
  # Usage:
  #   # config/initializers/fish0.rb
  #   Fish0::Configuration.configure do |config|
  #     config.mongo_uri = 'mongodb://user:password@host_1:27017,replica_host_2:27017/'\
  #       'fish0_development?auth_source=admin'
  #     config.mongo_params = { read: { mode: :secondary } }
  #   end
  #

  class Configuration
    include ActiveSupport::Configurable

    # Usage:
    # Enter your full mongo_uri (can include username, password, multiple hosts, ports, db name,
    # and additional options as get-parameters
    config_accessor :mongo_uri do
      'mongodb://localhost:27017/fish0_development'
    end

    # Usage:
    # Enter your as second argument to MongoClient::New
    config_accessor :mongo_params do
      { read: { mode: :secondary } }
    end
  end
end
