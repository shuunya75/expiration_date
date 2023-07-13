class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @q = Profile.ransack(params[:q])
    @results = @q.result
    @profile = current_user.profile
    if @profile
      @profile = current_user.profile
    else
      redirect_to edit_profile_path
    end
    followings = current_user.followings.pluck(:id)
    followers = current_user.followers.pluck(:id)
    @mutual_follow = followings & followers
    @user = User.where(id: @mutual_follow)
  end

  def edit
    @profile = current_user.profile || current_user.build_profile
  end

  def update
    @profile = current_user.profile || current_user.build_profile
    @profile.assign_attributes(profile_params)

    if params[:profile][:remove_avatar] == "1"
      @profile.avatar.purge
    end

    if @profile.save
      redirect_to profile_path, notice: 'プロフィール更新'
    else
      flash.now[:error] = '更新できませんでした'
      render :edit, status: :unprocessable_entity
    end
  end

  def search
    @q = Profile.ransack(params[:q])
    @results = @q.result
    if params[:q][:'my_id_eq'].length > 10
      redirect_to profile_path, notice: "10桁までで入力してください"
    elsif params[:q][:'my_id_eq'] == ""
      redirect_to profile_path, notice: "検索キーワードがありません。"
    elsif params[:q][:'my_id_eq'].to_i == current_user.profile.my_id
      redirect_to profile_path
    elsif @results.present?
      redirect_to account_path(@results.first.user)
    else
      redirect_to profile_path, notice: '存在しません'
    end
  end

  private
  def profile_params
    params.require(:profile).permit(:avatar, :nickname, :my_id)
  end
end