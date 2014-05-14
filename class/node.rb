class Node
    attr_reader :x, :y
    def initialize(window, x, y, alive = false)
        @win = window
        @x, @y = x, y
        @alive = alive
    end
    
    def inverse
        @alive = !@alive
    end
    
    def alive?
        @alive
    end
    
    def draw
        col1 = @alive ? 0xFF474747 : 0xFFDAF89F
        col2 = @alive ? 0xFF171717 : 0xFFBDD68B
        @win.draw_quad( @x,   @y,     col2,
                        @x,   @y+1,   col1,
                        @x+1, @y,     col2,
                        @x+1, @y+1,   col2)
    end
end