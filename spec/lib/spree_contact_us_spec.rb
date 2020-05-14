require 'spec_helper'

describe SpreeContactUs do

  after do
    # Reset to defaults.
    SpreeContactUs.mailer_from     = nil
    SpreeContactUs.mailer_to       = 'contact@please-change-me.com'
    SpreeContactUs.require_name    = false
    SpreeContactUs.require_subject = false
  end

  it 'should be valid' do
    expect(SpreeContactUs).to be_a(Module)
  end

  describe 'setup block' do
    it 'should yield self' do
      SpreeContactUs.setup do |config|
        expect(SpreeContactUs).to eq(config)
      end
    end
  end

  describe 'mailer_from' do
    it 'should be configurable' do
      SpreeContactUs.mailer_from = 'contact@please-change-me.com'
      expect(SpreeContactUs.mailer_from).to eq('contact@please-change-me.com')
    end
  end

  describe 'mailer_to' do
    it 'should be configurable' do
      SpreeContactUs.mailer_to = 'contact@changed-me.com'
      expect(SpreeContactUs.mailer_to).to eq('contact@changed-me.com')
    end
  end

  describe 'require_name' do
    it 'should be configurable' do
      SpreeContactUs.require_name = true
      expect(SpreeContactUs.require_name).to eq(true)
    end
  end

  describe 'require_subject' do
    it 'should be configurable' do
      SpreeContactUs.require_subject = true
      expect(SpreeContactUs.require_subject).to eq(true)
    end
  end
end
