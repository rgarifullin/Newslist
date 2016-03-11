require 'rails_helper'

RSpec.describe 'root page', type: :request do
  let(:user) { FactoryGirl.create(:user) }

  it 'displays the root page after successful login' do
    get '/users/sign_in'
    assert_select 'form.new_user' do
      assert_select 'input[name=?]', 'user[email]'
      assert_select 'input[name=?]', 'user[password]'
      assert_select 'input[name=?]', 'user[remember_me]'
      assert_select 'input[type=?]', 'submit'
    end

    post '/users/sign_in', user: { email: user.email, password: user.password }

    expect(response).to redirect_to(root_path)
  end
end
