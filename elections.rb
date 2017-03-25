require 'csv'

# Data comes from https://cityofphiladelphia.carto.com/u/phl/tables/board_workers_2017/public

class Elections
  attr_reader :headers, :rows

  def initialize(file)
    @headers, *@rows = CSV.parse(File.read(file))
  end

  def all
    @all ||= rows.map do |row|
      hsh = Hash[headers.zip(row)]

      # normalize the data
      hsh['id']       = hsh.delete('cartodb_id').to_i
      hsh['ward']     = hsh['ward'].to_i
      hsh['division'] = hsh['division'].to_i
      hsh
    end
  end

  def wards
    @wards ||= all.group_by { |row| row['ward'] }
  end

  def find_ward(id)
    wards[id.to_i]
  end

  def find_division(ward_id, division_id)
    ward = find_ward(ward_id)
    return if ward.nil?

    ward.select do |row|
      row['division'] == division_id.to_i
    end
  end
end
