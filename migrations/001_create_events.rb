Sequel.migration do
  up do
    create_table(:events) do
      primary_key :id
      String      :name
      DateTime    :starts_at
      DateTime    :ends_at
    end
  end
end
