class User < ApplicationRecord
# Column and before_action
  attr_accessor :remember_token, :activation_token, :reset_token
  before_save   :downcase_email
  before_create :create_activation_digest
  has_secure_password

# Validation
  validates :gender,   presence: true
  validates :name,     presence: true, length: { maximum: 50 }
  validates :email,    presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum:  6 }, allow_nil: true

# Relation
  has_one_attached :avater
  has_many :active_relationships, 
            class_name:  "LikeRelationship",
            foreign_key: "like_sender_id",
            dependent:   :destroy
  has_many :negative_relationships, 
            class_name:  "LikeRelationship",
            foreign_key: "like_receiver_id",
            dependent:   :destroy  
  has_many :like_sending,   through: :active_relationships,   source: :like_receiver
  has_many :like_receiving, through: :negative_relationships, source: :like_sender
  has_many :user_room_relationships
  has_many :rooms, through: :user_room_relationships
  
# Method

  # Return random token
  def User.new_token
    SecureRandom.urlsafe_base64
  end
      
  # Return hash of argument
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
    
  # Update remember_digest
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
      
  # Return true if digest match token of argument
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end
      
  # Update remember_digest as nil
  def forget
    update_attribute(:remember_digest, nil)
  end
    
  # Update activated as true
  def activate
    update_columns(activated: true, activated_at: Time.zone.now)
  end
    
  # Send mail for activation
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end
    
  # Update reset_digest
  def create_reset_digest
    self.reset_token = User.new_token
    update_columns(reset_digest:  User.digest(reset_token), reset_sent_at: Time.zone.now)
  end
    
  # Send mail for password_reset
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end
    
  # Return true if password_reset_expired
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  # Return avater or default
  def display_image
    self.avater.attached? ? (self.avater.variant(resize: '250x250')) : "default.png"
  end
  
  # Add argument to like_sending
  def like(other_user)
    like_sending << other_user
  end

  # Return true if User send like to argument
  def like_send_to?(other_user)
    like_sending.include?(other_user)
  end

  # Return true if User sent like by argument
  def like_sent_by?(other_user)
    like_receiving.include?(other_user)
  end

  # Return true if matching users
  def matching?(other_user)
    like_sending.include?(other_user) && like_receiving.include?(other_user)
  end

  # Return array of matcher with User
  def matchers
    like_sending & like_receiving
  end

  # Return true if form should not be displayed as button
  def cannot_push?(other_user)
    self.matching?(other_user) || self.like_send_to?(other_user)
  end

  # Return like_relationship_status
  def like_status(other_user)
    if self.like_send_to?(other_user)
      self.matchers.include?(other_user) ? "Already Matching!" : "Already Sent!"
    else
      self.like_sent_by?(other_user) ? "Thanks Like!" : "Like!"
    end
  end

    private
    
    # Make email downcase
    def downcase_email
      self.email = email.downcase
    end
    
    # Create activation_token and set activation_digest
    def create_activation_digest
      self.activation_token  = User.new_token
      self.activation_digest = User.digest(activation_token)
    end
    
end    