class CourseController < ApplicationController
    before_action :current_instructor, only: [:new, :create]
    before_action :authenticate_user, only: [:enroll]
    before_action :current_instructor, only: [:review]
    
    def index
        @courses = Course.all
    end
    def new
        @course = Course.new
    end

    def create
        puts "course = #{@course}"
        @course = @current_instructor.courses.build(course_params)
      
        if @course.save
          redirect_to courses_path, notice: 'Course created successfully'
        else
          flash[:notice] = 'Some error occurred, please try again.'
          render :new
        end
    end
      

    

    def uploadFile

    end

    def enroll
      @course = Course.find(params[:id])
      current_instructor.courses << @course
      redirect_to courses_path(@course), notice: 'Enrolled successfully!'
    end

    def review
      @course = Course.find(params[:id])
      @review = Review.new
    end

    def submit_review
      @course = Course.find(params[:id])
      @review = Review.new(review_params)
      @review.user = current_instructor
      @review.course = @course

      if @review.save
        redirect_to courses_path(@course), notice: 'Review submitted successfully!'
      else
        flash[:alert] = 'Error submitting review.'
        render :review
      end
    end


   

    private

    def current_instructor
      token = session[:usertype]
      puts "token = #{token}"
      if token.present?
        user_info = JsonWebToken.decode(token)
        user_id = user_info[:email]
        puts "user id = #{user_id}"
        if user_id.present?
          user = User.find_by(email: user_id)
          puts "user = #{user}"
          if user.usertype == "Instructor"
            @current_instructor = user 
          else
            @current_instructor = nil
          end
        else
          @current_instructor = nil
        end
      else
        @current_instructor = nil
      end
      @current_instructor
    end

    def course_params
        params.require(:course).permit(:title, :description, :price, :video, :document, :user_id)
    end

    
    def authenticate_user 
      unless current_instructor
        redirect_to login_path, alert: 'You need to log in to enroll.'
      end
    end

    def review_params
      params.require(:review).permit(:rating, :comment)
    end
    
      
end
