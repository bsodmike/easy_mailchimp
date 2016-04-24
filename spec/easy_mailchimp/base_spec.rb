require 'spec_helper'

describe EasyMailchimp::Base do
  subject { described_class.new }

  xdescribe '#create_member' do
    let(:list_id) { "id" }

    it 'calls ' do
      expect_any_instance_of(::Gibbon::Request).to receive(:lists).with(list_id)

      subject.create_member(list_id)
    end
  end
end
