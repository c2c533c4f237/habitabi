class ActionsController < ApplicationController
  before_filter :authenticate_user!

   def autocomplete_action_name
    @action = Action.select("id, name").where("name LIKE ?", "#{params[:name]}%").order(:name).limit(10)

    respond_to do |format|
      format.json { render json: @action , :only => [:id, :name] }
    end    
    
  end

end