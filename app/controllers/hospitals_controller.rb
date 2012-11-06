class HospitalsController < ApplicationController
  def search
    @hospitals = Hospital.search(params[:type], params[:query])
  end
end
