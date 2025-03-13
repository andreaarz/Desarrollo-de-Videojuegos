/* Configuración inicial en Unity
    Crea un nuevo proyecto 2D en Unity.
    Crea un GameObject para el jugador (por ejemplo, un sprite simple de un cuadrado o un personaje).
    Crea una plataforma estática en el escenario para que el jugador pueda saltar sobre ella (puedes hacerlo con un cubo 2D).
    Agrega un Rigidbody2D y un Collider2D al jugador y a las plataformas.
    Asocia un Sprite Renderer al jugador para que tenga una apariencia visual.
*/

// Código en C#
using UnityEngine;

public class PlayerController : MonoBehaviour
{
    // Variables públicas para ajustar en el Inspector
    public float moveSpeed = 5f;       // Velocidad de movimiento
    public float jumpForce = 10f;      // Fuerza de salto
    public Transform groundCheck;      // Referencia al suelo
    public LayerMask groundLayer;      // Capa que representa el suelo

    // Variables privadas
    private Rigidbody2D rb;
    private bool isGrounded;
    private float groundCheckRadius = 0.2f; // Radio de verificación del suelo
    private float moveInput;

    void Start()
    {
        // Inicializamos el Rigidbody2D
        rb = GetComponent<Rigidbody2D>();
    }

    void Update()
    {
        // Detectar si el jugador está tocando el suelo
        isGrounded = Physics2D.OverlapCircle(groundCheck.position, groundCheckRadius, groundLayer);

        // Obtener la entrada horizontal (teclas de dirección o A/D)
        moveInput = Input.GetAxisRaw("Horizontal");

        // Movimiento horizontal
        rb.velocity = new Vector2(moveInput * moveSpeed, rb.velocity.y);

        // Comprobar si el jugador presiona el botón de salto (espacio)
        if (isGrounded && Input.GetButtonDown("Jump"))
        {
            Jump();
        }
    }

    // Método de salto
    void Jump()
    {
        rb.velocity = Vector2.up * jumpForce;
    }
}

/* Explicación del código:
    moveSpeed: Controla la velocidad a la que se mueve el jugador.
    jumpForce: Determina qué tan alto puede saltar el jugador.
    groundCheck: Un Transform vacío en la base del jugador que se utiliza para verificar si el jugador está tocando el suelo.
    groundLayer: Capa para identificar qué objetos se consideran suelo.
    isGrounded: Booleano que asegura que el jugador solo pueda saltar cuando esté tocando el suelo.
*/
