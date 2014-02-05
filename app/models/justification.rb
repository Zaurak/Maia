class Justification < ActiveRecord::Base
	belongs_to 	:user
	belongs_to 	:debate
	belongs_to	:answer
	belongs_to	:tag
	belongs_to 	:objection
	has_many		:objections,	dependent: :destroy
	has_many 		:votes,    		dependent: :destroy
	validates 	:user_id, 	presence: true
	validates 	:name, 			presence: true
	validates		:content,		presence: true
	validates		:voices,		presence: true

	def self.justification_list
		[['General', ['Explanation of context']], ['Source', ['Side-Debate', 'External Website', 'Reference Book']], ['Example', ['Historical example', 'Modern example', 'Hypothetic example']], ['Demonstration', ['Theorem', 'Statistical analysis']]]
	end
end
