class ApplicationController < ActionController::Base
    def current_user
        @current_user ||= User.find_by(session_token: session[:session_token])
            #i thought find_by was onyl for numeric searched (ie; :id)
    end
   
    def login!
        #how do we decide if we need a bang
        session[session_token] = user.reset_session_token
   
    end
   
    def log_out!
        current_user.reset_session_token if logged_in?
    
    
    end
    
    def logged_in?
    
    end
    
    def require_logged_out
    
    end
    
    def require_logged_in
    
    end
end
