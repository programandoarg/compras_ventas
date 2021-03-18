module ComprasVentas::FileBuilder
  class AbstractExcelBuilder
    def initialize(comprobantes)
      @comprobantes = comprobantes
    end

    def generate
      @i = 1
      set_widths
      set_headers(sheet.row(0))
      set_totales(sheet.row(1))
      put_data_into_sheet
      file_contents = StringIO.new
      book.write file_contents
      file_contents.string
    end

    def put_data_into_sheet
      @comprobantes.each do |comprobante|
        put_comprobante_into_sheet(comprobante)
      end
    end

    def set_headers(row)
      columns.each do |column|
        row.push column[:name]
      end
      row.default_format = Spreadsheet::Format.new weight: :bold, italic: true, underline: :single
    end

    def set_widths
      columns.each_with_index do |column, index|
        sheet.column(index).width = column[:width]
      end
    end

    def book
      @book ||= Spreadsheet::Workbook.new
    end

    def sheet
      @sheet ||= book.create_worksheet
    end

    def next_row
      @i += 1
      sheet.row(@i)
    end

    def multiplicador(cbte)
      ComprasVentas::TipoCbte.multiplicador(cbte.tipo_cbte)
    end
  end
end
