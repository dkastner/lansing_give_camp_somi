class UsersController < ResourceController::Base
  actions :all
  	
  before_filter :require_user, :except => [:new, :create]
  before_filter :require_manager, :only => :index
  before_filter :prevent_unauthorized_access, :only => [:edit, :update, :destroy]

  show.before do
    if object.admin?
      @upcoming_events = Event.upcoming
      @past_events = Event.past
    else
      @other_upcoming = Event.upcoming - object.events.upcoming
    end
  end
  show.wants.html do
		if @user.admin?
			render :template => 'users/admin_dashboard' 
		end
  end

<<<<<<< HEAD
	# GET /users/1/admin_dashboard
	# GET /users/1/admin_dashboard.xml
	def admin_dashboard
    @user = User.find(params[:id])
		@upcoming_events = Event.upcoming
		@past_events = Event.past

		if not @user.admin?
			redirect_to :action => 'dashboard' 
		else
    	respond_to do |format|
      	format.html # admin_dashboard.html.erb
      	format.xml  { render :xml => @user }
    	end
		end
	end
	
=======
>>>>>>> fixed some formatting and user dashboard
private
	def prevent_unauthorized_access
		forbid if current_user != object and !current_user.admin?
	end	
end
