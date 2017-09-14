class User < ActiveRecord::Base
  enum role: [:admin, :standard, :premium]
  after_initialize :set_default_role
  has_many :collaborators, dependent: :destroy
  has_many :wikis, dependent: :destroy
  

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

  def collaborator_for(wiki)
    collaborators.where(wiki_id: wiki.id).first
  end
end
