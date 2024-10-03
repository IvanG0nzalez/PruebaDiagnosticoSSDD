var uuid = require('uuid');
const  models = require('../models');
const Lugar = models.lugar;

const lugares = [ 
    {
        tipo: 'Parques',
        nombre: 'Parque Lineal de la Tebaida',
        longitud: -79.20317352057474,
        latitud: -4.01930519378204,
    },
    {
        tipo: 'Parques',
        nombre: 'Parque Los Geranios',
        longitud: -79.20182309335632,
        latitud: -4.01469908357157,
    },
    {
        tipo: 'Hoteles',
        nombre: 'Jardines del Rìo Hotel',
        longitud: -79.20373456110322,
        latitud: -4.01928565048813,
    },
    {
        tipo: 'Hoteles',
        nombre: 'Real Hotel Jomaley',
        longitud: -79.20369632787958,
        latitud: -4.01989587730946,
    },
    {
        tipo: 'Hoteles',
        nombre: 'Hotel el Cardenal (3 estrellas)',
        longitud: -79.20193759956896,
        latitud: -4.01947634640736,
    },
    {
        tipo: 'Hoteles',
        nombre: 'Hostal CAMIL',
        longitud: -79.20300153042307,
        latitud: -4.00842742155751,
    },
    {
        tipo: 'Hoteles',
        nombre: 'Hotel La Casa de Manuel',
        longitud: -79.20268092281418,
        latitud: -4.00383124881930,
    },
    {
        tipo: 'Iglesias',
        nombre: 'Iglesia Católica Isidro Labrador',
        longitud: -79.20258517251430,
        latitud: -4.02823734579034,
    },
    {
        tipo: 'Iglesias',
        nombre: 'Capilla Católica del Monasterio de Santa Clara del Diviño Niño',
        longitud: -79.21227871457526,
        latitud: -4.03151891083824,
    },
    {
        tipo: 'Iglesias',
        nombre: 'Iglesia Cristiana Semilla de Mostaza',
        longitud: -79.20048627737816,
        latitud: -4.01614271827277,
    },
    {
        tipo: 'Iglesias',
        nombre: 'Iglesia Católica Nuestra Señora de La Paz - La Pradera',
        longitud: -79.19945398034000,
        latitud: -4.01301528660268,
    },
    {
        tipo: 'Iglesias',
        nombre: 'Iglesia Cristiana Verbo Loja',
        longitud: -79.20115535890865,
        latitud: -4.01107017058101,
    },
    {
        tipo: 'Iglesias',
        nombre: 'Capilla Católica Reina del Cisne',
        longitud: -79.20608744486015,
        latitud: -4.01223342677453,
    },
    {
        tipo: 'Museos',
        nombre: 'Centro Municipal Alfredo Mora Reyes',
        longitud: -79.20171400292982,
        latitud: -4.00230423439573,
    },
    {
        tipo: 'Museos',
        nombre: 'Galería de Arte AGUILAR',
        longitud: -79.20279540182014,
        latitud: -4.00211545108484,
    },
    {
        tipo: 'Museos',
        nombre: 'Museo de la Música',
        longitud: -79.20115742296738,
        latitud: -3.99807161389808,
    },
    {
        tipo: 'Micromercados',
        nombre: 'Micromercado El Pentágono - Sucursal',
        longitud: -79.20275599371044,
        latitud: -4.03124890540542,
    },
    {
        tipo: 'Micromercados',
        nombre: 'Micromercado la argelia',
        longitud: -79.20286413359946,
        latitud: -4.02938810543788,
    },
    {
        tipo: 'Micromercados',
        nombre: 'Micromercado del Sur',
        longitud: -79.20618943524191,
        latitud: -4.03216581980657,
    },
    {
        tipo: 'Micromercados',
        nombre: 'Micromercado Maria José',
        longitud: -79.20837926818420,
        latitud: -4.02876783788509,
    },
    {
        tipo: 'Micromercados',
        nombre: 'Micromercado, Bazar y Papeleria Danielita',
        longitud: -79.20913624740744,
        latitud: -4.02952294620750,
    },
    {
        tipo: 'Micromercados',
        nombre: 'Micromercado Katha',
        longitud: -79.20923333269052,
        latitud: -4.02565111420427,
    },
    {
        tipo: 'Micromercados',
        nombre: 'Micromercado Marilú',
        longitud: -79.20965389815049,
        latitud: -4.02416369603267,
    },
    {
        tipo: 'Micromercados',
        nombre: 'Micromercado Sabor de Mi Tierra',
        longitud: -79.21454775077592,
        latitud: -4.02675714133952,
    },
    {
        tipo: 'Micromercados',
        nombre: 'Micromercado Emili',
        longitud: -79.21718499816843,
        latitud: -4.02106488709375,
    },
    {
        tipo: 'Micromercados',
        nombre: 'Micro Iberoamérica',
        longitud: -79.20359584651098,
        latitud: -4.01600393827749,
    },
    {
        tipo: 'Micromercados',
        nombre: 'Micromercado El Parque',
        longitud: -79.20508914267010,
        latitud: -4.01134282630577,
    },
    {
        tipo: 'Micromercados',
        nombre: 'Micromercado Paulina',
        longitud: -79.19820071197654,
        latitud: -4.01340909568574,
    },
    {
        tipo: 'Micromercados',
        nombre: 'Micromercado Portugal',
        longitud: -79.20937634776345,
        latitud: -4.01047787484455,
    },
    {
        tipo: 'Restaurantes',
        nombre: 'Los Baldes de la U',
        longitud: -79.20068465443266,
        latitud: -4.03260015544919,
    },
    {
        tipo: 'Restaurantes',
        nombre: 'Las Papitas Reinas del Cisne',
        longitud: -79.20263586606974,
        latitud: -4.03235916007866,
    },
    {
        tipo: 'Restaurantes',
        nombre: 'Orfita Restaurant',
        longitud: -79.20568406112068,
        latitud: -4.03325002117127,
    },
    {
        tipo: 'Restaurantes',
        nombre: 'Restaurant La Taberna',
        longitud: -79.20224668148857,
        latitud: -4.03190869106456,
    },
    {
        tipo: 'Restaurantes',
        nombre: 'Big Bang Restaurante',
        longitud: -79.20228074342295,
        latitud: -4.03176853331369,
    },
    {
        tipo: 'Restaurantes',
        nombre: 'Origen Restaurant',
        longitud: -79.20249317213738,
        latitud: -4.03021530514618,
    },
    {
        tipo: 'Restaurantes',
        nombre: 'Yanuna Taqueria',
        longitud: -79.20184599543758,
        latitud: -4.02928091781518,
    },
    {
        tipo: 'Restaurantes',
        nombre: 'Gringo\'s English Pub',
        longitud: -79.20090929231942,
        latitud: -4.02951876196492,
    },
    {
        tipo: 'Parques',
        nombre: 'Parque Universitario Educaciòn Ambiental y Recreacional Francisco Vivar Castro',
        longitud: -79.19765410072702,
        latitud: -4.03670869876438,
    },
    {
        tipo: 'Parques',
        nombre: 'Parque con Estatua A José Marti y Eloy Alfaro',
        longitud: -79.20556129044601,
        latitud: -4.03496140214333,
    },
    {
        tipo: 'Parques',
        nombre: 'Parque Jugaquina',
        longitud: -79.20310467259843,
        latitud: -4.01303381464748,
    },
    {
        tipo: 'Parques',
        nombre: 'Parque Recreacional Daniel Alvarez Burneo en LOJA',
        longitud: -79.21166216828077,
        latitud: -4.01908851247373,
    }
]

const agregarLugares = async () => {
    for (const lugarData of lugares) {
        try {
            const [lugarExistente, created] = await Lugar.findOrCreate({
                where: {
                    nombre: lugarData.nombre,
                    longitud: lugarData.longitud,
                    latitud: lugarData.latitud
                },
                defaults: {
                    tipo: lugarData.tipo,
                    external_id: uuid.v4()
                }
            });
            if (created) {
                console.log(`Lugar agregado: ${lugarData.nombre}`);
            } else {
                console.log(`Lugar ya existe: ${lugarData.nombre}`);
            }
        } catch (error) {
            console.error(`Error al agregar lugar: ${lugarData.nombre}`, error);
        }
    }
};

module.exports = agregarLugares;
