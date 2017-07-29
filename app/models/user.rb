class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  ROLES = ["admin", "editor"]
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
   has_many :memberships
   has_many :groups, :through => :memberships
   has_one :profile
   has_many :registrations
   accepts_nested_attributes_for :profile
  def display_name
    self.email.split("@").first
  end

   def is_admin?
     self.role == "admin"
   end

   def is_editor?
     ["admin", "editor"].include?(self.role)  # 如果是 admin 的话，当然也有 editor 的权限
   end
   
end
