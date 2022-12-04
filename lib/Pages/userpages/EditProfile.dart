import 'dart:io';

import 'package:after_layout/after_layout.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hilike/Models/user_image.dart';
import 'package:hilike/Networking/Mobx/profile_mobx.dart';
import 'package:hilike/Networking/Mobx/signup_mobx.dart';
import 'package:hilike/Utils/constants.dart';
import 'package:hilike/Widget/ContainerEditText.dart';
import 'package:hilike/Widget/FilterRow.dart';
import 'package:hilike/Widget/Navigation.dart';
import 'package:hilike/Widget/UserAvatar.dart';
import 'package:hilike/Widget/customDialog.dart';
import 'package:hilike/generated/l10n.dart';
import 'package:path/path.dart' as p;
import 'package:image_cropper/image_cropper.dart';
import 'package:path_provider/path_provider.dart';
//import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import '../../extensions.dart';

class EditProfile extends StatefulWidget {
  final ProfileMobx? profileMobx;
  final Function? onEditSuccess;

  const EditProfile({Key? key, this.profileMobx, this.onEditSuccess})
      : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> with AfterLayoutMixin {
  var image;
  bool isPng = false;
  ProfileMobx profileMobx = ProfileController();
  SignupMobx signupMobx = SignupController();
  List<int?> removedImages = [];
  Future<String?> pickPhoto() async {
    final _picker = ImagePicker();
    XFile? _pickedImage = await _picker.pickImage(source: ImageSource.gallery);

    if (_pickedImage != null) {
      isPng =
          _pickedImage.name.substring((_pickedImage.name).indexOf(".") + 1) ==
              "png";
      print("picked : ${isPng}");
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

  void setDob(val) {
    x = val;
  }

  @override
  void initState() {
    super.initState();
    if (widget.profileMobx != null) profileMobx = widget.profileMobx!;
  }

  String? x;
  // Future<String?> pickPhoto() async {
  //   final _picker = ImagePicker();
  //   XFile? _pickedImage = await _picker.pickImage(source: ImageSource.gallery);

  //   return _pickedImage?.path;
  // }
  void navIndex() {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return CustomDialogg(
          title: Localizations.localeOf(context).languageCode.toString() == "ar"
              ? S.of(context).doYouWantToSaveChanges + " ؟ "
              : S.of(context).doYouWantToSaveChanges + " ?",
          negativeButtonText: S.of(context).later,
          positiveButtonText: S.of(context).save,
          onNegativeClick: () {
            profileMobx.reset();
            switch (NavigationRow.global_value) {
              case 0:
                Navigator.pushReplacementNamed(context, 'mainmenu');
                break;
              case 1:
                Navigator.pushReplacementNamed(context, 'messages');
                break;
              case 2:
                Navigator.pushReplacementNamed(context, 'liked');
                break;
              case 3:
                Navigator.pushReplacementNamed(context, 'profile');
                break;
            }
          },
          onPositiveClick: () async {
            Navigator.pop(context);
            bool success = await profileMobx.updateProfile(
              context,
              profileImage: image,
              removedImages: removedImages,
            );
            if (success)
              switch (NavigationRow.global_value) {
                case 0:
                  Navigator.pushReplacementNamed(context, 'mainmenu');
                  break;
                case 1:
                  Navigator.pushReplacementNamed(context, 'messages');
                  break;
                case 2:
                  Navigator.pushReplacementNamed(context, 'liked');
                  break;
                case 3:
                  Navigator.pushReplacementNamed(context, 'profile');
                  break;
              }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Observer(
      builder: (_) => GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            leading: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext ctx) {
                    return CustomDialogg(
                      title: Localizations.localeOf(context)
                                  .languageCode
                                  .toString() ==
                              "ar"
                          ? S.of(context).doYouWantToSaveChanges + " ؟ "
                          : S.of(context).doYouWantToSaveChanges + " ?",
                      negativeButtonText: S.of(context).later,
                      positiveButtonText: S.of(context).save,
                      onNegativeClick: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                        profileMobx.reset();
                      },
                      onPositiveClick: () async {
                        Navigator.pop(context);
                        bool success = await profileMobx.updateProfile(
                          context,
                          profileImage: image,
                          removedImages: removedImages,
                        );
                        if (success) Navigator.pop(context);
                        if (widget.onEditSuccess != null)
                          widget.onEditSuccess!();
                      },
                    );
                  },
                );
              },
              child: Icon(
                Localizations.localeOf(context).languageCode.toString() == "ar"
                    ? Icons.arrow_back_ios
                    : Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 16,
              ),
            ),
            title: Text(
              S.of(context).editProfile,
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontFamily: "Roboto",
                fontWeight: FontWeight.w900,
                letterSpacing: 1.10,
              ),
            ),
            elevation: 0,
            backgroundColor: Color(0xff292929),
            actions: [
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext ctx) {
                      return CustomDialogg(
                        title: Localizations.localeOf(context)
                                    .languageCode
                                    .toString() ==
                                "ar"
                            ? S.of(context).doYouWantToSaveChanges + " ؟ "
                            : S.of(context).doYouWantToSaveChanges + " ?",
                        negativeButtonText: S.of(context).later,
                        positiveButtonText: S.of(context).save,
                        onNegativeClick: () {
                          profileMobx.reset();
                          Navigator.pushReplacementNamed(context, 'Bmenu');
                        },
                        onPositiveClick: () async {
                          Navigator.pop(context);
                          bool success = await profileMobx.updateProfile(
                            context,
                            profileImage: image,
                            removedImages: removedImages,
                          );
                          if (success)
                            Navigator.pushReplacementNamed(context, 'Bmenu');
                        },
                      );
                    },
                  );
                },
                child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    height: 14,
                    width: 20,
                    child: Image.asset(
                      "assets/img/menu.png",
                      matchTextDirection: true,
                    )),
              ),
            ],
          ),
          extendBodyBehindAppBar: true,
          body: ListView(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15)),
                  color: Color(0xff292929),
                ),
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 18),
                // height: size.height / 2.7,
                child: Column(
                  children: [
                    if (profileMobx.user != null)
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 80,
                                height: 80,
                                child: Stack(
                                  children: [
                                    image != null
                                        ? Container(
                                            width: 80,
                                            height: 80,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: FileImage(File(image!)),
                                                fit: BoxFit.cover,
                                              ),
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: Color(0xffffb84f),
                                                width: 1,
                                              ),
                                              color: Color(0xffc4c4c4),
                                            ),
                                          )
                                        : Center(
                                            child: UserAvatar(
                                              image: profileMobx
                                                      .user!.profileImage ??
                                                  (profileMobx.user!.isMale ??
                                                          true
                                                      ? imgMalePlaceholder
                                                      : imgFemalePlaceholder),
                                              size: 80,
                                              plan: profileMobx.user!.plan ??
                                                  "Free",
                                            ),
                                          ),
                                    profileMobx.user!.online ?? false
                                        ? Positioned(
                                            left: size.width / 6,
                                            bottom: size.width / 6.5,
                                            child: Container(
                                              width: 12,
                                              height: 12,
                                              decoration: BoxDecoration(
                                                color: Color(0xff3BC148),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                border: Border.all(
                                                  color: Color(0xff505050),
                                                  width: 2,
                                                ),
                                              ),
                                            ),
                                          )
                                        : Container(),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  /*image = await pickPhoto(
                                cropAspectRatioPreset:
                                    CropAspectRatioPreset.square);*/
                                  image = await pickPhoto();
                                  setState(() {});
                                },
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xffc4c4c4),
                                  ),
                                  child: Image.asset(
                                    "assets/img/camera.png",
                                    scale: 7,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${profileMobx.nickname != null ? profileMobx.nickname! : profileMobx.user!.nickname ?? ""}  ",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 0.90,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  dialogTextField(
                                    context,
                                    text: S.of(context).nickname,
                                    profileMobx: profileMobx,
                                    type: DialogTextFieldType.nickname,
                                    currentValue: profileMobx.nickname != null
                                        ? profileMobx.nickname!
                                        : profileMobx.user!.nickname ?? "",
                                    textInputType: TextInputType.name,
                                  );
                                },
                                child: Container(
                                  height: 20,
                                  width: 20,
                                  child: Image.asset(
                                    "assets/img/edit.png",
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: Text(
                              "${profileMobx.user!.plan ?? ""} ${S.of(context).account}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${S.of(context).progress}  ${profileMobx.user!.profileProgress ?? 0}%    ",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                ),
                              ),
                              Container(
                                // margin: EdgeInsets.symmetric(vertical: 20),
                                width: 113,
                                height: 9,
                                // color: Color(0xffD6D6D6),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    color: Color(0xffD6D6D6),
                                    width: 0.5,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  child: StepProgressIndicator(
                                    totalSteps: 100,
                                    currentStep:
                                        profileMobx.user!.profileProgress ?? 0,
                                    size: 8,
                                    padding: 0,
                                    unselectedColor: Color(0xffD6D6D6),
                                    roundedEdges: Radius.circular(15),
                                    selectedGradientColor: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                        HexColor("#f01537"),
                                        HexColor("#ffbc58")
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 14,
                          ),
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext ctx) {
                                  return CustomDialogg(
                                    title: Localizations.localeOf(context)
                                                .languageCode
                                                .toString() ==
                                            "ar"
                                        ? S.of(context).doYouWantToSaveChanges +
                                            " ؟ "
                                        : S.of(context).doYouWantToSaveChanges +
                                            " ?",
                                    negativeButtonText: S.of(context).later,
                                    positiveButtonText: S.of(context).save,
                                    onNegativeClick: () {
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                      profileMobx.reset();
                                    },
                                    onPositiveClick: () async {
                                      Navigator.pop(context);
                                      bool success =
                                          await profileMobx.updateProfile(
                                        context,
                                        profileImage: image,
                                        removedImages: removedImages,
                                      );
                                      if (success)
                                        Navigator.pushReplacementNamed(context,
                                            "profile"); //Navigator.pop(context);
                                      if (widget.onEditSuccess != null)
                                        widget.onEditSuccess!();
                                    },
                                  );
                                },
                              );
                            },
                            child: Container(
                              width: size.width / 4.5,
                              height: size.height / 35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Color(0xffe5003a),
                                  width: 1,
                                ),
                                color: Color(0xffe5003a),
                              ),
                              child: Center(
                                child: Text(
                                  S.of(context).apply,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              if (profileMobx.user != null)
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 18),
                      child: Container(
                        width: size.width / 1.06,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color(0xff292929),
                        ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(16, 14, 16, 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                S.of(context).myPhotos,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 0.90,
                                ),
                              ),
                              SizedBox(height: 12),
                              Container(
                                child: GridView.builder(
                                  shrinkWrap: true,
                                  itemCount: (profileMobx.images ?? []).length <
                                          8
                                      ? (profileMobx.images ?? []).length + 1
                                      : (profileMobx.images ?? []).length,
                                  gridDelegate:
                                      SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: size.width / 4,
                                  ),
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (ctx, index) {
                                    if ((profileMobx.images ?? []).length < 8 &&
                                        index ==
                                            (profileMobx.images ?? []).length) {
                                      return GestureDetector(
                                        onTap: () async {
                                          /*String? imgPath = await pickPhoto(
                                      cropAspectRatioPreset:
                                          CropAspectRatioPreset.ratio16x9,
                                    );*/
                                          String? imgPath = await pickPhoto();
                                          if (imgPath!.length > 0) {
                                            profileMobx.addImage(
                                              UserImageModel(
                                                id: 0,
                                                image: imgPath,
                                                isLocal: true,
                                              ),
                                            );
                                          }
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.all(6),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Color(0xffc4c4c4),
                                            ),
                                            child: Center(
                                              child: Image.asset(
                                                "assets/img/camera.png",
                                                scale: 6,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    } else {
                                      UserImageModel item =
                                          profileMobx.images![index];
                                      return Stack(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(6),
                                            child: item.isLocal ?? false
                                                ? ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0xff212121),
                                                      ),
                                                      child: Container(
                                                          width: size.width / 4,
                                                          height:
                                                              size.width / 4,
                                                          child: Image.file(
                                                            File(item.image!),
                                                            fit: BoxFit.cover,
                                                          )),
                                                    ),
                                                  )
                                                : CachedNetworkImage(
                                                    key: new ValueKey<String>(
                                                        imageUrl),
                                                    imageUrl: item.image ??
                                                        imgPlaceholder,
                                                    imageBuilder: (context,
                                                            imageProvider) =>
                                                        Container(
                                                      decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                          image: imageProvider,
                                                          fit: BoxFit.cover,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                    ),
                                                    progressIndicatorBuilder:
                                                        (context, url,
                                                                progress) =>
                                                            Center(
                                                      child: Wrap(
                                                        alignment: WrapAlignment
                                                            .center,
                                                        children: [
                                                          SizedBox(
                                                            width: 20,
                                                            height: 20,
                                                            child:
                                                                CircularProgressIndicator(
                                                              color: Color(
                                                                  0xffe5003a),
                                                              strokeWidth: 2,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              if (!(item.isLocal ?? false))
                                                removedImages.add(item.id);
                                              profileMobx.removeImage(item);
                                            },
                                            child: Align(
                                              alignment: Alignment.topRight,
                                              child: Container(
                                                width: 16,
                                                height: 16,
                                                decoration: BoxDecoration(
                                                  color: Color(0xff505050),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: Icon(
                                                  Icons.clear,
                                                  color: Colors.white,
                                                  size: 12,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                  },
                                ),
                              ),
                              SizedBox(height: 12),
                            ],
                          ),
                        ),
                      ),
                    ),
                    ContainerEditText(
                      title: S.of(context).aboutMe,
                      text: profileMobx.user!.otherInfo == null
                          ? ""
                          : profileMobx.user!.otherInfo!.about ?? "",
                      onChange: (val) {
                        profileMobx.setAbout(val);
                      },
                    ),
                    ContainerEditText(
                      title: S.of(context).iLookFor,
                      text: profileMobx.user!.otherInfo == null
                          ? ""
                          : profileMobx.user!.otherInfo!.lookingFor ?? "",
                      onChange: (val) {
                        profileMobx.setLookingFor(val);
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      child: Container(
                        width: size.width / 1.06,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color(0xff292929),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 16,
                              ),
                              Text(
                                S.of(context).basicInformation,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 0.90,
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              FilterRow(
                                text: S.of(context).dateOfBirth,
                                text2: profileMobx.dob != null
                                    ? profileMobx.dob!
                                    : profileMobx.user!.otherInfo != null
                                        ? profileMobx.user!.otherInfo!.dob ??
                                            S.of(context).notSpecify
                                        : S.of(context).notSpecify,
                                onTap: () {
                                  var age = profileMobx.dob != null
                                      ? int.parse(profileMobx.dob!)
                                      : profileMobx.user!.otherInfo!.dob != null
                                          ? int.parse(
                                              profileMobx.user!.otherInfo!.dob!)
                                          : 25;

                                  showMaterialNumberPicker(
                                      headerColor: Color(0xff292929),
                                      context: context,
                                      title: S.of(context).PickYourAge,
                                      maxNumber: 65,
                                      minNumber: 18,
                                      selectedNumber: age,
                                      onChanged: (value) => setState(() {
                                            profileMobx
                                                .setDob(value.toString());
                                          }));

                                  // x =
                                },
                              ),
                              FilterRow(
                                text: S.of(context).originCountry,
                                text2: profileMobx.originCountry != null
                                    ? profileMobx.originCountry!.name ?? ""
                                    : profileMobx.user!.otherInfo != null
                                        ? profileMobx.user!.otherInfo!
                                                .originCountry ??
                                            S.of(context).notSpecify
                                        : S.of(context).notSpecify,
                                onTap: () async {
                                  signupMobx.setLang(
                                      Localizations.localeOf(context)
                                          .languageCode
                                          .toString());
                                  pickCountry(
                                    context,
                                    type: S.of(context).origin,
                                    signupMobx: signupMobx,
                                    onSelect: (mobx) {
                                      profileMobx
                                          .setOriginCountry(mobx.originCountry);
                                    },
                                  );
                                },
                              ),
                              FilterRow(
                                text: S.of(context).residenceCountry,
                                text2: profileMobx.residenceCountry != null
                                    ? profileMobx.residenceCountry!.name ??
                                        S.of(context).notSpecify
                                    : profileMobx.user!.otherInfo != null
                                        ? profileMobx.user!.otherInfo!
                                                .residenceCountry ??
                                            S.of(context).notSpecify
                                        : S.of(context).notSpecify,
                                onTap: () async {
                                  signupMobx.setLang(
                                      Localizations.localeOf(context)
                                          .languageCode
                                          .toString());
                                  pickCountry(
                                    context,
                                    type: S.of(context).residenceCountry,
                                    signupMobx: signupMobx,
                                    onSelect: (mobx) {
                                      profileMobx.setResidenceCountry(
                                          mobx.residenceCountry);
                                    },
                                  );
                                },
                              ),
                              FilterRow(
                                text: S.of(context).religion,
                                text2: profileMobx.religion != null
                                    ? profileMobx.religion!.name ??
                                        S.of(context).notSpecify
                                    : profileMobx.user!.otherInfo != null
                                        ? profileMobx
                                                .user!.otherInfo!.religion ??
                                            S.of(context).notSpecify
                                        : S.of(context).notSpecify,
                                onTap: () async {
                                  selectIdName(
                                    context,
                                    type: IdNameType.religion,
                                    list: profileMobx.religions,
                                    profileMobx: profileMobx,
                                    text: S.of(context).religion,
                                  );
                                },
                              ),
                              FilterRow(
                                text: S.of(context).socialType,
                                text2: profileMobx.socialType != null
                                    ? profileMobx.socialType!.name ??
                                        S.of(context).notSpecify
                                    : profileMobx.user!.otherInfo != null
                                        ? profileMobx
                                                .user!.otherInfo!.socialType ??
                                            S.of(context).notSpecify
                                        : S.of(context).notSpecify,
                                onTap: () async {
                                  selectIdName(
                                    context,
                                    type: IdNameType.socialType,
                                    list: profileMobx.socialTypes,
                                    profileMobx: profileMobx,
                                    text: S.of(context).socialType,
                                  );
                                },
                              ),
                              FilterRow(
                                text: S.of(context).typeOfMarriage,
                                text2: profileMobx.marriageType != null
                                    ? profileMobx.marriageType!.name ??
                                        S.of(context).notSpecify
                                    : profileMobx.user!.otherInfo != null
                                        ? profileMobx.user!.otherInfo!
                                                .marriageType ??
                                            S.of(context).notSpecify
                                        : S.of(context).notSpecify,
                                onTap: () async {
                                  selectIdName(
                                    context,
                                    type: IdNameType.marriageType,
                                    list: profileMobx.marriageTypes,
                                    profileMobx: profileMobx,
                                    text: S.of(context).typeOfMarriage,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      child: Container(
                        width: size.width / 1.06,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color(0xff292929),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 16,
                              ),
                              Text(
                                S.of(context).personalInformation,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 0.90,
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              FilterRow(
                                text: S.of(context).education,
                                text2: profileMobx.education != null
                                    ? profileMobx.education!.name ??
                                        S.of(context).notSpecify
                                    : profileMobx.user!.otherInfo != null
                                        ? profileMobx
                                                .user!.otherInfo!.education ??
                                            S.of(context).notSpecify
                                        : S.of(context).notSpecify,
                                onTap: () async {
                                  selectIdName(
                                    context,
                                    type: IdNameType.education,
                                    list: profileMobx.educations,
                                    profileMobx: profileMobx,
                                    text: S.of(context).education,
                                  );
                                },
                              ),
                              FilterRow(
                                text: S.of(context).yourJob,
                                text2: profileMobx.job != null
                                    ? profileMobx.job!.name ??
                                        S.of(context).notSpecify
                                    : profileMobx.user!.otherInfo != null
                                        ? profileMobx.user!.otherInfo!.job ??
                                            S.of(context).notSpecify
                                        : S.of(context).notSpecify,
                                onTap: () async {
                                  selectIdName(
                                    context,
                                    type: IdNameType.job,
                                    list: profileMobx.jobs,
                                    profileMobx: profileMobx,
                                    text: S.of(context).job,
                                  );
                                },
                              ),
                              FilterRow(
                                text: S.of(context).children,
                                text2: profileMobx.children != null
                                    ? profileMobx.children!.name ??
                                        S.of(context).notSpecify
                                    : profileMobx.user!.otherInfo != null
                                        ? profileMobx
                                                .user!.otherInfo!.children ??
                                            S.of(context).notSpecify
                                        : S.of(context).notSpecify,
                                onTap: () async {
                                  selectIdName(
                                    context,
                                    type: IdNameType.children,
                                    list: profileMobx.childrens,
                                    profileMobx: profileMobx,
                                    text: S.of(context).children,
                                  );
                                },
                              ),
                              FilterRow(
                                text: S.of(context).smoking,
                                text2: profileMobx.smoking != null
                                    ? profileMobx.smoking!.name ??
                                        S.of(context).notSpecify
                                    : profileMobx.user!.otherInfo != null
                                        ? profileMobx
                                                .user!.otherInfo!.smoking ??
                                            S.of(context).notSpecify
                                        : S.of(context).notSpecify,
                                onTap: () async {
                                  selectIdName(
                                    context,
                                    type: IdNameType.smokeing,
                                    list: profileMobx.smoke,
                                    profileMobx: profileMobx,
                                    text: S.of(context).smoking,
                                  );
                                },
                              ),
                              FilterRow(
                                text: S.of(context).drink,
                                text2: profileMobx.drinking != null
                                    ? profileMobx.drinking!.name ??
                                        S.of(context).notSpecify
                                    : profileMobx.user!.otherInfo != null
                                        ? profileMobx
                                                .user!.otherInfo!.drinking ??
                                            S.of(context).notSpecify
                                        : S.of(context).notSpecify,
                                onTap: () async {
                                  selectIdName(
                                    context,
                                    type: IdNameType.drinking,
                                    list: profileMobx.drink,
                                    profileMobx: profileMobx,
                                    text: S.of(context).drink,
                                  );
                                },
                              ),
                              FilterRow(
                                  text: S.of(context).language,
                                  isList: profileMobx.languages.length == 0 &&
                                          profileMobx.nativeLangList.length == 0
                                      ? false
                                      : true,
                                  langList:
                                      profileMobx.nativeLangList.length > 0
                                          ? profileMobx.nativeLangList
                                          : profileMobx.languages,
                                  text2: S.of(context).notSpecify,
                                  onTap: () async {
                                    print("3333 ${profileMobx.languages}");

                                    selectLang(
                                      context,
                                      list: profileMobx.languages,
                                      profileMobx: profileMobx,
                                      text: S.of(context).language,
                                    );
                                  }),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      child: Container(
                        width: size.width / 1.06,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color(0xff292929),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 16,
                              ),
                              Text(
                                S.of(context).shape,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 0.90,
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              FilterRow(
                                text: S.of(context).height,
                                text2: profileMobx.height != null
                                    ? "${profileMobx.height!}"
                                    : (profileMobx.user!.otherInfo != null
                                        ? "${profileMobx.user!.otherInfo!.height ?? S.of(context).notSpecify}"
                                        : S.of(context).notSpecify),
                                onTap: () {
                                  dialogTextField(
                                    context,
                                    text: S.of(context).height,
                                    profileMobx: profileMobx,
                                    type: DialogTextFieldType.height,
                                    currentValue: profileMobx.height != null
                                        ? "${profileMobx.height!}"
                                        : (profileMobx.user!.otherInfo != null
                                            ? "${profileMobx.user!.otherInfo!.height ?? ""}"
                                            : S.of(context).notSpecify),
                                    textInputType: TextInputType.number,
                                  );
                                },
                              ),
                              FilterRow(
                                text: S.of(context).skinColor,
                                text2: profileMobx.skinColor != null
                                    ? profileMobx.skinColor!.name ??
                                        S.of(context).notSpecify
                                    : profileMobx.user!.otherInfo != null
                                        ? profileMobx
                                                .user!.otherInfo!.skinColor ??
                                            S.of(context).notSpecify
                                        : "",
                                onTap: () async {
                                  selectIdName(
                                    context,
                                    type: IdNameType.skinColor,
                                    list: profileMobx.skinColors,
                                    profileMobx: profileMobx,
                                    text: S.of(context).skinColor,
                                  );
                                },
                              ),
                              FilterRow(
                                text: S.of(context).body,
                                text2: profileMobx.bodyShape != null
                                    ? profileMobx.bodyShape!.name ??
                                        S.of(context).notSpecify
                                    : profileMobx.user!.otherInfo != null
                                        ? profileMobx.user!.otherInfo!.body ??
                                            S.of(context).notSpecify
                                        : "",
                                onTap: () async {
                                  selectIdName(
                                    context,
                                    type: IdNameType.bodyShape,
                                    list: profileMobx.bodyShapes,
                                    profileMobx: profileMobx,
                                    text: S.of(context).body,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
          bottomNavigationBar: GestureDetector(
            onTap: () {
              print(' plz work ${NavigationRow.global_value ?? 10}');
            },
            child: NavigationRow(
                currentIndex: 8,
                function: () {
                  navIndex();
                }),
          ),
        ),
      ),
    );
  }

  void updateProfile() {}

  @override
  void afterFirstLayout(BuildContext context) {
    getData();
  }

  Future<void> getData() async {
    if (widget.profileMobx == null || widget.profileMobx!.user == null) {
      await profileMobx.getMyProfile(context);
      profileMobx.setImages(profileMobx.user!.images ?? []);
    } else {
      profileMobx.setImages(widget.profileMobx!.user!.images ?? []);
    }
    profileMobx.getEditProfileData(context);
  }
}
