// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:permuta_brasil/models/termo_model.dart';
import 'package:permuta_brasil/rotas/app_screens_path.dart';
import 'package:permuta_brasil/screens/widgets/loading_default.dart';
import 'package:permuta_brasil/utils/app_colors.dart';
import 'package:permuta_brasil/utils/app_snack_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TermosCadastroPage extends StatefulWidget {
  const TermosCadastroPage({super.key});

  @override
  TermosCadastroPageState createState() => TermosCadastroPageState();
}

class TermosCadastroPageState extends State<TermosCadastroPage> {
  int _paginaAtual = 0;
  bool _aceitouTermo = false;
  final List<TermoModel> _termos = [
    TermoModel(
      titulo: 'Natureza do Serviço',
      texto: '''
O aplicativo Permuta Brasil oferece aos usuários a prestação de serviços de disponibilização de acesso à sua plataforma digital, que funciona como um meio tecnológico de facilitação de conexões entre usuários interessados em permutas de estados.

O serviço contratado limita-se ao acesso às funcionalidades disponibilizadas no ambiente virtual do aplicativo, não se estendendo à garantia de efetivação de permutas, à quantidade ou à qualidade dos perfis cadastrados, nem à verificação da veracidade das informações fornecidas por outros usuários.

O conteúdo da plataforma é dinâmico e depende exclusivamente da adesão voluntária de terceiros, razão pela qual o Permuta Brasil não assegura que, no momento do acesso, haverá usuários cadastrados, perfis compatíveis ou oportunidades de permuta disponíveis.

O usuário declara estar ciente de que a aquisição de créditos e a consequente utilização da plataforma não implicam em entrega de resultado específico, mas tão somente na disponibilização dos meios de busca e interação oferecidos.
''',
    ),
    TermoModel(
      titulo: 'Termo de Responsabilidade',
      texto: '''
O aplicativo Permuta Brasil atua exclusivamente como um meio tecnológico que possibilita a conexão entre usuários interessados em permutas de estados, sendo a efetivação de conexões ou permutas dependente da adesão e participação de terceiros na plataforma, sem qualquer garantia de sucesso.

O usuário reconhece que:

1. O Permuta Brasil não intermedeia, valida, supervisiona, certifica, assegura ou participa, direta ou indiretamente, das negociações entre usuários.

2. Toda responsabilidade pelas tratativas, acordos, combinações, deslocamentos e eventuais consequências decorrentes das permutas é exclusiva dos próprios usuários.

3. O aplicativo não se responsabiliza por informações inverídicas fornecidas por outros usuários, nem por danos ou prejuízos decorrentes de qualquer tipo de negociação ou tentativa de permuta.

4. Embora o envio da identidade funcional seja solicitado durante o cadastro, o aplicativo não realiza verificação técnica, pericial ou confirmação junto a bases oficiais quanto à autenticidade dos documentos recebidos, tampouco assegura que as imagens não tenham sido alteradas ou editadas. Dessa forma, o Permuta Brasil isenta-se de qualquer responsabilidade por documentos fraudulentos ou informações inexatas relacionadas à identidade dos usuários ''',
    ),
    TermoModel(
      titulo: 'Confidencialidade e Proteção de Dados',
      texto: '''
O usuário reconhece e concorda que o aplicativo Permuta Brasil lida com informações pessoais sensíveis, tais como nome, telefone e outros dados fornecidos por usuários para fins de permuta profissional.

O Permuta Brasil adota medidas de segurança para proteger esses dados, em conformidade com a legislação vigente, especialmente a Lei Geral de Proteção de Dados (LGPD).

O usuário compromete-se a:

1. Utilizar as informações pessoais acessadas exclusivamente para fins legítimos relacionados à permuta de estados.

2. Não copiar, armazenar, divulgar, vender, transferir ou utilizar os dados obtidos através do aplicativo para quaisquer outros propósitos não autorizados.

3. Manter o sigilo absoluto sobre todas as informações visualizadas no aplicativo, mesmo após a cessação de seu vínculo com a plataforma.

4. Respeitar integralmente a legislação de proteção de dados, sendo o único responsável por qualquer uso indevido das informações acessadas.

O descumprimento destas obrigações poderá acarretar medidas administrativas, cíveis e criminais cabíveis, conforme previsto na legislação aplicável.

O tratamento de dados realizado pelo Permuta Brasil está detalhado em sua Política de Privacidade, que integra e complementa este Termo de Uso.
''',
    ),
    TermoModel(
      titulo: 'Pagamento para Disponibilização de Perfil',
      texto: '''


Para que seu perfil permaneça visível e disponível para buscas de permutas no aplicativo, é necessário manter saldo suficiente de créditos na conta.

1. Será descontado diariamente 0,50 crédito (zero vírgula cinquenta) do saldo como taxa de disponibilização do perfil.

2. Caso o saldo seja insuficiente no momento da cobrança, o perfil será temporariamente retirado da lista de possíveis permutas até a regularização com a compra de novos créditos.

3. A aquisição de créditos é feita de forma antecipada pelo usuário, sendo responsabilidade do mesmo manter saldo para garantir a visibilidade do perfil.

4. A cobrança da taxa garante apenas o direito de listagem e visibilidade no aplicativo, não assegurando a efetivação de permutas.''',
    ),
    TermoModel(
      titulo: 'Direito de Arrependimento',
      texto: '''
Ao adquirir créditos no aplicativo Permuta Brasil, o usuário reconhece que:

1. A prestação dos serviços ocorrerá imediatamente após a confirmação do pagamento, consistindo exclusivamente no acesso à plataforma e às funcionalidades disponíveis, independentemente da quantidade, qualidade ou adequação dos perfis cadastrados no momento da consulta.

2. O conteúdo da plataforma depende da adesão voluntária de terceiros, não havendo qualquer garantia quanto à existência, número ou compatibilidade dos perfis de permuta disponíveis.

3. Em conformidade com o artigo 49 do Código de Defesa do Consumidor, considerando que o serviço é prestado de forma imediata e integral, não será possível exercer o direito de arrependimento após a confirmação do pagamento, tampouco solicitar cancelamento ou reembolso dos valores pagos.
''',
    ),
    TermoModel(
      titulo: 'Disposições Gerais',
      texto: '''
1. Atualizações dos Termos
O Permuta Brasil poderá alterar estes Termos de Uso a qualquer momento, visando seu aprimoramento ou adequação a mudanças legislativas ou operacionais. Quaisquer alterações relevantes serão comunicadas aos usuários, que deverão aceitar as novas condições para continuar utilizando a plataforma.

2. Vigência
Estes termos entram em vigor a partir do aceite do usuário e permanecem válidos enquanto houver utilização dos serviços da plataforma.

3. Foro de Eleição
Fica eleito o foro da Comarca de Aracaju, Estado de Sergipe, como competente para dirimir quaisquer dúvidas, questões ou litígios oriundos da utilização do aplicativo Permuta Brasil, com renúncia expressa de qualquer outro, por mais privilegiado que seja.

4. Independência das Cláusulas
Caso qualquer cláusula destes Termos seja considerada inválida ou inexequível, as demais disposições permanecerão em pleno vigor e efeito.

5. Aceitação Integral
O uso do aplicativo implica na aceitação plena e incondicional de todos os termos e condições aqui estabelecidos.
''',
    ),
  ];

  void _proximoTermo() async {
    if (_aceitouTermo) {
      if (_paginaAtual < _termos.length - 1) {
        setState(() {
          _paginaAtual++;
          _aceitouTermo = false;
        });
      } else {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('aceitou_termos', true);
        context.go(AppRouterName.login);
      }
    } else {
      Generic.snackBar(
          context: context,
          mensagem: "Você precisa aceitar o termo para continuar.");
    }
  }

  @override
  Widget build(BuildContext context) {
    final termoAtual = _termos[_paginaAtual];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Aceitar Termo",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: AppColors.cAccentColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Termo ${_paginaAtual + 1} de ${_termos.length}',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.cAccentColor,
              ),
            ),
            SizedBox(height: 14.h),

            // Título do termo
            Text(
              termoAtual.titulo,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 12.h),

            // Texto do termo
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  termoAtual.texto,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.grey.shade700,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
            SizedBox(height: 16.h),

            // Checkbox
            Row(
              children: [
                Checkbox(
                  value: _aceitouTermo,
                  onChanged: (value) {
                    setState(() {
                      _aceitouTermo = value ?? false;
                    });
                  },
                  activeColor: AppColors.cAccentColor,
                ),
                const Expanded(
                  child: Text('Li e aceito este termo.'),
                ),
              ],
            ),
            SizedBox(height: 16.h),

            // Botão de ação
            ElevatedButton(
              onPressed: _proximoTermo,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.cAccentColor,
                foregroundColor: Colors.white,
                minimumSize: Size(double.infinity, 48.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              child: Text(
                _paginaAtual == _termos.length - 1 ? 'Finalizar' : 'Próximo',
                style: TextStyle(fontSize: 18.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
