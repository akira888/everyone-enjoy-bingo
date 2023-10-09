class CardLogsRenameColumnTypeToAction < ActiveRecord::Migration[7.0]
  def change
    rename_column :card_logs, :type, :action
  end
end
