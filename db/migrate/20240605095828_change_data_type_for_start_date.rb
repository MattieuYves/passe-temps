class ChangeDataTypeForStartDate < ActiveRecord::Migration[7.1]
  def change
    change_column(:bookings, :start_date, :datetime)
  end
end
