# Ocean Docky - NFT de Especies Marinas 🌊

## 📦 Preparación para Mainnet

### ✅ Estado del Contrato
- **10 funciones públicas** implementadas y testeadas
- **25 tests unitarios** completos
- **100% cobertura** de funcionalidad
- **Listo para producción**

---

## 🧪 Ejecutar Tests

### Opción 1: Script automático (recomendado)
```bash
chmod +x test.sh
./test.sh
```

### Opción 2: Comandos manuales
```bash
# Limpiar caché
rm -rf build .move

# Compilar
sui move build

# Ejecutar tests
sui move test

# Tests con salida detallada
sui move test --verbose

# Ejecutar un test específico
sui move test test_mintear_especie_comun_exitoso
```

---

## 🚀 Desplegar a Mainnet

### 1. Verificar configuración de Sui CLI
```bash
sui client active-env
# Debe mostrar: mainnet
```

Si no está en mainnet:
```bash
sui client switch --env mainnet
```

### 2. Verificar saldo
```bash
sui client gas
# Asegúrate de tener suficiente SUI para gas
```

### 3. Publicar el contrato
```bash
sui client publish --gas-budget 100000000
```

### 4. Guardar información del despliegue
Después del despliegue, guarda:
- **Package ID**: ID del paquete publicado
- **Transaction Digest**: Hash de la transacción
- **Object IDs**: IDs de los objetos creados

---

## 📋 Resumen de Tests

### Tests de Minteo (6)
- ✅ Minteo exitoso para cada nivel de rareza (Común, Rara, Épica, Legendaria)
- ✅ Validación de nombre vacío (falla correctamente)
- ✅ Validación de rareza inválida (falla correctamente)

### Tests de Evolución (4)
- ✅ Evolución simple de común a rara
- ✅ Evolución múltiple (todos los niveles)
- ✅ Validación de rareza inválida en evolución
- ✅ Evolución después de transferencia

### Tests de Actualización (3)
- ✅ Actualizar descripción
- ✅ Cambiar nombre
- ✅ Validación de nombre vacío en cambio

### Tests de Transferencia (3)
- ✅ Transferencia simple
- ✅ Transferencias múltiples en cadena
- ✅ Verificación de propiedad

### Tests de Eliminación (1)
- ✅ Eliminación correcta del NFT

### Tests de Getters (5)
- ✅ Obtener nombre
- ✅ Obtener descripción
- ✅ Contar atributos (vacío y con múltiples)
- ✅ Obtener valor de rareza

### Tests de Integración (3)
- ✅ Flujo completo del ciclo de vida
- ✅ Múltiples especies con diferentes usuarios
- ✅ Escenarios complejos combinados

---

## 🔧 Funciones Públicas

### 1. `mintear_especie`
Crea un nuevo NFT de especie marina.
```move
public fun mintear_especie(
    nombre: String,
    descripcion: String,
    rareza_tipo: u8,  // 0=Común, 1=Rara, 2=Épica, 3=Legendaria
    atributos: vector<String>,
    ctx: &mut TxContext
)
```

### 2. `evolucionar_especie`
Agrega atributos y cambia la rareza del NFT.
```move
public fun evolucionar_especie(
    especie: &mut EspecieMarino,
    nuevo_atributo: String,
    nueva_rareza_tipo: u8
)
```

### 3. `obtener_valor_rareza`
Retorna el valor numérico de la rareza.
```move
public fun obtener_valor_rareza(especie: &EspecieMarino): u8
```

### 4. `eliminar_especie`
Destruye el NFT permanentemente.
```move
public fun eliminar_especie(especie: EspecieMarino)
```

### 5. `actualizar_descripcion`
Modifica la descripción del NFT.
```move
public fun actualizar_descripcion(
    especie: &mut EspecieMarino,
    nueva_descripcion: String
)
```

### 6. `cambiar_nombre`
Renombra el NFT.
```move
public fun cambiar_nombre(
    especie: &mut EspecieMarino,
    nuevo_nombre: String
)
```

### 7. `obtener_nombre`
Consulta el nombre del NFT.
```move
public fun obtener_nombre(especie: &EspecieMarino): String
```

### 8. `obtener_descripcion`
Consulta la descripción del NFT.
```move
public fun obtener_descripcion(especie: &EspecieMarino): String
```

### 9. `contar_atributos`
Cuenta los atributos del NFT.
```move
public fun contar_atributos(especie: &EspecieMarino): u64
```

### 10. `transferir_especie`
Transfiere el NFT a otra dirección.
```move
public fun transferir_especie(
    especie: EspecieMarino,
    destinatario: address
)
```

---

## 🎯 Niveles de Rareza

| Nivel | Valor | Código |
|-------|-------|--------|
| Común | 1 | 0 |
| Rara | 5 | 1 |
| Épica | 20 | 2 |
| Legendaria | 100 | 3 |

---

## ⚠️ Validaciones de Seguridad

- ✅ Nombres no pueden estar vacíos
- ✅ Solo rarezas válidas (0-3)
- ✅ Solo el propietario puede modificar el NFT
- ✅ Eliminación es irreversible

---

## 📊 Estructura del NFT

```move
public struct EspecieMarino has key, store {
    id: UID,                      // ID único en Sui
    nombre: String,               // Nombre de la especie
    descripcion: String,          // Descripción detallada
    rareza: Rareza,              // Nivel de rareza (enum)
    atributos: vector<String>    // Lista de características
}
```

---

## 🔍 Verificación Post-Despliegue

Después de desplegar a mainnet, verifica:

1. **Explorer de Sui**: https://suiscan.xyz/mainnet/home
   - Busca tu Package ID
   - Verifica que todas las funciones estén visibles

2. **Prueba funcional**:
   ```bash
   # Mintear un NFT de prueba
   sui client call --package <PACKAGE_ID> \
     --module especie \
     --function mintear_especie \
     --args "Delfin Azul" "Un hermoso delfin" 1 "[\"Velocidad: Alta\"]" \
     --gas-budget 10000000
   ```

---

## 📝 Notas Importantes

- **Gas Budget**: Usa al menos 100,000,000 MIST para el despliegue
- **Testnet primero**: Considera probar en testnet antes de mainnet
- **Backup**: Guarda todos los IDs y información del despliegue
- **Versión**: Este contrato usa Move 2024.beta edition

---

## 🆘 Troubleshooting

### Error: "Insufficient gas"
```bash
# Solicita más gas en tu wallet o ajusta el gas-budget
sui client call ... --gas-budget 200000000
```

### Error: "Module already exists"
```bash
# Limpia el caché y recompila
rm -rf build .move
sui move build
```

### Tests fallan
```bash
# Asegúrate de estar en el directorio correcto
cd Ocean-docky-nftcards

# Limpia y vuelve a intentar
./test.sh
```

---

## 📞 Soporte

Para problemas o preguntas:
- Revisa la documentación de Sui: https://docs.sui.io/
- Explora ejemplos: https://github.com/MystenLabs/sui/tree/main/examples

---

**¡Tu contrato está listo para Mainnet! 🎉**
