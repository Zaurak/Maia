class Debate < ActiveRecord::Base
	validates :description, presence: true
end
