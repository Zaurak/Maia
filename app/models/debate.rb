class Debate < ActiveRecord::Base
	validates :description, presence: true



def self.search(search)
  if search
    find(:all, :conditions => ['description LIKE ?', "%#{search}%"])
  else
    find(:all)
  end
end


end
