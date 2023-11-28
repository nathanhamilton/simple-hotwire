class StudentCourseRecordsController < ApplicationController

  def index
    @student = Student.find(params[:student_id])
    @student_course_records = StudentCourseRecord.where(student_id: @student.id).includes(:course)
    @courses = Course.where.not(id: @student_course_records.pluck(:course_id))
  end


  def new
    @student = Student.find(params[:student_id])
    @student_course_record = StudentCourseRecord.new
  end

  def create
    @student = Student.find(params[:student_id])
    @student_course_record = StudentCourseRecord.new(student_course_record_params)

    respond_to do |format|
      format.html do
        begin
          @student_course_record.save!
          redirect_to student_student_course_records_path(@student)
        rescue
          render :new
        end
      end
      format.js do
        if @student_course_record.save
          head :ok
        else
          head :internal_server_error
        end
      end
    end
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
    params.require(:student_course_record).permit(:student_id, :course_id, :name, :score, :start_date, :end_date, :registered_at)
  end
end
