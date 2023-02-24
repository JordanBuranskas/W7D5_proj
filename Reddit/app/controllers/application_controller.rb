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
        session[:session_token] = nil 
        @current_user = nil 
        #how do we have access to @current_user
    end
    
    def logged_in?
        !!current_user
    end
    
    def require_logged_out

        redirect_to users_url if logged_in?

    end
    
    def require_logged_in

        redirect_to new_session_url unless logged_in?
    
    end
end
