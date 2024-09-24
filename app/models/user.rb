class User < ApplicationRecord
    has_secure_password
    has_many :patients
  
    validates :username, presence: true, uniqueness: true
    validates :role, presence: true
  end
  