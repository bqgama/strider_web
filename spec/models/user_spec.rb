# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  context 'validations' do
     it { is_expected.to validate_presence_of :username }
  end

  # describe '#to_s' do
  #   subject { described_class.new(name: 'Teste').to_s }

  #   it { is_expected.to eql 'Teste' }
  # end
end