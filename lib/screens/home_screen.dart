import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permuta_brasil/models/contato_model.dart';
import 'package:permuta_brasil/models/foto_model.dart';
import 'package:permuta_brasil/models/propaganda_model.dart';
import 'package:permuta_brasil/rotas/app_screens_path.dart';
import 'package:permuta_brasil/utils/app_colors.dart';

class HomeScreen extends StatefulWidget {
  final String nomeUsuario;
  final List<Map<String, String>> matchs;

  const HomeScreen({
    super.key,
    required this.nomeUsuario,
    required this.matchs,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PropagandaViewModel> propagandasBanco = [
    PropagandaViewModel(
      propagandaId: 1,
      titulo: "Curso de Tiro Tático",
      resumo: "Curso completo de tiro defensivo com instrutores certificados.",
      instagram: "@tirotaticooficial",
      fotoModel: [
        FotoModel(
          fotoId: 1,
          nome: "Curso de Tiro",
          url:
              "https://www.clube.soarmas.com.br/wp-content/uploads/SOARMAS_Tela-Final-Curso-Pistola-1200x675.png",
          path: "/imagens/curso_tiro.jpg",
        ),
      ],
      contatos: [
        ContatoModel(
          email: "Instrutor Marcos",
          telefone: "11999998888",
        ),
      ],
    ),
    PropagandaViewModel(
      propagandaId: 2,
      titulo: "Venda de Armas e Munições",
      resumo: "Revenda autorizada com entrega rápida e seguro.",
      instagram: "@armaselite",
      fotoModel: [
        FotoModel(
          fotoId: 2,
          nome: "Armas em Destaque",
          url:
              "https://luarmodas.com.br/thumb/fachada.jpg?auto=format&q=70&crop=faces&fit=crop&w=100%25",
          path: "/imagens/armas.jpg",
        ),
      ],
      contatos: [
        ContatoModel(
          email: "Loja Elite",
          telefone: "11988887777",
        ),
      ],
    ),
    PropagandaViewModel(
      propagandaId: 3,
      titulo: "Treinamento em Combate Urbano",
      resumo: "Simulação real de situações de risco para policiais.",
      instagram: "@treinamentocombate",
      fotoModel: [
        FotoModel(
          fotoId: 3,
          nome: "Treinamento Urbano",
          url:
              "https://www.federaisclubedetiro.com.br/wp-content/uploads/Screenshot-2024-07-18-at-08-18-37-Federais-Clube-de-Tiro-@federaisclubedetiro-%E2%80%A2-Fotos-e-videos-do-Instagram.png",
          path: "/imagens/treinamento_urbano.jpg",
        ),
      ],
      contatos: [
        ContatoModel(
          email: "Capitão Souza",
          telefone: "11977776666",
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    bool isFuncionalVerificada = false;
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: _buildAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          Expanded(child: _buildMatchList()),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            child: _buildPropagandas(),
          )
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(
        "Bem-vindo, ${widget.nomeUsuario}",
        style: const TextStyle(color: Colors.white),
      ),
      centerTitle: true,
      backgroundColor: AppColors.cAccentColor,
      iconTheme: const IconThemeData(color: Colors.white),
    );
  }

  Padding _buildHeader() {
    return Padding(
      padding: EdgeInsets.all(10.0.w),
      child: Text(
        "Matchs:",
        style: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
          color: Colors.teal,
        ),
      ),
    );
  }

  SizedBox _buildPropagandas() {
    return SizedBox(
      height: 130.h,
      child: PropagandaCarousel(
        propagandas: propagandasBanco,
      ),
    );
  }

  ListView _buildMatchList() {
    return ListView.builder(
      itemCount: widget.matchs.length,
      itemBuilder: (context, index) {
        final match = widget.matchs[index];
        return _buildMatchCard(match);
      },
    );
  }

  Widget _buildMatchCard(Map<String, String> match) {
    return Card(
      color: Colors.white,
      elevation: 5,
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildStateImage(match['imagem']!),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildMatchName(match['nome'] ?? ''),
                  SizedBox(height: 6.h),
                  _buildMatchInfoRow(Icons.map, "Estado", match['estado']),
                  _buildMatchInfoRow(Icons.military_tech, "Graduação",
                      match['graduacao'] ?? 'Cabo'),
                  _buildMatchInfoRow(Icons.access_time, "Tempo de serviço",
                      match['tempoServico'] ?? "12 anos"),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    // abrir whatsapp
                  },
                  icon: Icon(
                    FontAwesomeIcons.whatsapp,
                    size: 22.sp,
                    color: Colors.green,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // fazer ligação
                  },
                  icon: Icon(
                    FontAwesomeIcons.phone,
                    size: 20.sp,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStateImage(String imagePath) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.asset(
        imagePath,
        height: 65.h,
        width: 65.h,
        fit: BoxFit.cover,
      ),
    );
  }

  Text _buildMatchName(String name) {
    return Text(
      name,
      style: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
        color: Colors.teal[700],
      ),
    );
  }

  Widget _buildMatchInfoRow(IconData icon, String label, String? value) {
    return Padding(
      padding: EdgeInsets.only(top: 4.h),
      child: Row(
        children: [
          SizedBox(width: 6.w),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: TextStyle(fontSize: 13.sp, color: Colors.grey[800]),
                children: [
                  TextSpan(
                    text: "$label: ",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  TextSpan(
                    text: value ?? '-',
                    style: TextStyle(
                        fontWeight: FontWeight.normal, color: Colors.grey[800]),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

//   Widget _buildExtraInfo(Map<String, String> match) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text("Tempo de serviço: ${match['tempoServico']}",
//             style: TextStyle(fontSize: 14.sp)),
//         Text("Graduação: ${match['graduacao']}",
//             style: TextStyle(fontSize: 14.sp)),
//       ],
//     );
//   }
}

class PropagandaCarousel extends StatelessWidget {
  final List<PropagandaViewModel> propagandas;

  const PropagandaCarousel({super.key, required this.propagandas});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 130,
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 0.8,
        enableInfiniteScroll: true,
        autoPlayInterval: const Duration(seconds: 3),
      ),
      items: propagandas.map((propaganda) {
        return GestureDetector(
          onTap: () {},
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: propaganda.fotoModel!.first.url!,
              fit: BoxFit.cover,
              width: double.infinity,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => Container(
                color: Colors.grey[300],
                child: Icon(
                  Icons.image_not_supported,
                  color: Colors.grey[600],
                  size: 50,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
