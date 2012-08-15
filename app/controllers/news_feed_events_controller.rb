class NewsFeedEventsController < ApplicationController
  before_filter :set_up_user
  after_filter :limit_database_size
  
  PER_PAGE = 10
  OBJECT_SIZE = 10
  NEWSFEED_EVENT_SIZE = 55
  NEWSFEED_OBJECTS = ["User", "Message", "Pet"]
  NEWSFEED_ACTIONS = ["Create", "Update", "Delete", "Send", "Custom Message"]
  
  def index
    set_up_instance_variables
  end
  
  def create
    user_id = params[:user_id]
    message_id = params[:message_id]
    pet_id = params[:pet_id]
    object_type = params[:news_feed_object]
    object_name = params[:news_feed_object_name]
    sender = User.find(params[:sender])
    action = params[:action_type]
    case action
    when "Create"
      if object_name.blank?
        flash[:notice] = "Missing information for #{object_type}."
        redirect_to news_feed_events_path and return
      end
      case object_type  
      when "Message"
        if Message.all.size >= OBJECT_SIZE
          flash[:notice] = "Can only have a maximum of #{OBJECT_SIZE} #{object_type}."
          redirect_to news_feed_events_path and return
        else
          object = Message.new(name: object_name)  
        end
      when "User"
        if User.all.size >= OBJECT_SIZE
          flash[:notice] = "Can only have a maximum of #{OBJECT_SIZE} #{object_type}."
          redirect_to news_feed_events_path and return
        else
          object = User.new(name: object_name)
        end
      when "Pet"
        if Pet.all.size >= OBJECT_SIZE
          flash[:notice] = "Can only have a maximum of #{OBJECT_SIZE} #{object_type}."
          redirect_to news_feed_events_path and return          
        else
          object = Pet.new(name: object_name)  
        end
      end
      if object.save
        flash[:notice] = "#{object_type} successfully created."
      else
        flash[:notice] = "Name is required for #{object_type}."
        set_up_instance_variables
        render "index" and return
      end
    when "Update"
      case object_type  
      when "Message"
        if message_id.blank? || object_name.blank?
          flash[:notice] = "Missing information for #{object_type}."
          redirect_to news_feed_events_path and return
        else
          object = Message.find(message_id)
          object.update_attributes(name: object_name)
        end
      when "User"
        if user_id.blank? || object_name.blank?
          flash[:notice] = "Missing information for #{object_type}."
          redirect_to news_feed_events_path and return
        else
          if User.find(user_id) == current_user
            flash[:notice] = "Cannot edit yourself"
            redirect_to news_feed_events_path and return
          else
            object = User.find(user_id)
            object.update_attributes(name: object_name)
          end
        end
      when "Pet"
        if pet_id.blank? || object_name.blank?
          flash[:notice] = "Missing information for #{object_type}."
          redirect_to news_feed_events_path and return
        else
          object = Pet.find(pet_id)
          object.update_attributes(name: object_name)
        end
      end
      flash[:notice] = "#{object_type} successfully updated."
    when "Delete"
      case object_type  
      when "Message"
        if message_id.blank?
          flash[:notice] = "Missing information for #{object_type}."
          redirect_to news_feed_events_path and return
        else
          object = Message.find(message_id).destroy
        end  
      when "User"
        if user_id.blank?
          flash[:notice] = "Missing information for #{object_type}."
          redirect_to news_feed_events_path and return
        else
          if User.find(user_id) == current_user
            flash[:notice] = "Cannot delete yourself"
            redirect_to news_feed_events_path and return
          else
            object = User.find(user_id).destroy
          end
        end
      when "Pet"
        if pet_id.blank?
          flash[:notice] = "Missing information for #{object_type}."
          redirect_to news_feed_events_path and return
        else
          object = Pet.find(pet_id).destroy
        end
      end
      flash[:notice] = "#{object_type} successfully removed."
    when "Send"
      case object_type  
      when "Message"
        if message_id.blank?
          flash[:notice] = "Missing information for #{object_type}."
          redirect_to news_feed_events_path and return
        else
          object = Message.find(message_id)
        end  
      when "User"
        if user_id.blank?
          flash[:notice] = "Missing information for #{object_type}."
          redirect_to news_feed_events_path and return
        else
          object = User.find(user_id)
        end
      when "Pet"
        if pet_id.blank?
          flash[:notice] = "Missing information for #{object_type}."
          redirect_to news_feed_events_path and return
        else
          object = Pet.find(pet_id)
        end
      end
      flash[:notice] = "#{object_type} successfully sent."
    when "Custom Message"
      if params[:news_feed_custom].blank?
          flash[:notice] = "Missing information for custom message."
          redirect_to news_feed_events_path and return        
      else
        flash[:notice] = "Custom message created."
        action = "custom"
        object = current_user
        options = params[:news_feed_custom]
      end
 
    else
      flash[:notice] = "Need to specify correct action"
      redirect_to news_feed_events_path and return
    end
    if NewsFeedEvent.all.size == NEWSFEED_EVENT_SIZE
      flash[:notice] = "Can only have a maximum of #{NEWSFEED_EVENT_SIZE} news feeds."
    else
      object.insertNewsFeed(action.to_sym.capitalize, current_user, sender, options)
    end
    redirect_to news_feed_events_path
  end
  
  def search
    set_up_instance_variables
    if params[:q].blank?
      @news_feed_events = User.first.news_feed_events.order("created_at desc").page(params[:page]).per(PER_PAGE)
    else
      conditions = <<-EOS
        to_tsvector('english', text) @@ plainto_tsquery('english', ?)
      EOS
      @search_params = params[:q].to_s
      search_results = User.first.news_feed_events.where(conditions, params[:q]).page(params[:page])
      @news_feed_events = search_results.per(PER_PAGE).order("created_at desc")
      @num_results = search_results.size
    end
    render 'index'
  end

  def destroy
    news_feed_event = NewsFeedEvent.find(params[:id])
    if news_feed_event.destroy
      redirect_to news_feed_events_path, notice: "News Feed Removed"
    else
      redirect_to :back, notice: "An error occured"
    end
  end
  
  private
  
  def set_up_instance_variables
    @all_news_feed_events = User.first.news_feed_events.order("created_at desc")
    @news_feed_events = @all_news_feed_events.page(params[:page]).per(PER_PAGE)
    @num_results = @all_news_feed_events.size
    @user_list = User.all
    @message_list = Message.all
    @pet_list = Pet.all
    @news_feed_objects = NEWSFEED_OBJECTS
    @action = NEWSFEED_ACTIONS
  end
  
  def set_up_user
    if User.all.size == 0
      User.create!(name: "Anonymous")
    end
  end
  
  def limit_database_size
    while User.all.size > 10
      User.last.delete
    end
    while Message.all.size > 10
      Message.last.delete
    end      
    while Pet.all.size > 10
      Pet.last.delete
    end
    while NewsFeedEvent.all.size > 55
      NewsFeedEvent.first.delete
    end
  end
end
