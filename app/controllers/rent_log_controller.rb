class RentLogController < ApplicationController
  def index
    @rents = RentLog.all
  end
end
