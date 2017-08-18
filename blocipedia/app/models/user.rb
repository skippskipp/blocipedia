class User < ActiveRecord::Base
  enum role: [:admin, :standard, :premium]
  after_initialize :set_default_role

  validates :username,
            :presence => true,
            :uniqueness => {
              :case_sensitive => false
            }

  def set_default_role
    self.role ||= :standard
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable

end
