module ComprasVentas::FileBuilder
  class AbstractFileBuilder
    EOL = "\r\n"

    def initialize(comprobantes)
      @comprobantes = comprobantes
      @output = ''
    end

    def generate
      @comprobantes.each do |comprobante|
        lineas = lineas(comprobante)
        # byebug
        next unless lineas.present?
        @output << lineas.join(EOL)
        @output << EOL
      end
      @output
    end
  end
end
