# frozen_string_literal: true

module BTrees
  class BTreeNode
    # max_degree = 3
    # at most 2 keys
    # at most 3 children
    # More generally, for a B-tree of degree "m", the minimum degree is defined as ceil(m/2) - 1.

    # BTreeNode#insert
    # The middle key is moved up to the parent node,
    # and the left and right keys are moved to the left and right child nodes, respectively.
    #
    # If the parent node already has three keys, it is split in the same way,
    # with the middle key moving up to its parent node.

    def initialize(max_degree:)
      @max_degree = max_degree

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

        split_child(i) if @children[i].at_most_keys?
      end
    end

    def split_child(i) # rubocop:disable Metrics/AbcSize, Naming/MethodParameterName
      mid = @max_degree / 2
      right_node = BTreeNode.new(max_degree: @max_degree)

      split_key = @children[i].keys.delete_at(mid)
      @keys.insert(i, split_key)

      right_node.keys = @children[i].keys.slice!(mid..)

      right_node.children = @children[i].children.slice!(mid + 1..) if @children[i].at_most_children?

      @children.insert(i + 1, right_node)
    end

    def at_most_keys?
      @keys.length == @max_degree
    end

    def at_most_children?
      @children.length == (@max_degree - 1) * 2
    end

    def leaf?
      @children.empty?
    end
  end
end
