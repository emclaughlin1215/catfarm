class User < ActiveRecord::Base
  has_and_belongs_to_many :roles
  before_create :set_default_role

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :confirmable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def role?(role)
    return !!self.roles.find_by_name(role)
  end

  private

  def set_default_role
    # self.role ||= Role.find_by_name('deactive')
  end
end
