module Fish0
  ##
  # Fish0::Configuration
  #
  # Usage:
  #   Fish0 will use mongo_uri if it's not empty and ignore mongo_hosts:
  #   # config/initializers/fish0.rb
  #   Fish0::Configuration.configure do |config|
  #     config.mongo_uri = 'mongodb://user:password@host_1:27017,replica_host_2:27017/'\
  #       'fish0_development?auth_source=admin'
  #     config.mongo_params = { read: { mode: :secondary } }
  #   end
  #
  # Or if you want to use array of hosts:
  #   # config/initializers/fish0.rb
  #   Fish0::Configuration.configure do |config|
  #     config.mongo_hosts = ['localhost:27017']
  #     config.mongo_params = { database: 'your_data_development', read: { mode: :secondary } }
  #   end

  class Configuration
    include ActiveSupport::Configurable

    # Usage:
    # Enter your full mongo_uri (can include username, password, multiple hosts, ports, db name,
    # and additional options as get-parameters
    # NOTE: do not set default value here - it will break projects which don't use mongo_uri format
    config_accessor :mongo_uri

    config_accessor :mongo_hosts do
      ['localhost:27017']
    end

    # Usage:
    # Enter your database and another params as second argument to MongoClient::New
    # In case of using mongo_uri - no need to set database here,
    # but database set here will override the one set in mongo_uri
    config_accessor :mongo_params do
      { database: 'fish0_development', read: { mode: :secondary } }
    end
  end
end
