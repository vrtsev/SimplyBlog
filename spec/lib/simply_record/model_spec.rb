describe SimplyRecord::Model do
  class Post < SimplyRecord::Model
  end

  before do
    allow(described_class).to receive(:send_request).and_return(received_data)
    allow_any_instance_of(SimplyRecord::DataWrapper).to receive_messages \
      collection: received_collection,
      single_object: received_single_object
  end

  let(:all_fields)             { %w(id title content pin user_id category_id created_at updated_at) }
  let(:received_collection)    { [first_post, second_post] }
  let(:received_single_object) { first_post }
  let(:first_post)             { create :post, title: 'First post' }
  let(:second_post)            { create :post, title: 'Second post' }
  let(:custom_title)           { 'My title' }
  let(:custom_content)         { 'My content' }
  let(:received_data) do
    instance_double \
      'PG::Result',
      fields: all_fields,
      first: { 'id' => '1' },
      result_status: 1
  end
  let(:data) do
    {
      title: custom_title,
      content: custom_content
    }
  end

  context 'instance methods' do
    subject              { Post }
    let(:object)         { subject.find 1 }
    let(:custom_title)   { 'First post' }
    let(:custom_content) { 'My content' }

    describe '#update' do
      it 'returns instance object' do
        expect(object.update(data)).to be_a(Post)
      end

      it 'sets atrtributes' do
        expect(object.update(data).title).to eq(custom_title)
        expect(object.update(data).content).to eq(custom_content)
      end

      it 'changes timestamps' do
        expect(object.update(data).updated_at).to eq(Time.now.utc.to_s)
      end
    end

    describe '#destroy' do
      it 'merge user data with timestamps' do
      end
    end
  end

  context 'class methods' do
    subject { Post }

    describe '.new' do
      it 'returns new instance object' do
        expect(subject.new).to be_a(Post)
      end

      it 'sets nil atrtributes' do
        expect(subject.new.id).to be_nil
        expect(subject.new.title).to be_nil
        expect(subject.new.content).to be_nil
      end
    end

    describe '.all' do
      it 'returns array' do
        expect(subject.all).to be_a(Array)
      end

      it 'returns array with collection of instances' do
        expect(subject.all).to include(first_post)
        expect(subject.all).to include(second_post)
      end
    end

    describe '.first' do
      it 'returns instance object' do
        expect(subject.first).to be_a(Post)
      end

      it 'returns object with the lowest id' do
        expect(subject.first.id).to eq('1')
      end
    end

    describe '.last' do
      it 'returns instance object' do
        expect(subject.last).to be_a(Post)
      end

      it 'returns object with the lowest id' do
        expect(subject.last.id).to eq('1')
      end
    end

    describe '.find' do
      let(:id)         { 4 }
      let(:first_post) { create :post, id: '4', title: 'Fourth post' }

      it 'returns instance object' do
        expect(subject.find(id)).to be_a(Post)
      end

      it 'returns object with the lowest id' do
        expect(subject.find(id).id).to eq('4')
      end
    end

    describe '.where' do
      let(:query)       { 'pin=f' }
      let(:first_post)  { create :post, title: 'First post', pin: 'f' }
      let(:second_post) { create :post, title: 'Second post', pin: 'f' }

      it 'returns array' do
        expect(subject.where(query)).to be_a(Array)
      end

      it 'returns array with collection of instances' do
        expect(subject.where(query).first.pin).to eq('f')
        expect(subject.where(query).second.pin).to eq('f')
      end
    end

    let(:first_post) { create :post, title: custom_title, content: custom_content }
    describe '.create' do
      it 'returns instance object' do
        expect(subject.create(data)).to be_a(Post)
      end

      it 'sets atrtributes' do
        expect(subject.create(data).title).to eq(custom_title)
        expect(subject.create(data).content).to eq(custom_content)
      end

      it 'sets timestamps' do
        expect(subject.create(data).created_at).to eq(Time.now.utc.to_s)
        expect(subject.create(data).updated_at).to eq(Time.now.utc.to_s)
      end
    end

    let(:id) { 1 }
    describe '.update' do
      it 'returns instance object' do
        expect(subject.update(id, data)).to be_a(Post)
      end

      it 'sets atrtributes' do
        expect(subject.update(id, data).title).to eq(custom_title)
        expect(subject.update(id, data).content).to eq(custom_content)
      end

      it 'changes timestamps' do
        expect(subject.update(id, data).updated_at).to eq(Time.now.utc.to_s)
      end
    end

    describe '.destroy' do
      it 'deletes record in DB' do
        # TODO : Take care of this example
        # expect(subject.destroy(id)).to eq()
      end

      it 'notifies that record successfuly deleted' do
        # TODO : Make sure that .destroy should return deleted object instance
        # expect(subject.destroy(id)).to be_nil
      end
    end
  end
end
