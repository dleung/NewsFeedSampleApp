module NewsFeedSampleApp
  class NewsFeedEventsController < ApplicationController
    before_filter :set_up_user
    after_filter :limit_database_size
    helper_method :current_user
    
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
      object_type_full = "NewsFeedSampleApp::"+params[:news_feed_object]
      object_name = Obscenity.sanitize(params[:news_feed_object_name])
      object_constantize = object_type_full.constantize
      object_id = object_type_full.foreign_key
      sender = NewsFeedSampleApp::User.find(params[:sender])
      action = params[:action_type]
      object_type = params[:news_feed_object]
      if ["Update", "Delete", "Send"].include? action
        unless eval(object_id).present? || object_name.present?
          flash[:notice] = "Missing information for #{object_type}."
          redirect_to news_feed_events_path and return
          
        end
      end
        
      case action
      when "Create"
        if object_name.blank?
          flash[:notice] = "Missing information for #{object_type}."
        elsif object_constantize.all.size >= OBJECT_SIZE
          flash[:notice] = "Can only have a maximum of #{OBJECT_SIZE} #{object_type}."
        else
          object = object_constantize.create!(name: object_name)
          flash[:notice] = "#{object_type} successfully created."
        end
      when "Update"
        if object_name =="User" && NewsFeedSampleApp::User.find(user_id) == current_user
           flash[:notice] = "Cannot edit yourself"
        else
          object = object_constantize.find(eval(object_id))
          object.update_attributes!(name: object_name)
          flash[:notice] = "#{object_type} successfully updated."
        end
      when "Delete"
        if (object_name =="User") && (NewsFeedSampleApp::User.find(user_id) == current_user)
          flash[:notice] = "Cannot delete yourself"
        else 
          object = object_constantize.find(eval(object_id)).destroy
          flash[:notice] = "#{object_type} successfully removed."
        end
      when "Send"
        object = object_constantize.find(eval(object_id))
        flash[:notice] = "#{object_type} successfully sent."          
      when "Custom Message"
        if params[:news_feed_custom].blank?
            flash[:notice] = "Missing information for custom message."        
        else
          flash[:notice] = "Custom message created."
          action = "custom"
          object = current_user
          options = params[:news_feed_custom]
        end
      else
        flash[:notice] = "Need to specify correct action"
      end
      if NewsFeedEvent.all.size == NEWSFEED_EVENT_SIZE
        flash[:notice] = "Can only have a maximum of #{NEWSFEED_EVENT_SIZE} news feeds."
      elsif defined?(object).present? && object.present?
        object.insertNewsFeed(action.to_sym.capitalize, current_user, sender, options)
      end
      redirect_to news_feed_events_path
    end
    
    def search
      set_up_instance_variables
      if params[:q].blank?
        @news_feed_events = NewsFeedSampleApp::User.first.news_feed_events.order("created_at desc").page(params[:page]).per(PER_PAGE)
      else
        conditions = <<-EOS
          to_tsvector('english', text) @@ plainto_tsquery('english', ?)
        EOS
        @search_params = params[:q].to_s
        search_results = NewsFeedSampleApp::User.first.news_feed_events.where(conditions, params[:q]).page(params[:page])
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
      @all_news_feed_events = NewsFeedSampleApp::User.first.news_feed_events.order("created_at desc")
      @news_feed_events = @all_news_feed_events.page(params[:page]).per(PER_PAGE)
      @num_results = @all_news_feed_events.size
      @user_list = NewsFeedSampleApp::User.all
      @message_list = NewsFeedSampleApp::Message.all
      @pet_list = NewsFeedSampleApp::Pet.all
      @news_feed_objects = NEWSFEED_OBJECTS
      @action = NEWSFEED_ACTIONS
    end
    
    def set_up_user
      if NewsFeedSampleApp::User.all.size == 0
        NewsFeedSampleApp::User.create!(name: "Anonymous")
      end
    end
    
    def limit_database_size
      while NewsFeedSampleApp::User.all.size > 10
        NewsFeedSampleApp::User.last.delete
      end
      while NewsFeedSampleApp::Message.all.size > 10
        NewsFeedSampleApp::Message.last.delete
      end      
      while NewsFeedSampleApp::Pet.all.size > 10
        NewsFeedSampleApp::Pet.last.delete
      end
      while NewsFeedEvent.all.size > 55
        NewsFeedEvent.first.delete
      end
    end
  end
  
  def current_user
    current_user
  end
end