class Label
  STATUS_TO_COLOR_MAPPING = {
    'created' => :blue,
    'failed' => :red
  }.freeze

  attr_reader :date

  def initialize(date)
    @date = Date.parse(date)
    require_relative './config.rb'
  end

  def table
    Terminal::Table.new headings: ['ID', 'Status', 'Tracking numbers', 'Label'], rows: rows
  end

  def rows
    labels.map do |label|
      [
        label.id,
        label.status.colorize(STATUS_TO_COLOR_MAPPING[label.status]),
        label.tracking_numbers.join(', '),
        label.files.to_h.dig(:label, :url)
      ]
    end
  end

  def labels
    @labels ||= Postmen::Label.all(created_at_min: date)
  end
end
