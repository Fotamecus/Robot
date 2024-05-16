module Commands
  class BaseCommand
    def execute(_robot, _table)
      raise NotImplementedError
    end
  end
end
