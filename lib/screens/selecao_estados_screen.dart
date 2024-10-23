import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permuta_brasil/utils/app_colors.dart';

class SelecaoEstadosScreen extends StatefulWidget {
  const SelecaoEstadosScreen({super.key});

  @override
  State<SelecaoEstadosScreen> createState() => _SelecaoEstadosScreenState();
}

class _SelecaoEstadosScreenState extends State<SelecaoEstadosScreen> {
  final List<Map<String, String>> estados = [
    {"nome": "Acre", "imagem": "assets/images/acre.png", "sigla": "AC"},
    {"nome": "Alagoas", "imagem": "assets/images/alagoas.png", "sigla": "AL"},
    {"nome": "Amapá", "imagem": "assets/images/amapa.png", "sigla": "AP"},
    {"nome": "Amazonas", "imagem": "assets/images/amazonas.png", "sigla": "AM"},
    {"nome": "Bahia", "imagem": "assets/images/bahia.png", "sigla": "BA"},
    {"nome": "Ceará", "imagem": "assets/images/ceara.png", "sigla": "CE"},
    {
      "nome": "Distrito Federal",
      "imagem": "assets/images/df.png",
      "sigla": "DF"
    },
    {
      "nome": "Espírito Santo",
      "imagem": "assets/images/espiritosanto.png",
      "sigla": "ES"
    },
    {"nome": "Goiás", "imagem": "assets/images/goias.png", "sigla": "GO"},
    {"nome": "Maranhão", "imagem": "assets/images/maranhao.png", "sigla": "MA"},
    {
      "nome": "Mato Grosso",
      "imagem": "assets/images/matogrosso.png",
      "sigla": "MT"
    },
    {
      "nome": "Mato Grosso do Sul",
      "imagem": "assets/images/matosul.png",
      "sigla": "MS"
    },
    {
      "nome": "Minas Gerais",
      "imagem": "assets/images/minasgerais.png",
      "sigla": "MG"
    },
    {"nome": "Pará", "imagem": "assets/images/para.png", "sigla": "PA"},
    {"nome": "Paraíba", "imagem": "assets/images/paraiba.png", "sigla": "PB"},
    {"nome": "Paraná", "imagem": "assets/images/parana.png", "sigla": "PR"},
    {
      "nome": "Pernambuco",
      "imagem": "assets/images/pernambuco.png",
      "sigla": "PE"
    },
    {"nome": "Piauí", "imagem": "assets/images/piaui.png", "sigla": "PI"},
    {
      "nome": "Rio de Janeiro",
      "imagem": "assets/images/riodejaneiro.png",
      "sigla": "RJ"
    },
    {
      "nome": "Rio Grande do Norte",
      "imagem": "assets/images/rn.png",
      "sigla": "RN"
    },
    {
      "nome": "Rio Grande do Sul",
      "imagem": "assets/images/riograndedosul.png",
      "sigla": "RS"
    },
    {"nome": "Rondônia", "imagem": "assets/images/rondonia.png", "sigla": "RO"},
    {"nome": "Roraima", "imagem": "assets/images/roraima.png", "sigla": "RR"},
    {
      "nome": "Santa Catarina",
      "imagem": "assets/images/santacatarina.png",
      "sigla": "SC"
    },
    {
      "nome": "São Paulo",
      "imagem": "assets/images/saopaulo.png",
      "sigla": "SP"
    },
    {"nome": "Sergipe", "imagem": "assets/images/sergipe.png", "sigla": "SE"},
    {
      "nome": "Tocantins",
      "imagem": "assets/images/tocantins.png",
      "sigla": "TO"
    },
  ];

  List<String> estadosSelecionados = [];

  void _navegarParaProximaTela() {
    if (estadosSelecionados.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ProximaTela(estadosSelecionados: estadosSelecionados),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selecione ao menos um estado!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: AppBar(
        title: const Text(
          "Selecione os Estados de interesse",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: AppColors.cAccentColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20.0,
                  mainAxisSpacing: 20.0,
                  childAspectRatio: 1,
                ),
                itemCount: estados.length,
                itemBuilder: (context, index) {
                  final estado = estados[index];
                  final bool isSelected =
                      estadosSelecionados.contains(estado["sigla"]);

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          estadosSelecionados.remove(estado["sigla"]);
                        } else {
                          estadosSelecionados.add(estado["sigla"]!);
                        }
                      });
                    },
                    child: Card(
                      elevation: 5,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(
                          color: isSelected ? Colors.red : Colors.transparent,
                          width: 3,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              estado["imagem"]!,
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            estado["nome"]!,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          if (estadosSelecionados.isEmpty)
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Selecione pelo menos 1 estado.",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          else
            Column(
              children: [
                const Text(
                  "Selecionados",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Wrap(
                    spacing: 8.0,
                    runSpacing: 4.0,
                    children: estadosSelecionados
                        .map((estado) => Chip(
                              label: Text(
                                estado,
                                style: const TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.teal,
                            ))
                        .toList(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: 5.h, bottom: 10.h, left: 10.w, right: 10.w),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _navegarParaProximaTela,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.cAccentColor,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 6,
                        shadowColor: Colors.black.withOpacity(0.3),
                      ),
                      label: const Text(
                        "Continuar",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class ProximaTela extends StatelessWidget {
  final List<String> estadosSelecionados;

  const ProximaTela({super.key, required this.estadosSelecionados});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Estados Selecionados'),
      ),
      body: ListView.builder(
        itemCount: estadosSelecionados.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(estadosSelecionados[index]),
          );
        },
      ),
    );
  }
}
