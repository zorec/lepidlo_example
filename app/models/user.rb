# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#

class User < ActiveRecord::Base
  has_many :filters, inverse_of: :user  
  has_many :created_projects, class_name: "Project", foreign_key: "user_id", inverse_of: :user
  has_many :created_issues, class_name: "Issue", foreign_key: "user_id", inverse_of: :user
#  has_and_belongs_to_many :issues
  has_and_belongs_to_many :involved_issues, join_table: :issues_users, class_name: "Issue"

  # Include default devise modules. Others available are
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  def to_label
    labelize do
      # do not show email address
      # email[0...email.index("@")]
      email
    end
  end

  # after_initialize do
  #   if self.new_record?
  #     # values will be available for new record forms.
  #     self.user_id = 1

  #     User.find_or_create_by(email: "Anonymous") 
  #   end
  # end
end
