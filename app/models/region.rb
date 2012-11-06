class Region < ActiveRecord::Base
  has_and_belongs_to_many :hospitals
  validates_presence_of :name
  
  def self.pinned_regions
    pinned = []
    if session[:region]
      session[:region].each do |fips|
        pinned << find_by_fips(fips)
      end
    end
    return pinned
  end
end
