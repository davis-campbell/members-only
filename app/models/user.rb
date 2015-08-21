class User < ActiveRecord::Base
  #attr_accessor :remember_token
  before_create { self.remember_token = User.new_token }
  before_save { self.email = email.downcase }
  validates :name, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, { presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX } }
  has_secure_password
  validates :password, presence: true
  
  has_many :posts
  has_many :comments
  
  def remember
    token = User.new_token
    update_attribute(:remember_token, token)
  end
  
  private
  
    def User.new_token
      token = SecureRandom.urlsafe_base64
      Digest::SHA1.hexdigest(token)
    end
    
end
