import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class MaskUtils {
  static MaskTextInputFormatter maskFormatterCpf() => MaskTextInputFormatter(
      mask: '###.###.###-##', filter: {"#": RegExp(r'[0-9-]')});

  static MaskTextInputFormatter maskFormatterData() => MaskTextInputFormatter(
      mask: '##/##/####', filter: {"#": RegExp(r'[0-9]')});

  static MaskTextInputFormatter padrao() => MaskTextInputFormatter();

  static MaskTextInputFormatter maskTelefone() => MaskTextInputFormatter(
      mask: '## # #### ####', filter: {"#": RegExp(r'[0-9-]')});
}
