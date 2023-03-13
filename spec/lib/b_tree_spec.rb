# frozen_string_literal: true

RSpec.describe BTrees::BTree do
  describe '#search' do
    it 'searches for the desired value' do
      b_tree = described_class.new(minimum_degree: 2)
      b_tree.insert(5)
      b_tree.insert(10)
      b_tree.insert(15)
      b_tree.insert(20)
      b_tree.insert(25)
      b_tree.insert(30)
      b_tree.insert(35)
      b_tree.insert(1)
      b_tree.insert(2)
      b_tree.insert(3)
      b_tree.insert(4)

      expect(b_tree.root.keys).to contain_exactly(4, 20)

      l, m, r = b_tree.root.children
      expect(l.keys).to contain_exactly(2)
      expect(m.keys).to contain_exactly(10)
      expect(r.keys).to contain_exactly(30)

      l_1, r_1 = l.children
      expect(l_1.keys).to contain_exactly(1)
      expect(r_1.keys).to contain_exactly(3)

      l_2, r_2 = m.children
      expect(l_2.keys).to contain_exactly(5)
      expect(r_2.keys).to contain_exactly(15)

      l_3, r_3 = r.children
      expect(l_3.keys).to contain_exactly(25)
      expect(r_3.keys).to contain_exactly(35)
    end
  end
end
