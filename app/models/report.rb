class Report < ActiveRecord::Base
  validates_presence_of :name, :domain, :thumbnail, :description, :url
  
  def thumbnail
    'thumbnails/' << read_attribute(:thumbnail)
  end
  
  def self.find_domains(*domains)
    result = {}
    domains.each do |domain|
      result[domain] = find_all_by_domain(domain)
    end
    return result
  end
end
