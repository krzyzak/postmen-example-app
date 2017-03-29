class LabelsController < ApplicationController
  def index
    @date = Date.parse(params.dig(:label, :date)) rescue 1.month.ago.to_date
    @labels = Postmen::Label.all(created_at_min: @date)
  end

  def show
    @label = Postmen::Label.find(params[:id])
  end

  def new
    @shipper_accounts = Postmen::ShipperAccount.all
    @paper_sizes = Postmen::PAPER_SIZES
  end
end
