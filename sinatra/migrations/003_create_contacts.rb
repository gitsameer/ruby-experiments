Sequel.migration do
  change do
    create_table(:contactbyphone) do
      primary_key :id               
      String :normalizedphone, :unique=>true
      foreign_key :contacts_id
    end
  end
end                                           