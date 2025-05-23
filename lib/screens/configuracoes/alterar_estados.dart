import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permutabrasil/controller/estado_controller.dart';
import 'package:permutabrasil/controller/user_controller.dart';
import 'package:permutabrasil/models/estado_instituicoes_model.dart';
import 'package:permutabrasil/models/estado_model.dart';
import 'package:permutabrasil/models/usuario_model.dart';
import 'package:permutabrasil/provider/providers.dart';
import 'package:permutabrasil/screens/widgets/loading_default.dart';
import 'package:permutabrasil/utils/app_colors.dart';
import 'package:permutabrasil/utils/styles.dart';

class SelecaoEstadosScreen extends ConsumerStatefulWidget {
  const SelecaoEstadosScreen({super.key});

  @override
  ConsumerState<SelecaoEstadosScreen> createState() =>
      _SelecaoEstadosScreenState();
}

class _SelecaoEstadosScreenState extends ConsumerState<SelecaoEstadosScreen> {
  List<EstadoModel>? estados = [];
  UsuarioModel usuarioModel = UsuarioModel();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = true;

  List<String> estadosSelecionados = [];

  @override
  void initState() {
    super.initState();
    _loadEstados();
  }

  Future<void> _loadEstados() async {
    final profissional = ref.read(profissionalProvider);

    EstadosEInstituicoes resultado = await EstadoController.getEstados(context);

    List<EstadoModel> estadosPegos = resultado.estados;

    setState(() {
      estados = estadosPegos;
      for (var estado in estadosPegos) {
        final jaSelecionado =
            profissional?.destinos.any((e) => e.id == estado.id);

        if (jaSelecionado!) {
          estadosSelecionados.add(estado.sigla);
          usuarioModel.locais ??= [];
          usuarioModel.locais!.add(estado.id);
        }
      }
      _isLoading = false;
    });
  }

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
          "Estados de interesse",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: AppColors.cAccentColor,
      ),
      body: _isLoading
          ? LoadingDualRing()
          : Column(
              children: [
                Expanded(
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GridView.count(
                              crossAxisCount: 2,
                              crossAxisSpacing: 25,
                              mainAxisSpacing: 25,
                              childAspectRatio: 1,
                              shrinkWrap: true,
                              physics:
                                  const NeverScrollableScrollPhysics(), // continua aqui
                              children:
                                  List.generate(estados?.length ?? 0, (index) {
                                final estado = estados?[index];
                                final bool isSelected =
                                    estadosSelecionados.contains(estado?.sigla);

                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      final sigla = estado?.sigla;
                                      final id = estado?.id;

                                      if (sigla == null || id == null) return;

                                      if (estadosSelecionados.contains(sigla)) {
                                        estadosSelecionados.remove(sigla);
                                        usuarioModel.locais?.remove(id);
                                      } else {
                                        estadosSelecionados.add(sigla);
                                        usuarioModel.locais ??= [];
                                        usuarioModel.locais!.add(id);
                                      }
                                    });
                                  },
                                  child: Card(
                                    elevation: 5,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      side: BorderSide(
                                        color: isSelected
                                            ? Colors.red
                                            : Colors.transparent,
                                        width: 3,
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.asset(
                                            estado?.foto ?? "",
                                            height: 60.h,
                                            width: 60.h,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        SizedBox(height: 10.h),
                                        Text(
                                          estado?.nome ?? "",
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.teal,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ],
                        ),
                      )),
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
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Column(
                      children: [
                        _buildSelecionados(),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _submitForm,
                            style: Styles().elevatedButtonStyle(),
                            child: _isLoading
                                ? LoadingDualRing(tamanho: 20.sp)
                                : Text('Salvar Alterações',
                                    style: TextStyle(fontSize: 13.sp)),
                          ),
                        ),
                      ],
                    ),
                  )
              ],
            ),
    );
  }

  void _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState?.save();
    setState(() => _isLoading = true);

    await UserController.alterarDadosPessoais(context, usuarioModel);

    setState(() => _isLoading = false);
  }

  Padding _buildSelecionados() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Selecionados",
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Colors.teal,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: estadosSelecionados
                .map((estado) => Chip(
                      label: Text(
                        estado,
                        style: TextStyle(color: Colors.white, fontSize: 12.sp),
                      ),
                      backgroundColor: Colors.teal,
                    ))
                .toList(),
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
