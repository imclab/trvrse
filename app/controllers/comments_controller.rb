class CommentsController < ApplicationController
  before_filter :load_trip

  def create
    @comment = Comment.new(params[:comment])
    @comment.trip = @trip
    @comment.user = current_user
    @comment.save

    if @comment.save
      render json: @comment, status: :created
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def update
    @comment = Comment.find(params[:id])

    if @comment.update_attributes(params[:comment])
      head :no_content
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @comment = @trip.comment.find(params[:id])
    @comment.destroy

    head :no_content
  end


  private
    def load_trip
      @trip = Trip.find(params[:trip_id])
    end
end
