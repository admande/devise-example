class User < ActiveRecord::Base
  validates :first_name, presence: true
  validates :last_name, presence: true
  after_initialize :set_default_values

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  def admin?
    role == "admin"
  end

  def set_default_values
    self.role ||= "member"
  end
end
