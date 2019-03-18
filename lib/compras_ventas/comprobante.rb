module ComprasVentas
  class Comprobante < OpenStruct
    include Utilidades

    class << self
      def detalle_alicuotas
        [
          { field: 'gravado_21', desc: 'Neto Gravado 21%', tipo_iva: 5, perc_iva: 21 },
          { field: 'gravado_105', desc: 'Neto Gravado 10.5%', tipo_iva: 4, perc_iva: 10.5 },
          { field: 'gravado_5', desc: 'Neto Gravado 5%', tipo_iva: 8, perc_iva: 5 },
          { field: 'gravado_27', desc: 'Neto Gravado 27%', tipo_iva: 6, perc_iva: 27 },
        ]
      end

      def detalle_tipos
        {
          'factura_a' => { tipo_afip: 1 },
          'factura_b' => { tipo_afip: 6 },
          'factura_c' => { tipo_afip: 11 },
          'nota_de_credito_a' => { tipo_afip: 3  },
          'nota_de_credito_b' => { tipo_afip: 8  },
          'nota_de_credito_c' => { tipo_afip: 13 },
        }
      end
    end

    def lineas(tipo)
      if tipo == :alicuotas
        lineas_alicuotas
      elsif tipo == :comprobantes
        [linea_comprobantes]
      end
    end

    def linea_comprobantes
      output = ''
      campos_comprobante.each do |campo|
        output << FieldPrinter.new(self, alicuota).field(campo)
      end
      output
    end

    def lineas_alicuotas
      lines = []

      # Sólo tienen alicuotas los comprobantes tipo A
      return lines unless [:factura_a, :nota_de_credito_a].include?(tipo_cbte)
      
      alicuotas.each do |alicuota|
        output = ''
        campos_alicuotas.each do |campo|
          output << FieldPrinter.new(self, alicuota).field(campo)
        end
        lines << output
      end
      lines
    end

    def alicuotas
      alicuotas = []
      Compra.detalle_alicuotas.each do |detalle_alicuota|
        if self[detalle_alicuota[:field]].present? && self[detalle_alicuota[:field]] > 0
          alicuota = {
            tipo_alicuota: detalle_alicuota[:tipo_iva],
            base_imponible: self[detalle_alicuota[:field]],
            importe: detalle_alicuota[:perc_iva] * 0.01 * self[detalle_alicuota[:field]],
          }
          alicuotas.push(alicuota)
        end
      end
      if alicuotas.empty?
        # Si no hay alicuotas le mando la de 0%
        alicuotas = [{
          tipo_alicuota: '3',
          base_imponible: 0,
          importe: 0,
        }]
      end
      alicuotas
    end
  end
end