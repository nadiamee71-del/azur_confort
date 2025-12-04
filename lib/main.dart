import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:html' as html;
import 'dart:convert';

// Imports pour la localisation
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';

// ============================================================================
// CONSTANTES DE COULEURS - PALETTE BLEU / BLANC / JAUNE-ORANGÉ
// ============================================================================

// Bleus (froid / climatisation / frigoriste)
const Color kPrimaryBlue = Color(0xFF2196F3);
const Color kDarkBlue = Color(0xFF1565C0);
const Color kLightBlue = Color(0xFFE3F2FD);
const Color kIceBlue = Color(0xFFBBDEFB);

// Jaune-Orangé (chaud / chauffage / feu)
const Color kAccentOrange = Color(0xFFFF9800);
const Color kAccentYellow = Color(0xFFFFB300);
const Color kWarmOrange = Color(0xFFE65100);

// ============================================================================
// THÈME CLAIR - Couleurs
// ============================================================================
const Color kLightBackground = Color(0xFFFFFFFF);
const Color kLightSurface = Color(0xFFF8F9FA);
const Color kLightCard = Color(0xFFFFFFFF);
const Color kLightTextPrimary = Color(0xFF111111);
const Color kLightTextSecondary = Color(0xFF5F6368);

// Fond blanc/gris très clair (legacy - à remplacer progressivement)
const Color kBackgroundColor = Color(0xFFFAFAFA);
const Color kWhite = Color(0xFFFFFFFF);

// ============================================================================
// THÈME SOMBRE - Couleurs (Bleu nuit profond)
// ============================================================================
const Color kDarkBackground = Color(0xFF020817);
const Color kDarkSurface = Color(0xFF111827);
const Color kDarkCard = Color(0xFF1E293B);
const Color kDarkTextPrimary = Color(0xFFFFFFFF);
const Color kDarkTextSecondary = Color(0xFFE5E7EB);

// ============================================================================
// THÈMES COMPLETS
// ============================================================================

/// Thème clair complet
ThemeData buildLightTheme() {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: kPrimaryBlue,
      onPrimary: Colors.white,
      secondary: kAccentYellow,
      onSecondary: Colors.black,
      surface: kLightCard,
      onSurface: kLightTextPrimary,
      background: kLightBackground,
      onBackground: kLightTextPrimary,
      surfaceVariant: kLightSurface,
      onSurfaceVariant: kLightTextSecondary,
      outline: Color(0xFFE0E0E0),
      error: Colors.red,
      onError: Colors.white,
    ),
    scaffoldBackgroundColor: kLightBackground,
    fontFamily: 'Segoe UI',
    appBarTheme: const AppBarTheme(
      backgroundColor: kLightCard,
      foregroundColor: kDarkBlue,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
    ),
    cardTheme: const CardThemeData(
      color: kLightCard,
      elevation: 0,
    ),
    dividerColor: const Color(0xFFE0E0E0),
    iconTheme: const IconThemeData(color: kLightTextSecondary),
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: kLightTextPrimary),
      displayMedium: TextStyle(color: kLightTextPrimary),
      displaySmall: TextStyle(color: kLightTextPrimary),
      headlineLarge: TextStyle(color: kLightTextPrimary),
      headlineMedium: TextStyle(color: kLightTextPrimary),
      headlineSmall: TextStyle(color: kLightTextPrimary),
      titleLarge: TextStyle(color: kLightTextPrimary),
      titleMedium: TextStyle(color: kLightTextPrimary),
      titleSmall: TextStyle(color: kLightTextPrimary),
      bodyLarge: TextStyle(color: kLightTextPrimary),
      bodyMedium: TextStyle(color: kLightTextPrimary),
      bodySmall: TextStyle(color: kLightTextSecondary),
      labelLarge: TextStyle(color: kLightTextPrimary),
      labelMedium: TextStyle(color: kLightTextSecondary),
      labelSmall: TextStyle(color: kLightTextSecondary),
    ),
  );
}

/// Thème sombre complet
ThemeData buildDarkTheme() {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: kPrimaryBlue,
      onPrimary: Colors.white,
      secondary: kAccentYellow,
      onSecondary: Colors.black,
      surface: kDarkSurface,
      onSurface: kDarkTextPrimary,
      background: kDarkBackground,
      onBackground: kDarkTextPrimary,
      surfaceVariant: kDarkCard,
      onSurfaceVariant: kDarkTextSecondary,
      outline: Color(0xFF374151),
      error: Color(0xFFEF4444),
      onError: Colors.white,
    ),
    scaffoldBackgroundColor: kDarkBackground,
    fontFamily: 'Segoe UI',
    appBarTheme: const AppBarTheme(
      backgroundColor: kDarkSurface,
      foregroundColor: kDarkTextPrimary,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
    ),
    cardTheme: const CardThemeData(
      color: kDarkCard,
      elevation: 0,
    ),
    dividerColor: const Color(0xFF374151),
    iconTheme: const IconThemeData(color: kDarkTextSecondary),
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: kDarkTextPrimary),
      displayMedium: TextStyle(color: kDarkTextPrimary),
      displaySmall: TextStyle(color: kDarkTextPrimary),
      headlineLarge: TextStyle(color: kDarkTextPrimary),
      headlineMedium: TextStyle(color: kDarkTextPrimary),
      headlineSmall: TextStyle(color: kDarkTextPrimary),
      titleLarge: TextStyle(color: kDarkTextPrimary),
      titleMedium: TextStyle(color: kDarkTextPrimary),
      titleSmall: TextStyle(color: kDarkTextPrimary),
      bodyLarge: TextStyle(color: kDarkTextPrimary),
      bodyMedium: TextStyle(color: kDarkTextPrimary),
      bodySmall: TextStyle(color: kDarkTextSecondary),
      labelLarge: TextStyle(color: kDarkTextPrimary),
      labelMedium: TextStyle(color: kDarkTextSecondary),
      labelSmall: TextStyle(color: kDarkTextSecondary),
    ),
  );
}

// ============================================================================
// PERSISTANCE DU THÈME (localStorage pour Web)
// ============================================================================

/// Sauvegarde le choix du thème dans localStorage
void saveThemePreference(bool isDarkMode) {
  if (kIsWeb) {
    html.window.localStorage['azur_confort_dark_mode'] = isDarkMode.toString();
  }
}

/// Charge le choix du thème depuis localStorage
bool loadThemePreference() {
  if (kIsWeb) {
    final saved = html.window.localStorage['azur_confort_dark_mode'];
    if (saved != null) {
      return saved == 'true';
    }
  }
  return false; // Mode clair par défaut
}

// ============================================================================
// PERSISTANCE DE LA LANGUE (localStorage pour Web)
// ============================================================================

/// Liste des langues supportées
const List<Locale> kSupportedLocales = [
  Locale('fr'), // Français (par défaut)
  Locale('en'), // Anglais
  Locale('es'), // Espagnol
  Locale('de'), // Allemand
  Locale('it'), // Italien
];

/// Noms des langues pour l'affichage
const Map<String, String> kLanguageNames = {
  'fr': 'Français',
  'en': 'English',
  'es': 'Español',
  'de': 'Deutsch',
  'it': 'Italiano',
};

/// Codes courts des langues
const Map<String, String> kLanguageCodes = {
  'fr': 'FR',
  'en': 'EN',
  'es': 'ES',
  'de': 'DE',
  'it': 'IT',
};

/// Sauvegarde le choix de la langue dans localStorage
void saveLocalePreference(String languageCode) {
  if (kIsWeb) {
    html.window.localStorage['azur_confort_locale'] = languageCode;
  }
}

/// Charge le choix de la langue depuis localStorage
Locale loadLocalePreference() {
  if (kIsWeb) {
    final saved = html.window.localStorage['azur_confort_locale'];
    if (saved != null && kSupportedLocales.any((l) => l.languageCode == saved)) {
      return Locale(saved);
    }
  }
  return const Locale('fr'); // Français par défaut
}

// ============================================================================
// NUMÉRO DE TÉLÉPHONE
// ============================================================================
const String kPhoneNumber = '0746559768';
const String kPhoneNumberFormatted = '07 46 55 97 68';

/// Ouvre le numéro de téléphone (appel)
/// Utilise window.location.href pour les liens tel: (plus fiable)
void launchPhone() {
  if (kIsWeb) {
    html.window.location.href = 'tel:$kPhoneNumber';
  }
}

/// Ouvre WhatsApp avec le numéro
void launchWhatsApp() {
  if (kIsWeb) {
    html.window.open('https://wa.me/33${kPhoneNumber.substring(1)}', '_blank');
  }
}

/// Ouvre le client email
void launchEmail() {
  if (kIsWeb) {
    html.window.location.href = 'mailto:contact@azur-confort.fr';
  }
}

// ============================================================================
// POINT D'ENTRÉE
// ============================================================================

void main() {
  runApp(const AzurConfortApp());
}

// ============================================================================
// APPLICATION PRINCIPALE - STATEFUL POUR GESTION DU THÈME
// ============================================================================

class AzurConfortApp extends StatefulWidget {
  const AzurConfortApp({Key? key}) : super(key: key);

  @override
  State<AzurConfortApp> createState() => _AzurConfortAppState();
}

class _AzurConfortAppState extends State<AzurConfortApp> {
  bool _isDarkMode = false;
  Locale _currentLocale = const Locale('fr');

  @override
  void initState() {
    super.initState();
    // Charger les préférences sauvegardées
    _isDarkMode = loadThemePreference();
    _currentLocale = loadLocalePreference();
  }

  void toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
      // Sauvegarder la préférence
      saveThemePreference(_isDarkMode);
    });
  }

  void changeLocale(Locale newLocale) {
    setState(() {
      _currentLocale = newLocale;
      // Sauvegarder la préférence
      saveLocalePreference(newLocale.languageCode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Azur Confort - Artisan Frigoriste',
      
      // ============================================================
      // CONFIGURATION DE LA LOCALISATION
      // ============================================================
      locale: _currentLocale,
      supportedLocales: kSupportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      // Fallback sur le français si la langue du navigateur n'est pas supportée
      localeResolutionCallback: (locale, supportedLocales) {
        // Si on a une locale définie, l'utiliser
        if (supportedLocales.contains(_currentLocale)) {
          return _currentLocale;
        }
        // Sinon, essayer de matcher avec la langue du navigateur
        if (locale != null) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale.languageCode) {
              return supportedLocale;
            }
          }
        }
        // Par défaut, français
        return const Locale('fr');
      },
      
      // Thème clair
      theme: buildLightTheme(),
      // Thème sombre
      darkTheme: buildDarkTheme(),
      // Sélection du thème
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: AzurConfortHome(
        isDarkMode: _isDarkMode,
        onToggleTheme: toggleTheme,
        currentLocale: _currentLocale,
        onChangeLocale: changeLocale,
      ),
    );
  }
}

// ============================================================================
// PAGE PRINCIPALE
// ============================================================================

class AzurConfortHome extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback onToggleTheme;
  final Locale currentLocale;
  final Function(Locale) onChangeLocale;

  const AzurConfortHome({
    super.key,
    required this.isDarkMode,
    required this.onToggleTheme,
    required this.currentLocale,
    required this.onChangeLocale,
  });

  @override
  State<AzurConfortHome> createState() => _AzurConfortHomeState();
}

class _AzurConfortHomeState extends State<AzurConfortHome> {
  int _selectedPageIndex = 0;

  // Clé globale pour permettre la navigation depuis les enfants
  static _AzurConfortHomeState? _instance;

  @override
  void initState() {
    super.initState();
    _instance = this;
  }

  /// Permet de naviguer vers une page depuis n'importe où
  static void navigateToPage(int index) {
    _instance?._goToPage(index);
  }

  void _goToPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 700;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = widget.isDarkMode;
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        shadowColor: colorScheme.shadow.withOpacity(0.05),
        surfaceTintColor: Colors.transparent,
        toolbarHeight: 70,
        title: Row(
          children: [
            // ============================================================
            // LOGO DESIGN - INTERRUPTEUR JOUR/NUIT (DARK MODE)
            // ============================================================
            Tooltip(
              message: widget.isDarkMode ? 'Passer en mode jour ☀️' : 'Passer en mode nuit 🌙',
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: widget.onToggleTheme,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: widget.isDarkMode 
                            ? [const Color(0xFF1A237E), const Color(0xFF3949AB)] // Bleu nuit
                            : [kPrimaryBlue, kDarkBlue],
                      ),
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: widget.isDarkMode 
                              ? const Color(0xFF3949AB).withOpacity(0.4)
                              : kPrimaryBlue.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: colorScheme.surface,
                        borderRadius: BorderRadius.circular(11),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Icône flocon (froid) ou lune (nuit)
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            transitionBuilder: (child, animation) => ScaleTransition(
                              scale: animation,
                              child: child,
                            ),
                            child: Icon(
                              widget.isDarkMode ? Icons.nightlight_round : Icons.ac_unit,
                              key: ValueKey(widget.isDarkMode ? 'moon' : 'snow'),
                              color: widget.isDarkMode ? const Color(0xFFFFD54F) : kPrimaryBlue,
                              size: 20,
                            ),
                          ),
                          Container(
                            width: 1,
                            height: 16,
                            margin: const EdgeInsets.symmetric(horizontal: 6),
                            color: colorScheme.outline.withOpacity(0.5),
                          ),
                          // Icône flamme (chaud) ou soleil (jour)
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            transitionBuilder: (child, animation) => ScaleTransition(
                              scale: animation,
                              child: child,
                            ),
                            child: Icon(
                              widget.isDarkMode ? Icons.wb_sunny : Icons.local_fire_department,
                              key: ValueKey(widget.isDarkMode ? 'sun' : 'fire'),
                              color: kAccentOrange,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),
            // Nom de l'entreprise
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: widget.isDarkMode 
                        ? [kDarkTextPrimary, kPrimaryBlue]
                        : [kDarkBlue, kPrimaryBlue],
                  ).createShader(bounds),
                  child: Text(
                    'AZUR',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: isMobile ? 16 : 20,
                      letterSpacing: 2,
                      height: 1,
                    ),
                  ),
                ),
                Text(
                  'CONFORT',
                  style: TextStyle(
                    color: kAccentOrange,
                    fontWeight: FontWeight.w600,
                    fontSize: isMobile ? 10 : 12,
                    letterSpacing: 3,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          // Navigation - version adaptative
          if (!isMobile) ...[
            _buildNavButton(AppLocalizations.of(context)?.navHome ?? 'Accueil', 0, Icons.home_outlined),
            _buildNavButton(AppLocalizations.of(context)?.navAbout ?? 'À propos', 1, Icons.info_outline),
            _buildNavButton(AppLocalizations.of(context)?.navContact ?? 'Contact', 2, Icons.mail_outline),
            const SizedBox(width: 8),
            // Sélecteur de langue
            _buildLanguageSelector(context),
            const SizedBox(width: 16),
          ] else ...[
            // Sélecteur de langue compact pour mobile
            _buildLanguageSelectorMobile(context),
            const SizedBox(width: 8),
            // Menu hamburger pour mobile
            PopupMenuButton<int>(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isDark ? colorScheme.surfaceVariant : kLightBlue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.menu, color: colorScheme.onSurface),
              ),
              offset: const Offset(0, 50),
              color: colorScheme.surface,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              onSelected: (index) => setState(() => _selectedPageIndex = index),
              itemBuilder: (context) => [
                _buildPopupMenuItem(0, AppLocalizations.of(context)?.navHome ?? 'Accueil', Icons.home_outlined),
                _buildPopupMenuItem(1, AppLocalizations.of(context)?.navAbout ?? 'À propos', Icons.info_outline),
                _buildPopupMenuItem(2, AppLocalizations.of(context)?.navContact ?? 'Contact', Icons.mail_outline),
              ],
            ),
            const SizedBox(width: 12),
          ],
        ],
      ),
      body: Stack(
        children: [
          // Pages principales
          IndexedStack(
            index: _selectedPageIndex,
            children: const [
              _AccueilPage(),
              _AProposPage(),
              _ContactPage(),
              _MentionsLegalesPage(),
            ],
          ),
          // Chatbot flottant (toujours visible)
          const AzurChatbot(),
        ],
      ),
    );
  }

  PopupMenuItem<int> _buildPopupMenuItem(int index, String text, IconData icon) {
    final isSelected = _selectedPageIndex == index;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return PopupMenuItem<int>(
      value: index,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isSelected 
                    ? colorScheme.primary.withOpacity(0.1) 
                    : colorScheme.surfaceVariant,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: isSelected 
                    ? colorScheme.primary 
                    : colorScheme.onSurfaceVariant,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              text,
              style: TextStyle(
                color: isSelected 
                    ? colorScheme.primary 
                    : colorScheme.onSurface,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                fontSize: 15,
              ),
            ),
            if (isSelected) ...[
              const Spacer(),
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: colorScheme.primary,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildNavButton(String text, int index, IconData icon) {
    final isSelected = _selectedPageIndex == index;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => setState(() => _selectedPageIndex = index),
          borderRadius: BorderRadius.circular(12),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              gradient: isSelected
                  ? const LinearGradient(colors: [kPrimaryBlue, kDarkBlue])
                  : null,
              color: isSelected ? null : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              border: isSelected
                  ? null
                  : Border.all(
                      color: colorScheme.outline, 
                      width: 1.5,
                    ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: colorScheme.primary.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ]
                  : null,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  size: 18,
                  color: isSelected 
                      ? Colors.white 
                      : colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 8),
                Text(
                  text,
                  style: TextStyle(
                    color: isSelected 
                        ? Colors.white 
                        : colorScheme.onSurface,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SÉLECTEUR DE LANGUE - VERSION DESKTOP
  // ============================================================
  Widget _buildLanguageSelector(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final currentLangCode = widget.currentLocale.languageCode.toUpperCase();
    
    return PopupMenuButton<Locale>(
      tooltip: AppLocalizations.of(context)?.languageSelector ?? 'Langue',
      offset: const Offset(0, 50),
      color: colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onSelected: (locale) => widget.onChangeLocale(locale),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: colorScheme.surfaceVariant.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: colorScheme.outline.withOpacity(0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.language,
              size: 18,
              color: colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: 6),
            Text(
              currentLangCode,
              style: TextStyle(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.keyboard_arrow_down,
              size: 18,
              color: colorScheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
      itemBuilder: (context) => kSupportedLocales.map((locale) {
        final isSelected = locale.languageCode == widget.currentLocale.languageCode;
        return PopupMenuItem<Locale>(
          value: locale,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: isSelected 
                        ? colorScheme.primary.withOpacity(0.1)
                        : colorScheme.surfaceVariant.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      kLanguageCodes[locale.languageCode] ?? locale.languageCode.toUpperCase(),
                      style: TextStyle(
                        color: isSelected ? colorScheme.primary : colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  kLanguageNames[locale.languageCode] ?? locale.languageCode,
                  style: TextStyle(
                    color: isSelected ? colorScheme.primary : colorScheme.onSurface,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
                if (isSelected) ...[
                  const Spacer(),
                  Icon(Icons.check, color: colorScheme.primary, size: 18),
                ],
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  // ============================================================
  // SÉLECTEUR DE LANGUE - VERSION MOBILE (compact)
  // ============================================================
  Widget _buildLanguageSelectorMobile(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final currentLangCode = widget.currentLocale.languageCode.toUpperCase();
    
    return PopupMenuButton<Locale>(
      tooltip: AppLocalizations.of(context)?.languageSelector ?? 'Langue',
      offset: const Offset(0, 50),
      color: colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onSelected: (locale) => widget.onChangeLocale(locale),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: colorScheme.surfaceVariant.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.language,
              size: 18,
              color: colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: 4),
            Text(
              currentLangCode,
              style: TextStyle(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
      itemBuilder: (context) => kSupportedLocales.map((locale) {
        final isSelected = locale.languageCode == widget.currentLocale.languageCode;
        return PopupMenuItem<Locale>(
          value: locale,
          child: Row(
            children: [
              Text(
                kLanguageCodes[locale.languageCode] ?? locale.languageCode.toUpperCase(),
                style: TextStyle(
                  color: isSelected ? colorScheme.primary : colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                kLanguageNames[locale.languageCode] ?? locale.languageCode,
                style: TextStyle(
                  color: isSelected ? colorScheme.primary : colorScheme.onSurface,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  fontSize: 13,
                ),
              ),
              if (isSelected) ...[
                const Spacer(),
                Icon(Icons.check, color: colorScheme.primary, size: 16),
              ],
            ],
          ),
        );
      }).toList(),
    );
  }
}

// ============================================================================
// PAGE ACCUEIL - DESIGN WAOUH
// ============================================================================

class _AccueilPage extends StatelessWidget {
  const _AccueilPage();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // HERO SECTION (compact)
          _buildHeroSection(context),
          // NOS SERVICES DÉTAILLÉS (remonté, sans doublon)
          _buildServicesSection(context),
          // ZONES D'INTERVENTION
          _buildZonesSection(context),
          // POURQUOI NOUS
          _buildWhyUsSection(context),
          // SECTION SEO - Texte optimisé pour le référencement
          _buildSeoSection(context),
          // FOOTER
          _buildFooter(context),
        ],
      ),
    );
  }

  // ======================== HERO SECTION ========================
  // Photo de fond avec overlay bleu semi-transparent
  Widget _buildHeroSection(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 800;

    return Container(
      width: double.infinity,
      // Hauteur réduite pour un hero plus compact
      constraints: BoxConstraints(
        minHeight: isMobile ? 400 : 480,
      ),
      child: Stack(
        fit: StackFit.passthrough,
        children: [
          // ============================================================
          // IMAGE DE FOND - Photo chauffage/artisan
          // Alignement adaptatif pour garder la partie importante visible
          // - Desktop : aligné à droite pour voir l'artisan/clim
          // - Mobile : centré
          // ============================================================
          Positioned.fill(
            child: Image.asset(
              'assets/images/service_chauffage.png',
              fit: BoxFit.cover,
              // Alignement adaptatif : sur grand écran, on privilégie le côté droit
              // où se trouve généralement l'artisan/la climatisation
              alignment: isMobile ? Alignment.center : Alignment.centerRight,
              // Gestion d'erreur si l'image n'existe pas
              errorBuilder: (context, error, stackTrace) {
                // Fallback : dégradé bleu si pas d'image
                return Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF0D47A1),
                        Color(0xFF1565C0),
                        Color(0xFF1E88E5),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          
          // ============================================================
          // OVERLAY BLEU LÉGER - On voit bien la photo
          // ============================================================
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF0D47A1).withOpacity(0.55),
                    const Color(0xFF1565C0).withOpacity(0.45),
                    const Color(0xFF1E88E5).withOpacity(0.40),
                  ],
                ),
              ),
            ),
          ),
          
          // ============================================================
          // DECOR BACKGROUND ICONS IMPROVED - Motifs décoratifs (cercles)
          // Très discrets, adaptés au thème jour/nuit
          // ============================================================
          Positioned(
            top: -100,
            right: -100,
            child: Opacity(
              opacity: 0.04, // DECOR BACKGROUND ICON IMPROVED - très discret
              child: Container(
                width: 380,
                height: 380,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).colorScheme.onSurface, // DECOR BACKGROUND ICON IMPROVED
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -150,
            left: -150,
            child: Opacity(
              opacity: 0.03, // DECOR BACKGROUND ICON IMPROVED - très discret
              child: Container(
                width: 450,
                height: 450,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).colorScheme.onSurface, // DECOR BACKGROUND ICON IMPROVED
                ),
              ),
            ),
          ),
          
          // ============================================================
          // DECOR BACKGROUND ICONS IMPROVED - Flocons décoratifs
          // Icônes très discrètes, adaptées au thème, taille réduite
          // ============================================================
          ...List.generate(6, (i) => Positioned( // DECOR BACKGROUND ICON IMPROVED - réduit à 6 icônes
            top: 60.0 + (i * 70),
            left: (i.isEven ? 40.0 : screenWidth - 90) + (i * 25 % 180),
            child: Opacity(
              opacity: 0.08, // DECOR BACKGROUND ICON IMPROVED - très discret (8%)
              child: Icon(
                Icons.ac_unit,
                color: Theme.of(context).colorScheme.onSurface, // DECOR BACKGROUND ICON IMPROVED
                size: (25 + (i * 4).toDouble()) * 0.85, // DECOR BACKGROUND ICON IMPROVED - taille réduite
              ),
            ),
          )),
          
          // Contenu principal - padding réduit pour hero compact
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 24 : 80,
              vertical: isMobile ? 40 : 60,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: isMobile
                    ? _buildHeroContentMobile()
                    : _buildHeroContentDesktop(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroContentDesktop(BuildContext context) {
    return Row(
      children: [
        // Texte à gauche
        Expanded(
          flex: 6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  color: kAccentYellow,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: kAccentYellow.withOpacity(0.4),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.bolt, color: Colors.black87, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Intervention rapide 06 & 83',
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              // Titre
              const Text(
                'Votre confort,',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 56,
                  fontWeight: FontWeight.w300,
                  height: 1.1,
                ),
              ),
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [Colors.white, kAccentYellow],
                ).createShader(bounds),
                child: const Text(
                  'notre priorité.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 56,
                    fontWeight: FontWeight.bold,
                    height: 1.1,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Sous-titre
              Text(
                'Climatisation • Pompes à chaleur • Plomberie • Chauffage',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Artisan frigoriste qualifié sur toute la Côte d\'Azur',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 40),
              // Boutons
              Row(
                children: [
                  _buildHeroButton(
                    'Appeler maintenant',
                    Icons.phone,
                    true,
                  ),
                  const SizedBox(width: 16),
                  _buildHeroButton(
                    'Demander un devis',
                    Icons.description_outlined,
                    false,
                  ),
                ],
              ),
              const SizedBox(height: 48),
              // Stats
              Row(
                children: [
                  _buildStat('10+', 'Ans d\'expérience'),
                  const SizedBox(width: 48),
                  _buildStat('500+', 'Clients satisfaits'),
                  const SizedBox(width: 48),
                  _buildStat('24h', 'Intervention rapide'),
                ],
              ),
            ],
          ),
        ),
        // Illustration à droite - DECOR BACKGROUND ICON IMPROVED
        Expanded(
          flex: 4,
          child: _buildHeroIllustration(context),
        ),
      ],
    );
  }

  Widget _buildHeroContentMobile() {
    return Column(
      children: [
        // Badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: kAccentYellow,
            borderRadius: BorderRadius.circular(30),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.bolt, color: Colors.black87, size: 18),
              SizedBox(width: 6),
              Text(
                'Intervention rapide 06 & 83',
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        // Titre
        const Text(
          'Votre confort,',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 36,
            fontWeight: FontWeight.w300,
          ),
        ),
        const Text(
          'notre priorité.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: kAccentYellow,
            fontSize: 36,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Climatisation • PAC • Plomberie • Chauffage',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white.withOpacity(0.9),
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 32),
        // Boutons
        _buildHeroButton('Appeler maintenant', Icons.phone, true),
        const SizedBox(height: 12),
        _buildHeroButton('Demander un devis', Icons.description_outlined, false),
        const SizedBox(height: 32),
        // Stats en ligne
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildStatMobile('10+', 'Ans'),
            _buildStatMobile('500+', 'Clients'),
            _buildStatMobile('24h', 'Réponse'),
          ],
        ),
      ],
    );
  }

  Widget _buildHeroButton(String text, IconData icon, bool isPrimary) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: isPrimary
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ]
            : null,
      ),
      child: ElevatedButton.icon(
        onPressed: () {
          if (isPrimary) {
            // Appeler maintenant
            launchPhone();
          } else {
            // Demander un devis - naviguer vers la page Contact
            _AzurConfortHomeState.navigateToPage(2);
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: isPrimary ? Colors.white : Colors.transparent,
          foregroundColor: isPrimary ? kDarkBlue : Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: isPrimary ? Colors.transparent : Colors.white,
              width: 2,
            ),
          ),
          elevation: 0,
        ),
        icon: Icon(icon, size: 22),
        label: Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildStat(String value, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: const TextStyle(
            color: kAccentYellow,
            fontSize: 36,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildStatMobile(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: kAccentYellow,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // DECOR BACKGROUND ICON IMPROVED - Illustration Hero
  // Icônes très discrètes, adaptées au thème jour/nuit
  // ============================================================
  Widget _buildHeroIllustration(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(40),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // DECOR BACKGROUND ICON IMPROVED - Cercle de fond très discret
          Opacity(
            opacity: 0.12, // DECOR BACKGROUND ICON IMPROVED
            child: Container(
              width: 280,
              height: 280,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    colorScheme.onSurface.withOpacity(0.15), // DECOR BACKGROUND ICON IMPROVED
                    colorScheme.onSurface.withOpacity(0.05), // DECOR BACKGROUND ICON IMPROVED
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          // DECOR BACKGROUND ICON IMPROVED - Icône principale très discrète
          Opacity(
            opacity: 0.10, // DECOR BACKGROUND ICON IMPROVED
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colorScheme.onSurface.withOpacity(0.08), // DECOR BACKGROUND ICON IMPROVED
                border: Border.all(
                  color: colorScheme.onSurface.withOpacity(0.12), // DECOR BACKGROUND ICON IMPROVED
                  width: 1.5,
                ),
              ),
              child: Icon(
                Icons.ac_unit,
                size: 80, // DECOR BACKGROUND ICON IMPROVED - taille réduite
                color: colorScheme.onSurface.withOpacity(0.15), // DECOR BACKGROUND ICON IMPROVED
              ),
            ),
          ),
          // DECOR BACKGROUND ICON IMPROVED - Icônes orbitales très discrètes
          ..._buildOrbitalIcons(context),
        ],
      ),
    );
  }

  // DECOR BACKGROUND ICON IMPROVED - Icônes orbitales
  List<Widget> _buildOrbitalIcons(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final icons = [
      Icons.thermostat,
      Icons.water_drop,
      Icons.local_fire_department,
      Icons.build,
    ];
    return List.generate(4, (i) {
      return Positioned(
        left: 150 + 100 * (i == 0 || i == 3 ? 1 : -1).toDouble(), // DECOR BACKGROUND ICON IMPROVED - rayon réduit
        top: 150 + 100 * (i < 2 ? -1 : 1).toDouble(), // DECOR BACKGROUND ICON IMPROVED - rayon réduit
        child: Opacity(
          opacity: 0.12, // DECOR BACKGROUND ICON IMPROVED - très discret
          child: Container(
            padding: const EdgeInsets.all(12), // DECOR BACKGROUND ICON IMPROVED - padding réduit
            decoration: BoxDecoration(
              color: colorScheme.onSurface.withOpacity(0.08), // DECOR BACKGROUND ICON IMPROVED
              shape: BoxShape.circle,
              border: Border.all(
                color: colorScheme.onSurface.withOpacity(0.10), // DECOR BACKGROUND ICON IMPROVED
                width: 1,
              ),
            ),
            child: Icon(
              icons[i],
              color: colorScheme.onSurface.withOpacity(0.20), // DECOR BACKGROUND ICON IMPROVED
              size: 22, // DECOR BACKGROUND ICON IMPROVED - taille réduite
            ),
          ),
        ),
      );
    });
  }

  // ======================== SERVICES RAPIDES ========================
  Widget _buildQuickServices(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    // Services avec couleurs bleu (froid) et orange (chaud)
    final services = [
      {'icon': Icons.ac_unit, 'title': 'Climatisation', 'color': kPrimaryBlue},
      {'icon': Icons.severe_cold, 'title': 'Frigoriste', 'color': kDarkBlue},
      {'icon': Icons.local_fire_department, 'title': 'Chauffage', 'color': kAccentOrange},
      {'icon': Icons.thermostat, 'title': 'Pompe à chaleur', 'color': kAccentYellow},
      {'icon': Icons.water_drop, 'title': 'Plomberie', 'color': kPrimaryBlue},
    ];

    return Transform.translate(
      offset: const Offset(0, -50),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1000),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: colorScheme.shadow.withOpacity(0.08),
                    blurRadius: 40,
                    offset: const Offset(0, 20),
                  ),
                ],
              ),
              child: Row(
                children: services.map((s) => Expanded(
                  child: _buildQuickServiceItem(
                    context,
                    s['icon'] as IconData,
                    s['title'] as String,
                    s['color'] as Color,
                  ),
                )).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuickServiceItem(BuildContext context, IconData icon, String title, Color color) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: color, size: 32),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  // ======================== SERVICES AVEC ONGLETS ========================
  Widget _buildServicesSection(BuildContext context) {
    return const _ServicesTabSection();
  }

  // ======================== ZONES D'INTERVENTION ========================
  Widget _buildZonesSection(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 900;
    
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 40),
      padding: const EdgeInsets.symmetric(vertical: 60),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            kPrimaryBlue.withOpacity(0.03),
            const Color(0xFF7C4DFF).withOpacity(0.03),
          ],
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1300),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                _buildSectionTitle(context,
                  'Zones d\'intervention',
                  'Climatisation et plomberie dans les Alpes-Maritimes (06) et le Var (83)',
                ),
                const SizedBox(height: 48),
                // Cartes géographiques
                if (isMobile)
                  Column(
                    children: [
                      _buildMapCard06(context),
                      const SizedBox(height: 24),
                      _buildMapCard83(context),
                    ],
                  )
                else
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _buildMapCard06(context)),
                      const SizedBox(width: 24),
                      Expanded(child: _buildMapCard83(context)),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Carte des Alpes-Maritimes (06) avec villes positionnées
  Widget _buildMapCard06(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: kPrimaryBlue.withOpacity(0.2), width: 2),
        boxShadow: [
          BoxShadow(
            color: kPrimaryBlue.withOpacity(0.1),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Column(
        children: [
          // En-tête avec dégradé bleu
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [kDarkBlue, kPrimaryBlue],
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(22),
                topRight: Radius.circular(22),
              ),
            ),
            child: Row(
              children: [
                // Badge numéro avec accent orange
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [kAccentOrange, kAccentYellow],
                    ),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: kAccentOrange.withOpacity(0.4),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Text(
                    '06',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: Text(
                    'Alpes-Maritimes',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                ),
                // Icône
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.location_on, color: Colors.white, size: 22),
                ),
              ],
            ),
          ),
          // Carte
          Container(
            height: 320,
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            child: CustomPaint(
              painter: _AlpesMaritimesMapPainter(),
              child: Stack(
                children: [
                  // Positions basées sur la vraie géographie
                  // Menton (extrême est, côte)
                  _buildCityMarker('Menton', 0.94, 0.48, kPrimaryBlue),
                  // Monaco
                  _buildCityMarker('Monaco', 0.90, 0.54, const Color(0xFFE91E63)),
                  // Nice (centre-est côte) - PRINCIPALE
                  _buildCityMarker('Nice', 0.72, 0.62, kPrimaryBlue, isMain: true),
                  // Cagnes-sur-Mer (ouest de Nice)
                  _buildCityMarker('Cagnes', 0.54, 0.68, kPrimaryBlue),
                  // Antibes (sud-ouest)
                  _buildCityMarker('Antibes', 0.40, 0.75, kPrimaryBlue),
                  // Cannes (sud-ouest) - PRINCIPALE
                  _buildCityMarker('Cannes', 0.18, 0.78, kPrimaryBlue, isMain: true),
                  // Grasse (intérieur nord-ouest)
                  _buildCityMarker('Grasse', 0.22, 0.52, kPrimaryBlue),
                  // Vence (intérieur)
                  _buildCityMarker('Vence', 0.48, 0.45, kPrimaryBlue),
                  // Mougins (entre Cannes et Grasse)
                  _buildCityMarker('Mougins', 0.25, 0.62, kPrimaryBlue),
                  // Saint-Martin-Vésubie (montagne)
                  _buildCityMarker('St-Martin', 0.72, 0.18, kPrimaryBlue),
                ],
              ),
            ),
          ),
          // Légende
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.location_on, color: kPrimaryBlue, size: 18),
                const SizedBox(width: 6),
                Text(
                  'Intervention dans tout le département',
                  style: TextStyle(
                    color: colorScheme.onSurfaceVariant,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Carte du Var (83) avec villes positionnées
  Widget _buildMapCard83(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: kAccentOrange.withOpacity(0.3), width: 2),
        boxShadow: [
          BoxShadow(
            color: kAccentOrange.withOpacity(0.1),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Column(
        children: [
          // En-tête avec dégradé orange/jaune
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [kAccentOrange, Color(0xFFFF9800)],
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(22),
                topRight: Radius.circular(22),
              ),
            ),
            child: Row(
              children: [
                // Badge numéro avec accent bleu
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [kDarkBlue, kPrimaryBlue],
                    ),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: kDarkBlue.withOpacity(0.4),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Text(
                    '83',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: Text(
                    'Var',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                ),
                // Icône
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.location_on, color: Colors.white, size: 22),
                ),
              ],
            ),
          ),
          // Carte
          Container(
            height: 320,
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            child: CustomPaint(
              painter: _VarMapPainter(),
              child: Stack(
                children: [
                  // Positions basées sur la vraie géographie
                  // Fréjus (est côte) - PRINCIPALE
                  _buildCityMarker('Fréjus', 0.86, 0.55, kAccentOrange, isMain: true),
                  // Saint-Raphaël (est côte)
                  _buildCityMarker('St-Raphaël', 0.90, 0.52, kAccentOrange),
                  // Sainte-Maxime (golfe St-Tropez)
                  _buildCityMarker('Ste-Maxime', 0.80, 0.62, kAccentOrange),
                  // Saint-Tropez
                  _buildCityMarker('St-Tropez', 0.74, 0.70, kAccentOrange),
                  // Draguignan (intérieur nord-est)
                  _buildCityMarker('Draguignan', 0.68, 0.25, kAccentOrange),
                  // Toulon (sud-ouest côte) - PRINCIPALE
                  _buildCityMarker('Toulon', 0.25, 0.78, kAccentOrange, isMain: true),
                  // Hyères (sud, près presqu'île Giens)
                  _buildCityMarker('Hyères', 0.48, 0.82, kAccentOrange),
                  // Bandol (ouest côte)
                  _buildCityMarker('Bandol', 0.10, 0.75, kAccentOrange),
                  // La Seyne-sur-Mer (près Toulon)
                  _buildCityMarker('La Seyne', 0.18, 0.78, kAccentOrange),
                  // Brignoles (intérieur centre)
                  _buildCityMarker('Brignoles', 0.42, 0.35, kAccentOrange),
                ],
              ),
            ),
          ),
          // Légende
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.location_on, color: kAccentOrange, size: 18),
                const SizedBox(width: 6),
                Text(
                  'Intervention dans tout le département',
                  style: TextStyle(
                    color: colorScheme.onSurfaceVariant,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Marqueur de ville sur la carte
  Widget _buildCityMarker(String name, double left, double top, Color color, {bool isMain = false}) {
    return Positioned(
      left: 0,
      top: 0,
      right: 0,
      bottom: 0,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              Positioned(
                left: constraints.maxWidth * left - (isMain ? 8 : 5),
                top: constraints.maxHeight * top - (isMain ? 8 : 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Point
                    Container(
                      width: isMain ? 16 : 10,
                      height: isMain ? 16 : 10,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                        boxShadow: [
                          BoxShadow(
                            color: color.withOpacity(0.4),
                            blurRadius: isMain ? 8 : 4,
                            spreadRadius: isMain ? 2 : 1,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Nom de la ville
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: isMain ? color : Colors.white,
                        borderRadius: BorderRadius.circular(4),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Text(
                        name,
                        style: TextStyle(
                          color: isMain ? Colors.white : Colors.black87,
                          fontSize: isMain ? 11 : 9,
                          fontWeight: isMain ? FontWeight.bold : FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // ======================== POURQUOI NOUS ========================
  Widget _buildWhyUsSection(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      color: colorScheme.surface,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              _buildSectionTitle(context,
                'Pourquoi nous choisir ?',
                'Artisan frigoriste et plombier chauffagiste de confiance – Intervention rapide 06 & 83',
              ),
              const SizedBox(height: 48),
              LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth > 800;
                  return isWide
                      ? Row(
                          children: [
                            Expanded(child: _buildWhyUsItem(context, Icons.verified_user, 'Artisan qualifié', 'Frigoriste certifié', kPrimaryBlue)),
                            const SizedBox(width: 24),
                            Expanded(child: _buildWhyUsItem(context, Icons.flash_on, 'Réactivité', 'Intervention sous 24h', kAccentOrange)),
                            const SizedBox(width: 24),
                            Expanded(child: _buildWhyUsItem(context, Icons.description, 'Transparence', 'Devis gratuit détaillé', kPrimaryBlue)),
                            const SizedBox(width: 24),
                            Expanded(child: _buildWhyUsItem(context, Icons.thumb_up, 'Garantie', 'Satisfaction assurée', kAccentYellow)),
                          ],
                        )
                      : Column(
                          children: [
                            Row(
                              children: [
                                Expanded(child: _buildWhyUsItem(context, Icons.verified_user, 'Artisan qualifié', 'Frigoriste certifié', kPrimaryBlue)),
                                const SizedBox(width: 16),
                                Expanded(child: _buildWhyUsItem(context, Icons.flash_on, 'Réactivité', 'Intervention 24h', kAccentOrange)),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(child: _buildWhyUsItem(context, Icons.description, 'Transparence', 'Devis gratuit', kPrimaryBlue)),
                                const SizedBox(width: 16),
                                Expanded(child: _buildWhyUsItem(context, Icons.thumb_up, 'Garantie', 'Satisfaction', kAccentYellow)),
                              ],
                            ),
                          ],
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWhyUsItem(BuildContext context, IconData icon, String title, String subtitle, Color color) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 32),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  // ======================== SECTION "NOTRE EXPERTISE" (SEO INTÉGRÉ) ========================
  // Section professionnelle avec contenu SEO intégré de manière naturelle
  Widget _buildSeoSection(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 800;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        // Fond avec dégradé subtil
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: isDark
              ? [colorScheme.surface, colorScheme.background]
              : [kLightBlue.withOpacity(0.3), colorScheme.surface],
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 60,
        vertical: isMobile ? 50 : 70,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              // Titre de section avec icône
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [kPrimaryBlue, kDarkBlue],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.workspace_premium, color: Colors.white, size: 24),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    'Notre expertise à votre service',
                    style: textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                'Un seul interlocuteur pour tous vos besoins thermiques et électriques',
                textAlign: TextAlign.center,
                style: textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 40),
              
              // Grille de domaines d'expertise
              LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth > 700;
                  return isWide
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: _buildExpertiseCard(
                              context,
                              icon: Icons.location_on,
                              title: 'Zone d\'intervention',
                              content: 'Nous intervenons dans toutes les **Alpes-Maritimes** (Nice, Cannes, Mandelieu, Grasse, Antibes, Menton) et dans le **Var** (Fréjus, Saint-Raphaël, Toulon, Hyères).',
                              color: kPrimaryBlue,
                            )),
                            const SizedBox(width: 20),
                            Expanded(child: _buildExpertiseCard(
                              context,
                              icon: Icons.build_circle,
                              title: 'Nos spécialités',
                              content: 'Climatisation mono/multi-split, pompes à chaleur air-air et air-eau, chauffage, plomberie, et travaux d\'électricité (tableaux, mise aux normes, dépannage).',
                              color: kAccentOrange,
                            )),
                            const SizedBox(width: 20),
                            Expanded(child: _buildExpertiseCard(
                              context,
                              icon: Icons.verified,
                              title: 'Notre engagement',
                              content: 'Interventions rapides, conseils personnalisés et travail soigné. Artisan qualifié pour particuliers et professionnels.',
                              color: kAccentYellow,
                            )),
                          ],
                        )
                      : Column(
                          children: [
                            _buildExpertiseCard(
                              context,
                              icon: Icons.location_on,
                              title: 'Zone d\'intervention',
                              content: 'Nous intervenons dans toutes les **Alpes-Maritimes** (Nice, Cannes, Mandelieu, Grasse, Antibes, Menton) et dans le **Var** (Fréjus, Saint-Raphaël, Toulon, Hyères).',
                              color: kPrimaryBlue,
                            ),
                            const SizedBox(height: 16),
                            _buildExpertiseCard(
                              context,
                              icon: Icons.build_circle,
                              title: 'Nos spécialités',
                              content: 'Climatisation mono/multi-split, pompes à chaleur air-air et air-eau, chauffage, plomberie, et travaux d\'électricité (tableaux, mise aux normes, dépannage).',
                              color: kAccentOrange,
                            ),
                            const SizedBox(height: 16),
                            _buildExpertiseCard(
                              context,
                              icon: Icons.verified,
                              title: 'Notre engagement',
                              content: 'Interventions rapides, conseils personnalisés et travail soigné. Artisan qualifié pour particuliers et professionnels.',
                              color: kAccentYellow,
                            ),
                          ],
                        );
                },
              ),
              
              const SizedBox(height: 40),
              
              // Bandeau CTA
              Container(
                padding: EdgeInsets.all(isMobile ? 20 : 32),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [kDarkBlue, kPrimaryBlue],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: kPrimaryBlue.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Besoin d\'un artisan de confiance ?',
                            style: textTheme.titleLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Devis gratuit et intervention rapide dans le 06 et le 83',
                            style: textTheme.bodyMedium?.copyWith(
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (!isMobile) ...[
                      const SizedBox(width: 24),
                      ElevatedButton.icon(
                        onPressed: launchPhone,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kAccentYellow,
                          foregroundColor: Colors.black87,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        icon: const Icon(Icons.phone),
                        label: const Text('Appeler', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Carte d'expertise professionnelle
  Widget _buildExpertiseCard(BuildContext context, {
    required IconData icon,
    required String title,
    required String content,
    required Color color,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withOpacity(0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icône avec fond coloré
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 16),
          // Titre
          Text(
            title,
            style: textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          // Contenu
          Text(
            content.replaceAll('**', ''),
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  // ======================== FOOTER ========================
  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [kDarkBlue, Color(0xFF1565C0)],
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.ac_unit, color: Colors.white, size: 32),
                  const SizedBox(width: 12),
                  const Text(
                    'AZUR CONFORT',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Text(
                'Artisan frigoriste sur la Côte d\'Azur (06 & 83)',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 32),
              Text(
                '© 2025 Azur Confort - Tous droits réservés',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 12),
              // Lien vers les mentions légales
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    _AzurConfortHomeState.navigateToPage(3); // Index 3 = Mentions légales
                  },
                  child: Text(
                    'Mentions légales',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.6),
                      fontSize: 12,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.white.withOpacity(0.6),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ======================== HELPERS ========================
  Widget _buildSectionTitle(BuildContext context, String title, String subtitle) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: colorScheme.onBackground,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

// ============================================================================
// SECTION SERVICES AVEC ONGLETS (TabBar + TabBarView)
// ============================================================================

class _ServicesTabSection extends StatefulWidget {
  const _ServicesTabSection();

  @override
  State<_ServicesTabSection> createState() => _ServicesTabSectionState();
}

class _ServicesTabSectionState extends State<_ServicesTabSection> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Définition des services avec leurs détails
  // ⚠️ IMAGES : Placez vos images dans assets/images/
  final List<_ServiceData> _services = [
    _ServiceData(
      id: 'clim',
      title: 'Climatisation',
      icon: Icons.ac_unit,
      color: kPrimaryBlue,
      description: 'Installation, entretien et dépannage de systèmes de climatisation pour particuliers et professionnels.',
      prestations: [
        'Installation clim monosplit',
        'Installation clim multisplit',
        'Entretien annuel',
        'Dépannage et réparation',
        'Remplacement de climatiseur',
      ],
      imagePath: 'assets/images/service_climatisation.png',
    ),
    _ServiceData(
      id: 'frigo',
      title: 'Frigoriste',
      icon: Icons.severe_cold,
      color: kDarkBlue,
      description: 'Expert en froid commercial et industriel : chambres froides, vitrines réfrigérées, équipements frigorifiques.',
      prestations: [
        'Chambres froides positives/négatives',
        'Vitrines réfrigérées',
        'Meubles frigorifiques',
        'Groupes froids',
        'Maintenance préventive',
      ],
      imagePath: 'assets/images/service_frigoriste.png',
    ),
    _ServiceData(
      id: 'pac',
      title: 'Pompes à chaleur',
      icon: Icons.thermostat,
      color: kAccentYellow,
      description: 'Solutions écologiques et économiques pour chauffer et rafraîchir votre habitat toute l\'année.',
      prestations: [
        'PAC Air/Air réversible',
        'PAC Air/Eau',
        'Ballon thermodynamique',
        'Entretien annuel PAC',
        'Dépannage et SAV',
      ],
      imagePath: 'assets/images/service_pac.jpg',
    ),
    _ServiceData(
      id: 'chauffage',
      title: 'Chauffage',
      icon: Icons.local_fire_department,
      color: kAccentOrange,
      description: 'Installation et maintenance de systèmes de chauffage performants pour votre confort thermique.',
      prestations: [
        'Chaudières gaz/fioul',
        'Radiateurs électriques',
        'Plancher chauffant',
        'Entretien chaudière',
        'Dépannage chauffage',
      ],
      imagePath: 'assets/images/service_chauffage.png',
    ),
    _ServiceData(
      id: 'plomberie',
      title: 'Plomberie',
      icon: Icons.water_drop,
      color: kPrimaryBlue,
      description: 'Dépannage, installation et rénovation de tous vos équipements sanitaires et canalisations.',
      prestations: [
        'Dépannage fuite d\'eau',
        'Installation sanitaires',
        'Rénovation salle de bain',
        'Débouchage canalisations',
        'Chauffe-eau / cumulus',
      ],
      imagePath: 'assets/images/service_plomberie.png',
    ),
    // ============================================================
    // SERVICE ÉLECTRICITÉ - Nouveau service ajouté
    // ============================================================
    _ServiceData(
      id: 'electricite',
      title: 'Électricité',
      icon: Icons.electrical_services,
      color: kAccentYellow,
      description: 'Azur Confort intervient pour tous vos travaux d\'électricité dans les Alpes-Maritimes (06) et le Var (83) : installation de tableaux électriques, rénovation complète, mise aux normes, ajout de prises et points lumineux, recherche de panne et dépannage d\'urgence. Nous accompagnons particuliers et professionnels pour sécuriser leurs installations et améliorer leur confort au quotidien.',
      prestations: [
        'Installation et remplacement de tableaux électriques',
        'Mise aux normes et sécurisation des installations',
        'Ajout de prises, interrupteurs et points lumineux',
        'Dépannage électrique d\'urgence (panne, court-circuit)',
        'Éclairage intérieur et extérieur',
        'Diagnostic et recherche de panne',
      ],
      imagePath: 'assets/images/service_electricite.jpg',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _services.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      color: colorScheme.surface,
      // Padding réduit en haut pour remonter la section
      padding: const EdgeInsets.only(top: 30, bottom: 50),
      child: Column(
        children: [
          // Titre de section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                Text(
                  'Nos Services',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Froid, chaud, eau : des solutions complètes pour votre confort',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          
          // TabBar - Onglets cliquables
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1000),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: isDark ? colorScheme.surfaceVariant : kLightBlue,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  padding: const EdgeInsets.all(6),
                  labelPadding: EdgeInsets.symmetric(horizontal: isMobile ? 12 : 20),
                  indicator: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: kPrimaryBlue.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                  labelColor: kDarkBlue,
                  unselectedLabelColor: kPrimaryBlue.withOpacity(0.7),
                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  unselectedLabelStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                  tabs: _services.map((service) {
                    return Tab(
                      height: isMobile ? 50 : 56,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(service.icon, size: isMobile ? 18 : 22),
                          const SizedBox(width: 8),
                          Text(service.title),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),
          
          // TabBarView - Contenu des onglets avec swipe
          SizedBox(
            height: isMobile ? 480 : 400,
            child: TabBarView(
              controller: _tabController,
              children: _services.map((service) {
                return _buildServiceContent(service, isMobile);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  /// Contenu d'un onglet de service
  Widget _buildServiceContent(_ServiceData service, bool isMobile) {
    final colorScheme = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Container(
            padding: EdgeInsets.all(isMobile ? 20 : 32),
            decoration: BoxDecoration(
              color: colorScheme.surfaceVariant,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: service.color.withOpacity(0.2)),
            ),
            child: isMobile
                ? _buildMobileContent(service)
                : _buildDesktopContent(service),
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopContent(_ServiceData service) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ============================================================
        // COLONNE GAUCHE - IMAGE DU SERVICE
        // ⚠️ Placez vos images dans assets/images/
        // ============================================================
        Expanded(
          flex: 4,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              height: 280,
              decoration: BoxDecoration(
                color: service.color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Image du service
                  Image.asset(
                    service.imagePath,
                    fit: BoxFit.cover,
                    // Fallback si l'image n'existe pas
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              service.color.withOpacity(0.3),
                              service.color.withOpacity(0.1),
                            ],
                          ),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                service.icon,
                                size: 80,
                                color: service.color.withOpacity(0.5),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'Image à ajouter',
                                style: TextStyle(
                                  color: service.color.withOpacity(0.7),
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  // Overlay léger en bas pour le badge
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(0.6),
                            Colors.transparent,
                          ],
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: service.color,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              service.icon,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            service.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 32),
        
        // ============================================================
        // COLONNE CENTRALE - Description et bouton
        // ============================================================
        Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Titre
              Text(
                service.title,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: service.color,
                ),
              ),
              const SizedBox(height: 16),
              // Description
              Text(
                service.description,
                style: TextStyle(
                  fontSize: 15,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  height: 1.7,
                ),
              ),
              const SizedBox(height: 24),
              // Bouton devis
              ElevatedButton.icon(
                onPressed: () {
                  // Naviguer vers la page Contact
                  _AzurConfortHomeState.navigateToPage(2);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: service.color,
                  foregroundColor: kWhite,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: const Icon(Icons.description, size: 18),
                label: const Text(
                  'Demander un devis',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 32),
        
        // ============================================================
        // COLONNE DROITE - Prestations
        // ============================================================
        Expanded(
          flex: 3,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: service.color.withOpacity(0.2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nos prestations',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: service.color,
                  ),
                ),
                const SizedBox(height: 14),
                ...service.prestations.map((prestation) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: service.color.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.check,
                            color: service.color,
                            size: 14,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            prestation,
                            style: TextStyle(
                              fontSize: 13,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileContent(_ServiceData service) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ============================================================
        // IMAGE DU SERVICE (Mobile)
        // ============================================================
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Container(
            height: 160,
            width: double.infinity,
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Image
                Image.asset(
                  service.imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            service.color.withOpacity(0.3),
                            service.color.withOpacity(0.1),
                          ],
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          service.icon,
                          size: 60,
                          color: service.color.withOpacity(0.5),
                        ),
                      ),
                    );
                  },
                ),
                // Overlay avec titre
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.7),
                          Colors.transparent,
                        ],
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: service.color,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Icon(
                            service.icon,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          service.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        
        // Description
        Text(
          service.description,
          style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 16),
        
        // Prestations (version compacte)
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: service.color.withOpacity(0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nos prestations',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: service.color,
                ),
              ),
              const SizedBox(height: 10),
              ...service.prestations.map((prestation) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    children: [
                      Icon(Icons.check_circle, color: service.color, size: 16),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          prestation,
                          style: const TextStyle(fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
        const SizedBox(height: 16),
        
        // Bouton
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () {
              // Naviguer vers la page Contact
              _AzurConfortHomeState.navigateToPage(2);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: service.color,
              foregroundColor: kWhite,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: const Icon(Icons.description, size: 16),
            label: const Text(
              'Demander un devis',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),
        ),
      ],
    );
  }
}

/// Données d'un service
class _ServiceData {
  final String id;
  final String title;
  final IconData icon;
  final Color color;
  final String description;
  final List<String> prestations;
  final String imagePath; // Chemin vers l'image du service

  _ServiceData({
    required this.id,
    required this.title,
    required this.icon,
    required this.color,
    required this.description,
    required this.prestations,
    required this.imagePath,
  });
}

// ============================================================================
// PAGE À PROPOS - DESIGN PROFESSIONNEL
// ============================================================================

class _AProposPage extends StatelessWidget {
  const _AProposPage();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 800;
    
    return SingleChildScrollView(
      child: Column(
        children: [
          // Hero immersif
          _buildHeroSection(isMobile),
          // Section "Qui sommes-nous"
          _buildWhoWeAre(context, isMobile),
          // Chiffres clés
          _buildKeyNumbers(isMobile),
          // Nos domaines d'expertise
          _buildExpertiseDomains(context, isMobile),
          // Engagement qualité
          _buildQualityCommitment(context, isMobile),
          // Nos valeurs
          _buildCoreValues(context, isMobile),
          // Call to action
          _buildCallToAction(isMobile),
        ],
      ),
    );
  }

  Widget _buildHeroSection(bool isMobile) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: isMobile ? 300 : 400),
      child: Stack(
        children: [
          // Image de fond
          Positioned.fill(
            child: Image.asset(
              'assets/images/service_climatisation.png',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [kDarkBlue, kPrimaryBlue],
                  ),
                ),
              ),
            ),
          ),
          // Overlay dégradé
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    kDarkBlue.withOpacity(0.95),
                    kDarkBlue.withOpacity(0.7),
                    kPrimaryBlue.withOpacity(0.5),
                  ],
                ),
              ),
            ),
          ),
          // Contenu
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 24 : 80,
              vertical: isMobile ? 50 : 80,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: Column(
                  crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                  children: [
                    // Badge
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: kAccentOrange,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Text(
                        'Depuis plus de 10 ans',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Votre partenaire',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: isMobile ? 24 : 32,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Text(
                      'confort thermique',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: isMobile ? 36 : 52,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      constraints: const BoxConstraints(maxWidth: 500),
                      child: Text(
                        'Artisan frigoriste qualifié, nous accompagnons les particuliers et professionnels de la Côte d\'Azur dans tous leurs projets de climatisation, chauffage et plomberie.',
                        textAlign: isMobile ? TextAlign.center : TextAlign.left,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.85),
                          fontSize: 16,
                          height: 1.6,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWhoWeAre(BuildContext context, bool isMobile) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      color: colorScheme.surface,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: 60,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: isMobile
              ? Column(
                  children: [
                    _buildWhoWeAreImage(),
                    const SizedBox(height: 40),
                    _buildWhoWeAreText(context),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(flex: 5, child: _buildWhoWeAreImage()),
                    const SizedBox(width: 60),
                    Expanded(flex: 6, child: _buildWhoWeAreText(context)),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildWhoWeAreImage() {
    return Container(
      height: 350,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: kPrimaryBlue.withOpacity(0.2),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/images/service_pac.jpg',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: kLightBlue,
                child: const Icon(Icons.engineering, size: 80, color: kPrimaryBlue),
              ),
            ),
            // Badge flottant
            Positioned(
              bottom: 20,
              left: 20,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.verified, color: kPrimaryBlue, size: 24),
                    SizedBox(width: 10),
                    Text(
                      'Certifié RGE',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: kDarkBlue,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWhoWeAreText(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: isDark ? kPrimaryBlue.withOpacity(0.2) : kLightBlue,
            borderRadius: BorderRadius.circular(6),
          ),
          child: const Text(
            'QUI SOMMES-NOUS',
            style: TextStyle(
              color: kPrimaryBlue,
              fontWeight: FontWeight.bold,
              fontSize: 12,
              letterSpacing: 1.5,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'L\'expertise au service\nde votre confort',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: isDark ? colorScheme.onSurface : kDarkBlue,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Azur Confort est une entreprise artisanale spécialisée dans les métiers du froid et du chaud. Basés sur la Côte d\'Azur, nous intervenons dans les Alpes-Maritimes (06) et le Var (83) pour tous vos besoins en climatisation, chauffage, pompes à chaleur et plomberie.',
          style: TextStyle(
            fontSize: 16,
            color: colorScheme.onSurfaceVariant,
            height: 1.7,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Notre force : une équipe réactive, des conseils personnalisés et un travail soigné pour garantir votre satisfaction.',
          style: TextStyle(
            fontSize: 16,
            color: colorScheme.onSurfaceVariant,
            height: 1.7,
          ),
        ),
        const SizedBox(height: 30),
        // Points forts
        Wrap(
          spacing: 24,
          runSpacing: 16,
          children: [
            _buildMiniFeature(context, Icons.schedule, 'Intervention 24h'),
            _buildMiniFeature(context, Icons.thumb_up, 'Devis gratuit'),
            _buildMiniFeature(context, Icons.eco, 'Solutions éco'),
          ],
        ),
      ],
    );
  }

  Widget _buildMiniFeature(BuildContext context, IconData icon, String text) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: kAccentOrange.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: kAccentOrange, size: 20),
        ),
        const SizedBox(width: 10),
        Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurface,
          ),
        ),
      ],
    );
  }

  Widget _buildKeyNumbers(bool isMobile) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 50),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [kDarkBlue, kPrimaryBlue],
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: isMobile
                ? Column(
                    children: [
                      _buildNumberCard('10+', 'Années d\'expérience', Icons.calendar_today),
                      const SizedBox(height: 24),
                      _buildNumberCard('500+', 'Clients satisfaits', Icons.people),
                      const SizedBox(height: 24),
                      _buildNumberCard('24h', 'Délai d\'intervention', Icons.flash_on),
                      const SizedBox(height: 24),
                      _buildNumberCard('100%', 'Devis gratuits', Icons.description),
                    ],
                  )
                : Row(
                    children: [
                      Expanded(child: _buildNumberCard('10+', 'Années d\'expérience', Icons.calendar_today)),
                      Expanded(child: _buildNumberCard('500+', 'Clients satisfaits', Icons.people)),
                      Expanded(child: _buildNumberCard('24h', 'Délai d\'intervention', Icons.flash_on)),
                      Expanded(child: _buildNumberCard('100%', 'Devis gratuits', Icons.description)),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildNumberCard(String number, String label, IconData icon) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: kAccentYellow, size: 28),
        ),
        const SizedBox(height: 16),
        Text(
          number,
          style: const TextStyle(
            fontSize: 42,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: Colors.white.withOpacity(0.85),
          ),
        ),
      ],
    );
  }

  Widget _buildExpertiseDomains(BuildContext context, bool isMobile) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      color: colorScheme.background,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: 70,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              Text(
                'Nos domaines d\'expertise',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: isDark ? colorScheme.onBackground : kDarkBlue,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Des solutions complètes pour votre confort thermique',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 50),
              LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth > 900) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _buildDomainCard(context, Icons.ac_unit, 'Froid', 'Climatisation, chambres froides, vitrines réfrigérées, maintenance frigorifique', kPrimaryBlue, ['Clim monosplit/multisplit', 'Chambres froides', 'Vitrines réfrigérées'])),
                        const SizedBox(width: 24),
                        Expanded(child: _buildDomainCard(context, Icons.local_fire_department, 'Chaud', 'Chauffage, pompes à chaleur air/air et air/eau, chaudières, radiateurs', kAccentOrange, ['Pompes à chaleur', 'Chaudières gaz/fioul', 'Plancher chauffant'])),
                        const SizedBox(width: 24),
                        Expanded(child: _buildDomainCard(context, Icons.water_drop, 'Eau', 'Plomberie, sanitaires, dépannage fuites, installation et rénovation', kPrimaryBlue, ['Dépannage fuites', 'Installation sanitaires', 'Chauffe-eau'])),
                      ],
                    );
                  }
                  return Column(
                    children: [
                      _buildDomainCard(context, Icons.ac_unit, 'Froid', 'Climatisation, chambres froides, vitrines réfrigérées', kPrimaryBlue, ['Clim monosplit/multisplit', 'Chambres froides', 'Vitrines réfrigérées']),
                      const SizedBox(height: 20),
                      _buildDomainCard(context, Icons.local_fire_department, 'Chaud', 'Chauffage, pompes à chaleur, chaudières', kAccentOrange, ['Pompes à chaleur', 'Chaudières', 'Plancher chauffant']),
                      const SizedBox(height: 20),
                      _buildDomainCard(context, Icons.water_drop, 'Eau', 'Plomberie, sanitaires, dépannage', kPrimaryBlue, ['Dépannage fuites', 'Installation sanitaires', 'Chauffe-eau']),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDomainCard(BuildContext context, IconData icon, String title, String description, Color color, List<String> features) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [color, color.withOpacity(0.7)],
                  ),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: Colors.white, size: 28),
              ),
              const SizedBox(width: 16),
              Text(
                title,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            description,
            style: TextStyle(
              fontSize: 15,
              color: colorScheme.onSurfaceVariant,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20),
          ...features.map((f) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                Icon(Icons.check_circle, color: color, size: 20),
                const SizedBox(width: 10),
                Text(f, style: TextStyle(fontSize: 14, color: colorScheme.onSurface)),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildQualityCommitment(BuildContext context, bool isMobile) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: 70,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(
          top: BorderSide(color: colorScheme.outline.withOpacity(0.3)),
          bottom: BorderSide(color: colorScheme.outline.withOpacity(0.3)),
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: kPrimaryBlue.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.verified_user, color: kPrimaryBlue, size: 40),
              ),
              const SizedBox(height: 24),
              Text(
                'Notre engagement qualité',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: isDark ? colorScheme.onSurface : kDarkBlue,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'En tant qu\'artisan frigoriste qualifié, nous nous engageons à fournir un travail soigné et professionnel. Nous respectons scrupuleusement les normes en vigueur et utilisons exclusivement des équipements de qualité pour garantir la performance et la durabilité de vos installations.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
                  color: colorScheme.onSurfaceVariant,
                  height: 1.8,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                decoration: BoxDecoration(
                  color: isDark ? kPrimaryBlue.withOpacity(0.15) : kLightBlue,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '« Notre objectif : votre confort thermique optimal, été comme hiver, tout en maîtrisant votre consommation d\'énergie. »',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    color: isDark ? colorScheme.onSurface : kDarkBlue,
                    height: 1.6,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCoreValues(BuildContext context, bool isMobile) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      color: colorScheme.background,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: 70,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            children: [
              Text(
                'Nos valeurs',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: isDark ? colorScheme.onBackground : kDarkBlue,
                ),
              ),
              const SizedBox(height: 50),
              LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth > 800) {
                    return Row(
                      children: [
                        Expanded(child: _buildValueCard(context, Icons.flash_on, 'Réactivité', 'Intervention rapide sous 24h sur toute la Côte d\'Azur. Nous comprenons l\'urgence de vos besoins.', kAccentOrange)),
                        const SizedBox(width: 24),
                        Expanded(child: _buildValueCard(context, Icons.handshake, 'Transparence', 'Devis gratuits, détaillés et sans surprise. Nous vous expliquons chaque intervention.', kPrimaryBlue)),
                        const SizedBox(width: 24),
                        Expanded(child: _buildValueCard(context, Icons.workspace_premium, 'Excellence', 'Travail soigné avec des équipements de marque. Votre satisfaction est notre priorité.', kAccentYellow)),
                      ],
                    );
                  }
                  return Column(
                    children: [
                      _buildValueCard(context, Icons.flash_on, 'Réactivité', 'Intervention rapide sous 24h sur toute la Côte d\'Azur.', kAccentOrange),
                      const SizedBox(height: 20),
                      _buildValueCard(context, Icons.handshake, 'Transparence', 'Devis gratuits, détaillés et sans surprise.', kPrimaryBlue),
                      const SizedBox(height: 20),
                      _buildValueCard(context, Icons.workspace_premium, 'Excellence', 'Travail soigné avec des équipements de marque.', kAccentYellow),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildValueCard(BuildContext context, IconData icon, String title, String description, Color color) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.03),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 32),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: colorScheme.onSurfaceVariant,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCallToAction(bool isMobile) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: 60,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [kDarkBlue, kPrimaryBlue],
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            children: [
              const Text(
                'Prêt à améliorer votre confort ?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Contactez-nous pour un devis gratuit et personnalisé',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withOpacity(0.85),
                ),
              ),
              const SizedBox(height: 32),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                alignment: WrapAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: launchPhone,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: kDarkBlue,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    icon: const Icon(Icons.phone),
                    label: const Text('Appeler maintenant', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  OutlinedButton.icon(
                    onPressed: () => _AzurConfortHomeState.navigateToPage(2),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white, width: 2),
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    icon: const Icon(Icons.mail),
                    label: const Text('Demander un devis', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// PAGE CONTACT - DESIGN PROFESSIONNEL
// ============================================================================

class _ContactPage extends StatefulWidget {
  const _ContactPage();

  @override
  State<_ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<_ContactPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _cityController = TextEditingController();
  final _messageController = TextEditingController();
  String? _selectedService;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _cityController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final dialogColorScheme = Theme.of(context).colorScheme;
      final dialogIsDark = Theme.of(context).brightness == Brightness.dark;
      showDialog(
        context: context,
        builder: (context) => Dialog(
          backgroundColor: dialogColorScheme.surface,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          child: Container(
            padding: const EdgeInsets.all(32),
            constraints: const BoxConstraints(maxWidth: 400),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(dialogIsDark ? 0.2 : 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.check_circle, color: Colors.green.shade600, size: 48),
                ),
                const SizedBox(height: 24),
                Text(
                  'Message envoyé !',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: dialogIsDark ? dialogColorScheme.onSurface : kDarkBlue,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Merci pour votre demande. Notre équipe vous recontactera dans les plus brefs délais.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: dialogColorScheme.onSurfaceVariant,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 28),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryBlue,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text(
                      'Parfait !',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
      _formKey.currentState!.reset();
      setState(() => _selectedService = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 900;

    return SingleChildScrollView(
      child: Column(
        children: [
          // Hero section
          _buildContactHero(isMobile),
          // Contenu principal
          Container(
            color: Theme.of(context).colorScheme.background,
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 20 : 80,
              vertical: 60,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: isMobile
                    ? Column(
                        children: [
                          _buildContactInfo(),
                          const SizedBox(height: 40),
                          _buildContactForm(),
                        ],
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(flex: 4, child: _buildContactInfo()),
                          const SizedBox(width: 50),
                          Expanded(flex: 6, child: _buildContactForm()),
                        ],
                      ),
              ),
            ),
          ),
          // Zone d'intervention
          _buildInterventionZone(isMobile),
        ],
      ),
    );
  }

  Widget _buildContactHero(bool isMobile) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: isMobile ? 280 : 350),
      child: Stack(
        children: [
          // Image de fond
          Positioned.fill(
            child: Image.asset(
              'assets/images/contact_hero.png',
              fit: BoxFit.cover,
              alignment: isMobile ? Alignment.center : Alignment.centerRight,
              errorBuilder: (context, error, stackTrace) => Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [kDarkBlue, kPrimaryBlue],
                  ),
                ),
              ),
            ),
          ),
          // Overlay dégradé
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    kDarkBlue.withOpacity(0.9),
                    kDarkBlue.withOpacity(0.7),
                    kPrimaryBlue.withOpacity(0.5),
                  ],
                ),
              ),
            ),
          ),
          // Contenu
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 24 : 80,
              vertical: isMobile ? 50 : 70,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.mail_outline, color: Colors.white, size: 40),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Contactez-nous',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Une question ? Un projet ? Besoin d\'un devis ?\nNotre équipe est à votre écoute.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.white.withOpacity(0.9),
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactInfo() {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nos coordonnées',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: isDark ? colorScheme.onSurface : kDarkBlue,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Plusieurs moyens de nous joindre',
          style: TextStyle(
            fontSize: 15,
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 32),
        
        // Carte téléphone
        _buildContactCard(
          icon: Icons.phone,
          iconColor: Colors.white,
          iconBgColor: kPrimaryBlue,
          title: 'Téléphone',
          subtitle: 'Du lundi au samedi',
          value: kPhoneNumberFormatted,
          onTap: launchPhone,
          actionLabel: 'Appeler',
          actionIcon: Icons.call,
        ),
        const SizedBox(height: 20),
        
        // Carte WhatsApp
        _buildContactCard(
          icon: Icons.chat,
          iconColor: Colors.white,
          iconBgColor: const Color(0xFF25D366),
          title: 'WhatsApp',
          subtitle: 'Réponse rapide',
          value: 'Envoyer un message',
          onTap: launchWhatsApp,
          actionLabel: 'Ouvrir',
          actionIcon: Icons.open_in_new,
        ),
        const SizedBox(height: 20),
        
        // Carte Email
        _buildContactCard(
          icon: Icons.email,
          iconColor: Colors.white,
          iconBgColor: kAccentOrange,
          title: 'Email',
          subtitle: 'Pour vos demandes détaillées',
          value: 'contact@azur-confort.fr',
          onTap: launchEmail,
          actionLabel: 'Écrire',
          actionIcon: Icons.send,
        ),
        const SizedBox(height: 32),
        
        // Horaires
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: isDark ? kPrimaryBlue.withOpacity(0.15) : kLightBlue,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.schedule, color: kPrimaryBlue, size: 24),
                  const SizedBox(width: 12),
                  Text(
                    'Horaires',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isDark ? colorScheme.onSurface : kDarkBlue,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildScheduleRow('Lundi - Vendredi', '8h00 - 19h00'),
              const SizedBox(height: 8),
              _buildScheduleRow('Samedi', '9h00 - 17h00'),
              const SizedBox(height: 8),
              _buildScheduleRow('Urgences', '7j/7', isHighlight: true),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContactCard({
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String title,
    required String subtitle,
    required String value,
    required VoidCallback onTap,
    required String actionLabel,
    required IconData actionIcon,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor, size: 26),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDark ? colorScheme.onSurface : kDarkBlue,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton.icon(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
              backgroundColor: iconBgColor.withOpacity(0.1),
              foregroundColor: iconBgColor,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            icon: Icon(actionIcon, size: 18),
            label: Text(actionLabel, style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleRow(String day, String hours, {bool isHighlight = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          day,
          style: TextStyle(
            fontSize: 14,
            color: isHighlight ? kAccentOrange : Colors.grey.shade700,
            fontWeight: isHighlight ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: isHighlight ? kAccentOrange.withOpacity(0.1) : Colors.white,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            hours,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isHighlight ? kAccentOrange : kDarkBlue,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContactForm() {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(36),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: kPrimaryBlue.withOpacity(0.08),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: kPrimaryBlue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.description, color: kPrimaryBlue, size: 24),
                ),
                const SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Demande de devis',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: isDark ? colorScheme.onSurface : kDarkBlue,
                      ),
                    ),
                    Text(
                      'Gratuit et sans engagement',
                      style: TextStyle(
                        fontSize: 13,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 32),
            
            // Nom et Téléphone
            Row(
              children: [
                Expanded(child: _buildModernTextField(_nameController, 'Nom complet', Icons.person_outline)),
                const SizedBox(width: 16),
                Expanded(child: _buildModernTextField(_phoneController, 'Téléphone', Icons.phone_outlined)),
              ],
            ),
            const SizedBox(height: 20),
            
            // Email et Ville
            Row(
              children: [
                Expanded(child: _buildModernTextField(_emailController, 'Email', Icons.email_outlined)),
                const SizedBox(width: 16),
                Expanded(child: _buildModernTextField(_cityController, 'Ville / Code postal', Icons.location_on_outlined, required: false)),
              ],
            ),
            const SizedBox(height: 20),
            
            // Type de demande
            DropdownButtonFormField<String>(
              value: _selectedService,
              dropdownColor: colorScheme.surface,
              style: TextStyle(color: colorScheme.onSurface),
              decoration: InputDecoration(
                labelText: 'Type de prestation',
                labelStyle: TextStyle(color: colorScheme.onSurfaceVariant),
                prefixIcon: const Icon(Icons.build_outlined, color: kPrimaryBlue),
                filled: true,
                fillColor: colorScheme.surfaceVariant,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: colorScheme.outline),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: kPrimaryBlue, width: 2),
                ),
              ),
              items: [
                'Climatisation',
                'Frigoriste / Froid commercial',
                'Pompe à chaleur',
                'Chauffage',
                'Plomberie',
                'Entretien / Maintenance',
                'Dépannage urgent',
                'Autre',
              ].map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
              onChanged: (v) => setState(() => _selectedService = v),
              validator: (v) => v == null ? 'Veuillez sélectionner un type' : null,
            ),
            const SizedBox(height: 20),
            
            // Message
            TextFormField(
              controller: _messageController,
              maxLines: 5,
              style: TextStyle(color: colorScheme.onSurface),
              decoration: InputDecoration(
                labelText: 'Décrivez votre projet ou besoin',
                labelStyle: TextStyle(color: colorScheme.onSurfaceVariant),
                alignLabelWithHint: true,
                prefixIcon: const Padding(
                  padding: EdgeInsets.only(bottom: 80),
                  child: Icon(Icons.message_outlined, color: kPrimaryBlue),
                ),
                filled: true,
                fillColor: colorScheme.surfaceVariant,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: colorScheme.outline),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: kPrimaryBlue, width: 2),
                ),
              ),
            ),
            const SizedBox(height: 28),
            
            // Bouton envoyer
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryBlue,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  elevation: 0,
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.send, color: Colors.white, size: 22),
                    SizedBox(width: 12),
                    Text(
                      'Envoyer ma demande',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // Note
            Row(
              children: [
                Icon(Icons.lock_outline, size: 16, color: Colors.grey.shade500),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Vos données sont protégées et ne seront jamais partagées.',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModernTextField(TextEditingController controller, String label, IconData icon, {bool required = true}) {
    final colorScheme = Theme.of(context).colorScheme;
    return TextFormField(
      controller: controller,
      style: TextStyle(color: colorScheme.onSurface),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: colorScheme.onSurfaceVariant),
        prefixIcon: Icon(icon, color: kPrimaryBlue),
        filled: true,
        fillColor: colorScheme.surfaceVariant,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: kPrimaryBlue, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.error),
        ),
      ),
      validator: required ? (v) => v == null || v.isEmpty ? 'Champ requis' : null : null,
    );
  }

  Widget _buildInterventionZone(bool isMobile) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: 50,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [kDarkBlue, kPrimaryBlue],
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Column(
            children: [
              const Icon(Icons.location_on, color: kAccentYellow, size: 36),
              const SizedBox(height: 16),
              const Text(
                'Zone d\'intervention',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Nous intervenons sur toute la Côte d\'Azur',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withOpacity(0.85),
                ),
              ),
              const SizedBox(height: 28),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                alignment: WrapAlignment.center,
                children: [
                  _buildZoneChip('Nice'),
                  _buildZoneChip('Cannes'),
                  _buildZoneChip('Antibes'),
                  _buildZoneChip('Grasse'),
                  _buildZoneChip('Fréjus'),
                  _buildZoneChip('Saint-Raphaël'),
                  _buildZoneChip('Menton'),
                  _buildZoneChip('Monaco'),
                  _buildZoneChip('Cagnes-sur-Mer'),
                  _buildZoneChip('+ tout le 06 & 83'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildZoneChip(String city) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
      ),
      child: Text(
        city,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
      ),
    );
  }
}

// ============================================================================
// CUSTOM PAINTERS POUR LES CARTES GÉOGRAPHIQUES (FORMES RÉELLES)
// ============================================================================

/// Peintre pour la carte des Alpes-Maritimes (06) - FORME RÉELLE
/// Basé sur les coordonnées géographiques réelles du département
class _AlpesMaritimesMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = kPrimaryBlue.withOpacity(0.12)
      ..style = PaintingStyle.fill;
    
    final borderPaint = Paint()
      ..color = kPrimaryBlue.withOpacity(0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;

    // Forme RÉELLE des Alpes-Maritimes basée sur les coordonnées géographiques
    // Le département a une forme caractéristique : étroit à l'ouest (Cannes),
    // s'élargissant vers le nord (montagnes du Mercantour), 
    // avec la frontière italienne à l'est
    final path = Path();
    
    // Coordonnées normalisées basées sur la vraie géographie
    // Départ de Théoule-sur-Mer (sud-ouest)
    path.moveTo(size.width * 0.02, size.height * 0.82);
    // Côte vers Cannes
    path.lineTo(size.width * 0.08, size.height * 0.78);
    // Grasse direction (intérieur)
    path.lineTo(size.width * 0.05, size.height * 0.65);
    // Limite ouest vers St-Vallier
    path.lineTo(size.width * 0.03, size.height * 0.52);
    // Nord-ouest (Andon, Séranon)
    path.lineTo(size.width * 0.08, size.height * 0.38);
    // Entrevaux direction
    path.lineTo(size.width * 0.15, size.height * 0.22);
    // Guillaumes
    path.lineTo(size.width * 0.28, size.height * 0.12);
    // Vallée de la Tinée nord
    path.lineTo(size.width * 0.42, size.height * 0.05);
    // Saint-Étienne-de-Tinée (Mercantour)
    path.lineTo(size.width * 0.52, size.height * 0.02);
    // Col de la Bonette direction
    path.lineTo(size.width * 0.62, size.height * 0.03);
    // Isola 2000
    path.lineTo(size.width * 0.70, size.height * 0.06);
    // Saint-Martin-Vésubie
    path.lineTo(size.width * 0.75, size.height * 0.12);
    // Frontière italienne nord (Tende)
    path.lineTo(size.width * 0.85, size.height * 0.08);
    // La Brigue
    path.lineTo(size.width * 0.92, size.height * 0.15);
    // Sospel direction
    path.lineTo(size.width * 0.95, size.height * 0.28);
    // Menton (frontière italienne côte)
    path.lineTo(size.width * 0.98, size.height * 0.45);
    // Cap Martin
    path.lineTo(size.width * 0.96, size.height * 0.52);
    // Monaco
    path.lineTo(size.width * 0.92, size.height * 0.56);
    // Villefranche-sur-Mer
    path.lineTo(size.width * 0.85, size.height * 0.60);
    // Nice (Baie des Anges)
    path.lineTo(size.width * 0.72, size.height * 0.65);
    // Aéroport Nice
    path.lineTo(size.width * 0.62, size.height * 0.68);
    // Cagnes-sur-Mer
    path.lineTo(size.width * 0.52, size.height * 0.72);
    // Antibes / Cap d'Antibes
    path.lineTo(size.width * 0.38, size.height * 0.78);
    path.lineTo(size.width * 0.32, size.height * 0.82);
    // Golfe Juan
    path.lineTo(size.width * 0.25, size.height * 0.80);
    // Cannes / La Napoule
    path.lineTo(size.width * 0.15, size.height * 0.82);
    // Retour Théoule
    path.lineTo(size.width * 0.08, size.height * 0.84);
    path.close();

    canvas.drawPath(path, paint);
    canvas.drawPath(path, borderPaint);

    // Ligne de côte (mer Méditerranée)
    final seaPaint = Paint()
      ..color = const Color(0xFF42A5F5).withOpacity(0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    final seaPath = Path();
    seaPath.moveTo(size.width * 0.02, size.height * 0.86);
    seaPath.quadraticBezierTo(
      size.width * 0.25, size.height * 0.88,
      size.width * 0.45, size.height * 0.82,
    );
    seaPath.quadraticBezierTo(
      size.width * 0.65, size.height * 0.75,
      size.width * 0.80, size.height * 0.68,
    );
    seaPath.quadraticBezierTo(
      size.width * 0.92, size.height * 0.60,
      size.width * 1.0, size.height * 0.52,
    );
    canvas.drawPath(seaPath, seaPaint);

    // Indicateur Italie
    final italiePaint = TextPainter(
      text: TextSpan(
        text: 'ITALIE →',
        style: TextStyle(
          color: Colors.grey.withOpacity(0.4),
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    italiePaint.layout();
    italiePaint.paint(canvas, Offset(size.width * 0.85, size.height * 0.35));

    // Label Mer
    final textPainter = TextPainter(
      text: TextSpan(
        text: 'Méditerranée',
        style: TextStyle(
          color: const Color(0xFF1976D2).withOpacity(0.4),
          fontSize: 11,
          fontStyle: FontStyle.italic,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(size.width * 0.35, size.height * 0.92));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Peintre pour la carte du Var (83) - FORME RÉELLE
/// Basé sur les coordonnées géographiques réelles du département
class _VarMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Couleurs orange/jaune pour le Var
    final paint = Paint()
      ..color = const Color(0xFFFF9800).withOpacity(0.12)
      ..style = PaintingStyle.fill;
    
    final borderPaint = Paint()
      ..color = const Color(0xFFFF9800).withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;

    // Forme RÉELLE du Var basée sur les coordonnées géographiques
    // Le département a une forme plus large, avec la rade de Toulon,
    // la presqu'île de Giens, le golfe de Saint-Tropez
    final path = Path();
    
    // Départ de Bandol (sud-ouest côte)
    path.moveTo(size.width * 0.08, size.height * 0.78);
    // Vers Six-Fours
    path.lineTo(size.width * 0.12, size.height * 0.82);
    // La Seyne-sur-Mer
    path.lineTo(size.width * 0.18, size.height * 0.80);
    // Rade de Toulon (entrée)
    path.lineTo(size.width * 0.22, size.height * 0.85);
    // Toulon
    path.lineTo(size.width * 0.28, size.height * 0.82);
    // La Garde
    path.lineTo(size.width * 0.35, size.height * 0.85);
    // Presqu'île de Giens
    path.lineTo(size.width * 0.42, size.height * 0.92);
    path.lineTo(size.width * 0.45, size.height * 0.95);
    path.lineTo(size.width * 0.48, size.height * 0.92);
    // Hyères
    path.lineTo(size.width * 0.52, size.height * 0.88);
    // Bormes-les-Mimosas
    path.lineTo(size.width * 0.58, size.height * 0.85);
    // Le Lavandou
    path.lineTo(size.width * 0.62, size.height * 0.82);
    // Cavalaire
    path.lineTo(size.width * 0.68, size.height * 0.80);
    // Saint-Tropez (presqu'île)
    path.lineTo(size.width * 0.72, size.height * 0.75);
    path.lineTo(size.width * 0.75, size.height * 0.70);
    path.lineTo(size.width * 0.78, size.height * 0.72);
    // Sainte-Maxime
    path.lineTo(size.width * 0.82, size.height * 0.65);
    // Fréjus
    path.lineTo(size.width * 0.88, size.height * 0.58);
    // Saint-Raphaël
    path.lineTo(size.width * 0.92, size.height * 0.55);
    // Limite avec 06 (côte)
    path.lineTo(size.width * 0.98, size.height * 0.48);
    // Frontière nord-est avec 06 (intérieur)
    path.lineTo(size.width * 0.95, size.height * 0.35);
    path.lineTo(size.width * 0.90, size.height * 0.25);
    // Fayence direction
    path.lineTo(size.width * 0.82, size.height * 0.18);
    // Draguignan
    path.lineTo(size.width * 0.70, size.height * 0.22);
    // Lorgues
    path.lineTo(size.width * 0.58, size.height * 0.28);
    // Brignoles
    path.lineTo(size.width * 0.45, size.height * 0.32);
    // Saint-Maximin
    path.lineTo(size.width * 0.32, size.height * 0.28);
    // Limite nord (Bouches-du-Rhône)
    path.lineTo(size.width * 0.18, size.height * 0.22);
    path.lineTo(size.width * 0.08, size.height * 0.25);
    // Limite ouest
    path.lineTo(size.width * 0.03, size.height * 0.35);
    path.lineTo(size.width * 0.02, size.height * 0.50);
    // Retour côte ouest (Sanary)
    path.lineTo(size.width * 0.05, size.height * 0.65);
    path.lineTo(size.width * 0.06, size.height * 0.72);
    path.close();

    canvas.drawPath(path, paint);
    canvas.drawPath(path, borderPaint);

    // Ligne de côte
    final seaPaint = Paint()
      ..color = const Color(0xFF9575CD).withOpacity(0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    final seaPath = Path();
    seaPath.moveTo(size.width * 0.02, size.height * 0.82);
    seaPath.quadraticBezierTo(
      size.width * 0.25, size.height * 0.90,
      size.width * 0.45, size.height * 0.98,
    );
    seaPath.quadraticBezierTo(
      size.width * 0.60, size.height * 0.92,
      size.width * 0.75, size.height * 0.80,
    );
    seaPath.quadraticBezierTo(
      size.width * 0.88, size.height * 0.65,
      size.width * 1.0, size.height * 0.52,
    );
    canvas.drawPath(seaPath, seaPaint);

    // Îles d'Hyères (indication)
    final islandPaint = Paint()
      ..color = const Color(0xFF7C4DFF).withOpacity(0.3)
      ..style = PaintingStyle.fill;
    
    // Porquerolles
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width * 0.48, size.height * 0.98),
        width: 25,
        height: 8,
      ),
      islandPaint,
    );
    
    // Port-Cros
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width * 0.55, size.height * 0.96),
        width: 12,
        height: 6,
      ),
      islandPaint,
    );

    // Label Mer
    final textPainter = TextPainter(
      text: TextSpan(
        text: 'Méditerranée',
        style: TextStyle(
          color: const Color(0xFF7C4DFF).withOpacity(0.35),
          fontSize: 11,
          fontStyle: FontStyle.italic,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(size.width * 0.25, size.height * 0.96));

    // Indicateur îles
    final ilesPainter = TextPainter(
      text: TextSpan(
        text: 'Îles d\'Hyères',
        style: TextStyle(
          color: const Color(0xFF7C4DFF).withOpacity(0.4),
          fontSize: 8,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    ilesPainter.layout();
    ilesPainter.paint(canvas, Offset(size.width * 0.52, size.height * 0.99));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ============================================================================
// PAGE MENTIONS LÉGALES
// ============================================================================

class _MentionsLegalesPage extends StatelessWidget {
  const _MentionsLegalesPage();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 800;
    
    return SingleChildScrollView(
      child: Column(
        children: [
          // Header de la page
          _buildHeader(context, isMobile),
          // Contenu des mentions légales
          Container(
            color: colorScheme.background,
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 24 : 80,
              vertical: 60,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 900),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SECTION 1 - Éditeur du site
                    _buildSection(
                      context,
                      '1. Éditeur du site',
                      '''Le présent site est édité par :

Nom / Raison sociale : [À compléter : Nom du propriétaire ou nom commercial]
Forme juridique : [À compléter : Micro-entreprise / EI / EURL…]
Adresse du siège social : [À compléter : adresse complète]
Téléphone : [À compléter]
Adresse e-mail : [À compléter : exemple contact@azurconfort.fr]
Numéro SIRET : [À compléter]
Responsable de la publication : [À compléter : nom de la personne physique]

Azur Confort est une entreprise spécialisée en :
• Installation et entretien de climatisations (mono-split et multi-split)
• Installation de pompes à chaleur (air-air / air-eau)
• Dépannage chauffage
• Plomberie (fuites, rénovations, sanitaires)
• Dépannage d'urgence

Zone d'intervention : Alpes-Maritimes (06) et Var (83).''',
                    ),
                    
                    const SizedBox(height: 40),
                    
                    // SECTION 2 - Hébergeur du site
                    _buildSection(
                      context,
                      '2. Hébergeur du site',
                      '''Hébergeur du site :

Vercel Inc.
340 S Lemon Ave #4133
Walnut, CA 91789, États-Unis
Site : https://vercel.com''',
                    ),
                    
                    const SizedBox(height: 40),
                    
                    // SECTION 3 - Propriété intellectuelle
                    _buildSection(
                      context,
                      '3. Propriété intellectuelle',
                      '''L'ensemble du contenu du site (textes, images, photos, logos, vidéos, éléments graphiques, structure…) est protégé par le Code de la Propriété Intellectuelle.

Toute reproduction, distribution, modification ou adaptation, totale ou partielle, sans autorisation écrite préalable d'Azur Confort, est strictement interdite.

Les images utilisées peuvent être :
• Des créations originales
• Des visuels appartenant à Azur Confort
• Ou des images sous licence''',
                    ),
                    
                    const SizedBox(height: 40),
                    
                    // SECTION 4 - Données personnelles
                    _buildSection(
                      context,
                      '4. Données personnelles',
                      '''Lorsque vous contactez Azur Confort (formulaire, e-mail, téléphone), les données suivantes peuvent être collectées :

• Nom, prénom
• Numéro de téléphone
• Adresse e-mail
• Adresse pour l'intervention
• Description du besoin

Ces données sont utilisées uniquement pour :
• Répondre à votre demande
• Établir un devis
• Organiser une intervention

Elles ne sont jamais revendues ni transmises à des tiers.

Pour toute demande de modification ou suppression de vos données personnelles, vous pouvez écrire à : [À compléter : e-mail de contact].''',
                    ),
                    
                    const SizedBox(height: 40),
                    
                    // SECTION 5 - Cookies
                    _buildSection(
                      context,
                      '5. Cookies',
                      '''Le site peut utiliser des cookies techniques nécessaires à son bon fonctionnement.

Aucune donnée personnelle n'est exploitée à des fins publicitaires.
Aucune solution de mesure d'audience invasive n'est installée par défaut.''',
                    ),
                    
                    const SizedBox(height: 40),
                    
                    // SECTION 6 - Responsabilité
                    _buildSection(
                      context,
                      '6. Responsabilité',
                      '''Azur Confort met tout en œuvre pour assurer l'exactitude et la mise à jour des informations présentes sur le site.

Cependant, des erreurs ou omissions peuvent se produire. L'utilisateur reconnaît utiliser le site sous sa seule responsabilité.

Azur Confort ne peut être tenue responsable en cas de :
• Indisponibilité du site
• Erreurs dans les informations fournies
• Dommages directs ou indirects liés à l'utilisation du site''',
                    ),
                    
                    const SizedBox(height: 40),
                    
                    // SECTION 7 - Droit applicable
                    _buildSection(
                      context,
                      '7. Droit applicable',
                      '''Le site et les présentes mentions légales sont soumis au droit français.

En cas de litige, une solution amiable sera recherchée avant toute procédure judiciaire.''',
                    ),
                    
                    const SizedBox(height: 60),
                    
                    // SECTION 8 - Anti-copie (en italique)
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: colorScheme.surfaceVariant.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: colorScheme.outline.withOpacity(0.3),
                        ),
                      ),
                      child: Text(
                        'Toute reproduction, même partielle, du contenu du site Azur Confort est strictement interdite sans autorisation écrite.',
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                          fontStyle: FontStyle.italic,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    
                    const SizedBox(height: 40),
                    
                    // Bouton retour à l'accueil
                    Center(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          _AzurConfortHomeState.navigateToPage(0);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryBlue,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        icon: const Icon(Icons.home),
                        label: const Text(
                          'Retour à l\'accueil',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Footer
          _buildFooter(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isMobile) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: isMobile ? 50 : 70,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [kDarkBlue, kPrimaryBlue],
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.gavel, color: Colors.white, size: 40),
              ),
              const SizedBox(height: 24),
              Text(
                'Mentions légales',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: isMobile ? 28 : 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Azur Confort',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: isMobile ? 16 : 18,
                  color: Colors.white.withOpacity(0.85),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, String content) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Titre de section
        Container(
          padding: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: kPrimaryBlue.withOpacity(0.3),
                width: 2,
              ),
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: kPrimaryBlue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  _getIconForSection(title),
                  color: kPrimaryBlue,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: textTheme.titleLarge?.copyWith(
                    color: colorScheme.onBackground,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        // Contenu
        Text(
          content,
          style: textTheme.bodyLarge?.copyWith(
            color: colorScheme.onBackground,
            height: 1.8,
          ),
        ),
      ],
    );
  }

  IconData _getIconForSection(String title) {
    if (title.contains('Éditeur')) return Icons.business;
    if (title.contains('Hébergeur')) return Icons.cloud;
    if (title.contains('Propriété')) return Icons.copyright;
    if (title.contains('Données')) return Icons.security;
    if (title.contains('Cookies')) return Icons.cookie;
    if (title.contains('Responsabilité')) return Icons.warning_amber;
    if (title.contains('Droit')) return Icons.balance;
    return Icons.article;
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [kDarkBlue, Color(0xFF1565C0)],
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.ac_unit, color: Colors.white, size: 32),
                  SizedBox(width: 12),
                  Text(
                    'AZUR CONFORT',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Text(
                'Artisan frigoriste sur la Côte d\'Azur (06 & 83)',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 32),
              Text(
                '© 2025 Azur Confort - Tous droits réservés',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 12),
              // Bouton retour accueil
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    _AzurConfortHomeState.navigateToPage(0);
                  },
                  child: Text(
                    'Retour à l\'accueil',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.6),
                      fontSize: 12,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.white.withOpacity(0.6),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// CHATBOT AZUR CONFORT - ASSISTANT VIRTUEL
// ============================================================================

/// Widget principal du chatbot flottant
class AzurChatbot extends StatefulWidget {
  const AzurChatbot({Key? key}) : super(key: key);

  @override
  State<AzurChatbot> createState() => _AzurChatbotState();
}

class _AzurChatbotState extends State<AzurChatbot> with SingleTickerProviderStateMixin {
  bool _isOpen = false;
  bool _showWelcome = true;
  bool _isBotTyping = false; // Indicateur "bot en train d'écrire"
  final List<_ChatMessage> _messages = [];
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late AnimationController _bounceController;
  late Animation<double> _bounceAnimation;

  // Options rapides du chatbot
  final List<_QuickOption> _quickOptions = [
    _QuickOption(
      id: 'devis',
      label: '📋 Demander un devis',
      icon: Icons.description,
    ),
    _QuickOption(
      id: 'urgence',
      label: '🚨 Urgence / Dépannage',
      icon: Icons.warning,
    ),
    _QuickOption(
      id: 'disponibilite',
      label: '📅 Disponibilités',
      icon: Icons.calendar_today,
    ),
    _QuickOption(
      id: 'services',
      label: '🔧 Nos services',
      icon: Icons.build,
    ),
    _QuickOption(
      id: 'contact',
      label: '📞 Nous contacter',
      icon: Icons.phone,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _bounceController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);
    _bounceAnimation = Tween<double>(begin: 0, end: 8).animate(
      CurvedAnimation(parent: _bounceController, curve: Curves.easeInOut),
    );
    
    // Message de bienvenue après 2 secondes
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted && _showWelcome) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _bounceController.dispose();
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _toggleChat() {
    setState(() {
      _isOpen = !_isOpen;
      _showWelcome = false;
      if (_isOpen && _messages.isEmpty) {
        // Message d'accueil du bot
        _messages.add(_ChatMessage(
          text: 'Bonjour ! 👋 Je suis Clim\', votre assistant Azur Confort.\n\nComment puis-je vous aider aujourd\'hui ?',
          isBot: true,
        ));
      }
    });
  }

  /// Gère les messages tapés par l'utilisateur avec recherche FAQ intelligente
  void _handleUserMessage(String text) {
    if (text.isEmpty) return;
    
    setState(() {
      _messages.add(_ChatMessage(text: text, isBot: false));
      _textController.clear();
      _isBotTyping = true; // Afficher l'indicateur de frappe
    });
    
    // Scroll vers le bas pour voir l'indicateur
    _scrollToBottom();
    
    // Recherche dans la FAQ avec délai pour l'effet "réflexion"
    Future.delayed(const Duration(milliseconds: 1200), () {
      final faqAnswer = findFaqAnswer(text);
      
      setState(() {
        _isBotTyping = false; // Masquer l'indicateur
        
        if (faqAnswer != null) {
          // Réponse trouvée dans la FAQ
          _messages.add(_ChatMessage(
            text: faqAnswer,
            isBot: true,
            options: [
              _QuickOption(id: 'devis', label: '📋 Demander un devis', icon: Icons.description),
              _QuickOption(id: 'appeler', label: '📞 Appeler', icon: Icons.phone),
              _QuickOption(id: 'retour', label: '↩️ Menu principal', icon: Icons.arrow_back),
            ],
          ));
        } else {
          // Pas de réponse trouvée - message par défaut
          _messages.add(_ChatMessage(
            text: 'Je n\'ai pas trouvé de réponse précise à votre question.\n\n'
                '💡 **Suggestions :**\n'
                '• Essayez avec des mots-clés simples (clim, fuite, panne...)\n'
                '• Utilisez les boutons ci-dessous\n'
                '• Ou appelez-nous directement !\n\n'
                '📞 $kPhoneNumberFormatted',
            isBot: true,
            options: _quickOptions,
          ));
        }
      });
      
      _scrollToBottom();
    });
  }
  
  /// Scroll vers le bas de la liste de messages
  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _handleQuickOption(_QuickOption option) {
    setState(() {
      _messages.add(_ChatMessage(text: option.label, isBot: false));
    });
    
    Future.delayed(const Duration(milliseconds: 500), () {
      String response = '';
      List<_QuickOption>? subOptions;
      
      switch (option.id) {
        case 'devis':
          response = '📋 **Demande de devis**\n\nPour établir un devis gratuit et personnalisé, j\'ai besoin de quelques informations :\n\n• Type de prestation souhaitée\n• Votre localisation (ville)\n• Vos coordonnées\n\nVoulez-vous remplir le formulaire de contact ou préférez-vous nous appeler directement ?';
          subOptions = [
            _QuickOption(id: 'formulaire', label: '📝 Formulaire de contact', icon: Icons.edit),
            _QuickOption(id: 'appeler', label: '📞 Appeler maintenant', icon: Icons.phone),
          ];
          break;
          
        case 'urgence':
          response = '🚨 **Urgence / Dépannage**\n\nNous intervenons rapidement pour :\n\n• Panne de climatisation\n• Fuite d\'eau urgente\n• Panne de chauffage\n• Problème de chambre froide\n\n⚡ **Intervention rapide 7j/7**\n\nAppelez-nous immédiatement au **$kPhoneNumberFormatted**';
          subOptions = [
            _QuickOption(id: 'appeler', label: '📞 Appeler maintenant', icon: Icons.phone),
            _QuickOption(id: 'whatsapp', label: '💬 WhatsApp', icon: Icons.message),
          ];
          break;
          
        case 'disponibilite':
          response = '📅 **Nos disponibilités**\n\n🕐 **Horaires d\'intervention :**\n• Lundi - Vendredi : 8h - 19h\n• Samedi : 9h - 17h\n• Urgences : 7j/7\n\n📍 **Zone d\'intervention :**\nAlpes-Maritimes (06) & Var (83)\n\n💡 Nous pouvons généralement intervenir sous 24-48h pour les demandes standards.';
          subOptions = [
            _QuickOption(id: 'devis', label: '📋 Prendre RDV', icon: Icons.calendar_today),
            _QuickOption(id: 'retour', label: '↩️ Retour au menu', icon: Icons.arrow_back),
          ];
          break;
          
        case 'services':
          response = '🔧 **Nos services**\n\nNous sommes spécialisés dans :\n\n❄️ **Climatisation** - Installation, entretien, dépannage\n🧊 **Frigoriste** - Chambres froides, vitrines réfrigérées\n🌡️ **Pompes à chaleur** - PAC air/air, air/eau\n🔥 **Chauffage** - Chaudières, radiateurs\n💧 **Plomberie** - Dépannage, installation\n\nQuel service vous intéresse ?';
          subOptions = [
            _QuickOption(id: 'clim', label: '❄️ Climatisation', icon: Icons.ac_unit),
            _QuickOption(id: 'frigo', label: '🧊 Frigoriste', icon: Icons.severe_cold),
            _QuickOption(id: 'pac', label: '🌡️ Pompes à chaleur', icon: Icons.thermostat),
            _QuickOption(id: 'chauffage', label: '🔥 Chauffage', icon: Icons.local_fire_department),
            _QuickOption(id: 'plomberie', label: '💧 Plomberie', icon: Icons.water_drop),
          ];
          break;
          
        case 'contact':
          response = '📞 **Nous contacter**\n\n📱 **Téléphone :** $kPhoneNumberFormatted\n💬 **WhatsApp :** Disponible\n📧 **Email :** contact@azur-confort.fr\n\n📍 **Zone d\'intervention :**\nCôte d\'Azur (06 & 83)';
          subOptions = [
            _QuickOption(id: 'appeler', label: '📞 Appeler', icon: Icons.phone),
            _QuickOption(id: 'whatsapp', label: '💬 WhatsApp', icon: Icons.message),
            _QuickOption(id: 'email', label: '📧 Email', icon: Icons.email),
          ];
          break;
          
        case 'appeler':
          launchPhone();
          response = '📞 **Appel en cours...**\n\nNuméro : **$kPhoneNumberFormatted**\n\nSi l\'appel ne s\'ouvre pas, composez directement ce numéro.';
          subOptions = [
            _QuickOption(id: 'retour', label: '↩️ Retour au menu', icon: Icons.arrow_back),
          ];
          break;
          
        case 'whatsapp':
          launchWhatsApp();
          response = '💬 **WhatsApp**\n\nEnvoyez-nous un message avec :\n• Votre besoin\n• Votre ville\n• Des photos si nécessaire\n\nNous répondons rapidement !';
          subOptions = [
            _QuickOption(id: 'retour', label: '↩️ Retour au menu', icon: Icons.arrow_back),
          ];
          break;
          
        case 'email':
          launchEmail();
          response = '📧 **Email**\n\nAdresse : **contact@azur-confort.fr**\n\nDécrivez votre projet, nous vous répondons sous 24h.';
          subOptions = [
            _QuickOption(id: 'retour', label: '↩️ Retour au menu', icon: Icons.arrow_back),
          ];
          break;
          
        case 'formulaire':
          _AzurConfortHomeState.navigateToPage(2);
          response = '📝 Je vous redirige vers notre formulaire de contact...\n\nRemplissez vos informations et nous vous recontacterons rapidement !';
          Future.delayed(const Duration(milliseconds: 500), () {
            setState(() => _isOpen = false);
          });
          break;
          
        case 'clim':
          response = '❄️ **Climatisation**\n\n**Nos prestations :**\n• Installation clim monosplit\n• Installation clim multisplit\n• Entretien annuel\n• Dépannage et réparation\n• Remplacement de climatiseur\n\n💰 **Devis gratuit** - Intervention rapide sur le 06 et 83';
          subOptions = [
            _QuickOption(id: 'devis', label: '📋 Devis climatisation', icon: Icons.description),
            _QuickOption(id: 'services', label: '↩️ Autres services', icon: Icons.arrow_back),
          ];
          break;
          
        case 'frigo':
          response = '🧊 **Frigoriste**\n\n**Nos prestations :**\n• Chambres froides positives/négatives\n• Vitrines réfrigérées\n• Meubles frigorifiques\n• Groupes froids\n• Maintenance préventive\n\n🏪 Idéal pour commerces, restaurants, grandes surfaces';
          subOptions = [
            _QuickOption(id: 'devis', label: '📋 Devis frigoriste', icon: Icons.description),
            _QuickOption(id: 'services', label: '↩️ Autres services', icon: Icons.arrow_back),
          ];
          break;
          
        case 'pac':
          response = '🌡️ **Pompes à chaleur**\n\n**Nos prestations :**\n• PAC Air/Air réversible\n• PAC Air/Eau\n• Ballon thermodynamique\n• Entretien annuel PAC\n• Dépannage et SAV\n\n🌿 Solution écologique et économique !';
          subOptions = [
            _QuickOption(id: 'devis', label: '📋 Devis PAC', icon: Icons.description),
            _QuickOption(id: 'services', label: '↩️ Autres services', icon: Icons.arrow_back),
          ];
          break;
          
        case 'chauffage':
          response = '🔥 **Chauffage**\n\n**Nos prestations :**\n• Chaudières gaz/fioul\n• Radiateurs électriques\n• Plancher chauffant\n• Entretien chaudière\n• Dépannage chauffage\n\n🏠 Pour un confort optimal toute l\'année';
          subOptions = [
            _QuickOption(id: 'devis', label: '📋 Devis chauffage', icon: Icons.description),
            _QuickOption(id: 'services', label: '↩️ Autres services', icon: Icons.arrow_back),
          ];
          break;
          
        case 'plomberie':
          response = '💧 **Plomberie**\n\n**Nos prestations :**\n• Dépannage fuite d\'eau\n• Installation sanitaires\n• Rénovation salle de bain\n• Débouchage canalisations\n• Chauffe-eau / cumulus\n\n🔧 Intervention rapide en cas d\'urgence';
          subOptions = [
            _QuickOption(id: 'devis', label: '📋 Devis plomberie', icon: Icons.description),
            _QuickOption(id: 'services', label: '↩️ Autres services', icon: Icons.arrow_back),
          ];
          break;
          
        case 'retour':
          response = 'Comment puis-je vous aider ?';
          subOptions = _quickOptions;
          break;
          
        default:
          response = 'Je n\'ai pas compris votre demande. Voici ce que je peux faire pour vous :';
          subOptions = _quickOptions;
      }
      
      setState(() {
        _messages.add(_ChatMessage(
          text: response,
          isBot: true,
          options: subOptions,
        ));
      });
      
      // Scroll vers le bas
      Future.delayed(const Duration(milliseconds: 100), () {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Stack(
      children: [
        // Bulle de bienvenue (avant ouverture) - AMÉLIORÉE POUR MODE NUIT
        if (_showWelcome && !_isOpen)
          Positioned(
            bottom: 100,
            right: 20,
            child: AnimatedBuilder(
              animation: _bounceAnimation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, -_bounceAnimation.value),
                  child: child,
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  // Fond avec dégradé bleu pour meilleure visibilité
                  gradient: const LinearGradient(
                    colors: [kPrimaryBlue, kDarkBlue],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: kAccentYellow.withOpacity(0.5),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: kPrimaryBlue.withOpacity(0.4),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                    BoxShadow(
                      color: colorScheme.shadow.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      '👋 Besoin d\'aide ?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.white, // Blanc sur fond bleu = toujours lisible
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () => setState(() => _showWelcome = false),
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.close, size: 14, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        
        // Fenêtre du chatbot
        if (_isOpen)
          Positioned(
            bottom: 100,
            right: 20,
            child: _buildChatWindow(),
          ),
        
        // Bouton flottant avec mascotte - AMÉLIORÉ POUR MODE NUIT
        Positioned(
          bottom: 20,
          right: 20,
          child: GestureDetector(
            onTap: _toggleChat,
            child: AnimatedBuilder(
              animation: _bounceAnimation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, _isOpen ? 0 : -_bounceAnimation.value / 2),
                  child: child,
                );
              },
              child: Container(
                width: 75,
                height: 75,
                decoration: BoxDecoration(
                  // Fond avec dégradé pour meilleure visibilité jour/nuit
                  gradient: LinearGradient(
                    colors: [
                      colorScheme.surface,
                      colorScheme.surfaceVariant,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                  // Bordure bleue plus visible
                  border: Border.all(
                    color: kPrimaryBlue,
                    width: 3,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: kPrimaryBlue.withOpacity(0.5),
                      blurRadius: 25,
                      offset: const Offset(0, 8),
                    ),
                    BoxShadow(
                      color: kAccentYellow.withOpacity(0.2),
                      blurRadius: 15,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Mascotte - plus grande et visible
                    ClipOval(
                      child: Image.asset(
                        'assets/images/chatbot_mascot.png',
                        width: 65,
                        height: 65,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            _isOpen ? Icons.close : Icons.chat,
                            color: kPrimaryBlue,
                            size: 36,
                          );
                        },
                      ),
                    ),
                    // Indicateur de fermeture
                    if (_isOpen)
                      Positioned(
                        top: -2,
                        right: -2,
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 14,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildChatWindow() {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 500;
    final colorScheme = Theme.of(context).colorScheme;
    
    return Container(
      width: isMobile ? screenWidth - 40 : 380,
      height: 500,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.15),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          // En-tête
          _buildChatHeader(),
          // Messages
          Expanded(
            child: _buildMessageList(),
          ),
          // Options rapides (si dernier message a des options)
          if (_messages.isNotEmpty && _messages.last.options != null)
            _buildQuickOptionsBar(_messages.last.options!),
          // Zone de saisie
          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildChatHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [kPrimaryBlue, kDarkBlue],
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Row(
        children: [
          // Avatar mascotte
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: ClipOval(
              child: Image.asset(
                'assets/images/chatbot_mascot.png',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.ac_unit, color: kPrimaryBlue);
                },
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Infos
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Clim\' - Assistant Azur',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Colors.greenAccent,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'En ligne',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Bouton fermer
          IconButton(
            onPressed: _toggleChat,
            icon: const Icon(Icons.close, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    final colorScheme = Theme.of(context).colorScheme;
    if (_messages.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.chat_bubble_outline, size: 48, color: colorScheme.outline),
            const SizedBox(height: 16),
            Text(
              'Démarrez la conversation !',
              style: TextStyle(color: colorScheme.onSurfaceVariant),
            ),
          ],
        ),
      );
    }
    
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(16),
      itemCount: _messages.length + (_isBotTyping ? 1 : 0),
      itemBuilder: (context, index) {
        // Afficher l'indicateur de frappe en dernier
        if (_isBotTyping && index == _messages.length) {
          return _buildTypingIndicator();
        }
        final message = _messages[index];
        return _buildMessageBubble(message);
      },
    );
  }

  /// Indicateur animé "bot en train d'écrire..."
  Widget _buildTypingIndicator() {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isDark ? colorScheme.surfaceVariant : kLightBlue,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(18),
            topRight: Radius.circular(18),
            bottomLeft: Radius.circular(4),
            bottomRight: Radius.circular(18),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildAnimatedDot(0),
            const SizedBox(width: 4),
            _buildAnimatedDot(1),
            const SizedBox(width: 4),
            _buildAnimatedDot(2),
          ],
        ),
      ),
    );
  }

  /// Point animé pour l'indicateur de frappe
  Widget _buildAnimatedDot(int index) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 600 + (index * 200)),
      builder: (context, value, child) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: kPrimaryBlue.withOpacity(0.4 + (0.6 * ((value * 2 - 1).abs()))),
            shape: BoxShape.circle,
          ),
        );
      },
      onEnd: () {
        // Redémarrer l'animation si toujours en train de taper
        if (_isBotTyping && mounted) {
          setState(() {});
        }
      },
    );
  }

  Widget _buildMessageBubble(_ChatMessage message) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    // Couleurs adaptatives pour les bulles
    final botBubbleColor = isDark ? colorScheme.surfaceVariant : kLightBlue;
    final botTextColor = colorScheme.onSurface;
    final userBubbleColor = kPrimaryBlue;
    const userTextColor = Colors.white;
    
    return Align(
      alignment: message.isBot ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        constraints: const BoxConstraints(maxWidth: 280),
        decoration: BoxDecoration(
          color: message.isBot ? botBubbleColor : userBubbleColor,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(18),
            topRight: const Radius.circular(18),
            bottomLeft: Radius.circular(message.isBot ? 4 : 18),
            bottomRight: Radius.circular(message.isBot ? 18 : 4),
          ),
        ),
        child: Text(
          message.text,
          style: TextStyle(
            color: message.isBot ? botTextColor : userTextColor,
            fontSize: 14,
            height: 1.4,
          ),
        ),
      ),
    );
  }

  Widget _buildQuickOptionsBar(List<_QuickOption> options) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: options.length,
        itemBuilder: (context, index) {
          final option = options[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
            child: ElevatedButton(
              onPressed: () => _handleQuickOption(option),
              style: ElevatedButton.styleFrom(
                backgroundColor: kLightBlue,
                foregroundColor: kDarkBlue,
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                option.label,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Row(
        children: [
          // Bouton poubelle pour effacer le texte
          AnimatedOpacity(
            opacity: _textController.text.isNotEmpty ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 200),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _textController.clear();
                });
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.delete_outline,
                  color: Colors.red.shade400,
                  size: 20,
                ),
              ),
            ),
          ),
          Expanded(
            child: TextField(
              controller: _textController,
              onChanged: (value) => setState(() {}), // Pour mettre à jour le bouton poubelle
              decoration: InputDecoration(
                hintText: 'Tapez votre message...',
                hintStyle: TextStyle(color: Colors.grey.shade400),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              onSubmitted: (text) => _handleUserMessage(text),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            decoration: const BoxDecoration(
              color: kPrimaryBlue,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () => _handleUserMessage(_textController.text),
              icon: const Icon(Icons.send, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}

/// Message du chatbot
class _ChatMessage {
  final String text;
  final bool isBot;
  final List<_QuickOption>? options;

  _ChatMessage({
    required this.text,
    required this.isBot,
    this.options,
  });
}

/// Option rapide du chatbot
class _QuickOption {
  final String id;
  final String label;
  final IconData icon;

  _QuickOption({
    required this.id,
    required this.label,
    required this.icon,
  });
}

// ============================================================================
// FAQ CHATBOT - BASE DE DONNÉES QUESTIONS/RÉPONSES
// ============================================================================

/// Structure d'une entrée FAQ
class _FaqEntry {
  final String category;
  final List<String> keywords;
  final String question;
  final String answer;

  const _FaqEntry({
    required this.category,
    required this.keywords,
    required this.question,
    required this.answer,
  });
}

/// Base de données FAQ complète
const List<_FaqEntry> kFaqDatabase = [
  // ==================== CLIMATISATION ====================
  _FaqEntry(
    category: 'Climatisation',
    keywords: ['installation', 'clim', 'réversible', 'installer', 'pose', 'monosplit', 'multisplit', 'nouvelle'],
    question: 'Installation de climatisation réversible',
    answer: '❄️ **Installation clim réversible**\n\n'
        'Nous installons tous types de climatisations :\n'
        '• Monosplit (1 unité intérieure)\n'
        '• Multisplit (plusieurs unités)\n'
        '• Gainable / Cassette\n\n'
        '✅ **Inclus dans nos prestations :**\n'
        '• Étude thermique gratuite\n'
        '• Conseil sur le dimensionnement\n'
        '• Installation aux normes\n'
        '• Mise en service et essais\n\n'
        '💰 Devis gratuit sous 24-48h',
  ),
  _FaqEntry(
    category: 'Climatisation',
    keywords: ['recharge', 'gaz', 'fluide', 'frigorigène', 'r410a', 'r32', 'manque', 'charge'],
    question: 'Recharge gaz / fluide frigorigène',
    answer: '🧊 **Recharge gaz climatisation**\n\n'
        'Votre clim ne refroidit plus assez ? Il peut s\'agir d\'un manque de gaz.\n\n'
        '**Notre intervention :**\n'
        '• Diagnostic complet du circuit\n'
        '• Recherche de fuite si nécessaire\n'
        '• Recharge en fluide frigorigène (R32, R410A...)\n'
        '• Contrôle des pressions\n\n'
        '⚠️ Une recharge fréquente indique une fuite à réparer.\n\n'
        '📞 Appelez-nous pour un diagnostic',
  ),
  _FaqEntry(
    category: 'Climatisation',
    keywords: ['coule', 'eau', 'goutte', 'fuite', 'condensat', 'bac', 'évacuation'],
    question: 'Climatisation qui coule / fuite d\'eau',
    answer: '💧 **Clim qui coule**\n\n'
        'Causes possibles :\n'
        '• Bac à condensats plein ou bouché\n'
        '• Évacuation obstruée\n'
        '• Pompe de relevage en panne\n'
        '• Givre sur l\'évaporateur\n\n'
        '**Notre intervention :**\n'
        '• Nettoyage du bac et de l\'évacuation\n'
        '• Vérification de la pompe de relevage\n'
        '• Contrôle du bon fonctionnement\n\n'
        '🔧 Intervention rapide pour éviter les dégâts des eaux',
  ),
  _FaqEntry(
    category: 'Climatisation',
    keywords: ['refroidit', 'plus', 'chaud', 'souffle', 'tiède', 'marche', 'fonctionne'],
    question: 'Climatisation qui ne refroidit plus',
    answer: '🌡️ **Clim qui ne refroidit plus**\n\n'
        'Plusieurs causes possibles :\n'
        '• Manque de gaz frigorigène\n'
        '• Filtres encrassés\n'
        '• Compresseur défaillant\n'
        '• Problème électronique\n\n'
        '**Diagnostic complet :**\n'
        '• Test des pressions\n'
        '• Vérification du compresseur\n'
        '• Contrôle électronique\n'
        '• Nettoyage si nécessaire\n\n'
        '⚡ Intervention rapide 7j/7',
  ),
  _FaqEntry(
    category: 'Climatisation',
    keywords: ['bruit', 'bruyant', 'vibration', 'claquement', 'sifflement', 'ronronne'],
    question: 'Climatisation bruyante',
    answer: '🔊 **Clim qui fait du bruit**\n\n'
        'Types de bruits et causes :\n'
        '• **Vibrations** : fixations desserrées\n'
        '• **Sifflement** : problème de gaz\n'
        '• **Claquement** : volet ou ventilateur\n'
        '• **Ronronnement fort** : compresseur fatigué\n\n'
        '**Solutions :**\n'
        '• Resserrage des fixations\n'
        '• Remplacement des silentblocs\n'
        '• Nettoyage du ventilateur\n'
        '• Diagnostic compresseur\n\n'
        '🔇 Retrouvez le silence !',
  ),
  
  // ==================== FRIGORISTE ====================
  _FaqEntry(
    category: 'Frigoriste',
    keywords: ['fuite', 'diagnostic', 'détection', 'recherche', 'gaz', 'frigorigène'],
    question: 'Diagnostic et recherche de fuite',
    answer: '🔍 **Diagnostic fuite frigorifique**\n\n'
        'Nous utilisons des équipements professionnels :\n'
        '• Détecteur électronique de fuite\n'
        '• Traceur UV\n'
        '• Test d\'azote sous pression\n\n'
        '**Intervention :**\n'
        '• Localisation précise de la fuite\n'
        '• Réparation (brasure, remplacement)\n'
        '• Recharge et mise en service\n'
        '• Contrôle d\'étanchéité\n\n'
        '🏪 Pour particuliers et professionnels',
  ),
  _FaqEntry(
    category: 'Frigoriste',
    keywords: ['chambre', 'froide', 'frigo', 'professionnel', 'commerce', 'restaurant', 'positive', 'négative'],
    question: 'Chambre froide',
    answer: '🧊 **Chambre froide**\n\n'
        'Installation et dépannage :\n'
        '• Chambres froides **positives** (0 à +8°C)\n'
        '• Chambres froides **négatives** (-18 à -25°C)\n\n'
        '**Nos services :**\n'
        '• Installation complète\n'
        '• Dépannage urgent\n'
        '• Contrat de maintenance\n'
        '• Remplacement groupe froid\n\n'
        '🏪 Restaurants, commerces, grandes surfaces\n\n'
        '⚡ **Urgence 7j/7** pour éviter la perte de marchandise',
  ),
  _FaqEntry(
    category: 'Frigoriste',
    keywords: ['pression', 'contrôle', 'entretien', 'maintenance', 'préventif', 'vérification'],
    question: 'Contrôle pression et entretien frigorifique',
    answer: '🔧 **Entretien frigorifique**\n\n'
        '**Contrôle annuel recommandé :**\n'
        '• Vérification des pressions HP/BP\n'
        '• Contrôle des températures\n'
        '• Nettoyage condenseur/évaporateur\n'
        '• Test d\'étanchéité circuit\n'
        '• Vérification électrique\n\n'
        '**Avantages maintenance :**\n'
        '• Évite les pannes coûteuses\n'
        '• Optimise les performances\n'
        '• Prolonge la durée de vie\n'
        '• Réduit la consommation\n\n'
        '📋 Contrats de maintenance disponibles',
  ),
  
  // ==================== PLOMBERIE ====================
  _FaqEntry(
    category: 'Plomberie',
    keywords: ['fuite', 'eau', 'tuyau', 'canalisation', 'goutte', 'inondation', 'dégât'],
    question: 'Fuite d\'eau',
    answer: '💧 **Fuite d\'eau**\n\n'
        '**En cas de fuite :**\n'
        '1. Coupez l\'arrivée d\'eau\n'
        '2. Appelez-nous immédiatement\n\n'
        '**Nos interventions :**\n'
        '• Recherche de fuite\n'
        '• Réparation canalisation\n'
        '• Remplacement tuyauterie\n'
        '• Colmatage d\'urgence\n\n'
        '🚨 **Intervention urgente possible**\n'
        '📞 Appelez le $kPhoneNumberFormatted',
  ),
  _FaqEntry(
    category: 'Plomberie',
    keywords: ['urgence', 'urgent', 'dépannage', 'rapide', 'immédiat', 'vite', 'sos'],
    question: 'Urgence plomberie',
    answer: '🚨 **Urgence plomberie**\n\n'
        'Nous intervenons rapidement pour :\n'
        '• Fuite importante\n'
        '• Canalisation bouchée\n'
        '• WC hors service\n'
        '• Chauffe-eau en panne\n'
        '• Dégât des eaux\n\n'
        '⚡ **Disponible 7j/7**\n'
        '📍 Intervention sur Nice, Cannes, Antibes et environs\n\n'
        '📞 **Appelez maintenant : $kPhoneNumberFormatted**',
  ),
  _FaqEntry(
    category: 'Plomberie',
    keywords: ['débouchage', 'bouché', 'bouchon', 'wc', 'toilette', 'évier', 'lavabo', 'canalisation'],
    question: 'Débouchage canalisation',
    answer: '🚿 **Débouchage**\n\n'
        '**Nous débouchons :**\n'
        '• WC / Toilettes\n'
        '• Éviers et lavabos\n'
        '• Douches et baignoires\n'
        '• Canalisations principales\n\n'
        '**Méthodes utilisées :**\n'
        '• Furet électrique\n'
        '• Débouchage haute pression\n'
        '• Inspection caméra si nécessaire\n\n'
        '✅ Résultat garanti',
  ),
  _FaqEntry(
    category: 'Plomberie',
    keywords: ['robinet', 'robinetterie', 'mitigeur', 'remplacement', 'changement', 'installation'],
    question: 'Remplacement robinetterie',
    answer: '🚰 **Robinetterie**\n\n'
        '**Nos prestations :**\n'
        '• Remplacement robinet/mitigeur\n'
        '• Installation colonne de douche\n'
        '• Changement mécanisme WC\n'
        '• Réparation fuite robinet\n\n'
        '**Marques installées :**\n'
        'Grohe, Hansgrohe, Jacob Delafon, Ideal Standard...\n\n'
        '💰 Devis gratuit avec fourniture ou pose seule',
  ),
  
  // ==================== CHAUFFAGE / PAC ====================
  _FaqEntry(
    category: 'Chauffage',
    keywords: ['entretien', 'pac', 'pompe', 'chaleur', 'maintenance', 'révision', 'annuel'],
    question: 'Entretien pompe à chaleur',
    answer: '🌡️ **Entretien PAC**\n\n'
        '**Entretien annuel obligatoire :**\n'
        '• Nettoyage filtres et échangeurs\n'
        '• Contrôle du fluide frigorigène\n'
        '• Vérification des performances\n'
        '• Test des sécurités\n'
        '• Rapport d\'intervention\n\n'
        '**Avantages :**\n'
        '• Garantie constructeur maintenue\n'
        '• Performances optimales\n'
        '• Durée de vie prolongée\n\n'
        '📋 Contrat d\'entretien disponible',
  ),
  _FaqEntry(
    category: 'Chauffage',
    keywords: ['panne', 'chauffage', 'chauffe', 'plus', 'froid', 'marche', 'fonctionne'],
    question: 'Panne de chauffage',
    answer: '🔥 **Panne chauffage**\n\n'
        '**Dépannage rapide :**\n'
        '• Pompes à chaleur\n'
        '• Chaudières gaz/fioul\n'
        '• Radiateurs électriques\n'
        '• Plancher chauffant\n\n'
        '**Diagnostic complet :**\n'
        '• Vérification électrique\n'
        '• Contrôle brûleur/compresseur\n'
        '• Test des sondes et régulations\n\n'
        '❄️ Intervention rapide en période de froid\n'
        '📞 $kPhoneNumberFormatted',
  ),
  _FaqEntry(
    category: 'Chauffage',
    keywords: ['radiateur', 'purge', 'chauffe', 'tiède', 'froid', 'bruit', 'purger'],
    question: 'Problème radiateurs',
    answer: '🔥 **Radiateurs**\n\n'
        '**Problèmes courants :**\n'
        '• Radiateur froid en haut → purge nécessaire\n'
        '• Radiateur tiède → désembouage circuit\n'
        '• Bruit dans les tuyaux → air dans le circuit\n'
        '• Fuite au niveau de la vanne\n\n'
        '**Nos interventions :**\n'
        '• Purge du circuit\n'
        '• Désembouage\n'
        '• Remplacement vannes/robinets\n'
        '• Équilibrage du réseau\n\n'
        '🏠 Pour un chauffage homogène',
  ),
  
  // ==================== ÉLECTRICITÉ ====================
  _FaqEntry(
    category: 'Électricité',
    keywords: ['coupure', 'courant', 'électricité', 'panne', 'plus', 'rien'],
    question: 'Coupure de courant',
    answer: '⚡ **Coupure électrique**\n\n'
        '**Vérifications à faire :**\n'
        '1. Le disjoncteur général est-il en position ON ?\n'
        '2. Un disjoncteur divisionnaire a-t-il sauté ?\n'
        '3. Vos voisins ont-ils du courant ?\n\n'
        '**Si le problème persiste :**\n'
        '• Recherche de court-circuit\n'
        '• Vérification du tableau électrique\n'
        '• Contrôle des prises et circuits\n\n'
        '🔌 Intervention pour dépannage électrique basique',
  ),
  _FaqEntry(
    category: 'Électricité',
    keywords: ['disjoncteur', 'saute', 'déclenche', 'tableau', 'différentiel'],
    question: 'Disjoncteur qui saute',
    answer: '⚡ **Disjoncteur qui saute**\n\n'
        '**Causes possibles :**\n'
        '• Surcharge électrique\n'
        '• Court-circuit\n'
        '• Appareil défectueux\n'
        '• Défaut d\'isolement\n\n'
        '**Notre intervention :**\n'
        '• Identification de la cause\n'
        '• Test des circuits\n'
        '• Remplacement disjoncteur si nécessaire\n'
        '• Mise en conformité\n\n'
        '🔧 Dépannage électrique basique inclus',
  ),
  _FaqEntry(
    category: 'Électricité',
    keywords: ['thermostat', 'installation', 'programmateur', 'régulation', 'connecté', 'wifi'],
    question: 'Installation thermostat',
    answer: '🌡️ **Thermostat / Régulation**\n\n'
        '**Nous installons :**\n'
        '• Thermostat d\'ambiance\n'
        '• Thermostat programmable\n'
        '• Thermostat connecté (WiFi)\n'
        '• Régulation par zone\n\n'
        '**Avantages :**\n'
        '• Confort optimal\n'
        '• Économies d\'énergie (15-25%)\n'
        '• Pilotage à distance\n\n'
        '💡 Compatible PAC, chaudière, radiateurs',
  ),
  
  // ==================== ZONES D'INTERVENTION ====================
  _FaqEntry(
    category: 'Zone',
    keywords: ['nice', 'cannes', 'antibes', 'grasse', 'menton', 'cagnes', '06', 'alpes', 'maritimes'],
    question: 'Intervention Alpes-Maritimes (06)',
    answer: '📍 **Alpes-Maritimes (06)**\n\n'
        '**Villes desservies :**\n'
        '• Nice et agglomération\n'
        '• Cannes, Antibes, Juan-les-Pins\n'
        '• Grasse, Mougins, Valbonne\n'
        '• Menton, Monaco\n'
        '• Cagnes-sur-Mer, Saint-Laurent-du-Var\n'
        '• Villeneuve-Loubet, Biot\n'
        '• Carros, Vence, Saint-Paul\n\n'
        '✅ **Déplacement gratuit** selon intervention\n'
        '📞 $kPhoneNumberFormatted',
  ),
  _FaqEntry(
    category: 'Zone',
    keywords: ['fréjus', 'saint', 'raphaël', 'draguignan', '83', 'var', 'toulon'],
    question: 'Intervention Var (83)',
    answer: '📍 **Var (83)**\n\n'
        '**Villes desservies :**\n'
        '• Fréjus, Saint-Raphaël\n'
        '• Draguignan\n'
        '• Sainte-Maxime\n'
        '• Roquebrune-sur-Argens\n'
        '• Le Muy, Puget-sur-Argens\n'
        '• Trans-en-Provence\n\n'
        '✅ **Déplacement gratuit** selon intervention\n'
        '📞 $kPhoneNumberFormatted',
  ),
  _FaqEntry(
    category: 'Zone',
    keywords: ['déplacement', 'frais', 'gratuit', 'zone', 'secteur', 'intervention'],
    question: 'Frais de déplacement',
    answer: '🚗 **Frais de déplacement**\n\n'
        '**Notre politique :**\n'
        '• Déplacement **GRATUIT** pour toute intervention\n'
        '• Devis sur place offert\n'
        '• Pas de frais cachés\n\n'
        '📍 **Zone couverte :**\n'
        '• Alpes-Maritimes (06)\n'
        '• Var Est (83)\n\n'
        '💡 Le déplacement est inclus dans le prix de l\'intervention',
  ),
  
  // ==================== HORAIRES ====================
  _FaqEntry(
    category: 'Horaires',
    keywords: ['horaire', 'heure', 'ouvert', 'disponible', 'quand', 'jour', 'semaine'],
    question: 'Horaires d\'ouverture',
    answer: '🕐 **Nos horaires**\n\n'
        '**Interventions standards :**\n'
        '• Lundi - Samedi : **8h - 20h**\n'
        '• Dimanche : sur rendez-vous\n\n'
        '**Urgences :**\n'
        '• Disponible **7j/7**\n'
        '• Intervention rapide selon disponibilité\n\n'
        '📞 Appelez-nous : $kPhoneNumberFormatted\n'
        '💬 Ou envoyez un WhatsApp',
  ),
  _FaqEntry(
    category: 'Horaires',
    keywords: ['urgence', 'urgent', 'nuit', 'weekend', 'dimanche', 'férié', '24h'],
    question: 'Urgences et disponibilités',
    answer: '🚨 **Urgences**\n\n'
        '**Service d\'urgence disponible :**\n'
        '• Fuite d\'eau importante\n'
        '• Panne de chambre froide (pro)\n'
        '• Panne chauffage en hiver\n'
        '• Climatisation HS en canicule\n\n'
        '⚡ **Intervention rapide 7j/7**\n'
        '📞 Appelez le $kPhoneNumberFormatted\n\n'
        '💡 Décrivez votre urgence, nous ferons notre maximum',
  ),
  
  // ==================== DEVIS ====================
  _FaqEntry(
    category: 'Devis',
    keywords: ['devis', 'gratuit', 'prix', 'tarif', 'coût', 'combien', 'estimation'],
    question: 'Devis gratuit',
    answer: '📋 **Devis gratuit**\n\n'
        '**Notre engagement :**\n'
        '• Devis **100% gratuit**\n'
        '• Sans engagement\n'
        '• Réponse sous 24-48h\n\n'
        '**Pour un devis précis :**\n'
        '• Décrivez votre besoin\n'
        '• Envoyez des photos si possible\n'
        '• Indiquez votre ville\n\n'
        '📝 Formulaire de contact disponible\n'
        '📞 Ou appelez le $kPhoneNumberFormatted',
  ),
  _FaqEntry(
    category: 'Devis',
    keywords: ['photo', 'whatsapp', 'envoyer', 'image', 'formulaire', 'demande'],
    question: 'Envoyer photos pour devis',
    answer: '📸 **Envoi de photos**\n\n'
        '**Via WhatsApp (recommandé) :**\n'
        '• Rapide et pratique\n'
        '• Réponse immédiate\n'
        '• Discussion directe\n\n'
        '**Via formulaire de contact :**\n'
        '• Décrivez votre besoin en détail\n'
        '• Nous vous recontactons\n\n'
        '📱 WhatsApp : $kPhoneNumberFormatted\n\n'
        '💡 Les photos nous aident à établir un devis précis',
  ),
  
  // ==================== POLITESSE / CONVERSATION ====================
  _FaqEntry(
    category: 'Politesse',
    keywords: ['merci', 'remercie', 'remercier', 'thanks', 'thank'],
    question: 'Remerciements',
    answer: '😊 **Avec plaisir !**\n\n'
        'Je suis là pour vous aider.\n\n'
        'N\'hésitez pas si vous avez d\'autres questions !',
  ),
  _FaqEntry(
    category: 'Politesse',
    keywords: ['parfait', 'super', 'genial', 'excellent', 'top', 'cool', 'nickel', 'impeccable'],
    question: 'Satisfaction',
    answer: '👍 **Super !**\n\n'
        'Ravi de pouvoir vous aider !\n\n'
        'Si vous avez besoin d\'autre chose, je suis là.',
  ),
  _FaqEntry(
    category: 'Politesse',
    keywords: ['ok', 'okay', 'daccord', 'd accord', 'compris', 'entendu', 'bien'],
    question: 'Confirmation',
    answer: '✅ **Parfait !**\n\n'
        'Y a-t-il autre chose que je puisse faire pour vous ?',
  ),
  _FaqEntry(
    category: 'Politesse',
    keywords: ['bonjour', 'bonsoir', 'salut', 'hello', 'coucou', 'hey'],
    question: 'Salutations',
    answer: '👋 **Bonjour !**\n\n'
        'Bienvenue chez Azur Confort !\n\n'
        'Comment puis-je vous aider aujourd\'hui ?\n'
        '• Demande de devis\n'
        '• Question sur nos services\n'
        '• Urgence / dépannage',
  ),
  _FaqEntry(
    category: 'Politesse',
    keywords: ['aurevoir', 'au revoir', 'bye', 'a bientot', 'bonne journee', 'bonne soiree'],
    question: 'Au revoir',
    answer: '👋 **À bientôt !**\n\n'
        'Merci de votre visite sur Azur Confort.\n\n'
        'N\'hésitez pas à revenir si vous avez des questions.\n'
        '📞 $kPhoneNumberFormatted',
  ),
  _FaqEntry(
    category: 'Politesse',
    keywords: ['aide', 'aider', 'besoin', 'question', 'renseignement', 'info', 'information'],
    question: 'Demande d\'aide',
    answer: '🤝 **Je suis là pour vous aider !**\n\n'
        'Voici ce que je peux faire :\n\n'
        '📋 **Devis** - Estimation gratuite\n'
        '🔧 **Services** - Clim, plomberie, chauffage...\n'
        '🚨 **Urgences** - Intervention rapide\n'
        '📍 **Zones** - 06 et 83\n'
        '📞 **Contact** - Appel, WhatsApp, email\n\n'
        'Que souhaitez-vous savoir ?',
  ),
];

/// Fonction pour rechercher une réponse FAQ basée sur le message utilisateur
String? findFaqAnswer(String userMessage) {
  final message = userMessage.toLowerCase()
      .replaceAll(RegExp(r'[éèêë]'), 'e')
      .replaceAll(RegExp(r'[àâä]'), 'a')
      .replaceAll(RegExp(r'[ùûü]'), 'u')
      .replaceAll(RegExp(r'[îï]'), 'i')
      .replaceAll(RegExp(r'[ôö]'), 'o')
      .replaceAll("'", ' ')
      .replaceAll(RegExp(r'[^\w\s]'), '');
  
  int bestScore = 0;
  _FaqEntry? bestMatch;
  
  for (final entry in kFaqDatabase) {
    int score = 0;
    
    // Vérifier chaque mot-clé
    for (final keyword in entry.keywords) {
      final normalizedKeyword = keyword.toLowerCase()
          .replaceAll(RegExp(r'[éèêë]'), 'e')
          .replaceAll(RegExp(r'[àâä]'), 'a')
          .replaceAll(RegExp(r'[ùûü]'), 'u')
          .replaceAll(RegExp(r'[îï]'), 'i')
          .replaceAll(RegExp(r'[ôö]'), 'o')
          .replaceAll("'", ' ');
      
      if (message.contains(normalizedKeyword)) {
        score += 3; // 3 points par mot-clé trouvé
      }
      
      // Correspondance partielle (début du mot)
      final words = message.split(' ');
      for (final word in words) {
        if (word.length >= 3 && normalizedKeyword.startsWith(word)) {
          score += 1;
        }
        if (word.length >= 3 && normalizedKeyword.contains(word)) {
          score += 2;
        }
      }
    }
    
    // Bonus si la catégorie est mentionnée
    final normalizedCategory = entry.category.toLowerCase()
        .replaceAll(RegExp(r'[éèêë]'), 'e');
    if (message.contains(normalizedCategory)) {
      score += 4;
    }
    
    // Garder la meilleure correspondance
    if (score > bestScore) {
      bestScore = score;
      bestMatch = entry;
    }
  }
  
  // Seuil abaissé à 2 pour être plus réactif
  if (bestScore >= 2 && bestMatch != null) {
    return bestMatch.answer;
  }
  
  return null;
}
