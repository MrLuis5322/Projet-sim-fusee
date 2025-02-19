extends Camera2D

@export var zoomSpeed : float = 10
@export var moveSpeed : float = 1000

var zoomTarget : Vector2

var dragStartMousePosition = Vector2.ZERO
var dragStartCameraPosition = Vector2.ZERO
var isDragging : bool = false

# Sensitivity for drag scaling
@export var dragSensitivity : float = 0.5

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
        position = dragStartCameraPosition - moveVector * dragSensitivity *0.00001/zoom.x 
