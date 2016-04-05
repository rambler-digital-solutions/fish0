require 'mongo'
require 'fish0/version'
require 'fish0/engine'
require 'fish0/exceptions'
require 'fish0/repository'
require 'fish0/paginator'
require 'fish0/concerns/cacheable'
require 'fish0/concerns/paginatable'
require 'fish0/concerns/view_model'
require 'fish0/concerns/base'
require 'fish0/model'

module Fish0
  class << self
    def mongo_reader
      Mongo::Logger.logger = mongo_config['logger'] || Rails.logger
      Mongo::Client.new(mongo_config['hosts'], mongo_config['params'])
    end

    def mongo_config
      @mongo_config || Rails.application.config_for(:mongo)
    end
  end
end
