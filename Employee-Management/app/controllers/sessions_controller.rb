class SessionsController < ApplicationController
  # FIXME_NISH add a before_filter to redirect it to home page, if user is already logged in.
  # Fixed
  skip_before_action :authorize
  skip_before_action :verify_authenticity_token, :only => [:create]
  layout false

  def new
    #FIXME_AB: It should be using if logged_in?
    # Fixed
    redirect_to admin_path if logged_in?
  end

  def create
    # FIXME_NISH Please optimize this.
    #FIXME_AB: Client id and secret should be defined as a hash environment wise. And should be a application level constant
    #Fixed using CLIENT_ID AND CLIENT_SECRET defined in constant in ENV hash
    admin = Employee.find_by(email: auth_hash.info.email, is_admin: true)
    if admin
      session[:user_id] = admin.id
      redirect_to admin_path
    else
      redirect_to login_path, flash: { error: "You are not Authorised to login" }
    end
  end

  def destroy
    reset_session
    respond_to do |format|
      format.html{ redirect_to login_path, notice: "You have been successfully logged out" }
    end
  end


  private
    def auth_hash
      request.env['omniauth.auth']
    end
end
