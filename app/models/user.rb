class User < ApplicationRecord
    has_secure_password

    validates :email, presence: true, uniqueness: true,
        format: {
            with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i,
            message: :invalid
    }

    validates :username, presence: true, uniqueness: true, 
        length: { in: 3..15 },
        format: { 
            with: /\A[a-z-0-9-A-Z]+\z/,
            messege: :invalid
        }

    validates :password, length: { in:6..20 }

    before_save :downcase_attributes

    private

    def downcase_attributes
        self.username = username.downcase
        self.email = email.downcase
    end
end
