class ValuesController < ApplicationController
  before_filter :authenticate_user!

   def autocomplete_value_name
    @value = Value.select("id, name").where("name LIKE ?", "#{params[:name]}%").order(:name).limit(10)

    respond_to do |format|
      format.json { render json: @value , :only => [:id, :name] }
    end    

  end

end