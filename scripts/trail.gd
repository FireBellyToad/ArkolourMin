extends Node2D

export var draw_circle = true
export var track_length = 10
var update_delay_frames = 0
var track_delay_counter = 0
var trail_color = 0
var track

func _ready():
	#Prende l'origin
	self.track = Array()
	var pos = get_global_transform().get_origin()
	#Aggiunge tutte le posizioni di origin ad un vettore
	for i in range(self.track_length):
		self.track.append(pos)

func _init():
	set_fixed_process(true)
	trail_color = Color(0,0,0,1)
	
func _fixed_process(delta):
	#Prende il delay
	self.track_delay_counter += delta
	var total_time_delay = self.update_delay_frames * get_process_delta_time()
	#Aggiunge la posizione corrente della trail
	if(self.track_delay_counter >= total_time_delay):
		add_position(get_global_transform().get_origin())
		self.update()
		self.track_delay_counter = 0

func _draw():
	self.draw_trail()

func add_position(new_position):
	self.track.append(new_position)
	if(self.track.size() >= self.track_length):
		self.track.pop_front()

func draw_trail():
	draw_set_transform( - get_global_transform().get_origin(), 0, Vector2(1,1))

	var i = 0
	if(draw_circle):
		for pos in self.track:
			draw_circle(pos,10,trail_color)
	else:
		for i in range(self.track_length):
			draw_line(self.track[i+1], self.track[i+1], trail_color, 2*(i/10))	
			draw_line(self.track[self.track_length -1], get_global_transform().get_origin(), Color(1, 0, 0), 2)
	
	if(self.track.size() > self.track_length):
		self.track.resize(self.track_length)
	
func set_track_length(lenght):
	self.track_length = lenght;	
	
func set_trail_color(color):
	self.trail_color = color;
	