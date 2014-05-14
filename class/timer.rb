class Timer
  def initialize
    reset
  end
  
  def time
    milliseconds - @ms_offset
  end
  
  def reset
    @ms_offset = milliseconds
  end
end
