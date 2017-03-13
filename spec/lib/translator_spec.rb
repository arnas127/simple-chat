require 'rails_helper'

RSpec.describe Translator do
  it 'translates text to binary dialect' do
    expect(Translator.translate('test', 'binary')).to eq('1110100110010111100111110100')
  end

  it 'translates text to valley girl dialect' do
    input = 'The last question was asked for the first time.'
    result = 'The last question was like totally asked for the first time.'
    expect(Translator.translate(input, 'valley')).to eq(result)
  end

  it 'translates text to Yoda dialect' do
    input = 'The last question was asked for the first time, half in jest, on May 21.'
    result = ' On  May 21, the last question was asked for the first time, half, in  jest, '
    expect(Translator.translate(input, 'yoda')).to eq(result)
  end

  it 'raise exeption when dialect is incorrect' do
    expect { Translator.translate('test', 'unknown') }.to raise_error(RuntimeError, 'Dialect unsupported')
  end
end
