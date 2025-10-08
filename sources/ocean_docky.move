module marino_nft::especie {
    // Imports necesarios para Sui y strings
    use std::string::String;

    // --- ESTRUCTURAS PRINCIPALES ---

    // NFT principal: Representa una especie marina única con ID, nombre, rareza y atributos.
    public struct EspecieMarino has key, store {
        id: sui::object::UID,
        nombre: String,
        descripcion: String,
        rareza: Rareza,
        atributos: vector<String>  // Ej: ["Profundidad: 100m", "Color: Azul"]
    }

    // Enum para niveles de rareza, cada uno con un valor numérico (para metadata).
    public enum Rareza has store, drop, copy {
        Comun(Comun),
        Rara(Rara),
        Epica(Epica),
        Legendaria(Legendaria)
    }

    // Estructuras para cada rareza con un "valor" (puede usarse para pricing futuro).
    public struct Comun has store, drop, copy {
        valor: u8  // Ej: 1
    }
    public struct Rara has store, drop, copy {
        valor: u8  // Ej: 5
    }
    public struct Epica has store, drop, copy {
        valor: u8  // Ej: 20
    }
    public struct Legendaria has store, drop, copy {
        valor: u8  // Ej: 100
    }

    // --- CONSTANTES DE ERROR ---
    #[error]
    const E_RAREZA_INVALIDA: vector<u8> = b"ERROR: Rareza invalida";
    #[error]
    const E_NOMBRE_VACIO: vector<u8> = b"ERROR: Nombre no puede estar vacio";

    // --- FUNCIONES PRINCIPALES ---

    // Mintea un nuevo NFT de especie marina.
    #[allow(lint(self_transfer))]
    public fun mintear_especie(
        nombre: String,
        descripcion: String,
        rareza_tipo: u8,  // 0=Comun, 1=Rara, 2=Epica, 3=Legendaria
        atributos: vector<String>,
        ctx: &mut sui::tx_context::TxContext
    ) {
        assert!(!nombre.is_empty(), E_NOMBRE_VACIO);

        let rareza = match_rareza(rareza_tipo);
        let especie = EspecieMarino {
            id: sui::object::new(ctx),
            nombre,
            descripcion,
            rareza,
            atributos
        };
        // Transfiere al creador.
        sui::transfer::transfer(especie, ctx.sender());
    }

    // Función helper para crear el enum Rareza.
    fun match_rareza(tipo: u8): Rareza {
        if (tipo == 0) {
            Rareza::Comun(Comun { valor: 1 })
        } else if (tipo == 1) {
            Rareza::Rara(Rara { valor: 5 })
        } else if (tipo == 2) {
            Rareza::Epica(Epica { valor: 20 })
        } else if (tipo == 3) {
            Rareza::Legendaria(Legendaria { valor: 100 })
        } else {
            abort E_RAREZA_INVALIDA
        }
    }

    // Evoluciona el NFT: Agrega un atributo y actualiza rareza si es posible (ej: de Comun a Rara).
    public fun evolucionar_especie(
        especie: &mut EspecieMarino,
        nuevo_atributo: String,
        nueva_rareza_tipo: u8
    ) {
        vector::push_back(&mut especie.atributos, nuevo_atributo);
        especie.rareza = match_rareza(nueva_rareza_tipo);
    }

    // Obtiene el valor de rareza como u8 para display.
    public fun obtener_valor_rareza(especie: &EspecieMarino): u8 {
        match (&especie.rareza) {
            Rareza::Comun(d) => d.valor,
            Rareza::Rara(d) => d.valor,
            Rareza::Epica(d) => d.valor,
            Rareza::Legendaria(d) => d.valor,
        }
    }

    // Elimina el NFT (solo el owner puede, en un contexto real agrega checks).
    public fun eliminar_especie(especie: EspecieMarino) {
        let EspecieMarino { id, nombre: _, descripcion: _, rareza: _, atributos: _ } = especie;
        sui::object::delete(id);
    }

    // Actualiza la descripción de una especie marina.
    public fun actualizar_descripcion(especie: &mut EspecieMarino, nueva_descripcion: String) {
        especie.descripcion = nueva_descripcion;
    }

    // Cambia el nombre de una especie marina.
    public fun cambiar_nombre(especie: &mut EspecieMarino, nuevo_nombre: String) {
        assert!(!nuevo_nombre.is_empty(), E_NOMBRE_VACIO);
        especie.nombre = nuevo_nombre;
    }

    // Obtiene el nombre de la especie como String.
    public fun obtener_nombre(especie: &EspecieMarino): String {
        especie.nombre
    }

    // Obtiene la descripción de la especie como String.
    public fun obtener_descripcion(especie: &EspecieMarino): String {
        especie.descripcion
    }

    // Obtiene el número total de atributos de una especie.
    public fun contar_atributos(especie: &EspecieMarino): u64 {
        vector::length(&especie.atributos)
    }

    // Transfiere una especie marina a otro usuario.
    #[allow(lint(custom_state_change))]
    public fun transferir_especie(especie: EspecieMarino, destinatario: address) {
        sui::transfer::transfer(especie, destinatario);
    }
}