import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permuta_brasil/screens/widgets/app_bar.dart';
import 'package:permuta_brasil/utils/app_colors.dart';

class TermoModel {
  final String titulo;
  final String texto;

  TermoModel({required this.titulo, required this.texto});
}

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
      titulo: 'Confidencialidade e Proteção de Dados',
      texto: '''
O usuário reconhece e concorda que o aplicativo Permuta Brasil lida com informações pessoais sensíveis, tais como nome, telefone de outros usuários.

O usuário se compromete a:
- Utilizar essas informações exclusivamente para fins de comunicação relacionada à permuta profissional.
- Não compartilhar, vender, divulgar ou utilizar os dados obtidos através do aplicativo para quaisquer outros fins que não estejam diretamente relacionados à permuta de estados.
- Manter o sigilo sobre todas as informações visualizadas no app, mesmo após deixar de utilizar o serviço.

O descumprimento dessas condições poderá acarretar em medidas legais cabíveis conforme a legislação vigente (LGPD - Lei Geral de Proteção de Dados).
''',
    ),
    TermoModel(
      titulo: 'Pagamento para Disponibilização de Perfil',
      texto: '''
Para que seu perfil esteja visível e disponível para buscas de permutas dentro do aplicativo, o usuário deverá manter saldo de créditos suficiente em sua conta.

O valor de R\$10 (dez reais) será descontado mensalmente do saldo de créditos como taxa de disponibilização de perfil.

Caso o saldo de créditos seja insuficiente no momento da cobrança, o perfil será removido temporariamente da lista de possíveis permutas até que novos créditos sejam adquiridos.

A compra de créditos é feita de forma antecipada pelo usuário, e a manutenção do perfil visível depende da existência de saldo disponível. O pagamento da taxa mensal não implica em garantias de encontrar permutas, sendo apenas o direito de ser listado e localizado pelos demais usuários.
''',
    ),
    TermoModel(
      titulo: 'Direito de Arrependimento',
      texto: '''
Ao adquirir créditos no aplicativo Permuta Brasil, o usuário reconhece que a prestação dos serviços ocorrerá imediatamente após a confirmação do pagamento, consistindo no acesso à plataforma e aos dados disponíveis no momento da consulta, se houver.

O usuário entende e concorda que o conteúdo da plataforma depende da adesão voluntária de terceiros, não sendo garantida a existência, quantidade ou adequação dos perfis às suas expectativas ou necessidades de permuta.

Dessa forma, conforme permitido pelo artigo 49 do Código de Defesa do Consumidor, o usuário concorda que, uma vez iniciado o serviço, não poderá exercer o direito de arrependimento e solicitar o cancelamento ou reembolso dos valores pagos, visto que o serviço foi integralmente disponibilizado.

''',
    ),
    TermoModel(
      titulo: 'Termo de Responsabilidade',
      texto: '''
O aplicativo Permuta Brasil atua apenas como uma plataforma de conexão entre usuários interessados em permutas de estados.

O usuário reconhece que:
- A plataforma não intermedeia, valida, garante ou participa das negociações entre as partes.
- Toda responsabilidade pelas tratativas, acordos, combinações, deslocamentos e eventuais consequências das permutas é exclusiva dos próprios usuários.
- O aplicativo não se responsabiliza por informações inverídicas fornecidas por outros usuários, nem por danos ou prejuízos decorrentes de qualquer tipo de negociação ou tentativa de permuta.

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

  void _proximoTermo() {
    if (_aceitouTermo) {
      if (_paginaAtual < _termos.length - 1) {
        setState(() {
          _paginaAtual++;
          _aceitouTermo = false;
        });
      } else {
        Navigator.pop(context, true); // Finaliza o processo
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Você precisa aceitar o termo para continuar.')),
      );
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
