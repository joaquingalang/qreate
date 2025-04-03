import 'package:flutter/material.dart';
import 'package:qreate/utils/constants.dart';
import 'package:qreate/services/auth/auth_service.dart';
import 'package:qreate/widgets/text_fields/auth_form_field.dart';
import 'package:qreate/widgets/buttons/rounded_rectangle_button.dart';
import 'package:qreate/widgets/progress_indicators/loading_icon.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // Supabase Authentication Service
  final AuthService _auth = AuthService();

  // Screen State
  bool _isLoading = false;

  // Sign-Up Form Key & Content
  final _signUpFormKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  String _confirmPassword = '';

  // TODO: Validate Form & Register Method
  Future<void> _signUp() async {
    // Collapse Keyboard & Mark State As Loading
    FocusScope.of(context).unfocus();
    setState(() => _isLoading = true);

    // Retrieve Form Content & Validate Form
    FormState formData = _signUpFormKey.currentState!;
    if (formData.validate()) {
      // Save Form Data
      formData.save();
      try {
        final result =
            _auth.signUpWithEmailPassword(email: _email, password: _password);
      } catch (e) {
        print('Sign-Up Error: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$e')),
        );
      }
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
                        key: _signUpFormKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Form Message
                            Text('Hi there!', style: kSubtext36),
                            Text('Create an account..', style: kSubtext20),

                            // Offset
                            SizedBox(
                              height: 18,
                            ),

                            // Email Text Field
                            AuthFormField(
                              hintText: 'Email',
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
                              onSaved: (value) {
                                _password = value!;
                              },
                            ),

                            // Offset
                            SizedBox(height: 16),

                            // Password Text Field
                            AuthFormField(
                              hintText: 'Confirm Password',
                              obscureText: true,
                              onSaved: (value) {
                                _confirmPassword = value!;
                              },
                            ),

                            // Offset
                            SizedBox(height: topOffset),

                            // Sign In Button
                            RoundedRectangleButton(
                              title: 'SIGN UP',
                              onPressed: _signUp,
                            ),

                            // Authentication Switch
                            Align(
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('Already a member?', style: kSubtext16),
                                  TextButton(
                                    onPressed: widget.onTap,
                                    child: Text(
                                      'Sign In',
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
