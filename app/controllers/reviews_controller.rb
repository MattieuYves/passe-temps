class ReviewsController < ApplicationController
  def show
    @review = Review.find(params[:id])
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])
    @review.update(review_params)
  end

  private

  def review_params
    params.require(:session).permit(:start_date, :end_date)
  end
end
