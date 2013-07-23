Sequel.migration do
  change do      
    add_column :contacts, :homephone, String
    add_column :contacts, :workphone, String
  end
end