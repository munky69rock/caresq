# frozen_string_literal: true

require 'rails_helper'
require 'application_url'

describe ApplicationUrl do
  OK = {
    scheme: 'https',
    host: 'www.caresq.jp'
  }.freeze

  NG = {
    scheme: 'http',
    host: 'caresq.herokuapp.com'
  }.freeze

  OK.keys.each do |key|
    let(key) { OK[key] }
  end
  let(:path) { '/posts/1?foo=bar' }
  let(:domain) { "#{scheme}://#{host}" }
  let(:original_url) { "#{scheme}://#{host}#{path}" }
  let(:request) { Struct.new(:original_url, :scheme, :host).new(original_url, scheme, host) }
  let(:url) { described_class.new(request, settings) }

  before { url.correct! }

  (OK.keys.size + 1).times.each do |i|
    OK.keys.combination(i) do |attrs|
      context "settings with #{attrs.join(',') || 'none'}" do
        let(:settings) do
          {}.tap do |settings|
            attrs.each { |key| settings[key] = OK[key] }
          end
        end

        context 'ok' do
          it { expect(url.corrected?).to be false }
        end

        if attrs.size.positive?
          context 'ng' do
            attrs.each do |key|
              let(key) { NG[key] }
            end

            it { expect(url.corrected?).to be true }
            it { expect(url.to_s).to eq "#{OK[:scheme]}://#{OK[:host]}#{path}" }
          end
        end
      end
    end
  end
end
