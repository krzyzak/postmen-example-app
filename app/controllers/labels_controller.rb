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

  def create
    label = Postmen::Label.create(data.deep_symbolize_keys)

    redirect_to label_path(label.id)
  end

  def data
    {
      shipper_account: {
        id: params[:label][:shipper_account_id]
      },
      service_type: params[:label][:service_type],
      shipment: {
        ship_from: params.dig(:label, :ship_from).to_hash,
        ship_to: params.dig(:label, :ship_to).to_hash,
        parcels: [
          box_type: 'custom',
          dimension: params.dig(:label, :dimension).to_hash,
          description: 'Sample',
          weight: item[:weight],
          items: [item]
        ]
      }
    }
  end

  def item
    {
      description: params.dig(:label, :parcel, :description),
      quantity: params.dig(:label, :parcel, :quantity),
      price: params.dig(:label, :parcel, :price).to_hash,
      weight: params.dig(:label, :parcel, :weight).to_hash
    }
  end
end
