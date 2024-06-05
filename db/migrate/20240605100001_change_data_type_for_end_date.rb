class ChangeDataTypeForEndDate < ActiveRecord::Migration[7.1]
  def change
    change_column(:bookings, :end_date, :datetime)
  end
end
