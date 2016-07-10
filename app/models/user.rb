class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, :confirmable, :lockable
  
  # Devise validates email and password automatically
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_length_of :first_name, within: 2..20, too_long: 'zadejte kratší jméno', too_short: 'zadejte delší jméno'
  validates_length_of :last_name, within: 2..30, too_long: 'zadejte kratší příjmení', too_short: 'zadejte delší příjmení'
  
  
  enum role: [:pending, :user, :manager, :admin]
  enum status: [:banned, :inactive,:active]
  after_initialize :set_default_role_and_status, :if => :new_record?

  def set_default_role_and_status
    self.role ||= :pending
    self.status ||= :inactive
  end
  
  
end
