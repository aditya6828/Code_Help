class User < ApplicationRecord
    has_secure_password
    validates :name, :email, presence: true
    validates :email, uniqueness: true
    has_many :courses, dependent: :destroy
    has_many :user_courses
    has_many :courses, through: :user_courses
    belongs_to :user
    belongs_to :course
end
