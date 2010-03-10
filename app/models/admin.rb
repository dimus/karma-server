class Admin < ActiveRecord::Base

  acts_as_authentic
    
  has_many :admins_websites
  has_many :websites, :through => :admins_websites, :uniq => true
  validates_presence_of :name, :message => "can't be blank"
  
end



# == Schema Information
#
# Table name: admins
#
#  id                :integer         not null, primary key
#  name              :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#  login             :string(255)     not null
#  crypted_password  :string(255)     not null
#  password_salt     :string(255)     not null
#  persistence_token :string(255)     not null
#

