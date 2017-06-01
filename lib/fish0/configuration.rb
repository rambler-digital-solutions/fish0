module Fish0
  ##
  # Fish0::Configuration
  #
  # Usage:
  #   # config/initializers/fish0.rb
  #   Fish0::Configuration.configure do |config|
  #     config.mongo_hosts = ['localhost:27017']
  #     config.mongo_params = { database: 'your_data_development', read: { mode: :secondary } }
  #   end
  #
  # Or if you want to use full mongo uri for access:
  #   # config/initializers/fish0.rb
  #   Fish0::Configuration.configure do |config|
  #     config.use_uri_format = true
  #     config.mongo_uri = 'mongodb://user:password@host_1:27017,replica_host_2:27017/'\
  #       'fish0_development?auth_source=admin'
  #     config.mongo_params = { read: { mode: :secondary } }
  #   end
  #
  class Configuration
    include ActiveSupport::Configurable

    config_accessor :mongo_hosts do
      ['localhost:27017']
    end

    # Usage:
    # Enter your database and another params as second argument to MongoClient::New
    ##
    config_accessor :mongo_params do
      { database: 'fish0_development', read: { mode: :secondary } }
    end

    # Usage:
    # Fish0 will use Configuration.mongo_uri only if Configuration.use_uri_format is set to 'true'
    ##
    config_accessor :use_uri_format do
      false
    end

    # Usage:
    # Enter your full mongo_uri (can include username, password, multiple hosts, ports, db name,
    # and additional options as get-parameters
    config_accessor :mongo_uri do
      'mongodb://localhost:27017/fish0_development'
    end
  end
end
