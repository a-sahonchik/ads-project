# frozen_string_literal: true

require 'carrierwave/test/matchers'
require 'rails_helper'

describe PictureUploader do
  include CarrierWave::Test::Matchers

  let(:advertisement) { build(:advertisement) }
  let(:uploader) { PictureUploader.new(advertisement, pictures: []) }

  before do
    PictureUploader.enable_processing = true
    File.open('public/uploads/images/mojave.jpg') { |f| uploader.store!(f) }
  end

  context 'resized version' do
    it 'resizes image to 800 by 800 piexels' do
      expect(uploader).to be_no_larger_than(800, 800)
    end
  end

  context 'the thumb version' do
    it 'scales down a landscape image to be exactly 250 by 250 pixels' do
      expect(uploader.thumb).to be_no_larger_than(250, 250)
    end
  end

  it 'has the correct format' do
    expect(uploader).to be_format('jpeg')
  end

  after do
    PictureUploader.enable_processing = false
    uploader.remove!
  end
end
