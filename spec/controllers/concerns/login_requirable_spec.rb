# frozen_string_literal: true

require 'rails_helper'

describe LoginRequirable::Requirement do
  let(:requirement) { described_class.new(args) }

  context 'all mode' do
    let(:requirement) { described_class.new }
    it { expect(requirement.match?(:index)).to be true }
    it { expect(requirement.match?(:show)).to be true }
  end

  context 'only mode' do
    let(:args) { { only: [:index] } }
    it { expect(requirement.match?(:index)).to be true }
    it { expect(requirement.match?(:show)).to be false }
  end

  context 'except mode' do
    let(:args) { { except: [:index] } }
    it { expect(requirement.match?(:index)).to be false }
    it { expect(requirement.match?(:show)).to be true }
  end
end

describe LoginRequirable, type: :controller do
  pending
end
