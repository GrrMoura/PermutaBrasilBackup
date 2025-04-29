// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permuta_brasil/controller/pagamento_controller.dart';
import 'package:permuta_brasil/models/pagamento_model.dart';
import 'package:permuta_brasil/models/plano_model.dart';
import 'package:permuta_brasil/screens/widgets/app_bar.dart';
import 'package:permuta_brasil/screens/widgets/loading_default.dart';
import 'package:permuta_brasil/utils/app_colors.dart';
import 'package:permuta_brasil/utils/app_constantes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class PagamentoPix extends StatefulWidget {
  final PlanoModel planoModel;

  const PagamentoPix({required this.planoModel, super.key});

  @override
  State<PagamentoPix> createState() => _PagamentoPixState();
}

class _PagamentoPixState extends State<PagamentoPix> {
  bool pixGerado = false;
  bool carregandoPix = false;
  DateTime? expiracaoPix;
  int? usuarioId;
  String pixCode = "Clique no botão para gerar o PIX";
  @override
  void initState() {
    super.initState();
    _carregarPayload();
  }

  Future<void> _carregarPayload() async {
    final prefs = await SharedPreferences.getInstance();
    final payloadSalvo = prefs.getString("pix_payload");
    final timestamp = prefs.getInt("pix_timestamp");
    final planoIdSalvo = prefs.getInt("pix_plano_id");
    final valorSalvo = prefs.getDouble("pix_valor");
    usuarioId = prefs.getInt(PrefsKey.userId) ?? 0;

    final planoIdAtual = widget.planoModel.id;
    final valorAtual = widget.planoModel.valor;

    // Verifica se dados são válidos e ainda correspondem ao plano atual
    if (payloadSalvo != null &&
        payloadSalvo.isNotEmpty &&
        timestamp != null &&
        planoIdSalvo == planoIdAtual &&
        valorSalvo == valorAtual) {
      final dataCriacao = DateTime.fromMillisecondsSinceEpoch(timestamp);
      final dataExpiracao = dataCriacao.add(const Duration(minutes: 60));
      final agora = DateTime.now();

      if (agora.isBefore(dataExpiracao)) {
        setState(() {
          expiracaoPix = dataExpiracao;
          pixCode = payloadSalvo;
          pixGerado = true;
        });
      } else {
        await _limparPixSalvo(prefs);
      }
    } else {
      // Se plano diferente ou valor diferente, apaga dados salvos
      await _limparPixSalvo(prefs);
    }
  }

  Future<void> _limparPixSalvo(SharedPreferences prefs) async {
    await prefs.remove("pix_payload");
    await prefs.remove("pix_timestamp");
    await prefs.remove("pix_plano_id");
    await prefs.remove("pix_valor");

    setState(() {
      pixCode = "Clique no botão para gerar o PIX";
      pixGerado = false;
      expiracaoPix = null;
    });
  }

  Future<void> gerarPagamento() async {
    setState(() {
      carregandoPix = true;
    });

    PagamentoModel? pagamento = await PagamentoController.buyCredit(
        context: context,
        idPlano: widget.planoModel.id ?? 0,
        idUsuario: usuarioId ?? 0);

    final payload = pagamento?.qrcodeTexto ?? "";

    if (payload.isNotEmpty) {
      final prefs = await SharedPreferences.getInstance();
      final dataCriacao = DateTime.now();
      final dataExpiracao = dataCriacao.add(const Duration(minutes: 60));

      await prefs.setInt("pix_plano_id", widget.planoModel.id ?? 0);
      await prefs.setDouble("pix_valor", widget.planoModel.valor ?? 0.0);
      await prefs.setString("pix_payload", payload);
      await prefs.setInt("pix_timestamp", dataCriacao.millisecondsSinceEpoch);

      setState(() {
        pixCode = payload;
        pixGerado = true;
        expiracaoPix = dataExpiracao;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Erro ao gerar o código PIX.")),
      );
    }

    setState(() {
      carregandoPix = false;
    });
  }

  void copiarPix() {
    Clipboard.setData(ClipboardData(text: pixCode));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Código PIX copiado!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    final formatador =
        NumberFormat.currency(locale: 'pt_BR', symbol: '', decimalDigits: 2);
    String valorFormatado = formatador.format(widget.planoModel.valor ?? 0);
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: const CustomAppBar(titulo: "Pagamento via Pix"),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo PIX
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Image.asset(
                  'assets/images/logopix.png',
                  height: 40.h,
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 28),

              // Cabeçalho com título e informações do plano
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Pagamento via PIX',
                    style: GoogleFonts.poppins(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Plano: ${widget.planoModel.nome}',
                    style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Valor: R\$$valorFormatado',
                    style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  if (expiracaoPix != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Text(
                        'Este PIX expira às ${DateFormat.Hm().format(expiracaoPix!)}',
                        style: GoogleFonts.poppins(
                          fontSize: 13.sp,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 24),

              // Código PIX
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: carregandoPix
                    ? LoadingDualRing(tamanho: 40.sp)
                    : SelectableText(
                        pixCode,
                        style: GoogleFonts.robotoMono(
                          fontSize: 13.sp,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
              ),
              const SizedBox(height: 24),

              // Botão copiar
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: carregandoPix
                      ? null
                      : () async {
                          if (!pixGerado) {
                            await gerarPagamento();
                          } else {
                            copiarPix();
                          }
                        },
                  icon: Icon(
                    pixGerado ? Icons.copy : Icons.qr_code,
                    color: Colors.white,
                  ),
                  label: Text(
                    carregandoPix
                        ? "Gerando PIX"
                        : pixGerado
                            ? "Copiar Código PIX"
                            : "Gerar PIX",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.cAccentColor,
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
