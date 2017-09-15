require 'spec_helper'

describe Users::RegistrationsController do
  before :each do
    @request.env['devise.mapping'] = Devise.mappings[:user]
    @user1 = FactoryGirl.create(:user, :email => "user1@example.com")
    FactoryGirl.create(:newsletter_user, :email => @user1.email)
    @user2 = FactoryGirl.create(:user, :email => "user2@example.com")
    @total_user = User.count
    @subscriber_count = NewsletterUser.count
  end
    
  describe 'return status of user subscribed' do
    it "return true if user is subscribing" do
      sign_in @user1
      subject.send(:resource=, @user1)
      expect(subject.subscribed?).to be true
    end
        
    it "return false if user is not subscribing" do
      sign_in @user2
      subject.send(:resource=, @user2)
      expect(subject.subscribed?).to be false
    end
  end
    
  describe 'sign_up' do
    it "sign up should render the sign_up form" do
      get :new
      expect(response).to render_template('devise/registrations/new')
    end
  end
    
  describe 'edit' do
    it "edit should render the edit form" do
      sign_in @user1
      get :edit
      expect(response).to render_template('devise/registrations/edit')
    end
  end
  
  describe 'destroy' do
    it "destroy should delete the account and back to home page" do
      sign_in @user1
      delete :destroy
      expect(response).to redirect_to root_path
      expect(User.count).to eq(@total_user - 1)
    end
  end
  
  # describe 'cancel' do
  #   it "edit should render the edit form" do
  #     sign_in @user1
  #     get "cancel"
  #     expect(response).to redirect_to root_path
  #   end
  # end
  
  describe 'update user' do
    it 'allow user to change password' do
      sign_in @user1
      put :update, {:user => {:current_password => @user1.password, :password => "password", :password_confirmation => "password"}}
      expect(flash[:notice]).to eq 'Your account has been updated successfully.'
      expect(response).to redirect_to root_path
    end
    
    it "stay in edit page if current password doesn't match" do
      sign_in @user2
      put :update, {:user => {:current_password => "qwewiofherig", :password => "password", :password_confirmation => "password"}}
      expect(response).to render_template 'devise/registrations/edit'
    end
    
    it "stay in edit page if new password and password_confirmation doesn't match" do
      sign_in @user1
      put :update, {:user => {:current_password => @user1.password, :password => "password", :password_confirmation => "password1"}}
      expect(response).to render_template 'devise/registrations/edit'
    end
  end
  
  describe 'create user' do
    it 'allow people to sign up' do
      post :create, {:user => {:email => "test1@example.com", :password => "password", 
                              :password_confirmation => "password", :username =>"test1"},
                     :subscribe_newsletter => "yes"}
      expect(response).to redirect_to root_path
      expect(User.count).to eq @total_user + 1
      new_user_subscribe = NewsletterUser.where("email = ?", "test1@example.com")
      expect(new_user_subscribe.length).to eq 1
    end
    
    it "disallow people to sign up with email that alredy signed up" do
      post :create, {:user => {:email => @user1.email, :password => @user1.password, 
                              :password_confirmation => @user1.password_confirmation, :username => @user1.username}}
      
      expect(User.count).to eq @total_user
      expect(response).to render_template 'new'
    end
  end
  
  describe 'unsubscribe newsletters' do
    it 'allow newsletter subscribers to unsubscribe' do
      get :unsubscribe_newsletter, {:email => @user1.email}
      new_user_subscribe = NewsletterUser.where("email = ?", "user1@example.com")
      expect(new_user_subscribe.length).to eq 0
      expect(flash[:notice]).to eq 'You have unsubscribed newsletter!'
      expect(response).to redirect_to root_path
    end
  end
  
  describe 'update subscription status' do
    it 'allow user to unsubscribe' do
      sign_in @user1
      expect {
        post :update_subscription, {:to_subscribe => "false"}
      }.to change{NewsletterUser.count}.from(@subscriber_count).to(@subscriber_count - 1)
      expect(flash[:notice]).to eq 'You have unsubscribed newsletter!'
    end
    
    it 'allow user to subscribe' do
      sign_in @user2
      expect {
        post :update_subscription, {:to_subscribe => "true"}
      }.to change{NewsletterUser.count}.from(@subscriber_count).to(@subscriber_count + 1)
      expect(flash[:notice]).to eq 'You are subscribing newsletter now!'
    end
  end
  
end
    