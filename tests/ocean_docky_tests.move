#[test_only]
module marino_nft::especie_tests {
    use marino_nft::especie;
    use sui::test_scenario as ts;
    use std::string;

    const ADMIN: address = @0xAD;
    const USER1: address = @0xB0B;

    #[test]
    fun test_mintear_especie_comun() {
        let mut scenario = ts::begin(ADMIN);
        
        ts::next_tx(&mut scenario, ADMIN);
        {
            let mut atributos = vector::empty();
            vector::push_back(&mut atributos, string::utf8(b"Profundidad: 100m"));
            
            especie::mintear_especie(
                string::utf8(b"Pez Comun"),
                string::utf8(b"Un pez comun del oceano"),
                0,
                atributos,
                ts::ctx(&mut scenario)
            );
        };

        ts::next_tx(&mut scenario, ADMIN);
        {
            let nft = ts::take_from_sender(&scenario);
            assert!(especie::obtener_nombre(&nft) == string::utf8(b"Pez Comun"), 0);
            assert!(especie::obtener_valor_rareza(&nft) == 1, 1);
            ts::return_to_sender(&scenario, nft);
        };

        ts::end(scenario);
    }

    #[test]
    fun test_mintear_especie_rara() {
        let mut scenario = ts::begin(ADMIN);
        
        ts::next_tx(&mut scenario, ADMIN);
        {
            especie::mintear_especie(
                string::utf8(b"Pez Raro"),
                string::utf8(b"Pez raro"),
                1,
                vector::empty(),
                ts::ctx(&mut scenario)
            );
        };

        ts::next_tx(&mut scenario, ADMIN);
        {
            let nft = ts::take_from_sender(&scenario);
            assert!(especie::obtener_valor_rareza(&nft) == 5, 0);
            ts::return_to_sender(&scenario, nft);
        };

        ts::end(scenario);
    }

    #[test]
    fun test_mintear_especie_epica() {
        let mut scenario = ts::begin(ADMIN);
        
        ts::next_tx(&mut scenario, ADMIN);
        {
            especie::mintear_especie(
                string::utf8(b"Pez Epico"),
                string::utf8(b"Pez epico"),
                2,
                vector::empty(),
                ts::ctx(&mut scenario)
            );
        };

        ts::next_tx(&mut scenario, ADMIN);
        {
            let nft = ts::take_from_sender(&scenario);
            assert!(especie::obtener_valor_rareza(&nft) == 20, 0);
            ts::return_to_sender(&scenario, nft);
        };

        ts::end(scenario);
    }

    #[test]
    fun test_mintear_especie_legendaria() {
        let mut scenario = ts::begin(ADMIN);
        
        ts::next_tx(&mut scenario, ADMIN);
        {
            especie::mintear_especie(
                string::utf8(b"Pez Legendario"),
                string::utf8(b"Pez legendario"),
                3,
                vector::empty(),
                ts::ctx(&mut scenario)
            );
        };

        ts::next_tx(&mut scenario, ADMIN);
        {
            let nft = ts::take_from_sender(&scenario);
            assert!(especie::obtener_valor_rareza(&nft) == 100, 0);
            ts::return_to_sender(&scenario, nft);
        };

        ts::end(scenario);
    }

    #[test]
    fun test_evolucionar_especie() {
        let mut scenario = ts::begin(ADMIN);
        
        ts::next_tx(&mut scenario, ADMIN);
        {
            especie::mintear_especie(
                string::utf8(b"Pez Evolutivo"),
                string::utf8(b"Descripcion"),
                0,
                vector::empty(),
                ts::ctx(&mut scenario)
            );
        };

        ts::next_tx(&mut scenario, ADMIN);
        {
            let mut nft = ts::take_from_sender(&scenario);
            
            assert!(especie::obtener_valor_rareza(&nft) == 1, 0);
            assert!(especie::contar_atributos(&nft) == 0, 1);
            
            especie::evolucionar_especie(
                &mut nft,
                string::utf8(b"Bioluminiscencia"),
                2
            );
            
            assert!(especie::obtener_valor_rareza(&nft) == 20, 2);
            assert!(especie::contar_atributos(&nft) == 1, 3);
            
            ts::return_to_sender(&scenario, nft);
        };

        ts::end(scenario);
    }

    #[test]
    fun test_actualizar_descripcion() {
        let mut scenario = ts::begin(ADMIN);
        
        ts::next_tx(&mut scenario, ADMIN);
        {
            especie::mintear_especie(
                string::utf8(b"Pez Test"),
                string::utf8(b"Descripcion original"),
                0,
                vector::empty(),
                ts::ctx(&mut scenario)
            );
        };

        ts::next_tx(&mut scenario, ADMIN);
        {
            let mut nft = ts::take_from_sender(&scenario);
            
            especie::actualizar_descripcion(
                &mut nft,
                string::utf8(b"Nueva descripcion")
            );
            
            assert!(especie::obtener_descripcion(&nft) == string::utf8(b"Nueva descripcion"), 0);
            
            ts::return_to_sender(&scenario, nft);
        };

        ts::end(scenario);
    }

    #[test]
    fun test_cambiar_nombre() {
        let mut scenario = ts::begin(ADMIN);
        
        ts::next_tx(&mut scenario, ADMIN);
        {
            especie::mintear_especie(
                string::utf8(b"Nombre Original"),
                string::utf8(b"Desc"),
                0,
                vector::empty(),
                ts::ctx(&mut scenario)
            );
        };

        ts::next_tx(&mut scenario, ADMIN);
        {
            let mut nft = ts::take_from_sender(&scenario);
            
            especie::cambiar_nombre(
                &mut nft,
                string::utf8(b"Nombre Nuevo")
            );
            
            assert!(especie::obtener_nombre(&nft) == string::utf8(b"Nombre Nuevo"), 0);
            
            ts::return_to_sender(&scenario, nft);
        };

        ts::end(scenario);
    }

    #[test]
    fun test_transferir_especie() {
        let mut scenario = ts::begin(ADMIN);
        
        ts::next_tx(&mut scenario, ADMIN);
        {
            especie::mintear_especie(
                string::utf8(b"Pez Transferible"),
                string::utf8(b"Desc"),
                1,
                vector::empty(),
                ts::ctx(&mut scenario)
            );
        };

        ts::next_tx(&mut scenario, ADMIN);
        {
            let nft = ts::take_from_sender(&scenario);
            especie::transferir_especie(nft, USER1);
        };

        ts::next_tx(&mut scenario, USER1);
        {
            let nft = ts::take_from_sender(&scenario);
            assert!(especie::obtener_nombre(&nft) == string::utf8(b"Pez Transferible"), 0);
            ts::return_to_sender(&scenario, nft);
        };

        ts::end(scenario);
    }

    #[test]
    fun test_eliminar_especie() {
        let mut scenario = ts::begin(ADMIN);
        
        ts::next_tx(&mut scenario, ADMIN);
        {
            especie::mintear_especie(
                string::utf8(b"Pez Temporal"),
                string::utf8(b"Desc"),
                0,
                vector::empty(),
                ts::ctx(&mut scenario)
            );
        };

        ts::next_tx(&mut scenario, ADMIN);
        {
            let nft = ts::take_from_sender(&scenario);
            especie::eliminar_especie(nft);
        };

        ts::end(scenario);
    }

    #[test]
    fun test_contar_atributos() {
        let mut scenario = ts::begin(ADMIN);
        
        ts::next_tx(&mut scenario, ADMIN);
        {
            let mut atributos = vector::empty();
            vector::push_back(&mut atributos, string::utf8(b"Attr1"));
            vector::push_back(&mut atributos, string::utf8(b"Attr2"));
            vector::push_back(&mut atributos, string::utf8(b"Attr3"));
            
            especie::mintear_especie(
                string::utf8(b"Pez Con Attrs"),
                string::utf8(b"Desc"),
                0,
                atributos,
                ts::ctx(&mut scenario)
            );
        };

        ts::next_tx(&mut scenario, ADMIN);
        {
            let nft = ts::take_from_sender(&scenario);
            assert!(especie::contar_atributos(&nft) == 3, 0);
            ts::return_to_sender(&scenario, nft);
        };

        ts::end(scenario);
    }
}
