class User < ActiveRecord::Base
  require 'bcrypt'
  attr_accessor :password, :avatar

  validates_presence_of :email, :password, on: :create
  validates_uniqueness_of :email, case_sensitive: false

  has_many :links

  before_create do
    self.token = 'ENU'+Digest::SHA1.hexdigest(rand().to_s + Time.new.to_s)[0, 32].upcase!
  end

  def avatar
    Gravatar.new(email).image_url
  end

  #def gravatar
  #  hash = Digest::MD5.hexdigest(self.email.downcase)
  #  "http://gravatar.com/avatar/#{hash}.png?s=50"
  #end

  ##
  # Password set, generate salt everythime before crypt the new pas
  def password=(psw)
    @password            = psw
    self.password_salt   = BCrypt::Engine.generate_salt
    self.password_digest = BCrypt::Engine.hash_secret(psw, password_salt)
  end

  ##
  # Check athentication
  def authenticated?(password)
    password.present? && password_digest.present? && password_digest == BCrypt::Engine.hash_secret(password, password_salt)
  end

end
