import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/data/profile_data.dart';
import 'package:portfolio/services/contact_message_service.dart';
import 'package:portfolio/theme/app_theme.dart';
import 'package:portfolio/utils/url_utils.dart';
import 'package:portfolio/widgets/custom_button.dart';
import 'package:portfolio/widgets/responsive_layout.dart';
import 'package:portfolio/l10n/app_localizations.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final _contactService = const ContactMessageService();
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _submitForm(AppLocalizations l10n) async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    try {
      await _contactService.saveMessage(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        message: _messageController.text.trim(),
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.messageSentSuccess),
          backgroundColor: AppTheme.secondaryAccent,
        ),
      );

      _nameController.clear();
      _emailController.clear();
      _messageController.clear();
    } on ContactMessageException catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${l10n.messageSendError}\n${error.message}'),
          backgroundColor: Colors.redAccent,
        ),
      );
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.messageSendError),
          backgroundColor: Colors.redAccent,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: ResponsiveLayout.isMobile(context)
          ? null
          : AppBar(title: Text(l10n.getInTouch)),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ResponsiveLayout(
            mobile: _buildContent(context, isDark, l10n, isMobile: true),
            desktop: _buildContent(context, isDark, l10n, isMobile: false),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    bool isDark,
    AppLocalizations l10n, {
    required bool isMobile,
  }) {
    final contactInfo = Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.cards : AppTheme.lightCards,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          _ContactItem(
            iconWidget: const Icon(
              Icons.email_outlined,
              color: AppTheme.primaryAccent,
              size: 24,
            ),
            text: ProfileData.email,
            onTap: () => launchEmailDraft(
              context: context,
              to: ProfileData.email,
              subject: 'Portfolio Contact',
              body: '',
            ),
          ),
          const Divider(height: 32),
          _ContactItem(
            iconWidget: const FaIcon(
              FontAwesomeIcons.linkedinIn,
              color: AppTheme.primaryAccent,
              size: 24,
            ),
            text: ProfileData.linkedInUrl.replaceFirst('https://', ''),
            onTap: () => launchExternalUrl(
              context: context,
              urlString: ProfileData.linkedInUrl,
            ),
          ),
          const Divider(height: 32),
          _ContactItem(
            iconWidget: const FaIcon(
              FontAwesomeIcons.github,
              color: AppTheme.primaryAccent,
              size: 24,
            ),
            text: ProfileData.githubUrl.replaceFirst('https://', ''),
            onTap: () => launchExternalUrl(
              context: context,
              urlString: ProfileData.githubUrl,
            ),
          ),
        ],
      ),
    );

    final contactForm = Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.cards : AppTheme.lightCards,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.sendMeMessage,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: l10n.name,
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              validator: (value) => (value == null || value.trim().isEmpty)
                  ? l10n.pleaseEnterName
                  : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: l10n.email,
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              validator: (value) {
                final trimmed = value?.trim() ?? '';
                if (trimmed.isEmpty ||
                    !trimmed.contains('@') ||
                    !trimmed.contains('.')) {
                  return l10n.pleaseEnterValidEmail;
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _messageController,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: l10n.message,
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              validator: (value) => (value == null || value.trim().isEmpty)
                  ? l10n.pleaseEnterMessage
                  : null,
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 50,
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: AppTheme.primaryAccent,
                      ),
                    )
                  : CustomButton(
                      text: l10n.sendMessage,
                      icon: Icons.send,
                      onPressed: () => _submitForm(l10n),
                    ),
            ),
          ],
        ),
      ),
    );

    return Column(
      children: [
        Text(
          l10n.letsWorkTogether,
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ).animate().fadeIn().slideY(begin: -0.2, end: 0),

        const SizedBox(height: 16),

        Text(
          l10n.contactSubtitle,
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(color: AppTheme.textSecondary),
          textAlign: TextAlign.center,
        ).animate().fadeIn(delay: 200.ms).slideY(begin: -0.2, end: 0),

        const SizedBox(height: 48),

        if (isMobile) ...[
          contactInfo.animate().fadeIn(delay: 300.ms),
          const SizedBox(height: 32),
          contactForm
              .animate()
              .fadeIn(delay: 400.ms)
              .slideY(begin: 0.1, end: 0),
        ] else ...[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: contactInfo.animate().fadeIn(delay: 300.ms),
              ),
              const SizedBox(width: 32),
              Expanded(
                flex: 2,
                child: contactForm
                    .animate()
                    .fadeIn(delay: 400.ms)
                    .slideY(begin: 0.1, end: 0),
              ),
            ],
          ),
        ],
        const SizedBox(height: 96),
      ],
    );
  }
}

class _ContactItem extends StatelessWidget {
  final Widget iconWidget;
  final String text;
  final VoidCallback onTap;

  const _ContactItem({
    required this.iconWidget,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppTheme.primaryAccent.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: iconWidget,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: AppTheme.textSecondary,
            ),
          ],
        ),
      ),
    );
  }
}
