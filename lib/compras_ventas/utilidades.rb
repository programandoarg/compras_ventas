module ComprasVentas
  module Utilidades
    include ActionView::Helpers::NumberHelper

    def lpad(value, length)
      value.to_s.truncate(length, omission: '').ljust(length)
    end

    def pad(value, length)
      value.to_s.rjust(length, '0')
    end

    def npad(value, length)
      pad(number_with_precision(value, delimiter: "", separator: "", precision: 2), length)
    end

    def cnpad(value, length)
      pad(number_with_precision(value, delimiter: "", separator: ",", precision: 2), length)
    end

    def space(number = 1)
      ' ' * number
    end
  end
end
