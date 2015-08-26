module RC
  module Numericality
    OPERATORS = {
      :greater_than             => :>,
      :greater_than_or_equal_to => :>=,
      :equal_to                 => :"=",
      :not_equal_to             => :"!=",
      :less_than                => :<,
      :less_than_or_equal_to    => :<=
    }.freeze

    def add_numericality_constraint(table, attribute, options = {})
      name = "#{table}_#{attribute}"

      conditions = OPERATORS.slice(*options.keys).map do |key, operator|
        value = options[key]
        [attribute, operator, value].join(" ")
      end.join(" AND ")

      execute("ALTER TABLE #{table} ADD CONSTRAINT #{name} CHECK (#{conditions})")
    end

    def drop_numericality_constraint(table, attribute)
      name = "#{table}_#{attribute}"
      execute("ALTER TABLE #{table} DROP CONSTRAINT #{name}")
    end
  end
end
