# frozen_string_literal: true

require 'pry-byebug'

module BTrees
  class BTree
    def initialize(max_degree: 3)
      @max_degree = max_degree

      @root = BTreeNode.new(max_degree: max_degree)
    end

    attr_accessor :root

    def insert(key)
      @root.insert(key)

      return unless @root.at_most_keys?

      new_root = BTreeNode.new(max_degree: @max_degree)
      new_root.children << @root
      new_root.split_child(0)
      @root = new_root
    end

    private

    attr_reader :max_degree
  end
end
