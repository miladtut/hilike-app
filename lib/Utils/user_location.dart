import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hilike/Networking/Mobx/home_mobx.dart';
import 'package:hilike/Networking/Mobx/search_mobx.dart';
import 'package:hilike/Storage/Storage.dart';
import 'package:hilike/Widget/customDialog.dart';
import 'package:hilike/generated/l10n.dart';

class UserLocation {
  final BuildContext context;
  UserLocation(this.context);

  Future<Position?> getUserLocation({bool filter = false}) async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      //Location services are disabled.
      showMessageDialog(context, S.of(context).please_enable_location, filter,
          openLocationSettings: true);
      return null;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      //Location permissions are permantly denied, we cannot request permissions
      showMessageDialog(
          context, S.of(context).location_permission_denied_forever, filter,
          openAppSettings: true);
      return null;
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        // Location permissions are denied
        showMessageDialog(
            context, S.of(context).location_permission_denied, filter,
            reRequestPermissions: true);
      }
      return null;
    }
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      // .timeout(Duration(seconds: 60));
      return position;
    }
    return null;
  }

  Future<void>? showMessageDialog(
      BuildContext context, String message, bool fromFilter,
      {bool openLocationSettings = false,
      bool openAppSettings = false,
      bool reRequestPermissions = false}) {
    fromFilter == true
        ? Future.delayed(Duration(seconds: 1), () {
            // var x = storage.tryToGetLoacation ?? true;
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return CustomDialogg(
                  title: S.of(context).location_permission_denied,
                  negativeButtonText: S.of(context).close,
                  positiveButtonText: openAppSettings
                      ? S.of(context).open_app_settings
                      : openLocationSettings
                          ? S.of(context).open_location_settings
                          : reRequestPermissions
                              ? S.of(context).re_request_location_permissions
                              : S.of(context).okay,
                  onNegativeClick: () {
                    // storage.tryToGetLoacation = false;
                    // Navigator.pop(context);
                    Navigator.pop(context, true);
                  },
                  onPositiveClick: () {
                    Navigator.pop(context);
                    if (openAppSettings) {
                      Geolocator.openAppSettings();
                    } else if (openLocationSettings) {
                      Geolocator.openLocationSettings();
                    } else if (reRequestPermissions) {
                      Geolocator.requestPermission();

                      Geolocator.openAppSettings();
                    }
                  },
                );
              },
            );
          })
        : Future.delayed(Duration(seconds: 6), () {
            print(
                "val : ${storage.tryToGetLoacation}  //   ${(storage.tryToGetLoacation ?? true) == true} ");
            var x = storage.tryToGetLoacation ?? true;
            if (x == true) {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) {
                  return CustomDialogg(
                    title: S.of(context).location_permission_denied,
                    negativeButtonText: S.of(context).close,
                    positiveButtonText: openAppSettings
                        ? S.of(context).open_app_settings
                        : openLocationSettings
                            ? S.of(context).open_location_settings
                            : reRequestPermissions
                                ? S.of(context).re_request_location_permissions
                                : S.of(context).okay,
                    onNegativeClick: () {
                      storage.tryToGetLoacation = false;
                      // Navigator.pop(context);
                      HomeController()
                          .getHome(context, lat: 0, long: 0)
                          .then((value) {
                        Navigator.pop(context, true);
                      });
                    },
                    onPositiveClick: () {
                      Navigator.pop(context);
                      if (openAppSettings) {
                        Geolocator.openAppSettings();
                      } else if (openLocationSettings) {
                        Geolocator.openLocationSettings();
                      } else if (reRequestPermissions) {
                        Geolocator.requestPermission();

                        Geolocator.openAppSettings();
                      }
                    },
                  );
                },
              );
            }
          });
  }
}
