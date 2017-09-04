class UserProfilesController < ApplicationController
  before_action :set_user_profile, only: [:edit, :update]

  # GET /user_profiles/1/edit
  def edit
  end

  # PATCH/PUT /user_profiles/1
  # PATCH/PUT /user_profiles/1.json
  def update
    respond_to do |format|
      if @user_profile.update(user_profile_params)
        format.html { redirect_to edit_user_profile_path, notice: 'Daten erfolgreich aktualisiert.' }
        format.json { render :edit, status: :ok, location: @user_profile }
      else
        format.html { render :edit }
        format.json { render json: @user_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_profile
      UserProfile.find_or_initialize_by(user: current_user) do |userprofile|
        @user_profile = userprofile
        @user_profile.save
      end
      if @user_profile == nil
        @user_profile = UserProfile.find_by_user_id(current_user.id)
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_profile_params
      params.require(:user_profile).permit(:firstname, :lastname, :street, :city, :zipcode)
    end
end
