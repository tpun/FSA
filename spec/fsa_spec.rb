require_relative '../fsa'

describe "FSA" do
  let(:rejected) { config = Hash[ name: 'rejected',
                                  rejected: true ]
                    State.new config }

  let(:state2) { config = Hash[ name: 'state2',
                                entry_triggers: ['a'],
                                exit_triggers: ['b'],
                                accepted: true,
                                next_state: rejected ]
                  State.new config }

  let(:state1) { config = Hash[ name: 'state1',
                                entry_triggers: ['a'],
                                exit_triggers: ['b'],
                                next_state: state2 ]
                  State.new config }

  let(:state0) { config = Hash[ name: 'state0',
                                entry_triggers: ['a'],
                                exit_triggers: ['b'],
                                next_state: state1 ]
                  State.new config }

  subject { FSA.new state0, [ state0, state1, state2, rejected ] }

  describe "#accepted?" do
    it "accepts 'bb'" do
      subject.accepted?('bb').should be_true
    end

    it "accepts 'aaaaabaaab'" do
      subject.accepted?('aaaaabaaab').should be_true
    end

    it "does not accept 'bbb'" do
      subject.accepted?('bbb').should be_false
    end

    it "treats each input independently" do
      subject.accepted?('bb').should be_true
      subject.accepted?('bb').should be_true
    end
  end

  describe "#rejected?" do
    it "rejects with 'bbb'" do
      subject.rejected?('bbb').should be_true
    end
  end

end