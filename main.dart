import 'package:flutter/material.dart';

void main() {
  runApp(const SafeSecurityApp());
}

class SafeSecurityApp extends StatelessWidget {
  const SafeSecurityApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Safe Security',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF031326),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF20E6A1),
          brightness: Brightness.dark,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF08233F),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFF16558A)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFF16558A)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFF20E6A1), width: 1.5),
          ),
        ),
      ),
      home: const AppShell(),
    );
  }
}

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int index = 0;

  final pages = const [
    HomePage(),
    ToolsPage(),
    AlertsPage(),
    MorePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: pages[index]),
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (value) => setState(() => index = value),
        backgroundColor: const Color(0xFF041A31),
        indicatorColor: const Color(0xFF0B6A54),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.build_outlined), selectedIcon: Icon(Icons.build), label: 'Tools'),
          NavigationDestination(icon: Icon(Icons.notifications_none), selectedIcon: Icon(Icons.notifications), label: 'Alerts'),
          NavigationDestination(icon: Icon(Icons.menu), selectedIcon: Icon(Icons.menu_open), label: 'More'),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void open(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      children: [
        Row(
          children: [
            const ShieldLogo(size: 46),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                'Safe Security',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
              ),
            ),
            IconButton(
              onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('You have no new security notifications.')),
              ),
              icon: const Icon(Icons.notifications_none),
            ),
          ],
        ),
        const SizedBox(height: 20),
        const Text('Hello!', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800)),
        const Text('Stay alert. Stay safe.', style: TextStyle(color: Colors.white70)),
        const SizedBox(height: 16),
        Card(
          color: const Color(0xFF079A71),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 27,
                  backgroundColor: Colors.white24,
                  child: Icon(Icons.verified_user, color: Colors.white, size: 30),
                ),
                const SizedBox(width: 14),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("You're Protected", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: 4),
                      Text('Use the tools below to improve your security.', style: TextStyle(color: Colors.white70)),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right),
              ],
            ),
          ),
        ),
        const SizedBox(height: 18),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.18,
          children: [
            ToolCard(icon: Icons.key, title: 'Password\nChecker', onTap: () => open(context, const PasswordCheckerPage())),
            ToolCard(icon: Icons.link, title: 'Phishing\nLink Checker', onTap: () => open(context, const LinkCheckerPage())),
            ToolCard(icon: Icons.warning_amber_rounded, title: 'Scam\nAlerts', onTap: () => open(context, const AlertsPage())),
            ToolCard(icon: Icons.shield_outlined, title: 'Security\nCheckup', onTap: () => open(context, const SecurityCheckupPage())),
            ToolCard(icon: Icons.menu_book_outlined, title: 'Account\nGuides', onTap: () => open(context, const GuidesPage())),
            ToolCard(icon: Icons.support, title: 'Hacked Account\nHelp', onTap: () => open(context, const RecoveryPage())),
          ],
        ),
        const SizedBox(height: 22),
        const InfoCard(
          icon: Icons.lock_outline,
          title: 'Privacy first',
          text: 'This demo does not send passwords or personal account data to a server.',
        ),
      ],
    );
  }
}

class ToolsPage extends StatelessWidget {
  const ToolsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const PageTitle('Security Tools'),
        const SizedBox(height: 16),
        LargeAction(icon: Icons.key, title: 'Password Checker', subtitle: 'Check strength locally on this device', page: const PasswordCheckerPage()),
        LargeAction(icon: Icons.link, title: 'Phishing Link Checker', subtitle: 'Look for common suspicious URL patterns', page: const LinkCheckerPage()),
        LargeAction(icon: Icons.shield, title: 'Security Checkup', subtitle: 'Review your account-safety checklist', page: const SecurityCheckupPage()),
        LargeAction(icon: Icons.menu_book, title: 'Account Guides', subtitle: 'Learn safer 2FA and recovery practices', page: const GuidesPage()),
        LargeAction(icon: Icons.emergency, title: 'Hacked Account Help', subtitle: 'Steps to take if an account may be compromised', page: const RecoveryPage()),
      ],
    );
  }
}

class PasswordCheckerPage extends StatefulWidget {
  const PasswordCheckerPage({super.key});

  @override
  State<PasswordCheckerPage> createState() => _PasswordCheckerPageState();
}

class _PasswordCheckerPageState extends State<PasswordCheckerPage> {
  final controller = TextEditingController();
  bool obscure = true;
  int score = 0;

  void check() {
    final p = controller.text;
    int s = 0;
    if (p.length >= 12) s++;
    if (p.length >= 16) s++;
    if (RegExp(r'[A-Z]').hasMatch(p)) s++;
    if (RegExp(r'[a-z]').hasMatch(p)) s++;
    if (RegExp(r'\d').hasMatch(p)) s++;
    if (RegExp(r'[^A-Za-z0-9]').hasMatch(p)) s++;
    if (RegExp(r'(123456|password|qwerty|admin)', caseSensitive: false).hasMatch(p)) s -= 2;
    setState(() => score = s.clamp(0, 6));
  }

  String get label {
    if (score <= 1) return 'Very weak';
    if (score <= 3) return 'Needs improvement';
    if (score <= 5) return 'Good';
    return 'Strong';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Password Checker')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Center(child: Icon(Icons.lock, size: 70, color: Color(0xFF20E6A1))),
          const SizedBox(height: 10),
          const Text('Check Your Password Strength', textAlign: TextAlign.center, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('Your password is checked locally. Do not enter a password you use for a sensitive account if you are uncomfortable testing it here.', textAlign: TextAlign.center, style: TextStyle(color: Colors.white70)),
          const SizedBox(height: 24),
          TextField(
            controller: controller,
            obscureText: obscure,
            onChanged: (_) => check(),
            decoration: InputDecoration(
              hintText: 'Enter a password',
              suffixIcon: IconButton(
                onPressed: () => setState(() => obscure = !obscure),
                icon: Icon(obscure ? Icons.visibility : Icons.visibility_off),
              ),
            ),
          ),
          const SizedBox(height: 14),
          FilledButton.icon(
            onPressed: check,
            icon: const Icon(Icons.security),
            label: const Text('Check Strength'),
          ),
          if (controller.text.isNotEmpty) ...[
            const SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    LinearProgressIndicator(value: score / 6, minHeight: 10),
                    const SizedBox(height: 14),
                    const Text('Good password habits', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    const Tip('Use 12+ characters; longer is better.'),
                    const Tip('Mix words with numbers and symbols.'),
                    const Tip('Avoid names, dates and common phrases.'),
                    const Tip('Never reuse an important password.'),
                    const Tip('Use a reputable password manager when possible.'),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class LinkCheckerPage extends StatefulWidget {
  const LinkCheckerPage({super.key});

  @override
  State<LinkCheckerPage> createState() => _LinkCheckerPageState();
}

class _LinkCheckerPageState extends State<LinkCheckerPage> {
  final controller = TextEditingController();
  String result = '';

  void check() {
    final raw = controller.text.trim();
    Uri? uri;
    try {
      uri = Uri.parse(raw);
    } catch (_) {}

    if (raw.isEmpty) {
      setState(() => result = 'Paste a link first.');
      return;
    }

    final host = uri?.host.toLowerCase() ?? '';
    final suspicious = raw.contains('@') ||
        raw.contains('xn--') ||
        RegExp(r'http://', caseSensitive: false).hasMatch(raw) ||
        RegExp(r'(login|verify|secure|update|gift|free|wallet|password)', caseSensitive: false).hasMatch(host) ||
        host.isEmpty;

    setState(() {
      result = suspicious
          ? '⚠️ Be careful: this URL contains patterns commonly seen in suspicious links. Do not enter passwords, OTPs or card details. Verify the sender and open the service from its official app/site.'
          : 'No obvious red flags were detected by this simple local check. This does NOT prove the link is safe. For important accounts, open the official app/site directly instead.';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Phishing Link Checker')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Center(child: Icon(Icons.link, size: 70, color: Color(0xFF3B8DFF))),
          const SizedBox(height: 10),
          const Text('Check Suspicious Links', textAlign: TextAlign.center, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('This is a basic heuristic checker, not a malware scanner or guarantee of safety.', textAlign: TextAlign.center, style: TextStyle(color: Colors.white70)),
          const SizedBox(height: 24),
          TextField(controller: controller, keyboardType: TextInputType.url, decoration: const InputDecoration(hintText: 'Paste link here...')),
          const SizedBox(height: 14),
          FilledButton(onPressed: check, child: const Text('Check Link')),
          if (result.isNotEmpty) ...[
            const SizedBox(height: 18),
            InfoCard(icon: result.startsWith('⚠️') ? Icons.warning : Icons.verified, title: 'Result', text: result),
          ],
          const SizedBox(height: 18),
          const InfoCard(icon: Icons.lightbulb_outline, title: 'Stay alert', text: 'Even a link that looks normal can be dangerous. Never share OTPs or passwords through links sent by strangers.'),
        ],
      ),
    );
  }
}

class AlertsPage extends StatelessWidget {
  const AlertsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scam Alerts')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: const [
          PageTitle('Common Scam Warnings'),
          SizedBox(height: 14),
          AlertCard(icon: Icons.sms_failed, title: 'Fake KYC / verification messages', text: 'Do not use unexpected links asking you to update KYC, verify identity or share OTPs.'),
          AlertCard(icon: Icons.card_giftcard, title: 'Prize and lucky-draw scams', text: 'A surprise prize that requires a fee, OTP or card details is a major warning sign.'),
          AlertCard(icon: Icons.account_balance, title: 'Bank impersonation', text: 'Banks do not need your ATM PIN or OTP over an unsolicited call. Use the official bank app or number.'),
          AlertCard(icon: Icons.work_outline, title: 'Fake job offers', text: 'Be cautious when recruiters ask for upfront payments, crypto transfers or sensitive documents through unofficial channels.'),
        ],
      ),
    );
  }
}

class SecurityCheckupPage extends StatefulWidget {
  const SecurityCheckupPage({super.key});

  @override
  State<SecurityCheckupPage> createState() => _SecurityCheckupPageState();
}

class _SecurityCheckupPageState extends State<SecurityCheckupPage> {
  final checks = <String, bool>{
    'I use unique passwords': true,
    'Two-factor authentication is enabled': false,
    'My recovery email/phone is current': true,
    'I review active sessions/devices': false,
    'I avoid unknown links and attachments': true,
  };

  @override
  Widget build(BuildContext context) {
    final done = checks.values.where((x) => x).length;
    final percent = done / checks.length;
    return Scaffold(
      appBar: AppBar(title: const Text('Security Checkup')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Center(
            child: SizedBox(
              width: 150, height: 150,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(width: 140, height: 140, child: CircularProgressIndicator(value: percent, strokeWidth: 10)),
                  Text('${(percent * 100).round()}%', style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Center(child: Text('Security score', style: TextStyle(color: Colors.white70))),
          const SizedBox(height: 18),
          ...checks.entries.map((entry) => Card(
            child: SwitchListTile(
              value: entry.value,
              onChanged: (value) => setState(() => checks[entry.key] = value),
              title: Text(entry.key),
              secondary: Icon(entry.value ? Icons.check_circle : Icons.warning_amber_rounded),
            ),
          )),
        ],
      ),
    );
  }
}

class GuidesPage extends StatelessWidget {
  const GuidesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Account Guides')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const PageTitle('Protect Your Accounts'),
          const SizedBox(height: 14),
          GuideCard(
            title: 'Enable 2FA',
            text: 'Open the official account app → Settings → Security → Two-factor authentication. Prefer an authenticator app or passkey when supported.',
          ),
          GuideCard(
            title: 'Check active sessions',
            text: 'Review logged-in devices regularly. Sign out devices you do not recognize, then change your password and enable 2FA if needed.',
          ),
          GuideCard(
            title: 'Protect your recovery options',
            text: 'Keep your recovery email and phone number current. Store backup codes somewhere secure and never share them.',
          ),
          GuideCard(
            title: 'Avoid social-engineering traps',
            text: 'Urgency, threats, secrecy, prizes and requests for OTPs are common scam signals. Pause and verify through an official channel.',
          ),
        ],
      ),
    );
  }
}

class RecoveryPage extends StatelessWidget {
  const RecoveryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hacked Account Help')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Center(child: Icon(Icons.support, size: 70, color: Color(0xFF20E6A1))),
          const SizedBox(height: 10),
          const Text('Think your account was hacked?', textAlign: TextAlign.center, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 18),
          const StepCard(number: '1', title: 'Change the password', text: 'Use a new, unique password from the official account app/site.'),
          const StepCard(number: '2', title: 'Sign out unknown sessions', text: 'Remove unfamiliar devices and sessions from the account security page.'),
          const StepCard(number: '3', title: 'Enable 2FA or a passkey', text: 'Add a second layer of protection after securing the password.'),
          const StepCard(number: '4', title: 'Use official recovery', text: 'If you are locked out, use only the platform’s official recovery flow. Never pay a stranger who promises to recover the account.'),
          const SizedBox(height: 14),
          const InfoCard(icon: Icons.warning_amber, title: 'Never share', text: 'OTP codes, recovery codes, passwords, card PINs or remote-access codes with anyone claiming to be support.'),
        ],
      ),
    );
  }
}

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const PageTitle('More'),
        const SizedBox(height: 16),
        const InfoCard(icon: Icons.privacy_tip_outlined, title: 'Privacy', text: 'Safe Security is designed as a local-first demo. Do not collect passwords, OTPs or private account credentials.'),
        const SizedBox(height: 12),
        const InfoCard(icon: Icons.info_outline, title: 'About', text: 'Safe Security 1.0 — cybersecurity awareness and account-protection toolkit.'),
        const SizedBox(height: 12),
        Card(
          child: ListTile(
            leading: const Icon(Icons.delete_outline),
            title: const Text('Clear local screen data'),
            subtitle: const Text('This demo keeps no account credentials.'),
            onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('There is no saved credential data to delete.'))),
          ),
        ),
      ],
    );
  }
}

class ShieldLogo extends StatelessWidget {
  final double size;
  const ShieldLogo({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size, height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size * .25),
        gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF1688FF), Color(0xFF20E6A1)]),
      ),
      child: Icon(Icons.shield, color: Colors.white, size: size * .62),
    );
  }
}

class ToolCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  const ToolCard({super.key, required this.icon, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 34, color: const Color(0xFF3B8DFF)),
              const SizedBox(height: 10),
              Text(title, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w700)),
            ],
          ),
        ),
      ),
    );
  }
}

class LargeAction extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Widget page;
  const LargeAction({super.key, required this.icon, required this.title, required this.subtitle, required this.page});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: CircleAvatar(child: Icon(icon)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => page)),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String text;
  const InfoCard({super.key, required this.icon, required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: const Color(0xFF20E6A1)),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              Text(text, style: const TextStyle(color: Colors.white70, height: 1.35)),
            ])),
          ],
        ),
      ),
    );
  }
}

class AlertCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String text;
  const AlertCard({super.key, required this.icon, required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.all(14),
        leading: CircleAvatar(child: Icon(icon)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Padding(padding: const EdgeInsets.only(top: 5), child: Text(text)),
      ),
    );
  }
}

class GuideCard extends StatelessWidget {
  final String title;
  final String text;
  const GuideCard({super.key, required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        children: [Text(text, style: const TextStyle(color: Colors.white70, height: 1.4))],
      ),
    );
  }
}

class StepCard extends StatelessWidget {
  final String number;
  final String title;
  final String text;
  const StepCard({super.key, required this.number, required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(child: Text(number)),
            const SizedBox(width: 14),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 5),
              Text(text, style: const TextStyle(color: Colors.white70, height: 1.35)),
            ])),
          ],
        ),
      ),
    );
  }
}

class Tip extends StatelessWidget {
  final String text;
  const Tip(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle, size: 18, color: Color(0xFF20E6A1)),
          const SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}

class PageTitle extends StatelessWidget {
  final String text;
  const PageTitle(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(text, style: const TextStyle(fontSize: 27, fontWeight: FontWeight.w800));
  }
}
