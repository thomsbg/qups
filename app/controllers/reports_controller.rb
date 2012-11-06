class ReportsController < ApplicationController
  before_filter :ensure_regions_chosen, :except => :choose_regions
  
  def choose_regions
    
  end
  
  # display a listing of all the available reports for the
  # chosen regions
  def index
    @reports = Report.all
  end
  
  # temporary!
  # todo: make a template that sets up default report parameters
  def show
    report = Report.find(params[:id])
    redirect_to report.url
  end
  
  private
  
  def ensure_regions_chosen
    
  end
end
