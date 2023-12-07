class StudentCourseRecordsController < ApplicationController
  include StudentCourseRecordHelper
  include ActionView::RecordIdentifier

  def index
    @student = Student.find(params[:student_id])
    @student_course_records = StudentCourseRecord.where(student_id: @student.id).includes(:course).order(:order)
    @courses = Course.where.not(id: @student_course_records.pluck(:course_id))
  end

  def new
    @student = Student.find(params[:student_id])
    @student_course_record = StudentCourseRecord.new
  end

  def bulk_update_order
    @student = Student.find(params[:student_id])
    checked_items = check_order_params(JSON.parse(params["order_array"]))

    updated_records = checked_items.map do |item|
      student_course_record = StudentCourseRecord.find(item["id"])
      student_course_record.update(order: item["order"])
      student_course_record
    end

    # Render turbo stream for each updated student_course_record
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: updated_records.map { |record|
          turbo_stream.replace(
            record,
            partial: "student_course_records/student_course_record",
            locals: { student_course_record: record, student: @student }
          )
        }.join.html_safe
      end
    end
  end

  def show
    @student = Student.find(params[:student_id])
    @student_course_record = StudentCourseRecord.find(params[:id])
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
      format.json do
        if @student_course_record.save
          render json: { status: :created, data: { student_course_record_id: @student_course_record.id }}
        else
          render json: @student_course_record.errors, status: :unprocessable_entity
        end
      end
      # May use this in the future to render the partial for a new student course record
      # format.turbo_stream do
      #   if @student_course_record.save
      #     render turbo_stream: turbo_stream.replace(
      #       dom_id(@student_course_record),
      #       partial: "student_course_records/student_course_record",
      #       locals: { student_course_record: @student_course_record, student: @student }
      #     )
      #   else
      #     head :internal_server_error
      #   end
      # end
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
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace(@student_course_record, partial: "student_course_records/student_course_record", locals: { student_course_record: @student_course_record, student: @student }) }
        format.html { redirect_to student_student_course_records_path(@student) }
      end
    rescue
      render :edit
    end
  end

  def destroy
    @student_course_record = StudentCourseRecord.find(params[:id])
    @student_course_record.destroy
    respond_to do |format|
      format.html { redirect_to student_student_course_records_path(@student) }
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@student_course_record) }
    end
  end

  private

  def student_course_record_params
    params.require(:student_course_record)
          .permit(:student_id, :order, :course_id, :name,
                  :score, :start_date, :end_date, :registered_at)
  end
end
