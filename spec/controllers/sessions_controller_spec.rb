# Iter 2-2 account actication (by Zipei Wang and Jack Chen)
require 'spec_helper'

describe SessionsController do
    
    describe "Users" do 
        before :each do
          @request.env["devise.mapping"] = Devise.mappings[:user]
          FactoryGirl.create(:user, email: "user1@berkeley.edu", password: '12345678', password_confirmation: '12345678', activated: true)
          FactoryGirl.create(:user, email: "user2@berkeley.edu", password: '12345678', password_confirmation: '12345678', activated: false)
        end
        it "should go to sign in page if clicking log in" do
          get :new
          response.should render_template 'new'
        end
        it "should get user logged in if activated" do 
          post :create, {:user => {:email => 'user1@berkeley.edu'}}
          response.should be_success
        end
        it "should not sign in if not activated" do
          post :create, {:user => {:email => 'user2@berkeley.edu',:password => '12345678'}}
          expect(flash[:notice]).to start_with("Account hasn't been activated.")
          response.should redirect_to new_user_session_path
        end
        it "should not get activated notice if incorrect password" do
          post :create, {:user => {:email => 'user2@berkeley.edu',:password => '123456789'}}
          response.should be_success
        end
        it "should not sign in if not existing" do
          post :create, {:user => {:email => 'user3@berkeley.edu'}}
          # Devise::SessionsController.should_receive(:create)
          response.should be_success
        end
        
    end
            
end
# End for Iter 2-2
