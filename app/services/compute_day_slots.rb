class ComputeDaySlots
    def initialize(opening_time: 900, closing_time: 1900, break_times: [1300, 1330], slot_duration: 60, bookings: [])
      @opening_time = opening_time
      @closing_time = closing_time
      @break_times = break_times
      @slot_duration = slot_duration
      @bookings = bookings
    end
  
    def call
      @time_slots = TimeSlot.new(@opening_time..@closing_time).match(@slot_duration, @slot_duration)
      @time_slots = @time_slots.reject { |slot| slot.start.in?(@break_times) }
      
      booking_slots = @bookings.map { |booking| booking_slot(booking) }
                               .compact
      
      @time_skots = @time_slots.map do |slot|
        { slot: slot, available: !slot.start.in?(booking_slots) }
      end
    end
  
    private
  
    def booking_slot(booking)
      return unless booking.is_a?(Booking)
  
      booking_hours_match = booking.start_date.to_s.match(/[\d+-]+\s(\d{2}:\d{2})/)
      return if booking_hours_match.nil?
  
      booking_hours_match.captures&.first&.gsub(":", "")&.to_i
    end
  end
  
  # paramètres d'entrée
  # - horaire d'ouverture
  # - horaire de fermeture
  # - horaires de pause
  # - durée d'un slot
  # - bookings
  