module UpdateBehavior
  def save!
    self.class.source.insert_one(attributes)
  end
end

Fish0::Model.include(UpdateBehavior)
