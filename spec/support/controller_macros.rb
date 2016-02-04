module ControllerMacros

  def self.extended(mod)
    mod.include ForInclusion
  end

  def login_admin
    let(:signed_in_user) { FactoryGirl.create(:admin) }

    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      sign_in signed_in_user
      expect(signed_in_user).to be_admin
    end
  end

  def login_user(user_factory = :user)
    let(:signed_in_user) { FactoryGirl.create(user_factory) }

    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in signed_in_user
    end
  end

  module ForInclusion
    def expect_user_not_authorized
      expect(flash[:alert]).to eq('You are not authorized to perform this action.')
      expect(response).to be_redirect
    end
  end
end
