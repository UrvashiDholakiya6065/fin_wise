import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomSheet {
  void showBiometricOptionBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Enable Biometric Login?",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[800],
                ),
              ),
              SizedBox(height: 12),
              Text(
                "You can use your fingerprint or face ID for faster login next time.",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  // User allows biometric login
                  // SharedPref.setBiometricEnabled(true); // Save in shared prefs
                  Navigator.pop(context);
                  // appRoute.push(AppRoutePath.homeScreen.path);
                },
                child: Text("Enable"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[600],
                  minimumSize: Size(double.infinity, 45),
                ),
              ),
              SizedBox(height: 12),
              TextButton(
                onPressed: () {
                  // User declines biometric login
                  // SharedPref.setBiometricEnabled(false);
                  Navigator.pop(context);
                  // appRoute.push(AppRoutePath.homeScreen.path);
                },
                child: Text("Not now"),
              ),
            ],
          ),
        );
      },
    );
  }
}