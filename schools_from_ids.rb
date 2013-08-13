require 'net/http'
require 'uri'
ids = [160258000455,160258000454,160258000171,160258000456,160237000423,160237000736,160237000580,160114000988,160114000211,160114000212,160114000213,160006000816,160006000003,160006000005,160006000589,160282000501,160009000006,160014100942,160014200809,160014300968,160014400967,160014600997,160014500996,160014800993,160015100994,160015401014,160015601007,160015501008,160036000042,160036000592,160036000758,160036000044,160036000045,160036000047,160036000049,160036000707,160036001002,160036000051,160036000984,160036000053,160036000982,160036000054,160036001004,160036000055,160036000056,160036000057,160036000009,160036000059,160036000060,160036000978,160036000183,160036000650,160036000062,160036000063,160036000065,160036000067,160036000980,160036000068,160036000069,160036000070,160036000071,160036000632,160036000004,160036000072,160036000591,160036000073,160036000643,160036000590,160036000075,160036000076,160036000987,160036000706,160036000078,160036000079,160036000074,160210000593,160210000674,160210000903,160210000597,160210000717,160210000366,160210000602,160210000901,160210000801,160210000466,160210000362,160210000318,160210000624,160210000319,160210000637,160210000945,160210000363,160210000958,160210000824,160210000598,160210000365,160210000638,160210000795,160210000639,160210000367,160210000368,160210000714,160210000371,160210000372,160210000804,160210000370,160210000759,160210000802,160210000803,160210000955,160210000931,160210000818,160210000794,160210000010,160210000770,160210000902,160210001000,160210000793,160210000985,160210000819,160210000601,160210000989,160210000640,160210000595,160210000373,160210000364,160210000374,160177000951,160177000805,160177000596,160177000913,160177000962,160177000307,160177000306,160177000904,160177000915,160206000826,160084000162,160084000163,160195000344,160195000345,160195000346,160195000820,160195000347,160195000348,160195000349,160264000686,160264000646,160264000464,160264000465,160264000467,160264000469,160264000642,160264000470,160264000471,160264000472,160264000473,160264000474,160264000475,160264000476,160264000468,160264000760,160264000478,160264000659,160264000481,160264000482,160264000483,160264000484,160024000016,160024000018,160024000017,160024000827,160024000021,160024000019,160306000485,160306000532,160306000534,160306000536,160081500719,160081500720,160081500647,160297000518,160297000519,160297000521,160297000520,160297000644,160027000022,160027000030,160027000031,160027000026,160027000027,160027000028,160027000689,160027000023,160027000025,160027000032,160003000828,160003000002,160003000829,160108000196,160108000198,160108000326,160291000723,160291000511,160291001012,160291000510,160291000508,160030000033,160030000034,160030000035,160030000036,160030000038,160030000493,160030000908,160117000830,160018000334,160018000350,160150000506,160150000831,160000100613,160000100771,160000100620,160000100619,160000100085,160000100084,160000200082,160000200615,160000200614,160000200603,160000200691,160000200621,160000200618,160000200772,160000200087,160000200724,160000200616,160000200617,160153000252,160153000255,160153000256,160153000257,160153000258,160153000697,160153000260,160153000726,160153000261,160153000262,160153000263,160153000264,160153000268,160153000725,160153000727,160105000194,160153000270,160153000633,160312000541,160093000167,160093000999,160093000169,160093000975,160093000630,160093000971,160093000172,160093000173,160093000024,160093000175,160093000176,160093000361,160093001015,160093000909,160093000168,160093000651,160093000649,160093000670,160093000178,160093000910,160042000089,160042000029,160042000091,160042000092,160042000606,160042000094,160049000007,160049000008,160049000662,160049000011,160054000110,160054000111,160234000409,160234000410,160234000870,160234000811,160234000947,160234000677,160234000834,160234000375,160234000986,160234000969,160234000514,160234000941,160234001013,160234000774,160234000383,160234000669,160234000775,160234000762,160234000773,160234000379,160234000515,160234000507,160234000419,160234000421,160234000422,160234000833,160051000104,160051000041,160051000105,160051000835,160051000106,160051000731,160051000109,160051000107,160051000108,160051000609,160348000585,160348000530,160213000675,160213000377,160213000378,160213000376,160213000812,160246000430,160246000431,160207000359,160207000836,160267000800,160267000487,160267000488,160267000489,160267000209,160267000844,160267000490,160267000970,160174000302,160174000303,160015001010,160318000884,160318000754,160318000543,160318000544,160318000545,160318000547,160324000548,160324000998,160324000549,160324000660,160324000550,160324000703,160324000551,160324000316,160324000553,160324000554,160324000755,160324000555,160324000552,160048000102,160048000103,160048000101,160105000193,160153000269,160105001006,160105000631,160105000195,160015300796,160015200304,160351100685,160171000300,160171000635,160171000179,160141000241,160141000757,160069000137,160231000406,160231000408,160231000407,160203000356,160203000583,160203000354,160203000584,160063000120,160063000121,160333000566,160333000567,160333000568,160333000569,160057000112,160057000113,160216000857,160000300858,160000400859,160000500862,160000600863,160000700864,160000800865,160001100866,160001200867,160001300890,160001400891,160001500892,160165000290,160165000293,160165000292,160165000294,160165000297,160228000404,160228000405,160330000562,160330000565,160014000949,160255000449,160255000451,160255000080,160060000778,160060000083,160060000935,160060000115,160060000976,160060001016,160060000838,160060000839,160060000914,160060000118,160060000539,160060001011,160060000119,160129000225,160129000742,160129000228,160243000427,160243000428,160300000525,160300000526,160300000527,160066000122,160066000123,160066000125,160066000124,160066000540,160066000126,160066000610,160066000127,160066000128,160066000130,160066000131,160066000132,160066000129,160066000134,160066000387,160075000144,160075000145,160252000436,160252000439,160252000440,160252000442,160252000983,160252000445,160072000139,160072000140,160072000143,160190000331,160190000332,160273000496,160123000219,160123000220,160123000744,160225000396,160225000745,160225000401,160225000397,160225000400,160225000402,160225000266,160225000403,160096000181,160096000182,160096000612,160342000563,160342000412,160342000388,160111000200,160111000622,160111000203,160111000204,160111000205,160111000625,160111000207,160102000095,160102000185,160102000187,160102000191,160102000797,160102000190,160102000923,160102001009,160102000798,160102000192,160126000223,160126000224,160126000222,160336000570,160336000271,160336000571,160138000840,160033000040,160081000160,160081000161,160081000159,160013800959,160013800944,160013900961,160013900936,160013900933,160013900946,160013900937,160157000634,160157000626,160157000276,160157000274,160157000275,160157000672,160157000277,160157000278,160157001001,160279000429,160279000435,160340000273,160340000280,160340000281,160159000272,160159000283,160159000284,160159000285,160159000097,160159000972,160327000558,160078000152,160078000146,160078000147,160078000148,160078000765,160078000149,160078000150,160078000208,160078000114,160078000291,160078000153,160078000694,160078000155,160078000799,160078000156,160078000157,160078000747,160180000309,160180000295,160180000734,160180000310,160180000312,160180000311,160180000437,160180000313,160180000842,160180000843,160180000956,160222000390,160222000391,160222000392,160222000749,160222000393,160222000394,160222000154,160222000395,160120000845,160168000298,160168000299,160270000494,160270000495,160000900581,160000900582,160001000578,160001000579,160001000846,160285000504,160285000502,160285000503,160285000847,160303000528,160303000529,160240000848,160162000286,160162000457,160162000458,160144000849,160294000512,160294000851,160294000850,160090000165,160276000497,160192000333,160192000336,160192000337,160192000338,160192000339,160192000340,160192000210,160192000341,160192000974,160309000537,160309000645,160309000538,160309000702,160309000853,160219000380,160219000381,160219000382,160219000385,160219000158,160219000641,160219000666,160219000389,160186000320,160186000321,160186000322,160186000323,160186000324,160186000325,160186000327,160186000328,160186000329,160186000330,160183000317,160183000854,160087000164,160249000432,160249000629,160249000433,160249000856,160198000351,160198000352,160198000636,160261000459,160045000098,160045000099,160045000100,160147000250,160147000248,160147000767]
#ids = [190408000101,190408000102,191467000467,190354000049,190822000409,190309000006,190309000007,190633000522,190858000456,190315000008,190315001986,190315000009,192211001313,190306000003,190306000004,190306000634,191401000838,190322001937,190322001938,190322001939,192094001251,190003101300,190327000017,190327001406,190330000024,190330000025,190003201317,190579000191,190336000030,190336000034,190339000039,190345000042,190348000045,190348000046,190735000374,191878001099,191914001250,192682001566,190759000048,190354000050,190354000060,190357000061,190507000153,190363000067,190363002136,190369000071,191872001082,190372000080,190372000079,190375000082,190375000081,190375001337,190378000083,190385002137,190385001901,190385001899,190654000233,190369002094,193024000427,190483000136,190393000090,190393000093,190396000095,190948000602,190396000096,190402000099,190402000013,192061002127,191872001084,191320000789,190420000106,190420000105,192061002052,190432000111,190432000864,190438000113,190438000114,190432000862,190444000119,190444000118,190444000087,191545000478,190456000122,190456000120,190462000124,190465000128,190465000129,190468001436,190468000130,190468002090,190474000134,190483001987,190483000137,192061002117,192061001221,193135001823,190336000031,190486000142,190486000143,190579000180,190822000411,190858000457,190771000597,191470000881,190507002125,190507000154,190513000156,190513000157,191722001002,190519000166,190519000167,190957000599,190957000628,192311001362,191851001060,190891002097,190897000517,191644000980,190549000173,190549000174,193051000699,190897000746,190948000603,190336000032,192640001498,190858000458,190858000459,191470002133,193048000586,190579001974,190579000181,191182000720,190597000201,190597000203,190600000204,190600002042,190897000519,190594000070,190594000200,190594000069,190594000199,190606000209,190606000206,190606000207,190897000518,190624001975,191851001061,190624000211,190627000214,190627000215,190627001561,191965001152,190708000982,190873001501,190633000218,190633001989,190822000413,190897001596,190948001532,193135001824,193135001825,190897000521,190651000830,190651000221,190651000222,192682001567,190666000272,190666002150,190666002041,190666000273,190675002096,190675000700,190675000275,190681000903,190678000284,190678000285,190678001998,190684000292,190690000297,192025001200,191470000883,193111001816,190681000286,190858000461,190681002144,190693000305,190693000302,190693000303,190696000306,190696000307,190696000308,190681000287,192013001182,193048002024,192076001238,192076001235,192076001239,192076001236,190675000276,191824001045,190705000313,190705000314,190708000319,190708000320,190711000327,190711000326,190711000328,190717000335,190858000471,190858001516,190858001416,190858001204,190675000650,190675000277,190735000423,190735000340,190735000341,190738000346,190738000347,190738000348,191653000983,192046001209,192640001500,190741000351,190741000349,190741000350,190744000354,190744000355,190747002027,190747000690,192682001168,191335000807,191335000806,191335000751,190759000361,190759001903,190759000359,190762000362,190762000363,190762000364,190765000367,190654000234,190771000370,193093001789,191437000858,192311001363,192082001241,190000900385,190000900386,190000901976,190822002146,190790001950,190790001951,190792000395,190792002152,190792002071,190792000394,192013001183,190798000396,190798000398,190705000315,190654000235,190807000402,191182000721,192334001377,192532001445,190813000403,190813000404,190813000405,190579000183,190819000407,190897002011,190822000414,192640001502,191428002088,191428000850,190831000446,190831001421,190831000444,190831001237,193093001790,191428000848,191428000849,190369000778,193093001791,193048001719,190852000705,190852000451,190852000453,190855000454,190855000455,190861000492,190861000059,190861000493,191320000790,199901902077,190873000501,190873000498,192682001568,191854001064,190888000505,191107000684,190891000915,190891000511,190891000508,190891000509,191185000732,190894000512,190894000513,190894000514,190897001548,190897002129,190315000010,192750000671,190906000593,190906000594,190912000595,190912000596,190912001207,192211001314,190897000232,190945000600,193135000205,190948000604,191182000722,190954000624,190954000625,190960000629,192760001609,190960000630,190960000631,193135001828,190002200632,191668000995,190999001537,190999000635,190771001519,191005000640,191005001956,191005000641,191854001065,191458001318,193099001408,190717000325,193051000299,191011000642,191011000643,191011000644,190339000036,192739001597,190420000109,190369000072,192598001473,191458000865,192640001504,190897000528,193048001714,190004001523,190004000132,190004000121,190004000117,192640001505,191824001046,191824000779,191824002086,192958001438,192958001686,192958001687,192958001511,191035000661,191035000659,191722002092,190495000667,190495000151,190495000668,191050000669,191050000670,190822000416,193048001715,190897000529,192034001326,192094001252,190354000052,190858000462,190948000605,192211001315,190681000288,191069001912,191069002048,190948000976,191470001030,191071002143,191071000674,193048001560,190684000293,191323000795,191428000851,191464000870,191869001074,192640001506,192061002131,191095000675,191095000676,191098000680,191098000679,193135001829,191470000885,190654000237,192628001606,191104000682,191104000683,191107000685,191107000686,192211001316,191722001005,191125002142,193048002126,191182001980,192976001693,191134000693,191134000694,193093001792,190633000217,191320000791,192691001577,193135001830,191152000702,191182000723,190354000053,190858000463,190897000531,191872001086,190861000959,191179001281,191179000715,191179000716,191179000717,191182000724,191185001957,191185000733,191185000734,192682001569,191869000437,190858000464,191872000372,192013001184,191653000985,190822000418,190513000159,190654000239,191197000741,191206000743,191212000747,191212000745,190948000607,190513002056,191223001959,191223001960,191223002122,190735000342,190858000465,190654000240,190675000278,191233000752,191233000753,191233000754,190897000534,190897002128,191248000757,193048001725,191563000936,190654000241,190948000620,191248001011,191248000758,190822000419,191251000759,191251000760,191251001471,191260000762,191260000210,191266001401,191266001402,191266002014,191269000766,191269000767,191275000771,191275000772,190006000182,190006000179,191584000524,190897000535,191281002120,191281000776,191281002118,199901900777,191020000651,190327000019,190654002044,192013001186,191470000886,190654000243,190486000144,190345000784,193054000832,190897000538,191320000793,191320000792,191323000796,191329000799,191329000801,191329000415,191332000803,191332000804,191332000805,191338001993,191338000808,193063000990,191347000813,191347000814,190897000539,191878001102,190897000540,190654000244,191350000826,191350000825,191350000821,191350000822,191989001169,191353000827,191353000828,191614000966,191614000967,190654000245,190858000469,190858001881,190627000216,191366001962,191366001963,191366002065,193129001819,190000601231,191563000930,190858000470,190651000223,191470000887,190948000608,191545002018,191470000889,190486000145,190897000516,190654000247,190831000184,193048001970,191401000839,191401000840,190897000541,191470000890,193093001188,191416000843,191416000844,191416000845,190651000224,190654000248,190822000422,190948000609,191878001103,193075001771,190897000543,193048001723,192311002164,192211001319,191470000891,191545000653,191884001114,190675000279,190897000544,192166001293,190897000545,191431002038,190897000546,191434000856,191434000857,191434000429,191437000859,191437000860,192640001513,191488001050,191488000912,191458000866,191722001003,193093001793,191464000872,191464000875,191653001101,192400001395,191467000880,191467000877,191467000878,199901901259,191470000892,191473000904,191485000909,191485000910,193129001820,193048001724,191464000874,192640001514,190948000610,192640002080,191488000911,190858000472,191872001089,190858000473,190897000547,190654000213,192211001320,190579000186,191470001034,190579000187,191518000913,191518000914,191878001104,192013001187,190897000548,190858000474,190771000378,192247000116,191521000076,191521000918,191521000919,192868001655,191533000923,191533000924,191533002051,191878001105,190873000500,190654000250,192094001253,190948000613,192334001378,192691001579,190654000251,191854001066,191545000926,191545000927,193093000168,192640001515,191914001130,192868001656,190354000054,191041000663,190327000021,190654000252,191563000932,191563000933,191566000938,191566000939,190483000139,190858002009,190897000556,191575000940,193048001727,191575000941,192637001495,191470000893,193048001728,191653000987,191584000948,191584000949,190002200956,191611000963,191611000964,191611000965,192658001542,190675000280,192124001273,193090001782,191632000974,191632000975,191632002019,191041000665,193111001815,191642000977,191642000978,191642000979,191545000532,191644000981,191653000988,191653000984,192640001934,191872001404,191662000991,191662000992,190822000424,191668000997,191668000996,191323000798,192640002165,191134000695,191428000852,190858000476,190327000018,190675000281,190708000323,190513000161,190651000226,191185000736,190948000614,191470000894,191989001170,192640001517,192691001580,192247001348,192184001301,193048001729,190897000550,191878002115,193024001702,191722001525,191722001004,191725001008,191725001009,191725001981,192163000706,191248001010,190717000888,191746001013,191746001014,191755001018,191755001019,191470000895,192640001518,190822000425,190462000127,193048001165,191782001023,191782001025,191782002106,190897000552,193048001731,190336000033,191788001026,191803001964,191803001031,191803001994,190771000382,190897000554,190858000477,190654000253,192013001189,192247001508,191818001039,191818001040,191818001041,193072001042,191488001049,191833001052,191833001053,193051001503,191848001057,191848001059,191851001062,191851001063,191854000725,191854001067,191863001072,191863001127,191863001073,193054001745,191869001075,191869002098,191470000896,190486000149,191344000812,190948000615,191872001091,191875001096,191875001097,193168000611,191878001107,193087001778,192211002034,190897000557,191812001484,190897002108,190897000559,190858000479,192013001190,190654000254,191893001117,191893001118,190354000056,191896001121,191896001122,191896001123,190897000560,190897000561,191812001038,191812001036,191812001068,191914001131,191914001132,191893001119,191920002162,191920001563,191013000647,191944001145,191944001146,191944001147,190897002166,192682001570,191884001112,191884000708,190897000563,190858000480,190654002045,199901702063,191959001149,191959001150,191959001151,191965001153,191965002000,191971001156,191971001157,191974001158,191974001160,191977001161,190897000583,190897000565,191980001163,191980001164,191986001166,191986001167,191989001172,191989001173,192004001883,192004001178,193195001863,192013001192,192010001180,192010001181,192013001193,190675000283,192556001459,192019001196,192019001197,192019001360,192094001254,190486000150,192025001202,192025002072,191041000666,192628001051,192034001205,192034001206,192034001922,190912001208,192046001210,192058001218,192058001217,192058000713,192058000712,192061001226,191824001230,191152000703,191344002138,190654000255,191311000786,191311000788,191311000170,192640001521,190759002103,190345000785,190345000043,190651000227,191710001001,191710001947,191710001000,191710000337,191470001392,190690000816,190000601232,190858001977,190897000566,192640001522,190579000190,190575000176,190575000177,190575001620,192083001887,192085001246,192085001245,192640001287,190000601233,192091001923,192091001248,192091002095,192091001249,190852002099,192094001255,192094001256,191347000817,192100001260,192100001258,192106001261,192106001262,192082001242,192082001243,190369000148,192109001265,191269000768,192112001888,192112001889,192112001267,193087001353,192109001266,191584002132,190369000380,190369000074,191470000897,190354001906,192121001270,192121001271,192124001274,192124001275,190483001277,192532001446,191722001006,192083001885,192160001285,190897000567,191722000810,192160001283,192163001288,192163001289,192166001295,192166001294,190002102004,190002102002,190002102003,192172001296,192172001297,192868001657,191884000710,193048001734,190651000228,190897000568,192181001298,192181001299,192184001302,192184001303,192187001094,192187001309,192187001310,192187002087,192211001322,192124001276,190513000163,190002501612,190002500606,190002501334,190002501335,190897000569,190375001336,192163001290,190369000073,192238001338,192238001339,190486000146,199901702060,199901702061,190651000229,192244001343,192244001345,192244000523,192247001350,192247001351,191134000698,191470000898,193135001346,190897000570,191533002057,192253000051,192253001355,192253001356,193093000238,190897000571,191182001979,192211001323,190654000256,191575000942,191575000943,191473000908,190894000831,190897000572,192311001364,192311001361,192311001365,193063001760,192316001367,192316001369,192316001403,192319001372,192319001373,192319000377,190654000257,192322001375,193048001546,199901702062,190786002113,190786000389,190786000104,191533002016,190786000387,190786000388,190786002110,190786000761,190369002139,190002801381,190002801382,190786000391,193051000931,190948001456,192376001384,192379001386,192379001387,192976001694,192400000527,192400001397,192400001398,191266000764,192412001405,192412001407,192412001995,192415001409,192415001410,191185000737,191020000652,191034000657,191034000658,190897000728,191473000905,192311001366,190002700260,190002700249,190002700279,191182000730,192640001526,191401000842,190999000636,190807000401,191470000899,191473000907,192466001414,192466001415,192496001431,191872001093,192487001422,192487001423,192487001424,192868001658,191107002104,190822000431,190717000332,192640001527,191878001109,191470000900,190897000574,190654000258,190798000397,192496001430,190897000580,190822000433,192682001571,192976001695,192976000520,192976001697,192976001698,192505001966,192505001967,191013000648,190948000617,191989001175,190897002093,192532001447,190897000537,190002400098,190002400961,192472002153,192472001417,192538001450,192538002121,192541001452,192541001451,190393000412,192556001458,192559000726,192559001891,192559001461,192559001460,192562001464,192562001465,191965001155,192598001474,192598001475,193054001746,192931001476,192607001478,192607001482,192607001483,193051002130,190001501486,190001501487,190001501485,192625001488,192625001489,192628001494,192628001491,192628002084,192637001496,192637001497,190002301541,190002301896,190002300835,190897000576,192658001543,192658000707,190690000300,192664001547,192664001549,191431001390,190002600618,190002601341,192667001551,192667001552,190852002029,191347000819,192673001463,192673001556,192673001557,190897001472,192679001562,192679001565,192679001564,190651000230,190369000077,193054001747,191470000901,192682001572,192682001573,192685001574,192685001576,192685001575,199901902076,199901902075,192691001582,192691001583,192700001584,192700001585,192700001905,192682002134,192706001586,192706001587,192520001441,192520001442,192739000847,192520001440,192724001588,192724001589,192727001591,192727001592,192727001593,191869001077,193024001703,193093001796,192739002107,192739001601,192739001600,190897000577,192748001603,190357000064,192750001605,190897000578,190858000482,191545000749,191197000742,192760001610,192640001530,190579000194,193063001763,192928001675,190948000619,191437000861,190654000261,190654000262,190369000078,190306001383,190486000147,192061002123,190654000263,190822000435,190948000612,192931001550,191545001412,192787001621,192787001622,192787000290,191668000994,192790001624,192796001626,192796001627,192799001630,192799001632,192799000309,192802001636,192802001634,192802001635,192805001637,192805001638,191533002017,190654000264,192811001639,192811001640,192817001641,192817001642,192820001644,192823001646,192823001647,192823001892,190002200957,190002202013,192856002105,192856001650,192640002089,192868001659,192868001660,190378000084,192868002069,192871002058,192871001664,193093001797,193093000483,191989001177,190705000317,192898001667,192898001670,190654000266,190483001988,192901001671,192901001672,192910001673,192910001674,191869001078,192928001676,192931001681,192931001680,190654000731,192094001257,192949001683,192949001684,190858000484,190858000485,192082001244,193093000393,192964001688,190822000438,192964001689,193051000958,192964002023,190897001143,192973001691,192973001927,192973001692,192976001700,191134000701,190858000486,190708000324,190393000094,192640001531,192004001179,192013001194,190717000333,193024001704,192400001399,193024001705,190771000383,191914001133,190339000037,193051001742,193051001743,193051001744,193051002116,190339000038,193054002163,193054001749,193056001755,193056001754,191470000304,193063001764,193063001765,192868001413,190897000584,191914001134,191563000937,192592002101,193072001770,193072001044,193075001774,193075001773,193078001775,193078001776,193078001777,190339000040,193054001751,193087001779,192750001607,192750000664,193090001786,193090001787,191584002114,190420000108,191095000678,191458000869,191269000770,192592001467,192592001419,192592001468,190543000171,190543000172,190543000928,193096000331,193096001801,193048001738,190858000487,192640001533,193099002109,193099001805,193099001804,193102001806,193102001807,193102001808,193108001811,193108001812,193108001813,192640001534,192013001195,190357000062,193111001817,193111000738,191470000902,190873000502,193129001821,193129001822,190000601234,193135001832,193093001798,191722000368,193093002055,190378000085,190369002026,193147001835,193147001837,193162001841,193162001842,190771000384,191464000876,192640001535,191470000436,191464002100,192211001327,191722001007,190897000585,190858000488,193168001844,193168001845,192682002068,192211001328,190858000489,190654001490,190654000267,193180001849,193180001850,190897000587,193183001851,193183001852,192163001292,193186001085,193186001856,193186000369,193186001857,193186001858,191989001015,193189001859,190858000490,193192001861,193192001862,193195001865,193195001864,191872001095,190897002140,192061002119,190822000440,192532001448,193201002079,193201001867,193201000434,193201001868,193201001866,190897000589,190654000268]
#ids = [190363002136, 190408000101,190408000102,191467000467,190354000049]
for id in ids
	nces_id = id.to_s()
	
	uri = URI('http://nces.ed.gov/ccd/schoolsearch/school_detail.asp?')
	params = {:Search => 1, :State => 19, :SpecificSchlTypes => "all", :IncGrade => -1, :LoGrade => -1, :HiGrade => -1, :SchoolPageNum => 1, :ID => nces_id}
	uri.query=URI.encode_www_form(params)

	response = Net::HTTP::get_response(uri)

	relev_html = response.body

	ind_charter = response.body.index("Charter")
	if ind_charter == nil
		next
	end
	charter = response.body[ind_charter+30, 2]
	if charter.eql?("Ye")
		charter_code = 1
	else
		charter_code = 0
	end

	def parse_line(body, category, prec_text, foll_text)
		strt_ind = body.index(category)
		if strt_ind == nil
			return "N/A"
		end
		ind = body[strt_ind, body.length()-strt_ind].index(prec_text)+strt_ind+prec_text.length()
		len = body[ind, body.length()-ind].index(foll_text)
		return body[ind, len]
	end	


	#parse county
	county = parse_line(response.body, '<font size="2">County:', '<font size="3">', "</font>")


	#parse total number of students
	total_students = parse_line(response.body, "Total Students:", '<font size="3">', "</font>")
	
	#parse FTE Teachers
	fte = parse_line(response.body, "Classroom Teachers (FTE):", '<font size="3">', "</font>")

	#parse student/teacher ratio
	st_rat = parse_line(response.body, "Student/Teacher Ratio:", '<font size="3">', "</font>")
	
	#parse locale
	locale = parse_line(response.body, "Locale:", '</strong>', "</font>")
	
	#parse Title I
	title= parse_line(response.body, "Title I School:", "&nbsp;", "<br />")
	
	
	def parse_table(not_null, prec_text, foll_text, keys, table)
		keyvals = Hash.new
		i = 0
		while table.index(not_null)!=nil
			num_ind = table.index(prec_text)+prec_text.length()
			num_leng = table[num_ind, table.length()-num_ind].index(foll_text)
			num = table[num_ind, num_leng]
			table = table[num_ind+num_leng, table.length()-num_ind-num_leng]
			keyvals[keys[i]]= num
			i += 1
		end
		return keyvals
	end


	#parse enrollment per grade
	enroll_ind = response.body.index("Enrollment by Grade:")
	if enroll_ind != nil
		enroll_grades_strt = response.body[enroll_ind, response.body.length()-enroll_ind].index('size="2"')+enroll_ind
		enroll_grades_length = response.body[enroll_grades_strt, response.body.length()-enroll_grades_strt].index("</tr>")
		enroll_grades = response.body[enroll_grades_strt, enroll_grades_length]
		prelim_grades = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14]
		grade_hash = parse_table("#23619E","color='#FFFFFF' size='2'>", "</font>", prelim_grades, enroll_grades)
		ct = grade_hash.count
		grades = Array.new
		grade_hash.each {|key, value| grades << value}
	
		enroll_counts_strt = response.body[enroll_ind, response.body.length()-enroll_ind].index("Students") + enroll_ind
		enroll_counts_length = response.body[enroll_counts_strt, response.body.length()-enroll_counts_strt].index("</tr>")
		enroll_counts = response.body[enroll_counts_strt, enroll_counts_length]
		enroll_tbl = parse_table("#FFDE9F", "font size='2'>", "</font>", grades, enroll_counts)
	end


	#parse enrollment by race
	race_eth = response.body.index("Enrollment by Race/Ethnicity:")
	if race_eth!=nil
		students_ind = response.body[race_eth, response.body.length()-race_eth].index("Students")+race_eth
		students_tbl = response.body[students_ind, response.body.length()-students_ind]
		ethnicities = ["American Indian/Alaskan", "Asian/Pacific Islander", "Black", "Hispanic", "White", "Two or More Races"]
		eth_enr = parse_table('<td bgcolor="#B8EEA8"', '<font size="2">', "</font>", ethnicities, students_tbl)
	end

	#parse enrollment by gender
	gender_strt = response.body.index("Enrollment by Gender")
	students_strt = response.body[gender_strt, response.body.length()-gender_strt].index("Students")+gender_strt
	gender_tbl = response.body[students_strt, response.body.length()-students_strt]
	genders = ["Male", "Female"]
	gender_enr = parse_table('<td bgcolor="#F5F196"', '<font size="2">', "</font>", genders, gender_tbl)
	


	free_lunch = parse_line(response.body, "Free lunch eligible:", "</font>", "</td>")
	red_lunch = parse_line(response.body, "Reduced-price lunch eligible:", "</font>", "</td>")

	print nces_id.to_s() + ", "
	print total_students.sub(",", "") + ", "
	print fte + ", "
	print st_rat + ", "
	print charter_code.to_s() + ", "
	print title + ", "
	print county + ", "
	print locale + ", "
	print free_lunch +", "
	print red_lunch + ", "
	print gender_enr["Male"].sub(",", "") + ", "
	print gender_enr["Female"].sub(",", "") + ", "
	eth_enr.each {|key, value| print value.sub(",", "") + ", "}
	
	grades = ["PK", "KG", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"]
	for g in grades
		if enroll_tbl.has_key?(g)
			print enroll_tbl[g].sub(",", "")+", "
		else
			print "0, "
		end
	end
	puts
end