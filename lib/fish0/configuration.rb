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
  ##
  class Configuration
    include ActiveSupport::Configurable

    config_accessor :mongo_hosts do
      ['localhost:27017']
    end

    ##
    # Fish0::Configuration.mongo_params
    #
    # Usage:
    # Enter your database and another params as second arguement to MongoClient::New
    ##
    config_accessor :mongo_params do
      { database: 'fish0_development', read: { mode: :secondary } }
    end
  end
end
