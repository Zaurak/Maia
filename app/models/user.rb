class User < ActiveRecord::Base
	before_save { self.email = email.downcase }
	before_create :create_remember_token

	acts_as_messageable

	has_many :debates
	has_many :answers
	has_many :tags

	has_many :users_relationships, foreign_key: "follower_id", dependent: :destroy
	has_many :followed_users, through: :users_relationships, source: :followed
	has_many :reverse_users_relationships, 	foreign_key: "followed_id",
																					class_name: 	"UsersRelationship",
																					dependent: 		:destroy
	has_many :followers, through: :reverse_users_relationships, source: :follower

	validates :name, 
						presence: true, 
						length: { maximum: 50 }

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
	validates :email, 
						presence: true, 
						format: { with: VALID_EMAIL_REGEX },
						uniqueness: { case_sensitive: false }
						
	has_secure_password
	validates :password, length: { minimum: 6 }

def User.from_omniauth(auth)
	user = User.find_by(email: auth['info']['email'])
	if user.nil?
		user = User.create
		user.provider 							= auth.provider
		user.uid 										= auth.uid
		user.name										= auth.info.name
		user.email 									= auth.info.email
		user.oauth_token 						= auth.credentials.token
		user.oauth_expires_at				= Time.at(auth.credentials.expires_at)
		user.password 							= User.create_password
		user.password_confirmation 	= user.password
		user.save!
	else
		user.update_attributes(
			provider: 					auth.provider,
			uid: 								auth.uid,
			oauth_token: 				auth.credentials.token,
			oauth_expires_at: 	Time.at(auth.credentials.expires_at)
			)
	end
	return user
end

def User.new_remember_token
	SecureRandom.urlsafe_base64
end

def User.encrypt_token(token)
	Digest::SHA1.hexdigest(token.to_s)
end

def self.encrypt_password(pass, salt)
    return Digest::MD5.hexdigest(pass.to_s+salt.to_s)
end

def self.random_string(len)
  chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a + ["&", "#", "(", ")", "-", "_", ":", "!", "?", ";", "%", ".", "+", "="]
  newpass = ""
  1.upto(len) { |i| newpass << chars[rand(chars.size-1)] }
  return newpass
end

def self.create_password
	pass = User.random_string(16)
  salt = User.random_string(16)
  User.encrypt_password(pass, salt)
end

def following_user?(other_user)
	users_relationships.find_by(followed_id: other_user.id)
end

def follow_user!(other_user)
	users_relationships.create!(followed_id: other_user.id)
end

def unfollow_user!(other_user)
	users_relationships.find_by(followed_id: other_user.id).destroy
end

def mailboxer_email(object)
	return nil
end

private
	
	def create_remember_token
		self.remember_token = User.encrypt_token(User.new_remember_token)
	end

end
