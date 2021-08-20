module ComprasVentas
  class Alicuotas
    class << self
      def detalle_alicuotas
        [
          { field: 'gravado_21', desc: 'Neto Gravado 21%', codigo_alicuota_afip: 5, perc_iva: 21 },
          { field: 'gravado_105', desc: 'Neto Gravado 10.5%', codigo_alicuota_afip: 4, perc_iva: 10.5 },
          { field: 'gravado_5', desc: 'Neto Gravado 5%', codigo_alicuota_afip: 8, perc_iva: 5 },
          { field: 'gravado_27', desc: 'Neto Gravado 27%', codigo_alicuota_afip: 6, perc_iva: 27 },
          { field: 'gravado_25', desc: 'Neto Gravado 2.5%', codigo_alicuota_afip: 9, perc_iva: 2.5 },
          { field: 'gravado_0', desc: 'Neto Gravado 0%', codigo_alicuota_afip: 3, perc_iva: 0 },
        ]
      end

      def get_ventas(comprobante)
        get(comprobante, :ventas)
      end

      def get_compras(comprobante)
        get(comprobante, :compras)
      end

      def get(comprobante, tipo)
        # Si es compras y no es A, entonces no tiene alicuotas
        return [] if tipo == :compras && !comprobante.es_tipo_a?

        alicuotas = []

        detalle_alicuotas.each do |detalle_alicuota|
          valor = comprobante.send(detalle_alicuota[:field])
          if valor.present? && valor > 0
            alicuota = {
              codigo_alicuota_afip: detalle_alicuota[:codigo_alicuota_afip],
              base_imponible: valor,
              importe: (detalle_alicuota[:perc_iva] * 0.01 * valor).round(2),
            }
            alicuotas.push(alicuota)
          end
        end
        # Creo que en VENTAS si o si tiene que haber alicuota aunque sea en cero
        if tipo == :ventas && alicuotas.empty?
          # Si no hay alicuotas le mando la de 0%
          # TODO: chequear si esto es necesario, creo que si pero no estoy seguro
          alicuotas = [{
            codigo_alicuota_afip: '3',
            base_imponible: 0,
            importe: 0,
          }]
        end
        alicuotas
      end
    end
  end
end
