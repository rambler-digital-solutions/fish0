RSpec.configure do |config|
  config.after(:each) do
    Fish0.mongo_reader.database.drop
  end
end
