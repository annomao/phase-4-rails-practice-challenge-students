class StudentsController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    render json: Student.all, status: :ok
  end

  def show
    student = student_id
    render json: student, status: :ok
  end

  def update
    student = student_id
    student.update!(allowed_params)
    render json: student
  end

  def create
    instructor = get_instructor
    student = instructor.students.create!(allowed_params)
    render json: student, status: :created
  end

  def destroy
    student = student_id
    student.destroy
    render :no_content
  end

  private

  def student_id
    Student.find(params[:id])
  end

  def get_instructor
    Instructor.find(params[:instructor_id])
  end

  def allowed_params
    params.permit(:name, :major,:age)
  end

  def record_not_found
    render json: {errors: "Record not found"}, status: :not_found
  end

  def record_invalid(e)
    render json: {errors: e.record.errors.full_messages}, status: :unprocessable_entity
  end
end
