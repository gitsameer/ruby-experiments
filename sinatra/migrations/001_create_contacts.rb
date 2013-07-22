Sequel.migration do
  change do
    create_table(:contacts) do
      primary_key :id
      String :csid, :unique=>true
      String :firstname
      String :lastname  
      Integer :age
      String :email
      String :phone
      Text   :notes
      String :type
      Integer :rating
      String :city
      String :country
      DateTime :created
      DateTime :updated
    end
  end
end