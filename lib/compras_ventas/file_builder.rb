module ComprasVentas
  class FileBuilder
    EOL = "\r\n"

    def initialize(comprobantes, tipo)
      @comprobantes = comprobantes
      @tipo = tipo
      @output = ''
    end

    def generate
      output = ''
      @comprobantes.each do |comprobante|
        imprimir_lineas(comprobante.lineas(tipo))
      end
      @output
    end

    def imprimir_lineas(lineas)
      return unless lineas.present?
      @output << lineas.join(EOL)
      output << EOL
    end
  end
end
