import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'image_picker_widgets.dart';

void showPickerBottomSheet(BuildContext context,Function(String path, String type) onFileSelected,) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            ListTile(
              leading:  Icon(Icons.camera_alt, color: Colors.blue),
              title:  Text("Camera"),
              onTap: () async {
                Navigator.pop(context);

                final path = await pickFromCamera();
                print("Camera Path: $path");
                if (path != null) {
                  onFileSelected(path, "image");

                }
                // pickFromCamera();
                // Navigator.pop(context);
                // TODO: Open Camera
              },
            ),

            ListTile(
              leading:  Icon(Icons.photo, color: Colors.green),
              title:  Text("Gallery"),
              onTap: () async {
                Navigator.pop(context);
                final path = await pickFromGallery();
                print("Gallery Path: $path");
                if (path != null) {
                  onFileSelected(path, "image");
                }                // pickFromGallery();
                // Navigator.pop(context);
                // TODO: Open Gallery
              },
            ),

            ListTile(
              leading:  Icon(Icons.insert_drive_file, color: Colors.orange),
              title:  Text("Document"),
              onTap: () async {
                Navigator.pop(context);
                final path = await pickDocument();
                print("Doc Path: $path");
                if (path != null) {
                  onFileSelected(path, "file"); // ✅ ADD THIS
                }
                // pickDocument();

                // Navigator.pop(context);
                // TODO: Pick Document
              },
            ),
          ],
        ),
      );
    },
  );
}