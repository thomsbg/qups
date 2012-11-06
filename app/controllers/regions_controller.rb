class RegionsController < ApplicationController
  before_filter :setup_pinned_session
  
  def pin
    region = Region.find_by_fips(params[:state_fips] || params[:county_fips])
    if region.nil? or session[:pinned][region.class.to_s].include?(region.fips)
      render :json => 'failure'.to_json, :status => 400
    else
      session[:pinned][region.class.to_s] << region.fips
      render :json => {
        :name => region.name,
        :fips => region.fips
      }
    end
    logger.debug session.inspect
  end
  
  def unpin
    region = Region.find_by_fips(params[:fips])
    if region
      session[:pinned][region.class.to_s].delete(region.fips)
      render :json => 'success'.to_json
    else
      render :json => 'failure'.to_json, :status => 400
    end
    logger.debug session.inspect
  end
  
  # List all the states, return as html <option>s with fips codes values
  def states
    render :partial => 'state_option', :collection => State.all
  end
  
  # List the counties for a given state, return as html <option>s with fips code values
  def counties
    counties = State.find_by_fips(params[:state_fips]).counties
    render :partial => 'option', :collection => counties
  end
end
