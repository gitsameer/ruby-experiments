Sequel.migration do
  change do      
    add_column :messages, :normalizedphone, String
  end
end