class Debate < ActiveRecord::Base
  belongs_to  :user
  has_many    :answers, dependent: :destroy
  has_many    :tags,    dependent: :destroy
  default_scope -> { order('created_at DESC') }
  validates :user_id,     presence: true
	validates :description, presence: true

  def self.search(search)
    if search
      find(:all, :conditions => ['description LIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end
end
