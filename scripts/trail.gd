extends Node2D

var track_length = 0
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
	trail_color = Color(1,0,0)
	
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
	for pos in self.track:
		draw_circle(pos,10,trail_color)
	if(self.track.size() > self.track_length):
		self.track.resize(self.track_length)
	
func set_track_length(lenght):
	self.track_length = lenght;	
	
func set_trail_color(color):
	self.trail_color = color;
	