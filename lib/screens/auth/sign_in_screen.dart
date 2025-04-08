import 'package:flutter/material.dart';
import 'package:qreate/utils/constants.dart';
import 'package:qreate/utils/form_validators.dart';
import 'package:qreate/services/connectivity/connectivity_service.dart';
import 'package:qreate/services/auth/auth_service.dart';
import 'package:qreate/widgets/text_fields/auth_form_field.dart';
import 'package:qreate/widgets/buttons/rounded_rectangle_button.dart';
import 'package:qreate/widgets/progress_indicators/loading_icon.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  // Connectivity Service
  final ConnectivityService _connectivity = ConnectivityService();

  // Supabase Authentication Service
  final AuthService _auth = AuthService();

  // Screen State
  bool _isLoading = false;

  // Sign-In Form Key & Content
  final _signInFormKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  Future<void> _signIn() async {
    // Dismiss Keyboard & Mark As Loading
    FocusScope.of(context).unfocus();
    setState(() => _isLoading = true);

    final bool isConnected = await _connectivity.checkConnectivity();
    if (isConnected) {

      // Retrieve & Validate Form Data
      FormState formData = _signInFormKey.currentState!;
      if (formData.validate()) {
        // Save Form State
        formData.save();

        try {
          final result = await _auth.signInWithEmailPassword(
              email: _email, password: _password);
        } catch (e) {
          print('Sign-In Error: $e');
        }
      }
    } else {
      // TODO: Visually Indicate No Internet Connection
      print('NO INTERNET CONNECTION!');
    }

    // Stop Loading State
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    // Get Responsive Height Of All Components
    double screenHeight = MediaQuery.of(context).size.height;
    double cardHeight = screenHeight * (0.65);
    double logoHeight = (screenHeight - cardHeight);
    double logoContentHeight = 150 + 70;

    // Get Offset For Logo
    double topOffset = (logoHeight - logoContentHeight) * 0.7;
    double bottomOffset = (logoHeight - logoContentHeight) * 0.3;

    return Scaffold(
      body: Container(
        // Gradient Container Has Infinite Bounds
        width: double.infinity,
        height: double.infinity,

        // Gradiant Background
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            colors: [
              kBlueColor500,
              kBlueColor400,
            ],
            stops: [0, 6],
          ),
        ),

        // Scroll View To Avoid Keyboard Overflow
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Column(
            children: [
              // Logo & Name
              SizedBox(
                height: logoHeight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Offset
                    SizedBox(height: topOffset),

                    // App Logo
                    Image.asset(kAppLogoPath, width: 150),

                    // App Name
                    Text(
                      'Qreate',
                      style: kOrbitronLarge,
                    ),

                    // Offset
                    SizedBox(height: bottomOffset),
                  ],
                ),
              ),

              // Authentication Form Card
              Container(
                width: double.infinity,
                height: cardHeight,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: (_isLoading)
                    ? LoadingIcon(
                        icon: Icon(
                          Icons.qr_code,
                          size: 72,
                        ),
                      )
                    : Form(
                        key: _signInFormKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Form Message
                            Text('Welcome back!', style: kSubtext36),
                            Text('Login to get started.', style: kSubtext20),

                            // Offset
                            SizedBox(
                              height: 18,
                            ),

                            // Email Text Field
                            AuthFormField(
                              hintText: 'Email',
                              validator: validateEmail,
                              onSaved: (value) {
                                _email = value!;
                              },
                            ),

                            // Offset
                            SizedBox(height: 16),

                            // Password Text Field
                            AuthFormField(
                              hintText: 'Password',
                              obscureText: true,
                              validator: validateLoginPassword,
                              onSaved: (value) {
                                _password = value!;
                              },
                            ),

                            // Offset
                            SizedBox(height: 10),

                            // Password Reset Button
                            Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTap: () {},
                                child:
                                    Text('Forgot Password', style: kSubtext16),
                              ),
                            ),

                            // Offset
                            SizedBox(height: topOffset),

                            // Sign In Button
                            RoundedRectangleButton(
                              title: 'SIGN IN',
                              onPressed: _signIn,
                            ),

                            // Authentication Switch
                            Align(
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('Not a member yet?', style: kSubtext16),
                                  TextButton(
                                    onPressed: widget.onTap,
                                    child: Text(
                                      'Sign Up',
                                      style: kSubtext16.copyWith(
                                          color: kBlueColor400),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
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
