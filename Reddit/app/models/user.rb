class User < ApplicationRecord

    validates :username, :session_token, presence:true, unique:true
    validates :password_digest, presence:true

    validate :passsword, length: {minimum: 6}, allow_nil: true 

    before_validation :ensure_session_token

    #has_many :sessions, Session, :user_id, :id, dependent::destroy

    attr_reader :password

    def password=(password)
        self.password_digest = BCrypt::Password.create(password)
        @password = password
    end

    def find_by_credentials(username, password)
        user = User.find_by(username: username)
        if user && user.the_password?(password)
            user
        else 
         return nil
        end
    end

    def the_password?(password)
       bcrypt = BCrypt::Password.new(self.password_digest)
       bcrypt.is_password?(password)
    end

    def generate_unique_session_token 
        token = SecureRandom::urlsafe_base64
        while User.exists?(session_token: token)
            token = SecureRandom::urlsafe_base64
        end
        token
    end

    def ensure_session_token
      self.session_token ||= generate_unique_session_token
    end

    def reset_session_token
        self.session_token = generate_unique_session_token
        self.save! 
        self.session_token
    end
end