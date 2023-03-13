# frozen_string_literal: true

module BTrees
  class BTreeNode
    # minimum_degree = 2
    # at most 2 keys
    # at most 3 children
    # More generally, for a B-tree of degree "m", the minimum degree is defined as ceil(m/2) - 1.

    # BTreeNode#insert
    # The middle key is moved up to the parent node,
    # and the left and right keys are moved to the left and right child nodes, respectively.
    #
    # If the parent node already has three keys, it is split in the same way,
    # with the middle key moving up to its parent node.

    def initialize(minimum_degree:)
      @minimum_degree = minimum_degree
      @maximum_degree = minimum_degree + 1

      @keys = []
      @children = []
    end

    attr_accessor :keys, :children

    def insert(key)
      i = @keys.bsearch_index { _1 >= key } || @keys.length
      if leaf?
        @keys.insert(i, key)
      else
        @children[i].insert(key)

        split_child(i) if @children[i].full?
      end
    end

    def split_child(i) # rubocop:disable Naming/MethodParameterName
      mid = @maximum_degree / 2
      new_node = BTreeNode.new(minimum_degree: @minimum_degree)

      split_key = @children[i].keys.delete_at(mid)
      @keys.insert(i, split_key)

      new_node.keys = @children[i].keys.slice!(mid..)

      @children << new_node
    end

    def full?
      @keys.length == @maximum_degree
    end

    private

    # def search_leaf_for_insert(key)
    #   return self if leaf?
    #
    #   i = @keys.bsearch_index { _1 >= key } || @keys.length
    #
    #   @children[i].search_leaf_for_insert(key)
    # end

    def leaf?
      @children.empty?
    end
  end
end
