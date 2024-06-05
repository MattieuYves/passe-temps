class ReviewsController < ApplicationController

  def show
    @review = Review.find(params[:id])
  end

  def create
    @booking = Booking.find(params[:booking_id])
    @review = Review.new(review_params)
    @review.booking = @booking
    @review.user = current_user
    if @review.save
      redirect_to booking_path(@booking)
    else
      render "bookings/show"
    end
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
    params.require(:review).permit(:title, :comment, :rating)
  end
end
