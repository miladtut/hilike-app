import 'package:flutter/material.dart';
import 'package:hilike/Models/account.dart';
import 'package:hilike/Widget/UserInfoBox.dart';
import 'package:hilike/generated/l10n.dart';

class UserDetails extends StatefulWidget {
  final AccountModel user;
  final bool isMyProfile;

  const UserDetails({Key? key, required this.user, this.isMyProfile = true})
      : super(key: key);

  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  late AccountModel user;

  @override
  void initState() {
    super.initState();
    user = widget.user;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
      padding: widget.isMyProfile
          ? const EdgeInsets.fromLTRB(16, 30, 16, 30)
          : const EdgeInsets.fromLTRB(16, 20, 16, 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: widget.isMyProfile ? Color(0xff292929) : Colors.transparent,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!widget.isMyProfile &&
                  (user.otherInfo == null ? "" : user.otherInfo!.about ?? "")
                      .isNotEmpty)
                IntrinsicHeight(
                  child: Row(
                    children: [
                      Column(
                        children: [
                          SizedBox(height: 4),
                          Container(
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                          ),
                          Expanded(
                            child: VerticalDivider(color: Colors.white),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            S.of(context).aboutMe,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w900,
                              letterSpacing: 0.90,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          SizedBox(
                            width: 240,
                            child: Text(
                              user.otherInfo!.about!,
                              style: TextStyle(
                                color: Color(0xffc4c4c4),
                                fontSize: 13,
                              ),
                              maxLines: 20,
                            ),
                          ),
                          SizedBox(height: 24),
                        ],
                      ),
                    ],
                  ),
                ),
              if (!widget.isMyProfile &&
                  (user.otherInfo == null
                          ? ""
                          : user.otherInfo!.lookingFor ?? "")
                      .isNotEmpty)
                IntrinsicHeight(
                  child: Row(
                    children: [
                      Column(
                        children: [
                          // SizedBox(height: 4),
                          SizedBox(
                            height: 3,
                            child: VerticalDivider(
                                color: user.otherInfo!.about != null
                                    ? Colors.white
                                    : Colors.transparent),
                          ),
                          Container(
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                          ),
                          Expanded(
                            child: VerticalDivider(color: Colors.white),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            S.of(context).iAmLookingFor,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w900,
                              letterSpacing: 0.90,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          SizedBox(
                            width: 240,
                            child: Text(
                              user.otherInfo!.lookingFor!,
                              style: TextStyle(
                                color: Color(0xffc4c4c4),
                                fontSize: 13,
                              ),
                            ),
                          ),
                          SizedBox(height: 24),
                        ],
                      ),
                    ],
                  ),
                ),
              IntrinsicHeight(
                child: Row(
                  children: [
                    Column(
                      children: [
                        Visibility(
                          visible: (user.otherInfo!.job == null &&
                                          user.otherInfo!.education == null &&
                                          user.otherInfo!.children == null &&
                                          user.otherInfo!.smoking == null &&
                                          user.otherInfo!.language!.length ==
                                              0 &&
                                          user.otherInfo!.drinking == null) &&
                                      user.otherInfo!.height == null &&
                                      (user.otherInfo!.skinColor == null ||
                                          user.otherInfo!.skinColor!.isEmpty) &&
                                      (user.otherInfo!.body == null ||
                                          user.otherInfo!.body!.isEmpty) ||
                                  widget.isMyProfile == true
                              ? false
                              : true,
                          child: SizedBox(
                            height: 3,
                            child: VerticalDivider(
                                color: user.otherInfo!.about != null ||
                                        user.otherInfo!.lookingFor != null
                                    ? Colors.white
                                    : Colors.transparent),
                          ),
                        ),
                        Container(
                          margin: (user.otherInfo!.job == null &&
                                          user.otherInfo!.education == null &&
                                          user.otherInfo!.children == null &&
                                          user.otherInfo!.smoking == null &&
                                          user.otherInfo!.language!.length ==
                                              0 &&
                                          user.otherInfo!.drinking == null) &&
                                      user.otherInfo!.height == null &&
                                      (user.otherInfo!.skinColor == null ||
                                          user.otherInfo!.skinColor!.isEmpty) &&
                                      (user.otherInfo!.body == null ||
                                          user.otherInfo!.body!.isEmpty) ||
                                  widget.isMyProfile == true
                              ? EdgeInsets.fromLTRB(0, 3, 0, 0)
                              : EdgeInsets.fromLTRB(0, 0, 0, 0),
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                        ),
                        Visibility(
                          visible: (user.otherInfo!.job == null &&
                                      user.otherInfo!.education == null &&
                                      user.otherInfo!.children == null &&
                                      user.otherInfo!.smoking == null &&
                                      user.otherInfo!.language!.length == 0 &&
                                      user.otherInfo!.drinking == null) &&
                                  user.otherInfo!.height == null &&
                                  (user.otherInfo!.skinColor == null ||
                                      user.otherInfo!.skinColor!.isEmpty) &&
                                  (user.otherInfo!.body == null ||
                                      user.otherInfo!.body!.isEmpty)
                              ? false
                              : true,
                          child: Expanded(
                            child: VerticalDivider(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                        Container(
                          width: size.width / 1.4,
                          child: Wrap(
                            children: [
                              UserInfoBox(
                                title: S.of(context).age +
                                    ": " +
                                    (user.otherInfo == null
                                        ? S.of(context).notSpecify
                                        : (user.otherInfo!.dob == null ||
                                                user.otherInfo!.dob!.isEmpty)
                                            ? "null"
                                            : user.otherInfo!.dob!),
                              ),
                              UserInfoBox(
                                title: S.of(context).originCountry +
                                    ": " +
                                    (user.otherInfo == null
                                        ? S.of(context).notSpecify
                                        : (user.otherInfo!.originCountry ==
                                                    null ||
                                                user.otherInfo!.originCountry!
                                                    .isEmpty)
                                            ? "null"
                                            : user.otherInfo!.originCountry!),
                              ),
                              UserInfoBox(
                                title: S.of(context).residenceCountry +
                                    ": " +
                                    (user.otherInfo == null
                                        ? S.of(context).notSpecify
                                        : (user.otherInfo!.residenceCountry ==
                                                    null ||
                                                user.otherInfo!
                                                    .residenceCountry!.isEmpty)
                                            ? "null"
                                            : user
                                                .otherInfo!.residenceCountry!),
                              ),
                              UserInfoBox(
                                title: S.of(context).religion +
                                    ": " +
                                    (user.otherInfo == null
                                        ? S.of(context).notSpecify
                                        : (user.otherInfo!.religion == null ||
                                                user.otherInfo!.religion!
                                                    .isEmpty)
                                            ? "null"
                                            : user.otherInfo!.religion!),
                              ),
                              UserInfoBox(
                                title: S.of(context).socialType +
                                    ": " +
                                    (user.otherInfo == null
                                        ? S.of(context).notSpecify
                                        : (user.otherInfo!.socialType == null ||
                                                user.otherInfo!.socialType!
                                                    .isEmpty)
                                            ? "null"
                                            : user.otherInfo!.socialType!),
                              ),
                              UserInfoBox(
                                title: S.of(context).typeOfMarriage +
                                    ": " +
                                    (user.otherInfo == null
                                        ? S.of(context).notSpecify
                                        : (user.otherInfo!.marriageType ==
                                                    null ||
                                                user.otherInfo!.marriageType!
                                                    .isEmpty)
                                            ? "null"
                                            : user.otherInfo!.marriageType!),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                            height: (user.otherInfo!.job == null &&
                                    user.otherInfo!.education == null &&
                                    user.otherInfo!.children == null &&
                                    user.otherInfo!.smoking == null &&
                                    user.otherInfo!.language!.length == 0 &&
                                    user.otherInfo!.drinking == null)
                                ? 0
                                : 12),
                      ],
                    ),
                  ],
                ),
              ),
              IntrinsicHeight(
                child: Row(
                  children: [
                    Column(
                      children: [
                        Visibility(
                          visible: (user.otherInfo!.job == null &&
                                  user.otherInfo!.education == null &&
                                  user.otherInfo!.children == null &&
                                  user.otherInfo!.smoking == null &&
                                  user.otherInfo!.language!.length == 0 &&
                                  user.otherInfo!.drinking == null)
                              ? false
                              : true,
                          child: SizedBox(
                            height: 3,
                            child: VerticalDivider(color: Colors.white),
                          ),
                        ),
                        Visibility(
                          visible: (user.otherInfo!.job == null &&
                                  user.otherInfo!.education == null &&
                                  user.otherInfo!.children == null &&
                                  user.otherInfo!.smoking == null &&
                                  user.otherInfo!.language!.length == 0 &&
                                  user.otherInfo!.drinking == null)
                              ? false
                              : true,
                          child: Container(
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Visibility(
                              visible: user.otherInfo!.height == null &&
                                      (user.otherInfo!.skinColor == null ||
                                          user.otherInfo!.skinColor!.isEmpty) &&
                                      (user.otherInfo!.body == null ||
                                          user.otherInfo!.body!.isEmpty)
                                  ? false
                                  : true,
                              child: VerticalDivider(color: Colors.white)),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Visibility(
                          visible: (user.otherInfo!.job == null &&
                                  user.otherInfo!.education == null &&
                                  user.otherInfo!.children == null &&
                                  user.otherInfo!.smoking == null &&
                                  user.otherInfo!.language!.length == 0 &&
                                  user.otherInfo!.drinking == null)
                              ? false
                              : true,
                          child: Text(
                            S.of(context).personalInformation,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w900,
                              letterSpacing: 0.90,
                            ),
                          ),
                        ),
                        Container(
                          width: size.width / 1.4,
                          child: Wrap(
                            children: [
                              UserInfoBox(
                                title: S.of(context).job +
                                    ": " +
                                    (user.otherInfo == null
                                        ? S.of(context).notSpecify
                                        : (user.otherInfo!.job == null ||
                                                user.otherInfo!.job!.isEmpty)
                                            ? "null"
                                            : user.otherInfo!.job!),
                              ),
                              UserInfoBox(
                                title: S.of(context).education +
                                    ": " +
                                    (user.otherInfo == null
                                        ? S.of(context).notSpecify
                                        : (user.otherInfo!.education == null ||
                                                user.otherInfo!.education!
                                                    .isEmpty)
                                            ? "null"
                                            : user.otherInfo!.education!),
                              ),
                              UserInfoBox(
                                title: S.of(context).children +
                                    ": " +
                                    (user.otherInfo == null
                                        ? S.of(context).notSpecify
                                        : user.otherInfo!.children == null
                                            ? "null"
                                            : "${user.otherInfo!.children}"),
                              ),
                              UserInfoBox(
                                title: S.of(context).smoking +
                                    ": " +
                                    (user.otherInfo == null
                                        ? "null"
                                        : (user.otherInfo!.smoking == null
                                            ? "null"
                                            : user.otherInfo!.smoking!)),
                              ),
                              UserInfoBox(
                                title: S.of(context).drink +
                                    ": " +
                                    (user.otherInfo == null
                                        ? "null"
                                        : (user.otherInfo!.drinking == null
                                            ? "null"
                                            : user.otherInfo!.drinking!)),
                              ),
                              UserInfoBox(
                                  isList: true,
                                  langList: user.otherInfo!.language,
                                  title: user.otherInfo!.language!.length == 0
                                      ? "null"
                                      : "s"),
                            ],
                          ),
                        ),
                        SizedBox(
                            height: user.otherInfo!.height == null &&
                                    (user.otherInfo!.skinColor == null ||
                                        user.otherInfo!.skinColor!.isEmpty) &&
                                    (user.otherInfo!.body == null ||
                                        user.otherInfo!.body!.isEmpty)
                                ? 0
                                : 12),
                      ],
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: user.otherInfo!.height == null &&
                        (user.otherInfo!.skinColor == null ||
                            user.otherInfo!.skinColor!.isEmpty) &&
                        (user.otherInfo!.body == null ||
                            user.otherInfo!.body!.isEmpty)
                    ? false
                    : true,
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: 5,
                            child: VerticalDivider(color: Colors.white),
                          ),
                          Container(
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                          Container(
                            width: size.width / 1.4,
                            child: Wrap(
                              children: [
                                UserInfoBox(
                                  title: S.of(context).height +
                                      ": " +
                                      (user.otherInfo == null
                                          ? S.of(context).notSpecify
                                          : user.otherInfo!.height == null
                                              ? "null"
                                              : "${user.otherInfo!.height!} ${S.of(context).cm}"),
                                ),
                                UserInfoBox(
                                  title: S.of(context).skinColor +
                                      ": " +
                                      (user.otherInfo == null
                                          ? S.of(context).notSpecify
                                          : (user.otherInfo!.skinColor ==
                                                      null ||
                                                  user.otherInfo!.skinColor!
                                                      .isEmpty)
                                              ? "null"
                                              : user.otherInfo!.skinColor!),
                                ),
                                UserInfoBox(
                                  title: S.of(context).body +
                                      ": " +
                                      (user.otherInfo == null
                                          ? S.of(context).notSpecify
                                          : (user.otherInfo!.body == null ||
                                                  user.otherInfo!.body!.isEmpty)
                                              ? "null"
                                              : user.otherInfo!.body!),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
