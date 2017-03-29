class RatesController < ApplicationController
  def index
    @rates = Postmen::Rate.all
  end
end
