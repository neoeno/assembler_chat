require 'rails_helper'

RSpec.describe ChatHelper, type: :helper do
    describe "#random_username" do
      subject { helper.random_username }

      it { is_expected.to be_a String }

      it "doesn't usually return the same value twice" do
        expect(subject).to_not eq helper.random_username
      end

      it "capitalizes each word" do
        expect(subject.titleize).to eq subject
      end
    end
end
