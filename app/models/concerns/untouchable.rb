# Skips touching on when persisting a new record
module Untouchable
  extend ActiveSupport::Concern

  def save!(*)
    return super if persisted?

    self.class.no_touching { super }
  end

  def save(*)
    return super if persisted?

    self.class.no_touching { super }
  end

  class_methods do
    def create!(*)
      no_touching { super }
    end

    def create(*)
      no_touching { super }
    end
  end
end
