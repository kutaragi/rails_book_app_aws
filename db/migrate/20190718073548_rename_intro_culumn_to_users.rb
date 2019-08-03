class RenameIntroCulumnToUsers < ActiveRecord::Migration[5.2]
  def change
  	rename_column :users, :intro, :introduction
  end
end
