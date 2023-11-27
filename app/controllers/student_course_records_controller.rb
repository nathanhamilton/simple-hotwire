class StudentCourseRecordsController < ApplicationController

  def index
    @student = Student.find(params[:student_id])
    @courses = Course.all
    @student_course_records = StudentCourseRecord.where(student_id: @student.id).includes(:course)
  end

  def new
    @student = Student.find(params[:student_id])
    @student_course_record = StudentCourseRecord.new
  end

  def create
    @student = Student.find(params[:student_id])
    @student_course_record = StudentCourseRecord.new(student_course_record_params)
  end

  def edit
    @student = Student.find(params[:student_id])
    @student_course_record = StudentCourseRecord.find(params[:id])
  end

  def update
    @student = Student.find(params[:student_id])
    @student_course_record = StudentCourseRecord.find(params[:id])
    begin
      @student_course_record.update!(student_course_record_params)
      redirect_to student_student_course_records_path(@student)
    rescue
      render :edit
    end
  end

  def destroy
    @student_course_record = StudentCourseRecord.find(params[:id])
    @student_course_record.destroy
  end

  private

  def student_course_record_params
    params.require(:student_course_record).permit(:student_id, :name, :score, :start_date, :end_date, :registered_at)
  end
end
