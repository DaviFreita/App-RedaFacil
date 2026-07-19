import 'dart:io';

import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class LoginBottomSheet extends StatefulWidget {
  final bool visible;

  final VoidCallback onClose;

  final Function(String email) onContinue;

  final VoidCallback onGoogleLogin;

  final VoidCallback? onAppleLogin;

  const LoginBottomSheet({
    super.key,
    required this.visible,
    required this.onClose,
    required this.onContinue,
    required this.onGoogleLogin,
    this.onAppleLogin,
  });

  @override
  State<LoginBottomSheet> createState() => _LoginBottomSheetState();
}

class _LoginBottomSheetState extends State<LoginBottomSheet> {
  final _controller = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = (MediaQuery.of(context).size.height * .58).clamp(
      470.0,
      620.0,
    );

    return IgnorePointer(
      ignoring: !widget.visible,
      child: AnimatedSlide(
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeOutCubic,
        offset: widget.visible ? Offset.zero : const Offset(0, 1),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Material(
            color: Colors.transparent,
            child: Container(
              height: height,
              width: double.infinity,
              padding: EdgeInsets.only(
                left: 24,
                right: 24,
                top: 18,
                bottom: MediaQuery.of(context).padding.bottom + 20,
              ),
              decoration: const BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      width: 42,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),

                    const SizedBox(height: 24),

                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Bem-vindo 👋",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Digite seu e-mail para continuar.",
                        style: TextStyle(color: Colors.white70, fontSize: 15),
                      ),
                    ),

                    const SizedBox(height: 30),

                    TextFormField(
                      controller: _controller,
                      keyboardType: TextInputType.emailAddress,
                      autofillHints: const [AutofillHints.email],
                      decoration: InputDecoration(
                        hintText: "seu@email.com",
                        prefixIcon: const Icon(Icons.email_outlined),
                        filled: true,
                        fillColor: Colors.white.withOpacity(.05),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Informe seu e-mail";
                        }

                        final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');

                        if (!emailRegex.hasMatch(value.trim())) {
                          return "E-mail inválido";
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 22),

                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            widget.onContinue(_controller.text.trim());
                          }
                        },
                        child: const Text(
                          "Continuar",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    Row(
                      children: [
                        Expanded(
                          child: Divider(color: Colors.white.withOpacity(.15)),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: Text(
                            "ou",
                            style: TextStyle(
                              color: Colors.white.withOpacity(.5),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(color: Colors.white.withOpacity(.15)),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    _SocialButton(
                      image: "assets/icons/google.png",
                      text: "Continuar com Google",
                      onTap: widget.onGoogleLogin,
                    ),

                    if (Platform.isIOS) ...[
                      const SizedBox(height: 14),
                      _SocialButton(
                        image: "assets/icons/apple.png",
                        text: "Continuar com Apple",
                        onTap: widget.onAppleLogin ?? () {},
                      ),
                    ],

                    const Spacer(),

                    Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        Text(
                          "Ao continuar você concorda com nossos ",
                          style: TextStyle(
                            color: Colors.white.withOpacity(.55),
                            fontSize: 12,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text("Termos"),
                        ),
                        Text(
                          " e ",
                          style: TextStyle(
                            color: Colors.white.withOpacity(.55),
                            fontSize: 12,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text("Política de Privacidade"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final String image;
  final String text;
  final VoidCallback onTap;

  const _SocialButton({
    required this.image,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: Colors.white.withOpacity(.12)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        onPressed: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(image, width: 22),
            const SizedBox(width: 12),
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
