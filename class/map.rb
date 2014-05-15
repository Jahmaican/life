class Map
    attr_reader :rat_x, :rat_y
    def initialize(window, width = 64, height = 36)
        @win = window
        @w, @h = width, height
        @rat_x, @rat_y = window.width.fdiv(@w), window.height.fdiv(@h)
        reset
    end
    
    def clicked(x, y, continous)
        if continous
            @map[(x.fdiv(@rat_x)).to_i][(y.fdiv(@rat_y)).to_i].live
        else
            @map[(x.fdiv(@rat_x)).to_i][(y.fdiv(@rat_y)).to_i].inverse
        end
        paint
    end
    
    def paint
        @img = @win.record(@w, @h) {
            @map.each do |row|
                row.each do |n|
                    n.draw
                end
            end
        }
    end
    
    def reset
        @map = Array.new(@w) { Array.new(@h) }
        @map.each_index do |x|
            @map[x].each_index do |y|
                @map[x][y] = Node.new(@win, x, y)
            end
        end
        paint
    end
    
    def update
        changed_nodes = Array.new
        @map.each_with_index do |row, x|
            row.each_with_index do |node, y|
                score = 0
                (-1 .. 1).each do |vx|
                    (-1 .. 1).each do |vy|
                        if (0 ... @map.size).include?(x+vx) and (0 ... @map[0].size).include?(y+vy)
                            if @map[x+vx][y+vy] != node and @map[x+vx][y+vy].alive?
                                score += 1
                            end
                        end
                    end
                end
                if node.alive?
                    if !(score == 2 or score == 3)
                        changed_nodes.push(Node.new(@win, x, y, false))
                    end
                else
                    if score == 3
                      changed_nodes.push(Node.new(@win, x, y, true))
                    end
                end 
            end
        end
        
        changed_nodes.each do |n|
            @map[n.x][n.y] = n
        end
        
        paint
    end
    
    def draw
        @img.draw(0,0,1)
    end
end