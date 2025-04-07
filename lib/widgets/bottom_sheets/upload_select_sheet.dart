import 'dart:io';
import 'package:flutter/material.dart';
import 'package:qreate/models/uploaded_logo.dart';
import 'package:qreate/services/database/logo_database.dart';
import 'package:qreate/utils/constants.dart';
import 'package:qreate/services/storage/logo_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qreate/widgets/buttons/image_button.dart';
import 'package:qreate/widgets/progress_indicators/loading_icon.dart';

class UploadSelectSheet extends StatefulWidget {
  const UploadSelectSheet({
    super.key,
    required this.onSelect,
  });

  final Function(String?)? onSelect;

  @override
  State<UploadSelectSheet> createState() => _UploadSelectSheetState();
}

class _UploadSelectSheetState extends State<UploadSelectSheet> {

  // Supabase Logo Database Instance
  final LogoDatabase _logoDatabase = LogoDatabase();

  // Supabase Logo Storage Instance
  final LogoStorage _logoStorage = LogoStorage();

  // TODO: Upload Logo
  Future<void> _upload() async {
    final ImagePicker imagePicker = ImagePicker();
    XFile? logo = await imagePicker.pickImage(source: ImageSource.gallery);
    String logoPath = logo!.path;
    await _logoStorage.uploadLogo(File(logoPath));
  }

  // TODO: Select Logo
  Future<void> _select(UploadedLogo logo) async {
    widget.onSelect!(logo.url!);
    Navigator.pop(context);
  }

  // TODO: Delete Logo
  Future<void> _delete(UploadedLogo logo) async {
    await _logoStorage.deleteLogo(logo);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: kGrayColor100,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(15),
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: 16),
          Text('Uploaded Logos', style: kTitleSmall),
          SizedBox(height: 16),
          Expanded(
            child: StreamBuilder(
              stream: _logoDatabase.getStream(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return LoadingIcon(
                    icon: Icon(
                      Icons.qr_code,
                      size: 72,
                    ),
                  );
                }

                // Logo Url List
                final uploadedLogos = snapshot.data;

                return GridView.builder(
                  shrinkWrap: true,
                  gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                  itemCount: uploadedLogos.length + 1,
                  itemBuilder: (context, index) {

                    // Render Image Buttons
                    if (index < uploadedLogos.length) {
                      final logo = uploadedLogos[index];
                      return ImageButton(
                        imageUrl: logo.url!,
                        onPressed: () => _select(logo),
                        onDelete: () => _delete(logo),
                      );
                    }

                    // Upload Logo Button
                    return AddImageButton(
                      onPressed: _upload,
                    );
                  },
                );
              }
            ),
          ),
        ],
      ),
    );
  }
}
