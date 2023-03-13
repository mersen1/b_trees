# frozen_string_literal: true

require 'pry-byebug'

module BTrees
  class BTree
    def initialize(minimum_degree: 2)
      @minimum_degree = minimum_degree
      @maximum_degree = minimum_degree + 1
      @root = BTreeNode.new(minimum_degree: minimum_degree)
    end

    attr_accessor :root

    def insert(key)
      @root.insert(key)

      return unless @root.full?

      new_root = BTreeNode.new(minimum_degree: @minimum_degree)
      new_root.children << @root
      new_root.split_child(0)
      @root = new_root
    end

    private

    attr_reader :minimum_degree
  end
end
