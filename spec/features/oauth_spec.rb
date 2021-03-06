require 'spec_helper'

describe "Oauth" do
  describe 'user not logged in and has had not account yet' do
    it "should succesfull authorized from facebook account" do
      set_omniauth(:facebook)
      visit "/"
      click_link "sign_in_with_facebook"
      page.should have_content "Successfully authorized from facebook account"
    end

    it "should increment all user counter after facebook authorisation" do
      set_omniauth(:facebook)
      visit "/"
      expect {
        click_link "sign_in_with_facebook"
      }.to change { User.count }.by(1)
    end
  end

  describe 'user not logged in and had account' do
    before do
      @user = FactoryGirl.create(:user, email: get_omniauth_email(:facebook))
    end

    it "should succesfull authorized from facebook account" do
      set_omniauth(:facebook)
      visit "/"
      click_link "sign_in_with_facebook"
      page.should have_content "Successfully authorized from facebook account"
    end

    it "should not increment User count after facebook authorisation" do
      set_omniauth(:facebook)
      visit "/"
      expect {
        click_link "sign_in_with_facebook"
      }.not_to change { User.count }.by(1)
    end
  end

  describe 'user signed in' do
    describe 'by /users/sign_in form' do
      before(:each) do
        @user = FactoryGirl.create(:user)
        login_as(@user, :scope => :user)
        visit '/users/edit'
      end

      it 'should not increment User count after merge with facebook' do
        set_omniauth(:facebook)
        expect {
          click_link 'merge_account_with_facebook'
        }.not_to change { User.count }.by(1)
      end

      it 'should update User record after merge with facebook' do
        set_omniauth(:facebook)
        @user.facebook.should be_nil
        click_link 'merge_account_with_facebook'
        @user.reload
        @user.facebook.should_not be_nil
      end
    end
  end

  describe "user registration other cases" do

    it 'can merge with facebook, twitter and github' do
      # @user: create account by form
      @user = FactoryGirl.create(:user)
      login_as(@user, :scope => :user)
      @user.facebook.should be_nil
      @user.github.should be_nil
      @user.twitter.should be_nil

      # merge with facebook
      visit '/users/edit'
      set_omniauth(:facebook)
      expect {
        click_link 'merge_account_with_facebook'
      }.to change { OAuthCredential.count }.by(1)
      page.should have_content "Succesfull merged with facebook"
      @user.reload
      @user.facebook.should_not be_nil
    end

    describe "signed in user cant merge with provider if account with this provider has previously created" do

      it 'should not update current user after try merge with facebook' do
        # @user1: create account by facebook
        User.count.should == 0
        set_omniauth(:facebook)
        visit "/"
        click_link "sign_in_with_facebook"
        User.count.should == 1
        @user1 = User.last
        @user1.facebook.should_not be_nil
        logout

        # @user2: create account by form
        @user2 = FactoryGirl.create(:user)
        User.count.should == 2

        login_as(@user2, :scope => :user)
        visit '/users/edit'

        #the same credential values as @user1
        set_omniauth(:facebook)
        expect {
          click_link 'merge_account_with_facebook'
        }.to_not change { OAuthCredential.count }.by(1)
        page.should have_content "The system has an account with the same facebook. Sign in by facebook and delete them. At the end add this facebook to the present account."
        @user2.reload
        @user2.facebook.should be_nil
      end
    end
  end
end


