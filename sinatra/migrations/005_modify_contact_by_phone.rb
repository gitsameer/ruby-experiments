Sequel.migration do
  change do      
    add_column :contactbyphone, :group_id, String
    add_column :contactbyphone, :country, String
  end
end