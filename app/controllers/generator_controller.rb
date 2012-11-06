class GeneratorController < ApplicationController
  before_filter :setup_pinned_session
  
  def show
    @states = State.find(:all)
    @pinned = %w{State County Csa Cbsa}.inject({}) do |result, el|
      result[el] = Region.find_all_by_fips(session[:pinned][el])
      result
    end
    @reports = %w{performance hcahps medicare mortality}.inject({}) do |result, el|
      result[el] = Report.find_all_by_domain(el)
      result
    end
    # reset_session
  end
end
