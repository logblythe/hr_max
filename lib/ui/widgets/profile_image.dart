import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hrmax/core/services/api_service.dart';

class ProfileImage extends StatelessWidget {
  final double size;
  final int userId;
  final String name;

  const ProfileImage({Key key, this.size, this.userId, this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 0.1,
          blurRadius: 7,
          offset: Offset(0, 1), // changes position of shadow
        ),
      ]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(80),
        child: CachedNetworkImage(
            height: size ?? 80,
            width: size ?? 80,
            imageUrl:
                "${ApiService.baseUrl}/Company/getProfilePhoto?paramSessionUserId=${userId}",
            placeholder: (context, url) =>
                Center(child: CircularProgressIndicator()),
            errorWidget: (context, string, d) {
              return Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.withOpacity(0.5)),
                child: Center(
                  child: Text(
                    getInitials(name),
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              );
            }),
      ),
    );
  }

  String getInitials(String name) {
    List<String> names = name.split(" ");
    String initials = "";
    int numWords = 2;

    if (numWords < names.length) {
      numWords = names.length;
    }

    try {
      for (var i = 0; i < numWords; i++) {
        initials += '${names[i][0]}';
      }
    } catch (e) {
      initials = name.substring(0, 1);
    }

    return initials;
  }
}
