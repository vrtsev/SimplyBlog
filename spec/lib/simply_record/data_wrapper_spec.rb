describe SimplyRecord::DataWrapper do
  let(:klass_name)   { Post }
  let(:obj_id)       { '6' }
  let(:obj_title)    { 'Заголовок' }
  let(:obj_content)  { 'Пример текста в посте' }
  let(:example_db_data) do
    {
      'id'=>obj_id,
      'title'=>obj_title,
      'content'=>obj_content,
      'pin'=>'f',
      'user_id'=>'4',
      'category_id'=>nil,
      'created_at'=>'2017-01-02 10:51:49.897369',
      'updated_at'=>'2017-01-07 10:10:30.520733'
    }
  end
  let(:data) do
    double \
      'PG data object',
      first: example_db_data,
      to_a: [
        example_db_data,
        example_db_data,
        example_db_data,
      ]
  end

  describe '#collection' do
    subject { described_class.new(klass_name).collection(data) }

    it 'makes instance objects' do
      expect(subject).to be_a(Array)
    end

    it 'returns array with instance objects' do
      expect(subject.first).to be_a(Post)
    end

    it 'returns correct count of instance objects' do
      expect(subject.count).to eq(3)
    end

    it 'sets instance variables with values from received data' do
      expect(subject.first.id).to eq('6')
      expect(subject.first.title).to eq('Заголовок')
      expect(subject.first.content).to eq('Пример текста в посте')
    end
  end

  describe '#single_object' do
    subject { described_class.new(klass_name).single_object(data) }

    it 'sets instance variables with values from received data' do
      expect(subject.id).to eq('6')
      expect(subject.title).to eq('Заголовок')
      expect(subject.content).to eq('Пример текста в посте')
    end

    it 'makes and returns one instance object' do
      expect(subject).to be_a(Post)
    end
  end
end