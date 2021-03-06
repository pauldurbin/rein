require 'spec_helper'

describe Rein::View do
  let(:adapter) do
    Class.new do
      include Rein::View
    end.new
  end

  subject { adapter }

  before { adapter.stub(:execute) }

  describe "#create_view" do
    before { adapter.create_view(:foo, "SELECT * FROM bar") }
    it { should have_received(:execute).with("CREATE VIEW foo AS SELECT * FROM bar") }
  end

  describe "#drop_view" do
    before { adapter.drop_view(:foo) }
    it { should have_received(:execute).with("DROP VIEW foo") }
  end
end
