module ComprasVentas::FileBuilder
  class ComprasExcel < AbstractExcelBuilder
    def columns
      [
        { width: 10, name: 'Fecha'},
        { width: 18, name: 'Tipo Cbte'},
        { width: 8, name: 'P. Venta'},
        { width: 10, name: 'Número'},
        { width: 9, name: 'Doc. Tipo'},
        { width: 15, name: 'Doc. Número'},
        { width: 40, name: 'Proveedor'},
        { width: 13, name: 'Gravado %21'},
        { width: 13, name: 'IVA %21'},
        { width: 13, name: 'Gravado %10.5'},
        { width: 13, name: 'IVA %10.5'},
        { width: 13, name: 'Gravado %5'},
        { width: 13, name: 'IVA %5'},
        { width: 13, name: 'Gravado %27'},
        { width: 13, name: 'IVA %27'},
        { width: 13, name: 'No gravado'},
        { width: 13, name: 'Exento'},
        # { width: 13, name: 'Imp. Gas Oil'},
        { width: 13, name: 'IIBB'},
        { width: 13, name: 'Perc. IVA 3%'},
        { width: 13, name: 'Perc. IVA 1.5%'},
        { width: 13, name: 'Total'},
      ]
    end

    def put_comprobante_into_sheet(comprobante)
      row = next_row
      row.push comprobante.fecha.strftime('%d/%m/%Y')
      row.push comprobante.tipo_cbte.to_s.titleize
      row.push comprobante.punto_de_venta
      row.push comprobante.numero
      row.push comprobante.emisor_doc_tipo
      row.push comprobante.emisor_doc_nro
      row.push comprobante.emisor_razon_social
      row.push ((comprobante.gravado_21 || 0)).round(2)
      row.push ((comprobante.gravado_21 || 0) * 0.21).round(2)
      row.push ((comprobante.gravado_105 || 0)).round(2)
      row.push ((comprobante.gravado_105 || 0) * 0.105).round(2)
      row.push ((comprobante.gravado_5 || 0)).round(2)
      row.push ((comprobante.gravado_5 || 0) * 0.05).round(2)
      row.push ((comprobante.gravado_27 || 0)).round(2)
      row.push ((comprobante.gravado_27 || 0) * 0.27).round(2)
      row.push ((comprobante.no_gravado || 0)).round(2)
      row.push ((comprobante.exento || 0)).round(2)
      # row.push ((comprobante.gas_oil || 0)).round(2)
      row.push ((comprobante.iibb_ba || 0)).round(2)
      row.push ((comprobante.iva_3 || 0)).round(2)
      row.push ((comprobante.iva_15 || 0)).round(2)
      row.push ((comprobante.total || 0)).round(2)
    end


    # def set_totales(row)
    #   row.push 'TOTAL'
    #   6.times.each { row.push '' }
    #   multiplicador = "CASE WHEN ARRAY[tipo_cbte] <@ ARRAY[0, 1, 2] THEN 1 ELSE -1 END"
    #   row.push comprobantes.sum("#{multiplicador} * gravado_21")
    #   row.push comprobantes.sum("#{multiplicador} * round(gravado_21 * 0.21, 2)")
    #   row.push comprobantes.sum("#{multiplicador} * gravado_105")
    #   row.push comprobantes.sum("#{multiplicador} * round(gravado_105 * 0.105, 2)")
    #   row.push comprobantes.sum("#{multiplicador} * gravado_5")
    #   row.push comprobantes.sum("#{multiplicador} * round(gravado_5 * 0.05, 2)")
    #   row.push comprobantes.sum("#{multiplicador} * gravado_27")
    #   row.push comprobantes.sum("#{multiplicador} * round(gravado_27 * 0.27, 2)")
    #   row.push comprobantes.sum("#{multiplicador} * no_gravado")
    #   row.push comprobantes.sum("#{multiplicador} * exento")
    #   row.push comprobantes.sum("#{multiplicador} * gas_oil")
    #   row.push comprobantes.sum("#{multiplicador} * iibb_ba")
    #   row.push comprobantes.sum("#{multiplicador} * iva_3")
    #   row.push comprobantes.sum("#{multiplicador} * iva_15")
    #   row.push comprobantes.sum("#{multiplicador} * round(gravado_21 + gravado_21 * 0.21 + gravado_105 + gravado_105 * 0.105 + gravado_5 + gravado_5 * 0.05 + gravado_27 + gravado_27 * 0.27 + no_gravado + exento + gas_oil + iibb_ba + iva_3 + iva_15, 2)")

    #   # row.push comprobantes.joins(:items).where('items.tipo_iva = 7').sum("(importe * cantidad) * CASE WHEN ARRAY[type::text] <@ ARRAY['Factura_A', 'Factura_B', 'Presupuesto'] THEN 1 ELSE -1 END")
    #   # row.push comprobantes.joins(:items).where('items.tipo_iva IN (0,1,2,3,4,5)').sum("(importe * cantidad) * CASE WHEN ARRAY[type::text] <@ ARRAY['Factura_A', 'Factura_B', 'Presupuesto'] THEN 1 ELSE -1 END")
    #   # row.push ''
    #   # row.push ''
    #   # row.push comprobantes.joins(:items).where('items.tipo_iva IN (0,1,2,3,4,5)').sum("round(cantidad * importe * 0.01 * perc_iva, 2) * CASE WHEN ARRAY[type::text] <@ ARRAY['Factura_A', 'Factura_B', 'Presupuesto'] THEN 1 ELSE -1 END")
    #   # row.push comprobantes.joins(:items).sum("round(cantidad * importe * (1 + 0.01 * perc_iva), 2) * CASE WHEN ARRAY[type::text] <@ ARRAY['Factura_A', 'Factura_B', 'Presupuesto'] THEN 1 ELSE -1 END")

    #   # # columns.each do |column|
    #   # # end
    #   row.default_format = Spreadsheet::Format.new weight: :bold
    # end
  end
end
