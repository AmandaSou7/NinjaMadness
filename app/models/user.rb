class User < ActiveRecord::Base
	attr_accessor :password
  attr_accessible :email_address, :first_name, :last_name, :password, :salt

  validates :first_name, :last_name, 	:presence 	=> true,
  			:format 									=> { :with => /^[-a-zA-Z]+$/ }
  validates :email_address,		:presence 			=> true,
  			:format 								=> { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i },
  			:uniqueness								=> true

  validates :password,		:presence				=> true,
  			:confirmation 							=> true,
  			:length 								=> { :within => 6..13 }

  before_save :encrypt_password

  def has_password?(submitted_password)
  	encrypted_password == encrypt(submitted_password)
  end


  # class method that checks whether the user's email and submitted_password are valid
  def self.authenticate(email, submitted_password)
    user = find_by_email_address(email)
    # user = where(:email_address => email)

   	return nil if user.nil?
   	return user if user.has_password?(submitted_password)
  end


  private
  	def encrypt_password
  		# generate a unique salt if it's a new user
  		self.salt = Digest::SHA2.hexdigest("#{Time.now.utc}--#{password}") if self.new_record?
  	
  		# encrypt the password and store that in the encrypted_password field
  		self.encrypted_password = encrypt(password)
  	end

  	# encrypt the password using both the salt and the passed password
  	def encrypt(pass)
  		Digest::SHA2.hexdigest("#{self.salt}--#{pass}")
  	end

  # validates :email_address, :first_name, :last_name, :password, :presence => true
  # validates_format_of :first_name, :last_name, :with => /^[-a-zA-Z]+$/
  # validates_format_of :email_address, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create
  # validates :email_address, :uniqueness => true
  # validates :password, :length => { :minimum => 6 }, :confirmation => true

  has_many :players, :dependent => :destroy
  has_many :friends, :dependent => :destroy
  has_one :score
end
