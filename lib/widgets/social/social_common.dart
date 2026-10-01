import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/social_post.dart';
import '../../providers/person_provider.dart';

void showSocialSnackBar(BuildContext context, String msg, {SnackBarAction? action}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(msg),
        action: action,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 3),
      ),
    );
}

/// Returns true when a user is signed in. Otherwise shows a snackbar with a
/// shortcut to the login screen and returns false, so callers can bail out of
/// actions the social API only allows for authenticated users.
bool requireSocialSignIn(BuildContext context, {String action = 'do that'}) {
  if (context.read<ProfileProvider>().profile != null) return true;

  showSocialSnackBar(
    context,
    'Sign in to $action.',
    action: SnackBarAction(
      label: 'Sign in',
      onPressed: () => Navigator.pushNamed(context, '/login'),
    ),
  );
  return false;
}

class SocialAvatar extends StatelessWidget {
  final SocialAuthor author;
  final double radius;

  const SocialAvatar({super.key, required this.author, this.radius = 20});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final photoUrl = author.photoUrl;

    return CircleAvatar(
      radius: radius,
      backgroundColor: theme.colorScheme.primaryContainer,
      backgroundImage: photoUrl != null ? NetworkImage(photoUrl) : null,
      child: photoUrl == null
          ? Text(
              author.initials,
              style: TextStyle(
                fontSize: radius * 0.7,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onPrimaryContainer,
              ),
            )
          : null,
    );
  }
}

/// Author name followed by verified agent / surveyor badges.
class SocialAuthorName extends StatelessWidget {
  final SocialAuthor author;
  final double fontSize;

  const SocialAuthorName({super.key, required this.author, this.fontSize = 13});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Text(
            author.name ?? 'Unknown user',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize),
          ),
        ),
        if (author.verifiedAgent == true) ...[
          const SizedBox(width: 4),
          Tooltip(
            message: 'Verified agent',
            child: Icon(
              Icons.verified,
              size: fontSize + 2,
              color: theme.colorScheme.primary,
            ),
          ),
        ],
        if (author.verifiedSurveyor == true) ...[
          const SizedBox(width: 4),
          Tooltip(
            message: 'Verified surveyor',
            child: Icon(
              Icons.architecture,
              size: fontSize + 2,
              color: theme.colorScheme.secondary,
            ),
          ),
        ],
      ],
    );
  }
}
