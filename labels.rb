Bundler.require

require_relative './config.rb'

status_to_color_mapping = {
  "created" => :blue,
  "failed" => :red
}

labels = Postmen::Label.all(created_at_min: Date.parse('2016-12-31'))

rows = labels.map do |label|
  [
    label.id,
    label.status.colorize(status_to_color_mapping[label.status]),
    label.tracking_numbers.join(', '),
    label.files.to_h.dig(:label, :url)
  ]
end


puts Terminal::Table.new headings: ['ID', 'Status', 'Tracking numbers', 'Label'], rows: rows
