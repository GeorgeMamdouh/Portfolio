import 'package:portfolio/config/supabase_config.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ContactMessageException implements Exception {
  final String message;

  const ContactMessageException(this.message);
}

class ContactMessageService {
  const ContactMessageService();

  SupabaseClient get _client => Supabase.instance.client;

  Future<void> saveMessage({
    required String name,
    required String email,
    required String message,
  }) async {
    try {
      await _client.from(SupabaseConfig.contactTable).insert({
        'name': name,
        'email': email,
        'message': message,
      });
    } on PostgrestException catch (error) {
      throw ContactMessageException(_mapPostgrestError(error));
    } on AuthException catch (error) {
      throw ContactMessageException(error.message);
    } catch (_) {
      throw const ContactMessageException(
        'Unexpected error while sending the message.',
      );
    }
  }

  String _mapPostgrestError(PostgrestException error) {
    final message = error.message.toLowerCase();

    if (message.contains('relation') && message.contains('does not exist')) {
      return 'Supabase table "contact_messages" was not found.';
    }
    if (message.contains('permission denied') ||
        message.contains('violates row-level security policy')) {
      return 'Insert is blocked by Supabase RLS policy.';
    }
    if (message.contains('invalid api key') || message.contains('jwt')) {
      return 'Supabase key is invalid or expired.';
    }

    return error.message;
  }
}
