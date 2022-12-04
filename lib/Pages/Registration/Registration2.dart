import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hilike/Networking/Mobx/signup_mobx.dart';
import 'package:hilike/Pages/Registration/Registration3.dart';

import 'package:hilike/Widget/BackButton.dart';
import 'package:hilike/Widget/CountryPop.dart';
import 'package:hilike/Widget/PointRow.dart';
import 'package:hilike/generated/l10n.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import 'package:nb_utils/nb_utils.dart' as nb;

import '../../extensions.dart';
import 'package:path/path.dart' as p;

class Registration2 extends StatefulWidget {
  final SignupMobx? signupMobx;
  final String? username, email, provider, provider_token;

  const Registration2(
      {Key? key,
      this.signupMobx,
      this.email,
      this.username,
      this.provider,
      this.provider_token})
      : super(key: key);

  @override
  _Registration2State createState() => _Registration2State();
}

class _Registration2State extends State<Registration2> {
  String image = "";
  SignupMobx? signupMobx;
  bool isPng = false;

  @override
  void initState() {
    super.initState();
    signupMobx = widget.signupMobx;
  }

  Future<String> testCompressAndGetFile(String path) async {
    String targetPath = p.join((await getTemporaryDirectory()).path,
        '${DateTime.now()}.${p.extension(path)}');

    var result = await FlutterImageCompress.compressAndGetFile(path, targetPath,
        format: isPng ? CompressFormat.png : CompressFormat.jpeg,
        quality: 70,
        minWidth: 500);

    // print(file.lengthSync());
    print(result!.lengthSync());

    return result.path;
  }

  Future<String?> _uploadImage() async {
    final _picker = ImagePicker();
    XFile? _pickedImage = await _picker.pickImage(source: ImageSource.gallery);

    if (_pickedImage != null) {
      isPng =
          _pickedImage.name.substring((_pickedImage.name).indexOf(".") + 1) ==
              "png";
      var newww = await testCompressAndGetFile(_pickedImage.path);
      ImageCropper imgC = new ImageCropper();
      File? croppedFile = await ImageCropper.cropImage(
          compressFormat:
              isPng ? ImageCompressFormat.png : ImageCompressFormat.jpg,
          sourcePath: newww,
          aspectRatio: CropAspectRatio(ratioX: 9.0, ratioY: 16.0),
          androidUiSettings: AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Color(0xff292929),
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: true,
              hideBottomControls: true,
              cropFrameColor: Colors.orange),
          iosUiSettings: IOSUiSettings(
              minimumAspectRatio: 1.0,
              rotateClockwiseButtonHidden: true,
              rotateButtonsHidden: true,
              resetButtonHidden: true));

      return croppedFile != null ? croppedFile.path : "";
    } else
      return "";
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/img/cop.png"),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: Observer(
          builder: (_) => Scaffold(
            backgroundColor: Color(0x1A1A1A),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.height / 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(22, 0, 22, 0),
                    child: BackButtoncon(
                      register: true,
                      towelcome: false,
                    ),
                  ),
                  SizedBox(
                    height: size.height / 22,
                  ),
                  PointRow(
                    color1: HexColor("#3BC148"),
                    color2: Color(0xffe5003a),
                    line1color: HexColor("#3BC148"),
                    line2color: HexColor("#3BC148"),
                    line3color: Color(0xffe5003a),
                  ),
                  SizedBox(
                    height: size.height / 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(22, 0, 22, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: GestureDetector(
                            onTap: () async {
                              /*image = await pickPhoto(
                                    cropAspectRatioPreset:
                                        CropAspectRatioPreset.square);*/
                              image = await _uploadImage() ?? "";
                              setState(() {});
                              print("image 2 $image");
                              signupMobx!.setProfileImage(image);
                            },
                            child: Container(
                              width: 91,
                              height: 91,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xcc292929),
                              ),
                              child: image.isEmpty
                                  ? Image.asset(
                                      image.isEmpty
                                          ? "assets/img/camera.png"
                                          : image,
                                      scale: 3.5,
                                    )
                                  : Image.file(
                                      File(image),
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height / 40,
                        ),
                        GestureDetector(
                          onTap: () {
                            var age = 25;

                            showMaterialNumberPicker(
                                headerColor: Color(0xff292929),
                                context: context,
                                title: S.of(context).PickYourAge,
                                maxNumber: 65,
                                minNumber: 18,
                                selectedNumber: age,
                                onChanged: (value) => setState(() {
                                      signupMobx!.setDob(value.toString());
                                    }));
                          },
                          child: Container(
                            width: size.width / 1,
                            height: size.height / 13.8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Color(0xcc292929),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "      ${signupMobx!.dob.isEmptyOrNull ? S.of(context).age : signupMobx!.dob}",
                                  style: TextStyle(
                                    color: Color(0xffc4c4c4),
                                    fontSize: 13,
                                    letterSpacing: 0.65,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    var age = signupMobx!.dob != null
                                        ? int.parse(signupMobx!.dob!)
                                        : 25;

                                    showMaterialNumberPicker(
                                        headerColor: Color(0xff292929),
                                        context: context,
                                        title: S.of(context).PickYourAge,
                                        maxNumber: 65,
                                        minNumber: 18,
                                        selectedNumber: age,
                                        onChanged: (value) => setState(() {
                                              signupMobx!
                                                  .setDob(value.toString());
                                            }));
                                  },
                                  icon: Icon(Icons.keyboard_arrow_right_sharp),
                                  color: Color(0xffc4c4c4),
                                  iconSize: 30,
                                )
                              ],
                            ),
                          ),
                        ),
                        CountryPop(
                          withTitle: false,
                          type: S.of(context).origin,
                          signupMobx: signupMobx!,
                          onSelect: (mobx) {
                            signupMobx = mobx;
                          },
                        ),
                        CountryPop(
                          withTitle: false,
                          type: S.of(context).residence,
                          signupMobx: signupMobx!,
                          onSelect: (mobx) {
                            signupMobx = mobx;
                          },
                        ),
                        SizedBox(
                          height: size.height / 50,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: size.width / 6.8,
                              height: size.width / 6.8,
                              decoration: BoxDecoration(
                                color: signupMobx!.isMale
                                    ? Color(0xffe5003a)
                                    : Color(0x1A1A1A),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: signupMobx!.isMale
                                      ? Color(0xffe5003a)
                                      : Colors.white,
                                  width: 1,
                                ),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  signupMobx!.setIsMale(true);
                                },
                                child: Center(
                                  child: Text(
                                    S.of(context).male,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontFamily: "Roboto",
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Container(
                              width: size.width / 6.8,
                              height: size.width / 6.8,
                              decoration: BoxDecoration(
                                color: !signupMobx!.isMale
                                    ? Color(0xffe5003a)
                                    : Color(0x1A1A1A),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: !signupMobx!.isMale
                                      ? Color(0xffe5003a)
                                      : Colors.white,
                                  width: 1,
                                ),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  signupMobx!.setIsMale(false);
                                },
                                child: Center(
                                  child: Text(
                                    S.of(context).female,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontFamily: "Roboto",
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height / 30,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (signupMobx!.dob == null ||
                                signupMobx!.dob!.isEmpty) {
                              showTopSnackBar(S.of(context).pleaseSelectDob,
                                  "assets/img/iii.png");
                              return;
                            }
                            if (signupMobx!.originCountry == null) {
                              showTopSnackBar(
                                  S.of(context).pleaseSelectOriginCountry,
                                  "assets/img/iii.png");
                              return;
                            }
                            if (signupMobx!.residenceCountry == null) {
                              showTopSnackBar(
                                  S.of(context).pleaseSelectResidenceCountry,
                                  "assets/img/iii.png");
                              return;
                            }

                            signupMobx!.username != null
                                ? print("wow")
                                : signupMobx!.setEmail(widget.email);
                            signupMobx!.username != null
                                ? print("wow")
                                : signupMobx!.setUsername(widget.username);
                            signupMobx!.setProvider(widget.provider);
                            signupMobx!.setProvidertoken(widget.provider_token);
                            Registration3(signupMobx: signupMobx)
                                .launch(context);
                          },
                          child: Container(
                            width: size.width / 1,
                            height: size.height / 13.8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Color(0xffe5003a),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 25,
                                  ),
                                  Container(
                                    width: 50,
                                    child: Center(
                                      child: Text(
                                        S.of(context).next,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontFamily: "Roboto",
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 0.75,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_sharp,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height / 50,
                        ),
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              S.of(context).alreadyHaveAnAccount,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Roboto',
                                fontSize: 13,
                                fontWeight: FontWeight.normal,
                                letterSpacing: 0.65,
                              ),
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.pushReplacementNamed(
                                    context, 'login');
                              },
                              child: Text(
                                S.of(context).log_in,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xff0583f2),
                                  fontFamily: 'Roboto',
                                  fontSize: 13,
                                  letterSpacing: 0.65,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
