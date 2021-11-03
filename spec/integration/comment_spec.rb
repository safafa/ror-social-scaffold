require 'swagger_helper'

describe ' API' do
  path '/api/v1/posts/{post_id}/comments' do
    post 'Creates a comment' do
      tags 'Comments'
      consumes 'application/json', 'application/xml'
      parameter name: :post_id, in: :path, type: :string
      parameter name: :comment, in: :body, schema: {
        type: :object,
        properties: {
          content: { type: :string }
        },
        required: ['content']
      }

      response '201', 'comment created' do
        let(:comment) { { content: 'test' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:comment) { {} }
        run_test!
      end
    end
  end
end
