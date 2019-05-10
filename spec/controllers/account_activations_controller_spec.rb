# Iter 2-2 account actication (by Zipei Wang and Jack Chen)
require 'spec_helper'

describe AccountActivationsController do

    describe "Activating account" do
        before :each do
            @user1 = FactoryGirl.create(:user, username: "user1", email: "user1@berkeley.edu", password: '12345678', password_confirmation: '12345678', activated: false)
            @user2 = FactoryGirl.create(:user, username: "user2", email: "user2@berkeley.edu", password: '12345678', password_confirmation: '12345678', activated: true)

            @user1.update_attribute(:activation_digest, User.digest("abcdefg"))
            @user1.save!
        end
        it "should activate the account if unactivated" do
            get :edit, {:email => 'user1@berkeley.edu', :id => "abcdefg"}
            expect(flash[:success]).to eq "Congratulations! Your account has been activated!"
            # expect(@user1.activated).to eq true
            response.should redirect_to root_path
        end
        it "should not do anything if activated" do
            get :edit, {:email => 'user2@berkeley.edu', :id => @user2.id}
            expect(flash[:danger]).to eq "Invalid activation link"
            response.should redirect_to root_url
        end
        it "should not do anything if user not existing" do
            get :edit, {:email => 'user3@berkeley.edu', :id => 250}
            expect(flash[:danger]).to eq "Invalid activation link"
            response.should redirect_to root_url
        end

        it "should return to root if try to activate invalid account" do
            get :send_mail, {:email => 'user3@berkeley.edu'}
            response.should redirect_to root_url
        end

        it "should send out email if user haven't activated" do
            get :send_mail, {:email => 'user1@berkeley.edu'}
            response.should redirect_to new_user_session_path
        end
    end
end
# End for Iter 2-2