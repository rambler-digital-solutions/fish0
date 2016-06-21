module Fish0
  class Model
    extend ActiveModel::Naming
    include Fish0::Concerns::Base
    include Fish0::Concerns::ViewModel
  end
end
