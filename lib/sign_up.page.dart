import "package:flutter/material.dart";

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _personalDetailsFormKey = GlobalKey<FormState>();
  final _accountDetailsFormKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _ageController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _addressController = TextEditingController();

  int _currentStep = 0;
  String? _gender;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _ageController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _continue() {
    final formKey = _currentStep == 0
        ? _personalDetailsFormKey
        : _accountDetailsFormKey;

    if (!formKey.currentState!.validate()) {
      return;
    }

    if (_currentStep < 1) {
      setState(() => _currentStep++);
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Registration completed successfully.")),
    );
  }

  String? _requiredValidator(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return "$fieldName is required";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create account")),
      body: Stepper(
        currentStep: _currentStep,
        onStepContinue: _continue,
        onStepCancel: _currentStep == 0
            ? null
            : () => setState(() => _currentStep--),
        controlsBuilder: (context, details) {
          return Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: details.onStepContinue,
                  child: Text(_currentStep == 1 ? "Create account" : "Next"),
                ),
                if (_currentStep > 0) ...[
                  const SizedBox(width: 12),
                  TextButton(
                    onPressed: details.onStepCancel,
                    child: const Text("Back"),
                  ),
                ],
              ],
            ),
          );
        },
        steps: [
          Step(
            title: const Text("Personal details"),
            subtitle: const Text("Tell us about yourself"),
            isActive: _currentStep >= 0,
            state: _currentStep > 0 ? StepState.complete : StepState.indexed,
            content: Form(
              key: _personalDetailsFormKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      labelText: "Full name",
                      prefixIcon: Icon(Icons.person_outline),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                        _requiredValidator(value, "Full name"),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      labelText: "Phone number",
                      prefixIcon: Icon(Icons.phone_outlined),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      final requiredError = _requiredValidator(
                        value,
                        "Phone number",
                      );
                      if (requiredError != null) return requiredError;
                      if (value!.trim().length < 7) {
                        return "Enter a valid phone number";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _ageController,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      labelText: "Age",
                      prefixIcon: Icon(Icons.cake_outlined),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      final requiredError = _requiredValidator(value, "Age");
                      if (requiredError != null) return requiredError;
                      final age = int.tryParse(value!.trim());
                      if (age == null || age < 13 || age > 120) {
                        return "Enter an age between 13 and 120";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: _gender,
                    decoration: const InputDecoration(
                      labelText: "Gender",
                      prefixIcon: Icon(Icons.wc_outlined),
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(value: "Female", child: Text("Female")),
                      DropdownMenuItem(value: "Male", child: Text("Male")),
                      DropdownMenuItem(
                        value: "Non-binary",
                        child: Text("Non-binary"),
                      ),
                      DropdownMenuItem(
                        value: "Prefer not to say",
                        child: Text("Prefer not to say"),
                      ),
                    ],
                    onChanged: (value) => setState(() => _gender = value),
                    validator: (value) =>
                        value == null ? "Gender is required" : null,
                  ),
                ],
              ),
            ),
          ),
          Step(
            title: const Text("Account details"),
            subtitle: const Text("Secure your account"),
            isActive: _currentStep >= 1,
            content: Form(
              key: _accountDetailsFormKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      labelText: "Email",
                      prefixIcon: Icon(Icons.email_outlined),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      final requiredError = _requiredValidator(value, "Email");
                      if (requiredError != null) return requiredError;
                      if (!value!.contains("@")) {
                        return "Enter a valid email address";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      labelText: "Password",
                      prefixIcon: Icon(Icons.lock_outline),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      final requiredError = _requiredValidator(
                        value,
                        "Password",
                      );
                      if (requiredError != null) return requiredError;
                      if (value!.length < 8) {
                        return "Password must be at least 8 characters";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _addressController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: "Address",
                      prefixIcon: Icon(Icons.location_on_outlined),
                      border: OutlineInputBorder(),
                      alignLabelWithHint: true,
                    ),
                    validator: (value) => _requiredValidator(value, "Address"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
