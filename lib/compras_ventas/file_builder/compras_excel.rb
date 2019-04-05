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
        { width: 13, name: 'Percepciones IVA'},
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
      row.push ((comprobante.percepcion_iva || 0)).round(2)
      row.push ((comprobante.total || 0)).round(2)
    end

    def set_totales(row)
      row.push 'TOTAL'
      6.times.each { row.push '' }
      row.push @comprobantes.inject(0) { |total, cbte| total + multiplicador(cbte) * (cbte.gravado_21 || 0) }
      row.push @comprobantes.inject(0) { |total, cbte| total + multiplicador(cbte) * ((cbte.gravado_21 || 0) * 0.21).round(2) }
      row.push @comprobantes.inject(0) { |total, cbte| total + multiplicador(cbte) * (cbte.gravado_105 || 0) }
      row.push @comprobantes.inject(0) { |total, cbte| total + multiplicador(cbte) * ((cbte.gravado_105 || 0) * 0.105).round(2) }
      row.push @comprobantes.inject(0) { |total, cbte| total + multiplicador(cbte) * (cbte.gravado_5 || 0) }
      row.push @comprobantes.inject(0) { |total, cbte| total + multiplicador(cbte) * ((cbte.gravado_5 || 0) * 0.05).round(2) }
      row.push @comprobantes.inject(0) { |total, cbte| total + multiplicador(cbte) * (cbte.gravado_27 || 0) }
      row.push @comprobantes.inject(0) { |total, cbte| total + multiplicador(cbte) * ((cbte.gravado_27 || 0) * 0.27).round(2) }
      row.push @comprobantes.inject(0) { |total, cbte| total + multiplicador(cbte) * (cbte.no_gravado || 0) }
      row.push @comprobantes.inject(0) { |total, cbte| total + multiplicador(cbte) * (cbte.exento || 0) }
      # row.push @comprobantes.inject(0) { |total, cbte| total + multiplicador(cbte) * (cbte.gas_oil || 0) }
      row.push @comprobantes.inject(0) { |total, cbte| total + multiplicador(cbte) * (cbte.iibb_ba || 0) }
      row.push @comprobantes.inject(0) { |total, cbte| total + multiplicador(cbte) * (cbte.percepcion_iva || 0) }
      row.push @comprobantes.inject(0) { |total, cbte| total + multiplicador(cbte) * (cbte.total || 0) }

      row.default_format = Spreadsheet::Format.new weight: :bold
    end
  end
end
