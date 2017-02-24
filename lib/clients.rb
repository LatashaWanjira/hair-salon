class Client

  attr_reader(:name, :stylist_id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @stylist_id = attributes.fetch(:stylist_id)
  end

  define_method(:==) do |other|
    same_class = self.class().eql?(other.class())
    same_name = self.name().eql?(other.name())
    same_class.&(same_name)
  end

  define_singleton_method(:all) do
    all_clients = DB.exec("SELECT * from clients;")
    clients = []

    all_clients.each() do |client|
      name = client.fetch('name')
      stylist_id = client.fetch('stylist_id').to_i()
      clients.push(Client.new({:name => name, :stylist_id => stylist_id}))
    end
    clients
  end

  define_method(:save) do
    DB.exec("INSERT INTO clients (name, stylist_id) VALUES ('#{@name}', #{@stylist_id});")
  end

  define_method(:update) do |attributes|
    @name = attributes.fetch(:name)
    @stylist_id = self.stylist_id()
    DB.exec("UPDATE clients SET name = '#{@name}' WHERE id = #{@stylist_id};")
  end

  define_method(:delete) do
    DB.exec("DELETE FROM clients WHERE name = '#{self.name()}';")
  end
end
