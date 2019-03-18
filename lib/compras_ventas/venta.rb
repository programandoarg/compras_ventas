module ComprasVentas
  class Venta < Comprobante
    def campos_comprobante
      [
      :fecha,
      :tipo_cbte,
      :punto_de_venta,
      :numero,
      :numero,
      :doc_tipo,
      :doc_nro,
      :nombre,
      :total,
      :fe_imp_tot_conc,
      :perc_a_no_categorizados,
      :fe_imp_op_ex,
      :impuestos_nacionales,
      :ingresos_brutos,
      :impuestos_municipales,
      :impuestos_internos,
      :moneda,
      :tipo_cambio,
      :cant_alicuotas,
      :cod_operacion,
      :otros_tributos,
      :fecha_venc_pago,
      ]
    end

    def lineas_alicuotas
      [
        :tipo_cbte,
        :punto_de_venta,
        :numero,
        :doc_tipo,
        :doc_nro,
        :base_imponible_alicuota,
        :tipo_alicuota,
        :importe_alicuota,
      ]
      lines = []

      # Sólo tienen alicuotas los comprobantes tipo A
      return lines unless [1, 3].include?(tipo_cbte)
      
      alicuotas.each do |id_alicuota, alicuota|
        output = ''
        output << tipo_cbte
        output << punto_de_venta
        output << numero
        output << npad(alicuota[:base_imponible], 15)
        output << pad(id, 4)
        output << npad(alicuota[:importe], 15)
        lines << output
      end
      lines
    end


  end
end
