module Commands
  # Base class for all commands
  class Base
    def execute!
      raise NotImplementedError, "#{self.class.name} must implement the execute! method"
    end
  end
end
