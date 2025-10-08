# Ocean Docky - Sistema de NFTs de Especies Marinas 🌊

Contrato inteligente en Move para la blockchain Sui que permite mintear, gestionar y evolucionar NFTs de especies marinas con diferentes niveles de rareza.

## Descripción General

Este contrato implementa un sistema de NFTs únicos que representan especies marinas. Cada especie tiene atributos personalizables, niveles de rareza (Común, Rara, Épica, Legendaria) y capacidad de evolución.

---

## Funciones Principales

### 1. `mintear_especie`
**Descripción:** Crea un nuevo NFT de especie marina y lo transfiere al creador.

**Parámetros:**
- `nombre: String` - Nombre de la especie (no puede estar vacío)
- `descripcion: String` - Descripción detallada de la especie
- `rareza_tipo: u8` - Nivel de rareza (0=Común, 1=Rara, 2=Épica, 3=Legendaria)
- `atributos: vector<String>` - Lista de características (ej: ["Profundidad: 100m", "Color: Azul"])
- `ctx: &mut TxContext` - Contexto de la transacción

**Uso:** Mintea una nueva especie marina única con sus características iniciales.

**Ejemplo:**
```move
mintear_especie(
    string::utf8(b"Delfin Azul"),
    string::utf8(b"Delfin de aguas profundas"),
    1, // Rareza: Rara
    vector[string::utf8(b"Velocidad: Alta"), string::utf8(b"Habitat: Oceano")],
    ctx
);
```

---

### 2. `evolucionar_especie`
**Descripción:** Mejora un NFT existente agregando atributos y cambiando su nivel de rareza.

**Parámetros:**
- `especie: &mut EspecieMarino` - Referencia mutable al NFT a evolucionar
- `nuevo_atributo: String` - Atributo adicional a agregar
- `nueva_rareza_tipo: u8` - Nuevo nivel de rareza

**Uso:** Permite que una especie crezca y se vuelva más valiosa con el tiempo.

**Ejemplo:**
```move
evolucionar_especie(
    &mut mi_especie,
    string::utf8(b"Bioluminiscencia: Si"),
    2 // Evoluciona a Épica
);
```

---

### 3. `obtener_valor_rareza`
**Descripción:** Consulta el valor numérico asociado a la rareza de una especie.

**Parámetros:**
- `especie: &EspecieMarino` - Referencia al NFT

**Retorna:** `String` - Texto con el valor de rareza (ej: "Valor: 20")

**Uso:** Obtiene información sobre el valor de rareza para display o decisiones.

**Valores de rareza:**
- Común: 1
- Rara: 5
- Épica: 20
- Legendaria: 100

---

### 4. `actualizar_descripcion`
**Descripción:** Modifica la descripción de una especie marina existente.

**Parámetros:**
- `especie: &mut EspecieMarino` - Referencia mutable al NFT
- `nueva_descripcion: String` - Nueva descripción a establecer

**Uso:** Actualiza la información descriptiva de la especie sin afectar otros atributos.

---

### 5. `cambiar_nombre`
**Descripción:** Renombra una especie marina.

**Parámetros:**
- `especie: &mut EspecieMarino` - Referencia mutable al NFT
- `nuevo_nombre: String` - Nuevo nombre (no puede estar vacío)

**Uso:** Permite personalizar el nombre de la especie después de mintearla.

**Error:** Falla si el nombre está vacío (`E_NOMBRE_VACIO`)

---

### 6. `obtener_nombre`
**Descripción:** Consulta el nombre actual de una especie.

**Parámetros:**
- `especie: &EspecieMarino` - Referencia al NFT

**Retorna:** `String` - Nombre de la especie

**Uso:** Lee el nombre sin modificar el NFT.

---

### 7. `obtener_descripcion`
**Descripción:** Consulta la descripción actual de una especie.

**Parámetros:**
- `especie: &EspecieMarino` - Referencia al NFT

**Retorna:** `String` - Descripción de la especie

**Uso:** Lee la descripción sin modificar el NFT.

---

### 8. `contar_atributos`
**Descripción:** Cuenta el número total de atributos que tiene una especie.

**Parámetros:**
- `especie: &EspecieMarino` - Referencia al NFT

**Retorna:** `u64` - Cantidad de atributos

**Uso:** Verifica cuántos atributos se han agregado a la especie.

---

### 9. `transferir_especie`
**Descripción:** Transfiere la propiedad de un NFT a otra dirección.

**Parámetros:**
- `especie: EspecieMarino` - NFT a transferir (consume el objeto)
- `destinatario: address` - Dirección del nuevo propietario

**Uso:** Envía el NFT a otro usuario de la blockchain Sui.

---

### 10. `eliminar_especie`
**Descripción:** Destruye permanentemente un NFT de especie marina.

**Parámetros:**
- `especie: EspecieMarino` - NFT a eliminar (consume el objeto)


---

##  Niveles de Rareza

| Nivel | Valor | Descripción |
|-------|-------|-------------|
| Común | 1 | Especies comunes y abundantes |
| Rara | 5 | Especies poco frecuentes |
| Épica | 20 | Especies muy raras y valiosas |
| Legendaria | 100 | Especies únicas y extremadamente raras |

---
## Estructura del NFT

```move
public struct EspecieMarino has key, store {
    id: UID,                      // ID único en Sui
    nombre: String,               // Nombre de la especie
    descripcion: String,          // Descripción detallada
    rareza: Rareza,              // Nivel de rareza (enum)
    atributos: vector<String>    // Lista de características
}
```

### SALIDA

╭──────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
│ Transaction Data                                                                                             │
├──────────────────────────────────────────────────────────────────────────────────────────────────────────────┤
│ Sender: 0x834ef2f8f2f98986320d4f47ae5cc06d9e3f689c1fb0cb38eea35bb2ca939165                                   │
│ Gas Owner: 0x834ef2f8f2f98986320d4f47ae5cc06d9e3f689c1fb0cb38eea35bb2ca939165                                │
│ Gas Budget: 17710000 MIST                                                                                    │
│ Gas Price: 495 MIST                                                                                          │
│ Gas Payment:                                                                                                 │
│  ┌──                                                                                                         │
│  │ ID: 0xb02612339f51839e3e7b0f4df945016da559cc1fad8a3fc794343b7fe98d346c                                    │
│  │ Version: 609580919                                                                                        │
│  │ Digest: FsBhFUtCgonMRqnPTNVRQEbTnfGMEbiWNih1FogAJDsY                                                      │
│  └──                                                                                                         │
│                                                                                                              │
│ Transaction Kind: Programmable                                                                               │
│ ╭──────────────────────────────────────────────────────────────────────────────────────────────────────────╮ │
│ │ Input Objects                                                                                            │ │
│ ├──────────────────────────────────────────────────────────────────────────────────────────────────────────┤ │
│ │ 0   Pure Arg: Type: address, Value: "0x834ef2f8f2f98986320d4f47ae5cc06d9e3f689c1fb0cb38eea35bb2ca939165" │ │
│ ╰──────────────────────────────────────────────────────────────────────────────────────────────────────────╯ │
│ ╭─────────────────────────────────────────────────────────────────────────╮                                  │
│ │ Commands                                                                │                                  │
│ ├─────────────────────────────────────────────────────────────────────────┤                                  │
│ │ 0  Publish:                                                             │                                  │
│ │  ┌                                                                      │                                  │
│ │  │ Dependencies:                                                        │                                  │
│ │  │   0x0000000000000000000000000000000000000000000000000000000000000001 │                                  │
│ │  │   0x0000000000000000000000000000000000000000000000000000000000000002 │                                  │
│ │  └                                                                      │                                  │
│ │                                                                         │                                  │
│ │ 1  TransferObjects:                                                     │                                  │
│ │  ┌                                                                      │                                  │
│ │  │ Arguments:                                                           │                                  │
│ │  │   Result 0                                                           │                                  │
│ │  │ Address: Input  0                                                    │                                  │
│ │  └                                                                      │                                  │
│ ╰─────────────────────────────────────────────────────────────────────────╯                                  │
│                                                                                                              │
│ Signatures:                                                                                                  │
│    aBcvec9p4O6kGn0DyqjLA/T0qfUEFAZqjNjBw7Ik/QJwdaG7+NsJOpy9CHKKJ5hft7xnSbHbGXrMCRrRtKpRDg==                  │
│                                                                                                              │
╰──────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
╭───────────────────────────────────────────────────────────────────────────────────────────────────╮
│ Transaction Effects                                                                               │
├───────────────────────────────────────────────────────────────────────────────────────────────────┤
│ Digest: 78fCrDuMzHaMjT8Y2a7mscgkAx5xETQECkrDsWVBiTMe                                              │
│ Status: Success                                                                                   │
│ Executed Epoch: 910                                                                               │
│                                                                                                   │
│ Created Objects:                                                                                  │
│  ┌──                                                                                              │
│  │ ID: 0x62b80a30228ee51263ebfbcea01590fd6497e2b834d49af9e14bf115d4d9198b                         │
│  │ Owner: Account Address ( 0x834ef2f8f2f98986320d4f47ae5cc06d9e3f689c1fb0cb38eea35bb2ca939165 )  │
│  │ Version: 609580920                                                                             │
│  │ Digest: 6JiNspkFsjAjR7XSeiAuy677Erku7W9YvpX13ENjqGg2                                           │
│  └──                                                                                              │
│  ┌──                                                                                              │
│  │ ID: 0xf336440d8dd87660f91bf320f945c3aca71fdb4966d206626c5ee0ad0eb5e366                         │
│  │ Owner: Immutable                                                                               │
│  │ Version: 1                                                                                     │
│  │ Digest: CM8MdWd4VFujjJGCApMJNfJ1v18PmUReLq5Xevy7vgGB                                           │
│  └──                                                                                              │
│ Mutated Objects:                                                                                  │
│  ┌──                                                                                              │
│  │ ID: 0xb02612339f51839e3e7b0f4df945016da559cc1fad8a3fc794343b7fe98d346c                         │
│  │ Owner: Account Address ( 0x834ef2f8f2f98986320d4f47ae5cc06d9e3f689c1fb0cb38eea35bb2ca939165 )  │
│  │ Version: 609580920                                                                             │
│  │ Digest: DNjm7oKTR89xUXCLJPURSFgGq8awwQNytHTunuzSZvHh                                           │
│  └──                                                                                              │
│ Gas Object:                                                                                       │
│  ┌──                                                                                              │
│  │ ID: 0xb02612339f51839e3e7b0f4df945016da559cc1fad8a3fc794343b7fe98d346c                         │
│  │ Owner: Account Address ( 0x834ef2f8f2f98986320d4f47ae5cc06d9e3f689c1fb0cb38eea35bb2ca939165 )  │
│  │ Version: 609580920                                                                             │
│  │ Digest: DNjm7oKTR89xUXCLJPURSFgGq8awwQNytHTunuzSZvHh                                           │
│  └──                                                                                              │
│ Gas Cost Summary:                                                                                 │
│    Storage Cost: 16720000 MIST                                                                    │
│    Computation Cost: 495000 MIST                                                                  │
│    Storage Rebate: 978120 MIST                                                                    │
│    Non-refundable Storage Fee: 9880 MIST                                                          │
│                                                                                                   │
│ Transaction Dependencies:                                                                         │
│    yqtELKLqAuSGkt6PX52KHKvmDKCrV3KCLxm6HAqL6DZ                                                    │
│    9nATGuLyuZfaHKhhkmyBSjSJDq5k4yuPqqPwbNsKq4je                                                   │
│    G1dJj3RH5cHEZbqmprV17reohbpobGQDncxhETDWiZzd                                                   │
╰───────────────────────────────────────────────────────────────────────────────────────────────────╯
╭─────────────────────────────╮
│ No transaction block events │
╰─────────────────────────────╯

╭──────────────────────────────────────────────────────────────────────────────────────────────────╮
│ Object Changes                                                                                   │
├──────────────────────────────────────────────────────────────────────────────────────────────────┤
│ Created Objects:                                                                                 │
│  ┌──                                                                                             │
│  │ ObjectID: 0x62b80a30228ee51263ebfbcea01590fd6497e2b834d49af9e14bf115d4d9198b                  │
│  │ Sender: 0x834ef2f8f2f98986320d4f47ae5cc06d9e3f689c1fb0cb38eea35bb2ca939165                    │
│  │ Owner: Account Address ( 0x834ef2f8f2f98986320d4f47ae5cc06d9e3f689c1fb0cb38eea35bb2ca939165 ) │
│  │ ObjectType: 0x2::package::UpgradeCap                                                          │
│  │ Version: 609580920                                                                            │
│  │ Digest: 6JiNspkFsjAjR7XSeiAuy677Erku7W9YvpX13ENjqGg2                                          │
│  └──                                                                                             │
│ Mutated Objects:                                                                                 │
│  ┌──                                                                                             │
│  │ ObjectID: 0xb02612339f51839e3e7b0f4df945016da559cc1fad8a3fc794343b7fe98d346c                  │
│  │ Sender: 0x834ef2f8f2f98986320d4f47ae5cc06d9e3f689c1fb0cb38eea35bb2ca939165                    │
│  │ Owner: Account Address ( 0x834ef2f8f2f98986320d4f47ae5cc06d9e3f689c1fb0cb38eea35bb2ca939165 ) │
│  │ ObjectType: 0x2::coin::Coin<0x2::sui::SUI>                                                    │
│  │ Version: 609580920                                                                            │
│  │ Digest: DNjm7oKTR89xUXCLJPURSFgGq8awwQNytHTunuzSZvHh                                          │
│  └──                                                                                             │
│ Published Objects:                                                                               │
│  ┌──                                                                                             │
│  │ PackageID: 0xf336440d8dd87660f91bf320f945c3aca71fdb4966d206626c5ee0ad0eb5e366                 │
│  │ Version: 1                                                                                    │
│  │ Digest: CM8MdWd4VFujjJGCApMJNfJ1v18PmUReLq5Xevy7vgGB                                          │
│  │ Modules: especie                                                                              │
│  └──                                                                                             │
╰──────────────────────────────────────────────────────────────────────────────────────────────────╯
╭───────────────────────────────────────────────────────────────────────────────────────────────────╮
│ Balance Changes                                                                                   │
├───────────────────────────────────────────────────────────────────────────────────────────────────┤
│  ┌──                                                                                              │
│  │ Owner: Account Address ( 0x834ef2f8f2f98986320d4f47ae5cc06d9e3f689c1fb0cb38eea35bb2ca939165 )  │
│  │ CoinType: 0x2::sui::SUI                                                                        │
│  │ Amount: -16236880                                                                              │
│  └──                                                                                              │
╰───────────────────────────────────────────────────────────────────────────────────────────────────╯

