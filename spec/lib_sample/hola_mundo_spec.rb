module LibSample
  RSpec.describe HolaMundo do
    let(:hola_mundo) { HolaMundo.new }
    it 'saluda' do
      expect(hola_mundo.saludar).to eq "HOLAA"
    end
  end
end
