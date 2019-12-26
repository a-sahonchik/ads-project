# frozen_string_literal: true

require 'rails_helper'

describe Advertisement do
  let(:advertisement) { build(:advertisement) }

  describe 'states' do
    describe ':draft' do
      it 'should be an initial state' do
        expect(advertisement).to be_draft
      end

      it 'should change to :opened on :start' do
        advertisement.start!
        expect(advertisement).to be_opened
      end
    end

    describe ':opened' do
      before do
        advertisement.state = :opened
      end

      it 'should change to :rejected on :reject' do
        advertisement.reject!
        expect(advertisement).to be_rejected
      end

      it 'should change to :approved on :approve' do
        advertisement.approve!
        expect(advertisement).to be_approved
      end
    end

    describe ':approved' do
      before do
        advertisement.state = :approved
      end

      it 'should change to :published on :publish' do
        advertisement.publish!
        expect(advertisement).to be_published
      end
    end

    describe ':rejected' do
      before do
        advertisement.state = :rejected
      end

      it 'should change to :draft on :change' do
        advertisement.change!
        expect(advertisement).to be_draft
      end
    end

    describe ':published' do
      before do
        advertisement.state = :published
      end

      it 'should change to :archived on :archive' do
        advertisement.archive!
        expect(advertisement).to be_archived
      end
    end

    describe ':archived' do
      before do
        advertisement.state = :archived
      end

      it 'should change to :draft on :change' do
        advertisement.change!
        expect(advertisement).to be_draft
      end
    end
  end
end
