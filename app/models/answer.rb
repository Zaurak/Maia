class Answer < ActiveRecord::Base
	belongs_to 	:user
	belongs_to 	:debate
	validates 	:user_id, 	presence: true
	validates 	:debate_id, presence: true
	validates 	:content, 	presence: true

end
