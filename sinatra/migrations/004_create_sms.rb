Sequel.migration do
  change do
    create_table(:messages) do
      primary_key :id
      Integer :ROWID, :unique=>true
      DateTime :date
      String :type  
      String :address
      String :country
      Text :text
      Integer :group_id
      DateTime :created
      DateTime :updated
    end
  end
end