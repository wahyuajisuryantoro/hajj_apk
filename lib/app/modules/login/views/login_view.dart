import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hajj/app/routes/app_pages.dart';
import 'package:hajj/app/utility/app_colors.dart';
import 'package:hajj/app/utility/app_responsive.dart';
import 'package:hajj/app/utility/app_text.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.secondary,
              AppColors.primary,
            ],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppResponsive.width(context, 10),
            vertical: AppResponsive.height(context, 5),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logoapp.png',
                width: AppResponsive.width(context, 70),
              ),
              SizedBox(height: AppResponsive.height(context, 9)),
              TextFormField(
                controller: controller.usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  labelStyle: AppText.body2(color: Colors.white),
                  prefixIcon: Icon(Icons.person, color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                style: AppText.body2(color: Colors.white),
              ),
              SizedBox(height: AppResponsive.height(context, 2)),
              Obx(() => TextFormField(
                    controller: controller.passwordController,
                    obscureText: !controller.isPasswordVisible.value,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: AppText.body2(color: Colors.white),
                      prefixIcon: Icon(Icons.lock, color: Colors.white),
                      suffixIcon: IconButton(
                        onPressed: controller.togglePasswordVisibility,
                        icon: SvgPicture.asset(
                          controller.isPasswordVisible.value
                              ? 'assets/icons/eye_on.svg'
                              : 'assets/icons/eye_off.svg',
                          width: 24,
                          height: 24,
                          colorFilter: const ColorFilter.mode(
                              Colors.white, BlendMode.srcIn),
                        ),
                        padding: EdgeInsets.zero,
                        constraints:
                            const BoxConstraints(minWidth: 40, minHeight: 40),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    style: AppText.body2(color: Colors.white),
                  )),
              // SizedBox(height: AppResponsive.height(context, 2)),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     Text(
              //       'I forgot my password',
              //       style: AppText.body3(color: Colors.white),
              //     ),
              //   ],
              // ),
              SizedBox(height: AppResponsive.height(context, 4)),
              Container(
                width: double.infinity,
                child: Obx(() => ElevatedButton(
                      onPressed: controller.login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: EdgeInsets.symmetric(
                          horizontal: AppResponsive.width(context, 20),
                          vertical: AppResponsive.height(context, 2),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: controller.isLoading.value
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text(
                              'Login',
                              style: AppText.body1(color: Colors.white),
                            ),
                    )),
              ),
              SizedBox(height: AppResponsive.height(context, 2)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Belum punya akun? ',
                    style: AppText.body3(color: Colors.white),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.toNamed(Routes.REGISTER);
                    },
                    child: Text(
                      'Daftar Sekarang',
                      style: AppText.body2(
                        color: Colors.white,
                      ).copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
