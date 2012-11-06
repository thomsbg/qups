class StaticController < ApplicationController
  rescue_from ActionView::MissingTemplate, :with => :invalid_page
  
  def show
    render params[:id]
  end
  
  def invalid_page
    flash[:error] = 'Invalid page requested: ' << request.url
    flash[:warning] = 'Invalid page!'
    redirect_to root_path
  end
end
