class PupsController < ApplicationController
  impressionist
  before_filter :check_sign_in, :only => [:new, :dog_name, :dog_how_long, :dog_breed, :dog_breeder]

  # Devise. Methods not in the list below will require a user to be logged in.
  before_filter :authenticate_user!, except: [:index, :new, :main, :breed, :search_breed, :random_comment]

  # The Root Path
  def main
    if current_user
      @username = current_user.username
    end
    
    start_over
    selected_comment = SelectedComment.find_randomly
    # Iter 2
    if selected_comment
      @comment_content = selected_comment.content
      @comment_breed = selected_comment.breed
    end
    # END of Iter 2
  end
  
  def random_comment
    render :json => SelectedComment.find_randomly
  end

  # The true rating page
  # Iter 1-2
  def new
    if not_finish_previous_steps?(session[:step1], session[:step2], session[:step3])
      redirect_to root_path and return
    end
    session.delete(:breeder_id)
    breeder_str = params[:breeder][:name]
    if breeder_str.empty?
      session[:breeder_id] = 1
      return
    end
    breeder = Breeder.find_by_formatted_string(breeder_str)
    if breeder
      @same_breeder = Pup.where("user_id = ? and breeder_id = ?", current_user.id, breeder.id)
      if @same_breeder.length >= 2
        redirect_to root_path, flash: {notice: 'SimpaticoPup is a website designed to collect information from dog
lovers about their own companion dogs. To ensure that our rating summaries accurately reflect input from a wide variety
of dog owners, we are currently limiting the number of ratings made by each dog owner to eight, and limiting each dog
owner to rating only two dogs that come from the same dog breeder. Thank you for your contributions to our database.'}
      else
        session[:breeder_id] = breeder.id
      end
      return
    end
    flash[:notice] = "The dog breeder or kennel you entered is not yet in our database.
    Please add the name of the dog breeder, city and state to our database."
    redirect_to new_breeder_path and return
  end
  # End for Iter 1-2

  # Rails default methods
  def index
    redirect_to root_path
  end

  def create
    # new_pup = set_pup
    # @pup = Pup.new(new_pup)
    # new_comment = {:content => params[:pup][:comments]}
    @pup = Pup.build_pup(params, session, current_user.id)
    @Comment = Comment.new({:content => params[:pup][:comments]})

    #Problem 2
    if !@pup.valid?
      flash[:notice] = 'Please make sure all fields are complete!'
      redirect_to new_pup_path and return
    end
    if !@Comment.valid?
      flash[:notice] = 'Please make sure the comment is less than 140 characters.'
      redirect_to new_pup_path and return
    end
    
    if @pup.user.pups(:reload).size > 8
      flash[:notice] = 'SimpaticoPup is a website designed to collect information from dog lovers about their own
companion dogs. To ensure that our rating summaries accurately reflect input from a wide variety of dog owners, we are
currently limiting the number of ratings made by each dog owner to eight, and limiting each dog owner to rating only two
 dogs that come from the same dog breeder. Thank you for your contributions to our database.'
    else
      @pup.save
      @Comment.pup_id = @pup.id
      @Comment.save
      # Successfully save pup & comment
      flash[:notice] = "Thank You! #{@pup.pup_name} was successfully added to our database."
    end
      redirect_to root_path
  end
  
  # Iter3-2 (Jeff Yu, Gilbert Lo)
  # Still need check if it is owner and check if dog exist
  # pup_name, year, month updated directly using update_attributes
  # Update comment, breed, breeder cannot be done directly
  def update
    @pup = Pup.find_by_id params[:id]
    
    breeder = @pup.update_breeder(params[:breeder_str])
    if !breeder
      flash[:modal] = "Non existing breeder."
      session[:pup_id] = params[:id]
      redirect_to edit_pup_path(@pup) and return
    end
    
    @pup.update_attributes(params[:pup])
    @pup.breed_id = Breed.find_by_name(params[:breed_name]).id
    @pup.update_comment(params[:comment])
    @pup.save
    
    flash[:notice] = "Pup has been updated"
    redirect_to user_pups_path
  end
  
  def show
    @pup = Pup.find_by_id params[:id]
    
    if !valid_access(@pup)
      flash.keep
      redirect_to root_path and return
    end
    
    session[:from] = 'dog_show'
  end

  def destroy
    @pup = Pup.find_by_id params[:id]
    
    if valid_access(@pup)
      @pup.destroy
      flash[:notice] = "Pup #{@pup.pup_name} has been deleted"
    end
    redirect_to user_pups_path
  end
  
  def edit
    @pup = Pup.find_by_id params[:id]
    @breeds = Breed.all
    
    if !valid_access(@pup)
      flash.keep
      redirect_to root_path and return
    end
    
    @breed = @pup.breed.name
    breeder = @pup.breeder
    @breeder_text = breeder.name != 'Unknown' ? breeder.name + ' - ' + breeder.address : ''
    @comment_content = @pup.comment ? @pup.comment.content : ""
  end
  
  def hashtags
    pup = Pup.find_by_id params[:pup_id]
    if pup
      render :json => pup.hashtags
    end
  end
  
  def ratings
    pup = Pup.find_by_id params[:pup_id]
    if pup
      render :json => pup.ratings
    end
  end
  #End Iter3-2
  
  def breed_avg_ratings
    pup = Pup.find_by_id params[:pup_id]
    render :json => Pup.avg_ratings_by_breeds(pup.breed.name)
  end
  
  #################### Start Questionnaire ####################

  # step 0
  def dog_name
    if current_user.pups.count >= 8
      redirect_to root_path, flash: {notice: 'SimpaticoPup is a website designed to collect information from dog lovers
 about their own companion dogs. To ensure that our rating summaries accurately reflect input from a wide variety of dog
 owners, we are currently limiting the number of ratings made by each dog owner to eight, and limiting each dog owner to
 rating only two dogs that come from the same dog breeder. Thank you for your contributions to our database.'}
    end
  end

  # step 1
  def dog_how_long
    if params[:pup]
      pup_name = params[:pup][:name]
    else
      pup_name = session[:pup_name]
    end
    if pup_name.nil? || pup_name.empty?
      flash[:notice] = "Please input a name"
      session[:step1] = false
      redirect_to dog_name_path and return      
    else
      session[:pup_name] = pup_name
      session[:step1] = true
    end
  end

  #step2
  def dog_breed
    if !session[:step1]
      redirect_to root_path and return
    elsif params[:pup]
      years = params[:pup][:years]
      months = params[:pup][:months]
    else
      years = session[:years]
      months = session[:months]
    end

    if check_time_valid?(years, months)
      flash[:notice] = "Please enter a valid integer number for year/month."
    elsif is_valid_year_month?(years, months)
      session[:years] = years
      session[:months] = months
      session[:step2] = true
      return
    else
      flash[:modal] = "Less than 6 months"
    end
    session[:step2] = false
    redirect_to dog_how_long_path(:pup => {:name => session[:pup_name]})
  end

  #step3
  def dog_breeder
    if not_finish_previous_steps?(session[:step1], session[:step2])
      redirect_to root_path and return
    end
    if params[:breed]
      breed = params[:breed][:name]
    else
      breed = session[:breed]
    end
    if !Breed.is_valid_breed breed
      session[:step3] = false
      flash[:modal] = "modal"
      redirect_to dog_breed_path and return
    end
    session[:breed] = breed
    session[:step3] = true
  end

  #################### End Questionnaire ####################

  # search for breeds when doing auto-fill
  def search_breed
    name = params[:name]
    render :json => Breed.find_breed_by_substr(name)
  end

  # search pups by breed name
  def breed
    name = params[:breed][:name]
    if !Breed.is_valid_breed(name)
      flash[:notice] = "Please enter a valid breed name."
      redirect_to root_path
    else
      @pups = Pup.find_by_breed(name)
      @avg_ratings = Pup.avg_ratings_by_breeds(name)
    end
  end

  private
  
  def not_finish_previous_steps?(step1, step2 = true, step3 = true)
    !step1 || !step2 || !step3
  end
  
  def check_time_valid?(years, months)
    result1 = check_valid?(years) || check_valid?(months)
    result2 = years.nil? || months.nil? || (years.empty? && months.empty?)
    result1 || result2
  end
  
  def check_valid?(input)
    !input.empty? && !is_num?(input)
  end
  
  # Iter3-2 (Gilbert Lo and Jeff Yu)
  def valid_access(pup)
    if pup.nil?
      flash[:notice] = "The dog you are trying to access does not exist"
    elsif !owner?(pup)
      flash[:notice] = "The dog you are trying to access is not yours"
    else
      return true
    end
    false
  end
  
  def owner?(pup)
    return pup.user_id == current_user.id
  end
  # End 3-2
  
  def check_sign_in
    unless user_signed_in?
      redirect_to welcome_path
    end
  end
  
  def is_valid_year_month?(years, months)
    return years.to_i * 12 + months.to_i >= 6
  end

  def is_num?(str)
    str.to_s == str.to_i.to_s
  end

  def start_over
    [:step1, :step2, :step3, :pup_name, :breed, :years, :months, :breed_id, :pup_id, :from].each do |key|
      session.delete(key)
    end
  end
end
  
