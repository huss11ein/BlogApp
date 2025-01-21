class User < ApplicationRecord
    has_many :posts, dependent: :destroy
    has_many :comments, dependent: :destroy
    validates_presence_of :name,:email,:password_digest
    validates :email , :uniqueness => true , format: { with: URI::MailTo::EMAIL_REGEXP, message: "must be a valid email" }
    has_secure_password #password must be present , password not more that 72 , confirm password in case exist, digest password
end
