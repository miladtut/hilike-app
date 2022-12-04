import 'dart:io';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hilike/Models/chat_listner.dart';
import 'package:hilike/Models/message_support.dart';
import 'package:hilike/Networking/Firebase/FirebaseApi.dart';
import 'package:hilike/Networking/Mobx/profile_mobx.dart';
import 'package:hilike/Networking/Mobx/user_mobx.dart';
import 'package:hilike/Storage/Storage.dart';
import 'package:hilike/Utils/constants.dart';
import 'package:hilike/Widget/Appbar60.dart';
import 'package:hilike/Widget/ContainerText.dart';
import 'package:hilike/Widget/Message_Support_Widget.dart';
import 'package:hilike/Widget/SupportButton.dart';
import 'package:hilike/extensions.dart';
import 'package:hilike/generated/l10n.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart' as intl;
import 'dart:ui' as ui;
import 'package:path/path.dart' as p;

import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class SupportTeam extends StatefulWidget {
  @override
  _SupportTeamState createState() => _SupportTeamState();
}

class _SupportTeamState extends State<SupportTeam>
    with SingleTickerProviderStateMixin, AfterLayoutMixin {
  bool _hasbeenPressed = true;
  ProfileMobx profileMobx = ProfileController();
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  final TextEditingController chatController = TextEditingController();

  var image;
  bool isfirstmassage = true;

  List<int?> removedImages = [];
  Future<String?> pickPhoto() async {
    final _picker = ImagePicker();
    XFile? _pickedImage = await _picker.pickImage(source: ImageSource.gallery);

    return _pickedImage?.path;
  }

  UserMobx userMobx = UserController();

  int clicknum = 0;
  String problem = "";
  Future<File> testCompressAndGetFile(String path) async {
    String targetPath = p.join((await getTemporaryDirectory()).path,
        '${DateTime.now()}.${p.extension(path)}');

    var result = await FlutterImageCompress.compressAndGetFile(
      path,
      targetPath,
      quality: 70,
    );

    // print(file.lengthSync());
    print(result!.lengthSync());

    return result;
  }

  var textDirection;
  var textDirection2;
  var textDirection3;
  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(
      context,
    )!
        .settings
        .arguments as List;
    Provider.of<ChatListner>(context, listen: false).setIsOpen(true);
    Provider.of<ChatListner>(context, listen: false)
        .setChatThread("s${storage.account.id}");
    Size size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async {
        Provider.of<ChatListner>(context, listen: false).setIsOpen(false);
        Provider.of<ChatListner>(context, listen: false).setChatThread("");
        return true;
      },
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Observer(
          builder: (_) => Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(70),
                child: Appbar60(
                  title: S.of(context).supportTeam,
                ),
              ),
              body: Column(
                // shrinkWrap: true,
                children: [
                  SizedBox(
                    height: size.height / 50,
                  ),
                  Visibility(
                    visible: isfirstmassage == true ? false : true,
                    child: ContainerText(
                      title: S.of(context).Sendmessagetous,
                      text: S.of(context).welcomeToHilikeIfYouHoveAnyProblem,
                    ),
                  ),
                  Expanded(
                    child: Container(
                        padding: EdgeInsets.all(10),
                        child: StreamBuilder<List<MessageSupport>>(
                          stream: FirebaseApi.getSupportMessages(
                              chatThread:
                                  "s${storage.account.id}"), //get my id  + userid
                          builder: (context, snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.waiting:
                                return Container();
                              default:
                                if (snapshot.hasError) {
                                  //showTopSnackBar(S.of(context).somethingIsWrong,
                                  //    "assets/img/iii.png");

                                  return Container();
                                } else {
                                  List<MessageSupport>? messages =
                                      snapshot.data;

                                  if ((messages ?? []).isEmpty) {
                                    WidgetsBinding.instance!
                                        .addPostFrameCallback((_) {
                                      // executes after build
                                      setState(() {
                                        isfirstmassage = false;
                                      });
                                    });
                                    return Container();
                                  } else {
                                    isfirstmassage = true;

                                    int i = 0;
                                    int j = 0;
                                    int lastSenderId = -1;
                                    DateTime? lastCreatedAt;
                                    // if (lastone == null) {
                                    List<MessageSupport> groupedMessages = [];

                                    // }
                                    for (MessageSupport message in messages!) {
                                      DateTime date = message.createdAt;
                                      DateTime dateWithoutSeconds = DateTime(
                                          date.year,
                                          date.month,
                                          date.day,
                                          date.hour,
                                          date.minute);
                                      if (lastSenderId == -1)
                                        lastSenderId = message.senderId;
                                      if (lastCreatedAt == null)
                                        lastCreatedAt = dateWithoutSeconds;
                                      if (lastSenderId == message.senderId &&
                                          lastCreatedAt == dateWithoutSeconds) {
                                        groupedMessages
                                            .add(message.copyWith(type: i));
                                        i++;
                                        j++;
                                      } else {
                                        if (j > 0)
                                          groupedMessages.last.type = -2;
                                        else
                                          groupedMessages.last.type = -1;
                                        i = 0;
                                        j = 0;
                                        groupedMessages
                                            .add(message.copyWith(type: i));
                                        i++;
                                      }
                                      lastSenderId = message.senderId;
                                      lastCreatedAt = dateWithoutSeconds;
                                    }
                                    groupedMessages.last.type = -2;

                                    return ListView.builder(
                                      physics: BouncingScrollPhysics(),
                                      reverse: true,
                                      itemCount: groupedMessages.length,
                                      itemBuilder: (context, index) {
                                        final message = groupedMessages[index];

                                        // FirebaseApi.updateMessageStatus(
                                        bool visable = index == 0
                                            ? true
                                            : intl.DateFormat('MM/dd/yyyy')
                                                        .format(groupedMessages[
                                                                index - 1]
                                                            .createdAt) !=
                                                    intl.DateFormat(
                                                            'MM/dd/yyyy')
                                                        .format(groupedMessages[
                                                                index]
                                                            .createdAt)
                                                ? true
                                                : false;

                                        return MessageSupportWidget(
                                          lastdate: index ==
                                                  groupedMessages.length - 1
                                              ? "true"
                                              : intl.DateFormat('MM/dd/yyyy')
                                                  .format(
                                                      groupedMessages[index + 1]
                                                          .createdAt),
                                          date: intl.DateFormat('MM/dd/yyyy')
                                              .format(groupedMessages[index]
                                                  .createdAt),
                                          visable: visable,
                                          secondimg: imgSupport,
                                          mePlan: arguments[1],
                                          message: message,
                                          isMe: message.senderId ==
                                              storage.account.id,
                                          locale:
                                              Localizations.localeOf(context)
                                                  .languageCode,
                                          isgift: message.giftId != 0
                                              ? true
                                              : false,
                                        );
                                      },
                                    );
                                  }
                                }
                            }
                          },
                        )),
                  )
                ],
              ),
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (int i = 0; i < userMobx.catlist.length; i++)
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    clicknum = userMobx.catlist[i].id!;
                                    problem = userMobx.catlist[i].name!;
                                  });
                                  clicknum != 0
                                      ? userMobx.chooseChatCat(
                                          context, clicknum.toString())
                                      : print(".");
                                },
                                child: SupportButton(
                                  text: userMobx.catlist[i].name!,
                                  number: userMobx.catlist[i].id!,
                                  clicknum: clicknum,
                                ),
                              ),
                          ],
                        )),
                    SizedBox(
                      height: 15,
                    ),
                    Directionality(
                      textDirection: ui.TextDirection.ltr,
                      child: Container(
                        width: size.width / 1,
                        // height: size.height / 14,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color(0xcc292929),
                        ),
                        child: TextFormField(
                          textDirection: textDirection3,
                          onChanged: (val) {
                            RegExp regex = new RegExp("[a-zA-Z]");

                            if (val.length > 0 && val.length < 2) {
                              if (val.substring(0, 1) != " ") {
                                regex.hasMatch(val.substring(0, 1))
                                    ? setState(() {
                                        textDirection3 = TextDirection.ltr;
                                      })
                                    : setState(() {
                                        textDirection3 = TextDirection.rtl;
                                      });
                              } else if (val.length == 2) {
                                if (val.substring(0, 1) == " " &&
                                    val.substring(1, 2) != " ")
                                  regex.hasMatch(val.substring(1, 2))
                                      ? setState(() {
                                          textDirection3 = TextDirection.ltr;
                                        })
                                      : setState(() {
                                          textDirection3 = TextDirection.rtl;
                                        });
                              } else if (val.length > 2) {
                                regex.hasMatch(val.substring(
                                        val.lastIndexOf(" ") + 1,
                                        val.lastIndexOf(" ") + 2))
                                    ? setState(() {
                                        textDirection3 = TextDirection.ltr;
                                      })
                                    : setState(() {
                                        textDirection3 = TextDirection.rtl;
                                      });
                              }
                            }
                          },
                          cursorColor: Color(0xffe5003a),
                          controller: chatController,
                          style: TextStyle(color: Colors.white),
                          textInputAction: TextInputAction.newline,
                          maxLines: 5,
                          minLines: 1,
                          decoration: InputDecoration(
                            hintText: S.of(context).writeMessage,
                            hintStyle: TextStyle(
                              color: Color(0xff949393),
                              fontSize: 13,
                              letterSpacing: 0.65,
                            ),
                            isDense: true,
                            prefixIcon: IconButton(
                              highlightColor: Colors.transparent,
                              onPressed: () {
                                image = pickPhoto().then((value) async {
                                  print("**552** ${value}");
                                  var x = await testCompressAndGetFile(value!);

                                  await userMobx.uploadChatImage(
                                      context, x.path);

                                  print('test222  ${userMobx.imageId}');

                                  print('test222  ${userMobx.uploadlink}');

                                  if (isfirstmassage == false) {
                                    await userMobx.createChatThread(
                                        context,
                                        "null",
                                        storage.account.id.toString(),
                                        "s" + storage.account.id.toString());

                                    FirebaseApi.sendMessageSupport(
                                        "s" + storage.account.id.toString(),
                                        userMobx.uploadlink!,
                                        userMobx.imageId!.toInt(),
                                        "");
                                  } else {
                                    FirebaseApi.sendMessageSupport(
                                        "s" + storage.account.id.toString(),
                                        userMobx.uploadlink!,
                                        userMobx.imageId!.toInt(),
                                        "");
                                  }
                                });
                              },
                              icon: Center(
                                  child: Image.asset("assets/img/attach.png")),
                            ),
                            suffixIcon: IconButton(
                              highlightColor: Colors.transparent,
                              onPressed: () async {
                                // await profileMobx.updateProfile(
                                //       context,
                                //       profileImage: image,
                                //       removedImages: removedImages,
                                //     );

                                if (chatController.text.trim().isNotEmpty) {
                                  isfirstmassage == false
                                      ? await userMobx.createChatThread(
                                          context,
                                          "null",
                                          storage.account.id.toString(),
                                          "s" + storage.account.id.toString())
                                      : print("wow");
                                  await FirebaseApi.sendMessageSupport(
                                      "s" + storage.account.id.toString(),
                                      chatController.text.trim(),
                                      0,
                                      problem);
                                  //     .then((value) {
                                  //   groupedMessages!.insert(0, value);
                                  //   print(groupedMessages!.length);
                                  //   setState(() {});
                                  // });

                                  chatController.clear();
                                  if (problem.length > 0) {
                                    setState(() {
                                      problem = "";
                                    });
                                  }
                                }
                              },
                              icon: Image.asset("assets/img/enter.png"),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    userMobx.getCatlist(context);
  }
}
