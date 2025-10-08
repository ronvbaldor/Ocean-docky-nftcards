#!/bin/bash

echo "🧹 Limpiando caché anterior..."
rm -rf build .move

echo "🔨 Compilando contrato..."
sui move build

if [ $? -eq 0 ]; then
    echo "✅ Compilación exitosa!"
    echo ""
    echo "🧪 Ejecutando tests..."
    sui move test
else
    echo "❌ Error en compilación"
    exit 1
fi
