class StudentsController < ApplicationController

  def index
    @students = Student.all
  end

  def show
    @student = Student.find(params[:id])
  end

  def new
    @student = Student.new
  end

  def create
    begin
      @student = Student.create!(student_params)
      redirect_to students_path
    rescue
      render :new
    end
  end

  def edit
    @student = Student.find(params[:id])
  end

  def update
    begin
      @student = Student.update!(student_params)
      redirect_to students_path
    rescue
      render :edit
    end
  end

  def destroy
    @student = Student.find(params[:id])
    @student.destroy
  end

  private

  def student_params
    params.require(:student).permit(:name, :email, :age, :sex, :married, :address, :city, :state, :zip, :phone)
  end
end
