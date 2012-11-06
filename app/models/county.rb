class County < Region
  belongs_to :state
  
  # def name
  #    return self[:name] << ' County'
  #  end
end
