require('spec_helper')

describe(Client) do
  describe('.name') do
    it('returns the name of the client') do
      test_client = Client.new(:name => 'Mimi', :stylist_id => 1)
      expect(test_client.name()).to(eq('Mimi'))
    end
  end

  describe('.all') do
    it('returns an empty array initially') do
      expect(Client.all()).to(eq([]))
    end
  end

  describe('.save') do
    it('saves a new client') do
      test_client = Client.new(:name => 'Mimi', :stylist_id => 1)
      test_client.save()
      expect(Client.all()).to(eq([test_client]))
    end
  end

  describe('.update') do
    it('allows the user to edit the client\'s name') do
      test_client = Client.new({:name => 'Kimberly', :stylist_id => 1})
      test_client.save()
      test_client.update({:name => 'Elizabeth'})
      expect(test_client.name()).to(eq("Elizabeth"))
    end
  end

  describe('.delete') do
    it('deletes a client from the list') do
      test_client = Client.new(:name => 'Mimi', :stylist_id => 1)
      test_client.save()
      test_client2 = Client.new(:name => 'Kimberly', :stylist_id => 1)
      test_client2.save()
      test_client.delete()
      expect(Client.all()).to(eq([test_client2]))
    end
  end

  describe('.stylist_id') do
    it('links a client to a stylist') do
      test_client = Client.new(:name => 'Mimi', :stylist_id => 1)
      expect(test_client.stylist_id()).to(eq(1))
    end
  end
end
