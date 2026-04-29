import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> launchExternalUrl({
  required BuildContext context,
  required String urlString,
}) async {
  final uri = Uri.tryParse(urlString);
  if (uri == null) {
    _showError(context, 'Invalid URL');
    return;
  }

  final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
  if (!launched && context.mounted) {
    _showError(context, 'Unable to open link');
  }
}

Future<void> launchEmailDraft({
  required BuildContext context,
  required String to,
  required String subject,
  required String body,
}) async {
  final uri = Uri(
    scheme: 'mailto',
    path: to,
    queryParameters: <String, String>{'subject': subject, 'body': body},
  );

  final launched = await launchUrl(uri);
  if (!launched && context.mounted) {
    _showError(context, 'Unable to open email app');
  }
}

void _showError(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}
