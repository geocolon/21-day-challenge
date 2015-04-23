require "gtk2"

class LangtonsAntWalkGridSquare < Gtk::Frame
  def initialize(color)
    super()
    # It's like a border... until I figure out how to draw a border.
    self.modify_bg(Gtk::STATE_NORMAL, Gdk::Color.parse("black"))
    # The area that actually changes color.
    @interior = Gtk::DrawingArea.new.tap { |area| 
      area.modify_bg(Gtk::STATE_NORMAL, Gdk::Color.parse(color.to_s)) 
    }
    self.add(@interior)
  end

  def self.white
    self.new(:white)
  end

  def color_yourself(color)
    @interior.modify_bg(Gtk::STATE_NORMAL, Gdk::Color.parse(color.to_s))
  end
end

class LangtonsAntWalkGridPanel < Gtk::Table
  attr_reader :squares

  def initialize
    @rows = @columns = 3

    # true -> all cells the same size
    super(@rows, @columns, true)

    @squares = []
    @rows.times do |x|
      @squares.push([])
      @columns.times do |y|
        square = LangtonsAntWalkGridSquare.white
        @squares[x][y] = square
        self.attach_defaults(square, x, x+1, y, y+1)
      end
    end

  end
end

class LangtonsAntWalkMainWindow < Gtk::Window
  attr_reader :grid_panel

  def initialize
    super

    set_title("Langton's Ant")

    signal_connect("destroy") do
      Gtk.main_quit
    end

    self.set_default_size(600, 600)

    @grid_panel = LangtonsAntWalkGridPanel.new
    self.add(@grid_panel)

    self.show_all()
  end
end
