import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permuta_brasil/utils/app_colors.dart';
import 'package:permuta_brasil/utils/app_names.dart';
import 'package:permuta_brasil/utils/app_snack_bar.dart';

class ConfigScreen extends StatelessWidget {
  const ConfigScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey, width: 0.3),
            ),
          ),
          child: AppBar(
            elevation: 0,
            backgroundColor: AppColors.scaffoldColor,
            leading: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.arrow_back, color: Colors.black),
            ),
            title:
                const Text("Meu perfil", style: TextStyle(color: Colors.black)),
            centerTitle: true,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
        child: ListView(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(12.0)),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 8.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Stack para a imagem circular com o ícone de câmera
                    Stack(
                      children: [
                        Container(
                          width: 80.0,
                          height: 80.0,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  'https://via.placeholder.com/150'), // URL da imagem
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 30.0,
                            height: 30.0,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black54,
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 20.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 15.w),
                    // Coluna com nome, email e opção para editar perfil
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Nome do Usuário',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8.0),
                        const Text(
                          'tamiresguimaraesmoura@hotmail.com',
                          style: TextStyle(fontSize: 13.0, color: Colors.grey),
                        ),
                        const SizedBox(height: 14.0),
                        ElevatedButton(
                          onPressed: () {
                            // Ação ao clicar no botão de editar perfil
                          },
                          child: const Text('Editar Perfil'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 9.h),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Geral',
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.bold)),
                  SizedBox(height: 5.h),
                  ListTile(
                    minLeadingWidth: 30.w,
                    minTileHeight: 35.h,
                    leading: const Icon(Icons.add_box),
                    title: const Text('Cadastrar Produto'),
                    onTap: () {
                      showAddProductDialog(context);
                    },
                  ),
                  ListTile(
                    minLeadingWidth: 30.w,
                    minTileHeight: 35.h,
                    leading: const Icon(Icons.picture_as_pdf),
                    title: const Text('Exportar para PDF'),
                    onTap: () {
                      // Ação ao clicar na opção
                    },
                  ),
                  ListTile(
                    minLeadingWidth: 30.w,
                    minTileHeight: 35.h,
                    leading: const Icon(Icons.grid_on),
                    title: const Text('Exportar para Excel'),
                    onTap: () {
                      // Ação ao clicar na opção
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 9.h),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
                borderRadius: BorderRadius.circular(12.0),
              ),
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 15.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Account',
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.bold)),
                  SizedBox(height: 5.h),
                  ListTile(
                    minLeadingWidth: 30.w,
                    minTileHeight: 35.h,
                    leading: const Icon(Icons.security),
                    title: const Text('Segurança'),
                    onTap: () {},
                  ),
                  ListTile(
                    minLeadingWidth: 30.w,
                    minTileHeight: 35.h,
                    leading: const Icon(Icons.lock),
                    title: const Text('Password'),
                    onTap: () {
                      // Ação ao clicar na opção
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 9.h),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(12.0)),
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Suporte',
                      style: TextStyle(
                          fontSize: 16.h, fontWeight: FontWeight.bold)),
                  SizedBox(height: 6.h),
                  ListTile(
                    minLeadingWidth: 30.w,
                    minTileHeight: 35.h,
                    leading: const Icon(Icons.help_outline),
                    title: const Text('Como usar o app'),
                    onTap: () async {
                      // Ação ao clicar na opção
                    },
                  ),
                  ListTile(
                    minLeadingWidth: 30.w,
                    minTileHeight: 35.h,
                    leading: const Icon(Icons.contact_support),
                    title: const Text('Contato para Suporte'),
                    onTap: () {
                      // Ação ao clicar na opção
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showAddProductDialog(BuildContext context) {
    final TextEditingController nomeController = TextEditingController();
    final TextEditingController priceController = TextEditingController();
    // final FocusNode priceFocus = FocusNode();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment:
                  CrossAxisAlignment.center, // Centralizando o conteúdo
              children: <Widget>[
                const Text(
                  'Adicionar Produto',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center, // Centralizando o texto
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: nomeController,
                  decoration: const InputDecoration(
                    labelText: 'Nome do Produto',
                    hintText: 'Digite o nome do produto',
                    border: OutlineInputBorder(),
                  ),
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: priceController,
                  //focusNode: priceFocus,

                  decoration: const InputDecoration(
                    prefixText: 'R\$ ',
                    labelText: 'Preço',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    TextButton(
                      child: const Text(
                        'Cancelar',
                        style: TextStyle(color: Colors.red),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.cAccentColor),
                      child: const Text(
                        'Salvar',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if (priceController.text.isEmpty ||
                            priceController.text == "" ||
                            nomeController.text == "" ||
                            nomeController.text.isEmpty) {
                          // Ação ao clicar no botão de salvar
                          Generic.snackBar(
                              context: context,
                              mensagem: "Os campos precisam ser preenchido",
                              duracao: 1);
                          // Navigator.of(context).pop();
                        } else {
                          // produto.nome = nomeController.text;
                          // produto.preco = double.parse(priceController.text);
                          // await db.insertProduto(produto);
                          Generic.snackBar(
                              context: context,
                              mensagem: "Produto cadastrado com sucesso",
                              tipo: AppName.sucesso,
                              duracao: 1);

                          Navigator.of(context).pop();
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
