extends Resource
class_name TileAnimation

@export var texture: AtlasTexture = null
@export var start_frame = 0
@export var end_frame = 0
@export var frame_duration = 0.2

var time_till_next_frame = frame_duration
var frame_index = 0

func run(delta):
	time_till_next_frame -= delta
	if (time_till_next_frame <= 0):
		time_till_next_frame = frame_duration
		frame_index += 1
	if frame_index > end_frame:
		frame_index = start_frame

func get_current_frame():
	texture.region.position.x = texture.region.size.x * frame_index
	return texture
