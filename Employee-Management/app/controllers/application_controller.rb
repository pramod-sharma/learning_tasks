class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authorize, :load_autocomplete_options

  #FIXME_NISH Please remove this exception once we remove all find in the app.
  # Fixed
  protected
    def authorize
      #FIXME_NISH: Please rename this method to user_signed_in?, please ensure it has to only check 
      # user signed in and not authorization.

      #FIXME_AB: You should not save email in session, save user's id.
      # Fixed
      #FIXME_AB: also avoid using unless statements.
      #Fixed 
      #FIXME_AB: also ensure that the logged in user is an admin
      # Fixed
    	if current_user.nil? || !current_user.is_admin
        reset_session
        redirect_to login_path, notice: 'Please Login with your Vinsol Id'
    	end
    end

    def load_autocomplete_options
      collection = Project.all + Employee.all
      gon.auto_complete_options = collection.collect do |record|
        { 'url' => send("#{record.class.to_s.downcase}_path", record), 'label' => record.name }
      end
    end

    def current_user
      #FIXME_NISH PLease use memozitation here.
      # How could we use memoization here if this intance variable is going to be instatiated everytime
      # a new request comes
      @current_user = Employee.find_by( :id => session[:user_id] )
    end

    def logged_in?
      session[:user_id]
    end

    def redirect_if_no_referer
      redirect_to admin_path if request.referer.nil?
    end

    #FIXME_AB: YOu should not be doing this. instead you have to ensure that such exception should not occur
    # Fixed using before_action where ever we have redirect_to back in application

end
