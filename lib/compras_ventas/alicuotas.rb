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

      def get(comprobante)
        alicuotas = []

        # Sólo tienen alicuotas los comprobantes tipo A
        # return alicuotas unless [:factura_a, :nota_de_credito_a].include?(comprobante.tipo_cbte)

        detalle_alicuotas.each do |detalle_alicuota|
          valor = comprobante.send(detalle_alicuota[:field])
          if valor.present? && valor > 0
            alicuota = {
              codigo_alicuota_afip: detalle_alicuota[:codigo_alicuota_afip],
              base_imponible: valor,
              importe: detalle_alicuota[:perc_iva] * 0.01 * valor,
            }
            alicuotas.push(alicuota)
          end
        end
        if alicuotas.empty?
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
