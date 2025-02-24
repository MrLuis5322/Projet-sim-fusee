extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	make_current()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	Zoom()
	SimplePan()
	ClickAndDrag()
	


func Zoom():
	if Input.is_action_just_pressed("camera_zoom_in"):
		zoom = zoom *1.1
	if Input.is_action_just_pressed("camera_zoom_out"):
		zoom = zoom *-1.1


func SimplePan():
	pass


func ClickAndDrag():
	pass
