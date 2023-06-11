import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:plateshare/screens/InicioScreen.dart';
import 'package:http/http.dart' as http;

import '../util/AppColors.dart';

class ContactScreen extends StatefulWidget {
  final String emailData;
  final String nameData;
  final String usernameData;
  final String profilePicData;

  const ContactScreen({
    Key? key,
    required this.emailData,
    required this.nameData,
    required this.usernameData,
    required this.profilePicData,
  }) : super(key: key);

  @override
  _ContactScreenState createState() => _ContactScreenState();
}

dynamic screenSizeContactScreen;

class _ContactScreenState extends State<ContactScreen> {
  final TextEditingController _asuntoController = TextEditingController();
  final TextEditingController _mensajeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    screenSizeContactScreen = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              color: AppColors.primaryColor,
              height: 50,
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: AppColors.primaryColor,
                    ),
                    onPressed: () {},
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'Contacta con nosotros',
                        style: GoogleFonts.acme(
                          textStyle: const TextStyle(
                            color: AppColors.whiteColor,
                            fontSize: 24,
                            fontFamily: 'Acme',
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: AppColors.whiteColor,
                      size: 22,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => InicioScreen(
                            emailData: widget.emailData,
                            nameData: widget.nameData,
                            profilePicData: widget.profilePicData,
                            usernameData: widget.usernameData,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: AppColors.accentColor,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Lottie.network(
                        'https://assets10.lottiefiles.com/packages/lf20_hqrpwcwb.json',
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Text(
                              'Asunto',
                              style: GoogleFonts.acme(
                                textStyle: const TextStyle(
                                  color: AppColors.brownTextColor,
                                  fontSize: 24,
                                  fontFamily: 'Acme',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              padding: const EdgeInsets.fromLTRB(3, 1, 3, 1),
                              decoration: BoxDecoration(
                                color: AppColors.greyAccentColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      controller: _asuntoController,
                                      decoration: const InputDecoration(
                                        hintText: 'Asunto...',
                                        border: InputBorder.none,
                                        counterText: '',
                                      ),
                                      maxLines: 1,
                                      style: const TextStyle(fontSize: 18),
                                      maxLength: 50,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
                            child: Text(
                              'Mensaje',
                              style: GoogleFonts.acme(
                                textStyle: const TextStyle(
                                  color: AppColors.brownTextColor,
                                  fontSize: 24,
                                  fontFamily: 'Acme',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              padding: const EdgeInsets.fromLTRB(3, 1, 3, 1),
                              decoration: BoxDecoration(
                                color: AppColors.greyAccentColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 200,
                                      child: TextField(
                                        controller: _mensajeController,
                                        decoration: const InputDecoration(
                                          hintText: 'Mensaje...',
                                          border: InputBorder.none,
                                          counterText: '',
                                        ),
                                        maxLines: null,
                                        style: const TextStyle(fontSize: 18),
                                        maxLength: 500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                        child: GestureDetector(
                          onTap: () async {
                            String asunto = _asuntoController.text;
                            String message = _mensajeController.text;

                            if (asunto.isNotEmpty && message.isNotEmpty) {
                              enviarEmail(
                                email: widget.emailData,
                                name: widget.nameData,
                                message: message,
                                asunto: asunto,
                              );

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Email enviado con éxito'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                              _asuntoController.clear();
                              _mensajeController.clear();
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'El asunto y el cuerpo del correo no pueden estar vacios'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },
                          child: Container(
                            height: 50,
                            width: 200,
                            decoration: BoxDecoration(
                              color: AppColors.orangeColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.all(10.0),
                            child: Align(
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Text(
                                    'Enviar',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.whiteColor,
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Icon(
                                    Icons.send,
                                    color: AppColors.whiteColor,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future enviarEmail({email, name, message, asunto}) async {
    var serviceId = 'service_df6jida';
    var templateId = 'template_o3926cs';
    var userId = 'J0XTNBhNp5LcSKLga';

    var url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    try {
      await http.post(url,
          headers: {
            'origin': '<http://localhost>',
            'Content-Type': 'application/json'
          },
          body: json.encode({
            'service_id': serviceId,
            'template_id': templateId,
            'user_id': userId,
            'template_params': {
              'name': name,
              'useremail': email,
              'message': message,
              'asunto': asunto,
            }
          }));
    } catch (error) {
     //    
  }
}
}