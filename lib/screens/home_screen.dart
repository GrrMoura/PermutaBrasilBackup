// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:permutabrasil/models/contato_model.dart';
import 'package:permutabrasil/models/foto_model.dart';
import 'package:permutabrasil/models/propaganda_model.dart';
import 'package:permutabrasil/provider/providers.dart';
import 'package:permutabrasil/screens/widgets/confirmar_debito.dart';
import 'package:permutabrasil/screens/widgets/loading_default.dart';
import 'package:permutabrasil/services/dispositivo_service.dart';
import 'package:permutabrasil/utils/app_colors.dart';
import 'package:permutabrasil/utils/app_snack_bar.dart';
import 'package:permutabrasil/utils/erro_handler.dart';
import 'package:permutabrasil/viewModel/match_view_model.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    getMatches();
  }

  Future<void> getMatches() async {
    final matches = ref.read(matchesProvider);
    final ultimaRequisicao =
        ref.read(matchesProvider.notifier).ultimaRequisicao;

    final now = DateTime.now();

    if (matches.isNotEmpty &&
        ultimaRequisicao != null &&
        now.difference(ultimaRequisicao).inMinutes < 10) {
      setState(() {
        isOcupado = false;
      });
      return;
    }
    if (!await DispositivoService.verificarConexaoComFeedback(context)) {
      return;
    }

    try {
      await ref.read(matchesProvider.notifier).carregarMatches();
      setState(() {
        isOcupado = false;
      });
    } catch (erro) {
      setState(() {
        isOcupado = false;
      });
      if (erro is Response) {
        ErroHandler.tratarErro(context, erro);
      } else {
        Generic.snackBar(
            context: context, mensagem: "Erro inesperado", duracao: 3);
      }
    }
  }

  bool isOcupado = true;
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
    final matches = ref.watch(matchesProvider);
    final nome = ref.watch(nomeProvider);
    final creditos = ref.watch(creditoProvider);
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: _buildAppBar(nome ?? ""),
      body: isOcupado
          ? const LoadingDualRing()
          : Column(
              children: [
                matches.isNotEmpty
                    ? _buildHeader(matches.length)
                    : _buildNoResults(matches.length),
                if (matches.isNotEmpty) _buildCreditosCard(creditos),
                Expanded(child: _buildMatchList(matches)),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  child: _buildPropagandas(),
                )
              ],
            ),
    );
  }

  Widget _buildCreditosCard(int creditos) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 8.0.h),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.teal[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.teal, width: 1),
        ),
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ignore: prefer_const_constructors
            Icon(Icons.monetization_on_outlined, color: Colors.teal),
            SizedBox(width: 8.w),
            Text(
              'Créditos disponíveis: $creditos',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.teal[800],
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(String nome) {
    return AppBar(
      title: Text(
        isOcupado ? "Bem-vindo" : "Bem-vindo, ${formatarNome(nome)}",
        style: const TextStyle(color: Colors.white),
      ),
      centerTitle: true,
      backgroundColor: AppColors.cAccentColor,
      automaticallyImplyLeading: false,
    );
  }

  Padding _buildHeader(int matchLength) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 12.0.h),
      child: Text(
        textoPermutas(matchLength),
        style: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
          color: Colors.teal[700],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildNoResults(int matchLength) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.0.w, vertical: 32.0.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 72.sp, color: Colors.grey[500]),
          SizedBox(height: 20.h),
          Text(
            "Nenhuma permuta compatível encontrada",
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.teal[700],
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12.h),
          Text(
            "Ainda não há usuários do estado desejado com interesse em vir para o seu.",
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey[700],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  String textoPermutas(int matchLength) {
    if (matchLength == 1) {
      return "$matchLength oportunidade de permuta";
    } else {
      return "$matchLength oportunidades de permuta";
    }
  }

  SizedBox _buildPropagandas() {
    return SizedBox(
      height: 130.h,
      child: PropagandaCarousel(
        propagandas: propagandasBanco,
      ),
    );
  }

  ListView _buildMatchList(List<MatchViewModel> matches) {
    return ListView.builder(
      itemCount: matches.length,
      itemBuilder: (context, index) {
        final match = matches[index];
        return _buildMatchCard(match);
      },
    );
  }

  Widget _buildMatchCard(MatchViewModel? match) {
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
            _buildStateImage(match?.estado.foto ?? ""),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildMatchName(match?.usuario.nome ?? ''),
                  SizedBox(height: 6.h),
                  _buildMatchInfoRow(Icons.map, "Estado", match?.estado.sigla),
                  _buildMatchInfoRow(Icons.military_tech, "Graduação", "Cabo"),
                  _buildMatchInfoRow(Icons.access_time, "Tempo de serviço",
                      _calcularTempoServico(match?.dataInclusao)),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () async {
                    bool? confirmar =
                        await ConfirmarDebitoDialog.mostrar(context);
                    if (confirmar == true) {
                      _realizarDebito();
                    }
                  },
                  icon: Icon(
                    FontAwesomeIcons.whatsapp,
                    size: 22.sp,
                    color: Colors.green,
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    bool? confirmar =
                        await ConfirmarDebitoDialog.mostrar(context);
                    if (confirmar == true) {
                      _realizarDebito();
                    }
                  },
                  icon: Icon(
                    FontAwesomeIcons.phone,
                    size: 18.sp,
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
    if (imagePath.isEmpty) {
      return const SizedBox(
        height: 65,
        width: 65,
      );
    }
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

  String _calcularTempoServico(String? dataInclusaoStr) {
    if (dataInclusaoStr == null || dataInclusaoStr.isEmpty) {
      return "Data de inclusão inválida";
    }

    DateTime? dataInicio;
    try {
      dataInicio = DateTime.parse(dataInclusaoStr);
    } catch (e) {
      return "Data de inclusão inválida";
    }

    DateTime dataAtual = DateTime.now();
    int anos = dataAtual.year - dataInicio.year;

    if (dataAtual.month < dataInicio.month ||
        (dataAtual.month == dataInicio.month &&
            dataAtual.day < dataInicio.day)) {
      anos--;
    }

    if (anos == 0) {
      return "Menos de 1 ano";
    } else if (anos == 1) {
      return "1 ano";
    } else {
      return "$anos anos";
    }
  }

  String formatarNome(String? nomeCompleto) {
    if (nomeCompleto == null || nomeCompleto.trim().isEmpty) {
      return '';
    }
    List<String> partes = nomeCompleto.trim().split(' ');
    if (partes.length == 1) {
      return partes[0].toUpperCase();
    }
    return "${partes.first.toUpperCase()} ${partes.last.toUpperCase()}";
  }

  void _realizarDebito() {}

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

class PropagandaCarousel extends StatefulWidget {
  final List<PropagandaViewModel> propagandas;

  const PropagandaCarousel({super.key, required this.propagandas});

  @override
  State<PropagandaCarousel> createState() => _PropagandaCarouselState();
}

class _PropagandaCarouselState extends State<PropagandaCarousel> {
  final BannerAd bannerAd = BannerAd(
    adUnitId: 'ca-app-pub-3940256099942544/6300978111',
    size: AdSize.banner,
    request: const AdRequest(),
    listener: const BannerAdListener(),
  )..load();

  @override
  Widget build(BuildContext context) {
    final items = [
      ...widget.propagandas
          .map((propaganda) => _buildPropagandaItem(propaganda)),
      _buildAdMobItem(), // insere banner AdMob como um item do carrossel
    ];

    return CarouselSlider(
      options: CarouselOptions(
        height: 130,
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 0.8,
        enableInfiniteScroll: true,
        autoPlayInterval: const Duration(seconds: 4),
        autoPlayAnimationDuration: const Duration(milliseconds: 1500),
      ),
      items: items,
    );
  }

  Widget _buildPropagandaItem(PropagandaViewModel propaganda) {
    return GestureDetector(
      onTap: () {},
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CachedNetworkImage(
          imageUrl: propaganda.fotoModel!.first.url!,
          fit: BoxFit.cover,
          width: double.infinity,
          placeholder: (context, url) => const Center(
            child: LoadingDualRing(tamanho: 20),
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
  }

  Widget _buildAdMobItem() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        color: Colors.white,
        alignment: Alignment.center,
        child: AdWidget(ad: bannerAd),
      ),
    );
  }
}
