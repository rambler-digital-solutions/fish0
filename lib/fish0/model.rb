module Fish0
  class Model
    extend ActiveModel::Naming
    include Fish0::Concerns::Base
    include Fish0::Concerns::ViewModel
    include Fish0::Concerns::Equalable

    skip_coercion
  end
end
