extends Camera2D

@export var zoomSpeed : float = 10
@export var moveSpeed : float = 1000

var zoomTarget : Vector2

var dragStartMousePosition = Vector2.ZERO
var dragStartCameraPosition = Vector2.ZERO
var isDragging : bool = false

# Sensitivity for drag scaling
@export var dragSensitivity : float = 0.5

# Limits for zoom
var minZoom : float = 0.5
var maxZoom : float = 4

# Limits for camera position  A RETRAVAILLER
var minX : float = 1150
var maxX : float = 2500
var minY : float = 648
var maxY : float = 3000

# Called when the node enters the scene tree for the first time.
func _ready():
	zoomTarget = zoom
	make_current()
	print(is_current())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	Zoom(delta)
	SimplePan(delta)
	ClickAndDrag()
	print(zoom)
	print(position)

func Zoom(delta):
	if Input.is_action_just_pressed("camera_zoom_in"):
		zoomTarget *= 1.1
	if Input.is_action_just_pressed("camera_zoom_out"):
		zoomTarget *= 0.9

	# Apply zoom limits
	zoomTarget.x = clamp(zoomTarget.x, minZoom, maxZoom)
	zoomTarget.y = clamp(zoomTarget.y, minZoom, maxZoom)

	# Smooth zoom transition
	zoom = zoom.slerp(zoomTarget, 5 * delta)

func SimplePan(delta):
	var moveAmount = Vector2.ZERO
	# Move with WASD
	if Input.is_action_pressed("camera_move_right"):
		moveAmount.x += 1
	if Input.is_action_pressed("camera_move_left"):
		moveAmount.x -= 1
	if Input.is_action_pressed("camera_move_up"):
		moveAmount.y -= 1
	if Input.is_action_pressed("camera_move_down"):
		moveAmount.y += 1

	moveAmount = moveAmount.normalized()
	# Adjust movement speed based on zoom level
	position += moveAmount * delta * moveSpeed * (1 / zoom.x)

	# Apply position limits
	position.x = clamp(position.x, minX, maxX)
	position.y = clamp(position.y, minY, maxY)

func ClickAndDrag():
	if !isDragging and Input.is_action_just_pressed("camera_pan"):
		dragStartMousePosition = get_global_mouse_position()
		dragStartCameraPosition = position
		isDragging = true

	if isDragging and Input.is_action_just_released("camera_pan"):
		isDragging = false

	if isDragging:
		var moveVector = get_global_mouse_position() - dragStartMousePosition
		# Apply the drag sensitivity to adjust the movement scaling
		position = dragStartCameraPosition - moveVector * dragSensitivity * 0.00001 / zoom.x

		# Apply position limits
		position.x = clamp(position.x, minX, maxX)
		position.y = clamp(position.y, minY, maxY)
