module Revertable
  extend ActiveSupport::Concern

  def revert!(changes = 1)
    raise "Invalid number of changes to revert: #{changes}" if changes < 1

    # `object_changes` are `nil` when a `belongs_to ... touch: true` is saved
    vs = versions.select(&:object_changes)
    raise "Not enough history to revert #{changes} changes" if changes > vs.size

    vs[changes * -1].reify.save!
  end

  class_methods do
    # revertable_association :content # defines revert_content!
    # * it `saves!` a number of `changes` ago with a no_touching block to
    #   prevent an extra query to the database
    # * it updates the association to avoid needing a reload
    # * it explicity raises an error if changes is out of bounds
    def revertable_association(attr_name)
      define_method("revert_#{attr_name}!") do |changes = 1|
        raise "Invalid number of changes to revert: #{changes}" if changes < 1

        vs = send(attr_name).versions
        raise "Not enough history to revert #{changes} changes" if changes > vs.size

        reverted = vs[changes * -1].reify
        self.class.no_touching { reverted.save! }

        send("#{attr_name}=", reverted)
      end
    end
  end
end
