# Configuración inicial en Godot
#    Crea un nuevo proyecto en Godot.
#    Crea un Scene para el jugador y los objetos interactivos (por ejemplo, bloques y botones).
#    Agrega un Player como KinematicBody2D con una forma de colisión, y un sprite para el personaje.
#    Agrega bloques o interruptores interactivos que el jugador pueda mover o activar para resolver los puzzles.

#Código en GDScript
#ayerController.gd
extends KinematicBody2D

# Variables públicas para ajustar en el Inspector
export var speed = 200   # Velocidad del jugador
export var jump_height = 300  # Altura del salto

# Variables privadas
var velocity = Vector2()  # Dirección del movimiento

func _ready():
    pass

func _process(delta):
    velocity = Vector2()  # Resetear la velocidad

    # Movimiento horizontal
    if Input.is_action_pressed("ui_right"):
        velocity.x += speed
    if Input.is_action_pressed("ui_left"):
        velocity.x -= speed

    # Movimiento vertical (salto)
    if Input.is_action_just_pressed("ui_up") and is_on_floor():
        velocity.y -= jump_height

    # Aplicar la velocidad al personaje
    velocity = move_and_slide(velocity, Vector2(0, 1))

#Explicación:

#    El jugador se mueve hacia la izquierda y derecha usando las teclas de flecha (o las teclas que se definan en el proyecto).
#    El jugador puede saltar si está tocando el suelo.
#    La función move_and_slide maneja el movimiento físico del jugador.

#PuzzleBlock.gd
extends StaticBody2D

# Variables para el bloque
export var move_speed = 100  # Velocidad a la que se mueve el bloque

# Referencia al objeto interactivo
var target_position = Vector2()

func _ready():
    # Establecer la posición inicial del bloque
    target_position = position

func _process(delta):
    # Mover el bloque hacia la posición de destino
    if position != target_position:
        position = position.move_toward(target_position, move_speed * delta)

# Método para mover el bloque
func move_to_position(new_position):
    target_position = new_position

#Explicación:

#    Este script permite que el bloque se mueva hacia una nueva posición cuando se llama a la función move_to_position().
#    La función move_toward() hace que el bloque se desplace suavemente hacia su objetivo.

#Button.gd
extends Area2D

# Variables
export var is_active = false  # Estado del botón (activado/desactivado)
export var target_block : Node2D  # Referencia al bloque que debe moverse

func _ready():
    connect("body_entered", self, "_on_button_pressed")

func _on_button_pressed(body):
    if body.is_in_group("player"):
        is_active = true
        target_block.move_to_position(Vector2(500, 300))  # Mover el bloque a una nueva posición
        # Puedes agregar aquí otras acciones que se activan cuando el botón es presionado

#Explicación:

#    El botón detecta cuando el jugador entra en su área de colisión (es decir, cuando el jugador está cerca del botón).
#    Al presionar el botón, se mueve el bloque a una nueva posición.
#    Nota: Asegúrate de agregar al jugador (Player) al grupo "player" para que la función _on_button_pressed funcione correctamente.

#Escena de Godot
#    Crear la Escena: Añade un KinematicBody2D para el jugador con su sprite y colisión.
#    Crear el Bloque: Añade un StaticBody2D para el bloque con un sprite y colisión.
#    Crear el Botón: Añade un Area2D para el botón con una colisión y el script correspondiente.
#    Configurar la Cámara: Agrega una cámara a la escena para seguir al jugador si es necesario.
