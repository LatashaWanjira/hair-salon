class Stylist

  attr_reader(:name, :id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @id = attributes[:id]
  end

  define_method(:==) do |other|
    same_class = self.class().eql?(other.class())
    same_name = self.name().eql?(other.name())
    same_class.&(same_name)
  end

  define_singleton_method(:all) do
    all_stylists = DB.exec("SELECT * from stylists;")
    stylists = []

    all_stylists.each() do |stylist|
      name = stylist.fetch('name')
      id = stylist.fetch('id').to_i()
      stylists.push(Stylist.new({:name => name, :id => id}))
    end
    stylists
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO stylists (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_singleton_method (:find) do |id|
    found_stylist = nil

    Stylist.all().each() do |stylist|
      if stylist.id().==(id)
        found_stylist = stylist
      end
    end
    found_stylist
  end

  define_method(:update) do |attributes|
    @name = attributes.fetch(:name)
    @id = self.id()
    DB.exec("UPDATE stylists SET name = '#{@name}' WHERE id = #{@id};")
  end

  define_method(:delete) do
    DB.exec("DELETE FROM stylists WHERE id = #{self.id()};")
  end
end
