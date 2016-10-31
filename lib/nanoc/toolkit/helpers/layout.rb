module Nanoc::Toolkit::Helpers
  # Contains functions for layout.
  module Layout
    # Include the compiled content of an item.
    #
    # @param [String] identifier Identifier of the item to include
    # @param [String] layout Additional layout for this item (default: none)
    # @param [Symbol] snapshot Snapshot used for this item (default: post)
    # @param [Symbol] rep Representation for the item (default: default)
    #
    # @return The compiled content at the given snapshot
    def include(identifier, layout: nil, snapshot: :last, rep: :default)
      item = SmartPath.item_from(identifier)

      # Notify to create a dependency
      notify item

      # Return compiled content
      layout ? compile(item, layout, snapshot, rep) : item.compiled_content(snapshot: snapshot, rep: rep)
    end

    # Return the compiled content of an item right before the first layout call (if any)
    #
    # @return The compiled content
    def include_raw(identifier, rep: :default)
      include(identifier, snapshot: :pre, rep: rep)
    end

    # Return the nth block of an item compiled content.
    #
    # @param [Item] item Item to get the block from
    # @param [Integer] n Number of the block to return (default: 0)
    # @param [Regex] splitter Splitter telling how to split the content into block
    def nth_block(item, n = 0, splitter: %r{/^<!-- split -->$/})
      item.compiled_content.split(splitter)[n]
    rescue
      raise "Unable to load block n°#{n} from item #{item.identifier}."
    end

    private

    # Compile an item with given layout and return its content at given snapshot and rep.
    def compile(item, layout, snapshot, rep)
      # Create an ERB output target
      erbout = ''

      # Render the layout with item's compiled content
      render(layout) do
        erbout << item.reps[:rep].compiled_content(snapshot: snapshot, rep: rep)
      end

      # Notify to create a dependency
      notify layout

      # Return ERB output target
      erbout
    end

    # Notify Nanoc of a visit to track dependencies
    def notify(target)
      Nanoc::Int::NotificationCenter.post :visit_started, target
      Nanoc::Int::NotificationCenter.post :visit_ended, target
    end
  end
end
