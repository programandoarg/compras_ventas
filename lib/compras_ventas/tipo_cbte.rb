module ComprasVentas
  class TipoCbte
    class << self
      def hash
        {
          factura_a: { codigo_cbte_afip: 1 },
          factura_b: { codigo_cbte_afip: 6 },
          factura_c: { codigo_cbte_afip: 11 },
          nota_de_credito_a: { codigo_cbte_afip: 3  },
          nota_de_credito_b: { codigo_cbte_afip: 8  },
          nota_de_credito_c: { codigo_cbte_afip: 13 },
          nota_de_debito_a: { codigo_cbte_afip: 2  },
          nota_de_debito_b: { codigo_cbte_afip: 7  },
          nota_de_debito_c: { codigo_cbte_afip: 12 },
          factura_e: { codigo_cbte_afip: 19 },
          nota_de_debito_e: { codigo_cbte_afip: 20 },
          nota_de_credito_e: { codigo_cbte_afip: 21 },
        }
      end

      def multiplicador(tipo_cbte)
        if [:factura_a, :factura_b, :factura_c, :factura_e].include?(tipo_cbte)
          1
        else
          -1
        end
      end

      def all
        hash.keys
      end

      def tipos_a
        [:factura_a, :nota_de_credito_a, :nota_de_debito_a]
      end
    end
  end
end
