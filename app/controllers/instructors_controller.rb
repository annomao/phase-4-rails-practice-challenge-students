class InstructorsController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    render json: Instructor.all, status: :ok
  end

  def show
    instructor = instructor_id
    render json: instructor, status: :ok
  end

  def update
    instructor = instructor_id
    instructor.update!(allowed_params)
    render json: instructor
  end

  def create
    instructor = Instructor.create!(allowed_params)
    render json: instructor, status: :created
  end

  def destroy
    instructor = instructor_id
    instructor.destroy
    render :no_content
  end

  private

  def instructor_id
    Instructor.find(params[:id])
  end

  def allowed_params
    params.permit(:name)
  end

  def record_not_found
    render json: {errors: "Record not found"}, status: :not_found
  end

  def record_invalid(e)
    render json: {errors: e.record.errors.full_messages}, status: :unprocessible_entity
  end
end
