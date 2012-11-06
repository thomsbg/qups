class Hospital < ActiveRecord::Base
  has_and_belongs_to_many :regions
  
  def self.search(type, query)
    if type == 'zip' and query
      find(:all, :conditions => ['zip = ?'], query)
    elsif type == 'name' and query
      find(:all, :conditions => ['name LIKE ?', "%#{query}%"])
    else
      find(:all)
    end
  end
end
