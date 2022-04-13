require 'rails_helper'

RSpec.describe "Tweets", type: :request do

  describe '#index' do
    let!(:tweets) { create_list(:tweet, 3) }
    let(:result) { JSON.parse(response.body) }

    context 'when passing per_page parameters' do
      it 'return paginated query' do
        get tweets_path, params: { per_page: 1 }

        expect(result['total_pages']).to eq(3)
        expect(result['pages'].last['page']).to eq(3)
      end
    end

    context 'when no parameters passed' do
      it 'return all query in one page' do
        get tweets_path

        expect(result['total_pages']).to eq(1)
        expect(result['pages'].first['page']).to eq(1)
      end
    end
  end
end
