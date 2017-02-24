require('spec_helper')

describe(Stylist) do
  describe('.name') do
    it('returns the name of the stylist') do
      test_stylist = Stylist.new(:name => 'Nduku', :id => nil)
      expect(test_stylist.name()).to(eq('Nduku'))
    end
  end

  describe('.all') do
    it('returns an empty array initially') do
      expect(Stylist.all()).to(eq([]))
    end
  end

  describe('.save') do
    it('saves a new stylist') do
      test_stylist = Stylist.new(:name => 'Nduku', :id => nil)
      expect(test_stylist.save()).to(eq(test_stylist.id()))
    end
  end

  describe('.find') do
    it('finds a stylist by id number') do
      test_stylist = Stylist.new(:name => 'Nduku', :id => nil)
      test_stylist.save()
      test_stylist2 = Stylist.new(:name => 'Sarah', :id => nil)
      test_stylist2.save()
      expect(Stylist.find(test_stylist.id())).to(eq(test_stylist))
    end
  end

  describe('.update') do
    it('allows the user to edit the stylist\'s name') do
      test_stylist = Stylist.new({:name => 'Nduku', :id => nil})
      test_stylist.save()
      test_stylist.update({:name => 'Kwamboka'})
      expect(test_stylist.name()).to(eq("Kwamboka"))
    end
  end

  describe('.delete') do
    it('deletes a stylist from the list') do
      test_stylist = Stylist.new(:name => 'Nduku', :id => nil)
      test_stylist.save()
      test_stylist2 = Stylist.new(:name => 'Sarah', :id => nil)
      test_stylist2.save()
      test_stylist.delete()
      expect(Stylist.all()).to(eq([test_stylist2]))
    end
  end
end
