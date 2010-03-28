class UsersController < ResourceController::Base
  actions :all
  	
  	before_filter :require_user, :except => [:new, :create]
  	before_filter :require_manager, :only => :index
  	before_filter :prevent_unauthorized_access, :only => [:edit, :update, :destroy]
	# GET /users/1/dashboard
	# GET /users/1/dashboard.xml
	def dashboard
    @user = User.find(params[:id])
		@other_upcoming = Event.upcoming - @user.events.upcoming

		if @user.admin?
			render :action => 'admin_dashboard' 
		else
    	respond_to do |format|
      	format.html # dashboard.html.erb
      	format.xml  { render :xml => @user }
    	end
		end
	end

	# GET /users/1/admin_dashboard
	# GET /users/1/admin_dashboard.xml
	def admin_dashboard
    @user = User.find(params[:id])
		@upcoming_events = Event.upcoming
		@past_events = Event.past

		if not @user.admin?
			render :action => 'dashboard' 
		else
    	respond_to do |format|
      	format.html # admin_dashboard.html.erb
      	format.xml  { render :xml => @user }
    	end
		end
	end
	
private
	def prevent_unauthorized_access
		forbid if current_user != object and !current_user.admin?
	end	
end
