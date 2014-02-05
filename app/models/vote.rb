class Vote < ActiveRecord::Base
	belongs_to 	:user
	belongs_to 	:debate
	belongs_to	:answer
	belongs_to	:tag
	belongs_to 	:objection
	belongs_to	:justification
	validates 	:user_id, 		presence: true
	validates 	:clarity, 		presence: true
	validates		:usefulness,	presence: true
	validates		:completness,	presence: true

end
