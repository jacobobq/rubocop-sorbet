# frozen_string_literal: true

require "rubocop"

module RuboCop
  module Cop
    module Sorbet
      # This cop disallows using `T.unsafe` anywhere.
      #
      # @example
      #
      #   # bad
      #   T.unsafe(foo)
      #
      #   # good
      #   foo
      class ForbidTUnsafe < RuboCop::Cop::Base
        MSG = "Do not use `T.unsafe`."
        RESTRICT_ON_SEND = [:unsafe].freeze

        # @!method t_unsafe?(node)
        def_node_matcher(:t_unsafe?, "(send (const nil? :T) :unsafe _)")

        def on_send(node)
          add_offense(node) if t_unsafe?(node)
        end
      end
    end
  end
end
