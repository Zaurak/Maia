class Justification < ActiveRecord::Base
	belongs_to 	:user
	belongs_to 	:debate
	belongs_to	:answer
	belongs_to	:tag
	validates 	:user_id, 	presence: true
	validates 	:name, 			presence: true
	validates		:content,		presence: true
	validates		:voices,		presence: true

	def self.justification_list
		[['General', ['Explanation of context']], ['Source', ['Side-Debate', 'External Website', 'Reference Book']], ['Example', ['Historical example', 'Modern example', 'Hypothetic example']], ['Demonstration', ['Theorem', 'Statistical analysis']]]
	end
end
