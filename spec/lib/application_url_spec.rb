# frozen_string_literal: true

require 'rails_helper'
require 'application_url'

describe ApplicationUrl do
  MockRequest = Struct.new(:original_url, :scheme, :host)
  MockSettings = Struct.new(:scheme, :host)

  let(:host) {}
  let(:scheme) {}
  let(:path) { '/posts/1?foo=bar' }
  let(:domain) { "#{scheme}://#{host}" }
  let(:original_url) { "#{scheme}://#{host}#{path}" }
  let(:request) { MockRequest.new(original_url, scheme, host) }
  let(:settings) { MockSettings.new }
  let(:url) { described_class.new(request, settings) }

  before { url.correct! }

  context 'regular pattern' do
    let(:scheme) { 'https' }
    let(:host) { 'www.caresq.jp' }
    it { expect(url.corrected?).to be false }
  end

  context 'host' do
    let(:scheme) { 'http' }
    let(:host) { 'caresq.herokuapp.com' }
    let(:expected_host) { 'www.caresql.com' }
    let(:settings) { MockSettings.new(nil, expected_host) }

    it { expect(url.corrected?).to be true }
    it { expect(url.to_s).to eq "#{scheme}://#{expected_host}#{path}" }
  end

  context 'scheme' do
    let(:scheme) { 'http' }
    let(:host) { 'www.caresq.jp' }
    let(:expected_scheme) { 'https' }
    let(:settings) { MockSettings.new(expected_scheme, nil) }

    it { expect(url.corrected?).to be true }
    it { expect(url.to_s).to eq "#{expected_scheme}://#{host}#{path}" }
  end

  context 'all' do
    let(:scheme) { 'http' }
    let(:host) { 'caresq.herokuapp.com' }
    let(:expected_scheme) { 'https' }
    let(:expected_host) { 'www.caresql.com' }
    let(:settings) { MockSettings.new(expected_scheme, expected_host) }

    it { expect(url.corrected?).to be true }
    it { expect(url.to_s).to eq "#{expected_scheme}://#{expected_host}#{path}" }
  end
end
