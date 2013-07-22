Sequel.migration do
  up do
    create_table :items do
      primary_key :id
      String :body
      String :sessionid
    end
  end

  down do
    drop_table :items
  end
end
