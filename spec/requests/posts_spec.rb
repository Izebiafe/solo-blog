# RSpec.describe 'Posts', type: :request do
#   describe 'GET users/:user_id/posts' do
#     before :each do
#       get user_posts_path({ user_id: 1 })
#     end

#     it 'returns http success' do
#       expect(response).to have_http_status(:success)
#     end

#     it 'renders the index template' do
#       expect(response).to render_template('index')
#     end

#     it 'renders the correct text' do
#       expect(response.body).to match(/this is the users post/)
#     end
#   end

#   describe 'GET users/:user_id/posts/:id' do
#     before :each do
#       get '/users/1/posts/1'
#     end

#     it 'returns http success' do
#       expect(response).to have_http_status(:success)
#     end

#     it 'renders the show template' do
#       expect(response).to render_template('show')
#     end

#     it 'renders the correct text' do
#       expect(response.body).to match(/this is going to show the user post page/)
#     end
#   end
# end
