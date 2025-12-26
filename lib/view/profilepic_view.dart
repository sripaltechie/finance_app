import 'package:chanda_finance/utils/constants.dart';
import 'package:flutter/cupertino.dart';

class ProfilePicScreen extends StatelessWidget {
  const ProfilePicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Image img = Image.asset(logoSrc);
    ImageProvider image = img.image;
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: image),
      ),
    );
  }
}
