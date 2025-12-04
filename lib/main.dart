import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:html' as html;
import 'dart:ui_web' as ui_web;
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
// WIDGET FOOTER GLOBAL - RÉUTILISABLE SUR TOUTES LES PAGES
// ============================================================================

/// Footer unifié pour toutes les pages du site Azur Confort
/// Inclut : Logo, baseline, copyright et liens légaux
class AppFooter extends StatelessWidget {
  /// Callback optionnel pour naviguer vers les pages légales
  /// Si non fourni, utilise la navigation par défaut via _AzurConfortHomeState
  final void Function(int pageIndex)? onLegalLinkTap;
  
  const AppFooter({Key? key, this.onLegalLinkTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20), // RÉDUIT
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [kDarkBlue, Color(0xFF0D47A1)],
        ),
        boxShadow: [
          BoxShadow(
            color: kDarkBlue.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            mainAxisSize: MainAxisSize.min, // COMPACT
            children: [
              // Logo et nom - COMPACT
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(6), // RÉDUIT
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.ac_unit, color: Colors.white, size: 20), // RÉDUIT
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'AZUR CONFORT',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16, // RÉDUIT
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8), // RÉDUIT
              
              // Baseline
              Text(
                'Artisan frigoriste sur la Côte d\'Azur (06 & 83)',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 12, // RÉDUIT
                ),
              ),
              const SizedBox(height: 14), // RÉDUIT
              
              // Séparateur - plus discret
              Container(
                width: 60, // RÉDUIT
                height: 1, // RÉDUIT
                color: Colors.white.withOpacity(0.2),
              ),
              const SizedBox(height: 14), // RÉDUIT
              
              // Liens légaux + Copyright sur même ligne si possible
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 16, // RÉDUIT
                runSpacing: 8,
                children: [
                  _buildLegalLink(context, 'Mentions légales', 3),
                  _buildLegalLink(context, 'Confidentialité', 4),
                  _buildLegalLink(context, 'Cookies', 5),
                  _buildLegalLink(context, 'CGU', 6),
                ],
              ),
              const SizedBox(height: 12), // RÉDUIT
              
              // Copyright
              Text(
                '© 2025 Azur Confort – Tous droits réservés',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.45),
                  fontSize: 10, // RÉDUIT
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLegalLink(BuildContext context, String text, int pageIndex) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          if (onLegalLinkTap != null) {
            onLegalLinkTap!(pageIndex);
          } else {
            _AzurConfortHomeState.navigateToPage(pageIndex);
          }
        },
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 11, // COMPACT
            fontWeight: FontWeight.w400,
            decoration: TextDecoration.underline,
            decorationColor: Colors.white.withOpacity(0.3),
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// POINT D'ENTRÉE
// ============================================================================

void main() {
  // Enregistrer les viewTypes pour les iframes Google Maps (Flutter Web uniquement)
  if (kIsWeb) {
    _registerGoogleMapIframe();
    _registerZonesMapIframe();
  }
  runApp(const AzurConfortApp());
}

/// Enregistre l'iframe Google Maps pour l'adresse Azur Confort (page Contact)
void _registerGoogleMapIframe() {
  // URL de l'iframe Google Maps avec recherche de l'adresse
  // Adresse : 60 bis avenue de la Bornala, Résidence Le Vallon Monari, 06200 Nice
  // Note: Pour afficher "Azur Confort" sur le marqueur, l'entreprise doit être
  // enregistrée sur Google My Business. En attendant, on affiche l'adresse.
  ui_web.platformViewRegistry.registerViewFactory(
    'google-map-iframe',
    (int viewId) {
      final iframe = html.IFrameElement()
        // Recherche avec le nom de l'entreprise + adresse
        ..src = 'https://www.google.com/maps?q=Azur+Confort+60+bis+Avenue+de+la+Bornala+06200+Nice+France&output=embed'
        ..style.border = 'none'
        ..style.width = '100%'
        ..style.height = '100%'
        ..style.borderRadius = '20px'
        ..allowFullscreen = true
        ..setAttribute('loading', 'lazy')
        ..setAttribute('referrerpolicy', 'no-referrer-when-downgrade');
      return iframe;
    },
  );
}

/// Enregistre l'iframe Google Maps pour la zone d'intervention (06 + 83) en mode terrain
void _registerZonesMapIframe() {
  // Carte Google Maps en mode TERRAIN centrée entre Nice et Toulon
  // pour montrer les départements Alpes-Maritimes (06) et Var (83)
  // Coordonnées : ~43.5°N, 6.8°E avec zoom 9 pour voir les 2 départements
  ui_web.platformViewRegistry.registerViewFactory(
    'google-map-zones-iframe',
    (int viewId) {
      final iframe = html.IFrameElement()
        // Mode terrain (t) avec zoom 9 centré entre Nice et Fréjus
        ..src = 'https://www.google.com/maps/embed?pb=!1m14!1m12!1m3!1d370000!2d6.8!3d43.55!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!5e1!3m2!1sfr!2sfr!4v1701700000000'
        ..style.border = 'none'
        ..style.width = '100%'
        ..style.height = '100%'
        ..style.borderRadius = '20px'
        ..allowFullscreen = true
        ..setAttribute('loading', 'lazy')
        ..setAttribute('referrerpolicy', 'no-referrer-when-downgrade');
      return iframe;
    },
  );
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
              _CentreJuridiquePage(initialTab: 0), // Mentions légales
              _CentreJuridiquePage(initialTab: 1), // Politique de confidentialité
              _CentreJuridiquePage(initialTab: 2), // Cookies
              _CentreJuridiquePage(initialTab: 3), // CGU
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
          // FOOTER UNIFIÉ (widget global)
          const AppFooter(),
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
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    // Villes principales avec leur département
    final cities = [
      {'name': 'Nice', 'dept': '06', 'main': true},
      {'name': 'Cannes', 'dept': '06', 'main': true},
      {'name': 'Antibes', 'dept': '06', 'main': false},
      {'name': 'Grasse', 'dept': '06', 'main': false},
      {'name': 'Menton', 'dept': '06', 'main': false},
      {'name': 'Cagnes-sur-Mer', 'dept': '06', 'main': false},
      {'name': 'Fréjus', 'dept': '83', 'main': true},
      {'name': 'Saint-Raphaël', 'dept': '83', 'main': false},
      {'name': 'Toulon', 'dept': '83', 'main': true},
      {'name': 'Hyères', 'dept': '83', 'main': false},
    ];
    
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
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                _buildSectionTitle(context,
                  'Zones d\'intervention',
                  'Climatisation et plomberie dans les Alpes-Maritimes (06) et le Var (83)',
                ),
                const SizedBox(height: 48),
                
                // ==================== CARTE GOOGLE MAPS TERRAIN ====================
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: isDark 
                            ? Colors.black.withOpacity(0.3) 
                            : kPrimaryBlue.withOpacity(0.15),
                        blurRadius: 25,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // En-tête avec badges départements
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [kDarkBlue, kPrimaryBlue],
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Badge 06
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.location_on, color: Colors.white, size: 18),
                                  SizedBox(width: 6),
                                  Text(
                                    'Alpes-Maritimes (06)',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            // Séparateur
                            Container(
                              width: 2,
                              height: 30,
                              color: Colors.white.withOpacity(0.3),
                            ),
                            const SizedBox(width: 16),
                            // Badge 83
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: kAccentOrange.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.location_on, color: Colors.white, size: 18),
                                  SizedBox(width: 6),
                                  Text(
                                    'Var (83)',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      // Carte Google Maps Terrain (taille réduite)
                      ClipRRect(
                        child: SizedBox(
                          width: double.infinity,
                          height: isMobile ? 200 : 250,
                          child: HtmlElementView(
                            viewType: 'google-map-zones-iframe',
                            onPlatformViewCreated: (int viewId) {
                              // Carte créée
                            },
                          ),
                        ),
                      ),
                      
                      // Bloc inférieur avec vignettes de villes
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: isDark 
                              ? colorScheme.surfaceVariant.withOpacity(0.5)
                              : Colors.white,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(24),
                            bottomRight: Radius.circular(24),
                          ),
                        ),
                        child: Column(
                          children: [
                            // Titre
                            Text(
                              'Nos principales zones d\'intervention',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: isDark ? colorScheme.onSurface : kDarkBlue,
                              ),
                            ),
                            const SizedBox(height: 20),
                            
                            // Grille de villes
                            Wrap(
                              alignment: WrapAlignment.center,
                              spacing: 12,
                              runSpacing: 12,
                              children: cities.map((city) {
                                final is06 = city['dept'] == '06';
                                final isMain = city['main'] == true;
                                final accentColor = is06 ? kPrimaryBlue : kAccentOrange;
                                
                                return Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: isMain 
                                        ? accentColor.withOpacity(0.15)
                                        : (isDark ? colorScheme.surface : Colors.grey.shade100),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: accentColor.withOpacity(isMain ? 0.4 : 0.2),
                                      width: isMain ? 2 : 1,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        color: accentColor,
                                        size: isMain ? 18 : 14,
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        city['name'] as String,
                                        style: TextStyle(
                                          color: isDark ? colorScheme.onSurface : kDarkBlue,
                                          fontWeight: isMain ? FontWeight.bold : FontWeight.w500,
                                          fontSize: isMain ? 14 : 13,
                                        ),
                                      ),
                                      const SizedBox(width: 6),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: accentColor.withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: Text(
                                          city['dept'] as String,
                                          style: TextStyle(
                                            color: accentColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                            
                            const SizedBox(height: 20),
                            
                            // Badge "Et plus encore"
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [kDarkBlue, kPrimaryBlue],
                                ),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: kPrimaryBlue.withOpacity(0.3),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.add_location_alt, color: Colors.white, size: 20),
                                  SizedBox(width: 10),
                                  Text(
                                    'Et toutes les communes des Alpes-Maritimes et du Var',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
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
      imagePath: 'assets/images/service_frigoriste_new.png',
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
      imagePath: 'assets/images/service_pac_new.png',
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
      imagePath: 'assets/images/service_electricite_new.png',
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
          // FOOTER UNIFIÉ
          const AppFooter(),
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
              'assets/images/about_hero.png',
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
          // FOOTER UNIFIÉ
          const AppFooter(),
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
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    // Villes principales avec leur département
    final cities = [
      {'name': 'Nice', 'dept': '06'},
      {'name': 'Cannes', 'dept': '06'},
      {'name': 'Antibes', 'dept': '06'},
      {'name': 'Grasse', 'dept': '06'},
      {'name': 'Menton', 'dept': '06'},
      {'name': 'Cagnes-sur-Mer', 'dept': '06'},
      {'name': 'Fréjus', 'dept': '83'},
      {'name': 'Saint-Raphaël', 'dept': '83'},
    ];
    
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 80,
        vertical: 60,
      ),
      decoration: BoxDecoration(
        color: isDark ? colorScheme.surface : const Color(0xFFF8FAFC),
        border: Border(
          top: BorderSide(color: colorScheme.outline.withOpacity(0.2)),
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            children: [
              // En-tête
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: kPrimaryBlue.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.location_on, color: kPrimaryBlue, size: 32),
              ),
              const SizedBox(height: 20),
              Text(
                'Zone d\'intervention',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: isDark ? colorScheme.onSurface : kDarkBlue,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Alpes-Maritimes (06) & Var (83)',
                style: TextStyle(
                  fontSize: 16,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 32),
              
              // ==================== CARTE GOOGLE MAPS ====================
              _GoogleMapSection(isDark: isDark, isMobile: isMobile),
              const SizedBox(height: 40),
              
              // Grille des villes
              LayoutBuilder(
                builder: (context, constraints) {
                  final crossAxisCount = constraints.maxWidth > 800 ? 4 : (constraints.maxWidth > 500 ? 3 : 2);
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 2.5,
                    ),
                    itemCount: cities.length,
                    itemBuilder: (context, index) {
                      final city = cities[index];
                      return _buildCityCard(city['name']!, city['dept']!, isDark, colorScheme);
                    },
                  );
                },
              ),
              
              const SizedBox(height: 32),
              
              // Badge "Et plus encore"
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [kDarkBlue, kPrimaryBlue],
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: kPrimaryBlue.withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                children: [
                    const Icon(Icons.add_location_alt, color: Colors.white, size: 22),
                    const SizedBox(width: 12),
                    const Text(
                      'Et toutes les communes des Alpes-Maritimes et du Var',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCityCard(String city, String dept, bool isDark, ColorScheme colorScheme) {
    final is06 = dept == '06';
    final accentColor = is06 ? kPrimaryBlue : kAccentOrange;
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isDark ? colorScheme.surfaceVariant : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: accentColor.withOpacity(0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.location_on_outlined,
            color: accentColor,
            size: 18,
          ),
          const SizedBox(width: 8),
          Flexible(
      child: Text(
        city,
              style: TextStyle(
                color: isDark ? colorScheme.onSurface : kDarkBlue,
                fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: accentColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              dept,
              style: TextStyle(
                color: accentColor,
                fontWeight: FontWeight.bold,
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// WIDGET GOOGLE MAPS - CARTE D'INTERVENTION
// ============================================================================

/// Widget encapsulant la carte Google Maps pour la zone d'intervention
/// Utilise un iframe HTML pour l'intégration web
class _GoogleMapSection extends StatelessWidget {
  final bool isDark;
  final bool isMobile;
  
  const _GoogleMapSection({
    required this.isDark,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    // URL de l'iframe Google Maps avec l'adresse Azur Confort
    // Adresse : 60 bis avenue de la Bornala, Résidence Le Vallon Monari, 06200 Nice
    const String mapEmbedUrl = 'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d2884.8!2d7.2558!3d43.7034!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x12cdd0106a852d31%3A0x5f0!2s60+Bis+Avenue+de+la+Bornala%2C+06200+Nice%2C+France!5e0!3m2!1sfr!2sfr!4v1701700000000!5m2!1sfr!2sfr';
    
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: isDark 
                ? Colors.black.withOpacity(0.3) 
                : kPrimaryBlue.withOpacity(0.15),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          // Carte Google Maps (sans overlay pour laisser l'UI Google Maps visible)
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: SizedBox(
              width: double.infinity,
              height: isMobile ? 280 : 400,
              child: HtmlElementView(
                viewType: 'google-map-iframe',
                onPlatformViewCreated: (int viewId) {
                  // Le view est créé
                },
              ),
            ),
          ),
          
          // Informations sous la carte
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: isDark 
                  ? colorScheme.surfaceVariant.withOpacity(0.5)
                  : Colors.white,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              border: Border.all(
                color: isDark 
                    ? kPrimaryBlue.withOpacity(0.2)
                    : colorScheme.outline.withOpacity(0.1),
              ),
            ),
            child: Row(
              children: [
                // Icône localisation
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [kPrimaryBlue, Color(0xFF1976D2)],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.location_on, color: Colors.white, size: 24),
                ),
                const SizedBox(width: 16),
                
                // Adresse et infos
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Azur Confort – Artisan frigoriste (06 & 83)',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: isDark ? colorScheme.onSurface : kDarkBlue,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '60 bis avenue de la Bornala, Résidence Le Vallon Monari',
                        style: TextStyle(
                          fontSize: 13,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      Text(
                        '06200 Nice, France',
                        style: TextStyle(
                          fontSize: 13,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Bouton itinéraire (desktop uniquement)
                if (!isMobile)
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        // Ouvrir Google Maps dans un nouvel onglet
                        _launchMapsUrl();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        decoration: BoxDecoration(
                          color: kPrimaryBlue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: kPrimaryBlue.withOpacity(0.3)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.directions, color: kPrimaryBlue, size: 20),
                            const SizedBox(width: 8),
                            Text(
                              'Itinéraire',
                              style: TextStyle(
                                color: kPrimaryBlue,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  void _launchMapsUrl() {
    // URL Google Maps pour l'itinéraire
    const url = 'https://www.google.com/maps/dir/?api=1&destination=60+Bis+Avenue+de+la+Bornala,+06200+Nice,+France';
    // ignore: undefined_prefixed_name
    if (kIsWeb) {
      // Pour Flutter Web, utiliser dart:html
      html.window.open(url, '_blank');
    }
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
// CENTRE JURIDIQUE PREMIUM - PAGE UNIFIÉE AVEC ONGLETS PROFESSIONNELS
// ============================================================================
// Version premium avec contenus juridiques complets, structurés et optimisés SEO
// Compatible mode jour/nuit - Responsive - Design moderne
// ============================================================================

class _CentreJuridiquePage extends StatefulWidget {
  final int initialTab;
  
  const _CentreJuridiquePage({this.initialTab = 0});

  @override
  State<_CentreJuridiquePage> createState() => _CentreJuridiquePageState();
}

class _CentreJuridiquePageState extends State<_CentreJuridiquePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  // Définition des 4 onglets juridiques premium
  static const List<_LegalTabData> _tabs = [
    _LegalTabData(
      id: 'mentions',
      title: 'Mentions légales',
      icon: Icons.gavel,
    ),
    _LegalTabData(
      id: 'rgpd',
      title: 'Confidentialité',
      icon: Icons.shield,
    ),
    _LegalTabData(
      id: 'cookies',
      title: 'Cookies',
      icon: Icons.cookie_outlined,
    ),
    _LegalTabData(
      id: 'cgu',
      title: 'CGU',
      icon: Icons.article_outlined,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: _tabs.length,
      vsync: this,
      initialIndex: widget.initialTab.clamp(0, _tabs.length - 1),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant _CentreJuridiquePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialTab != oldWidget.initialTab) {
      _tabController.animateTo(widget.initialTab.clamp(0, _tabs.length - 1));
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 800;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      child: Column(
        children: [
          // Header du Centre Juridique
          _buildJuridicalHeader(context, isMobile),
          
          // Contenu avec onglets
          Container(
            color: colorScheme.background,
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 16 : 60,
              vertical: 40,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1100),
                child: Column(
                  children: [
                    // Barre d'onglets style services
                    _buildTabBar(context, isMobile, isDark),
                    const SizedBox(height: 32),
                    
                    // Contenu de l'onglet actif
                    SizedBox(
                      height: isMobile ? 600 : 500,
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          _buildMentionsLegalesContent(context),
                          _buildConfidentialiteContent(context),
                          _buildCookiesContent(context),
                          _buildCguContent(context),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Bouton retour accueil
                    ElevatedButton.icon(
                      onPressed: () => _AzurConfortHomeState.navigateToPage(0),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryBlue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      icon: const Icon(Icons.home),
                      label: const Text('Retour à l\'accueil', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Footer juridique
          _buildJuridicalFooter(context),
        ],
      ),
    );
  }

  // ======================== HEADER PREMIUM ========================
  Widget _buildJuridicalHeader(BuildContext context, bool isMobile) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 80,
        vertical: isMobile ? 50 : 80,
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [kDarkBlue, Color(0xFF1565C0), kPrimaryBlue],
          stops: [0.0, 0.5, 1.0],
        ),
        boxShadow: [
          BoxShadow(
            color: kDarkBlue.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Column(
            children: [
              // Icône avec effet de brillance
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white.withOpacity(0.3), width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.1),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: const Icon(Icons.verified_user, color: Colors.white, size: 48),
              ),
              const SizedBox(height: 28),
              
              // Titre principal
              Text(
                'Centre Juridique',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: isMobile ? 32 : 42,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  letterSpacing: 1.2,
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              
              // Sous-titre
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.white.withOpacity(0.2)),
                ),
                child: Text(
                  'Transparence • Conformité • Confiance',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: isMobile ? 13 : 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withOpacity(0.95),
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              
              // Badge de confiance
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildTrustBadge(Icons.shield, 'RGPD'),
                  const SizedBox(width: 16),
                  _buildTrustBadge(Icons.gavel, 'LCEN'),
                  const SizedBox(width: 16),
                  _buildTrustBadge(Icons.verified, 'Conforme'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  // Badge de confiance pour le header
  Widget _buildTrustBadge(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white.withOpacity(0.9), size: 16),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // ======================== BARRE D'ONGLETS PREMIUM ========================
  Widget _buildTabBar(BuildContext context, bool isMobile, bool isDark) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Container(
      decoration: BoxDecoration(
        color: isDark 
            ? colorScheme.surfaceVariant.withOpacity(0.5) 
            : kLightBlue.withOpacity(0.7),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark 
              ? kPrimaryBlue.withOpacity(0.2) 
              : kPrimaryBlue.withOpacity(0.1),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: isDark 
                ? Colors.black.withOpacity(0.2) 
                : kPrimaryBlue.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TabBar(
        controller: _tabController,
        isScrollable: true,
        padding: const EdgeInsets.all(8),
        labelPadding: EdgeInsets.symmetric(horizontal: isMobile ? 8 : 16),
        indicator: BoxDecoration(
          gradient: const LinearGradient(
            colors: [kPrimaryBlue, Color(0xFF1976D2)],
          ),
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: kPrimaryBlue.withOpacity(0.4),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        labelColor: Colors.white,
        unselectedLabelColor: isDark 
            ? colorScheme.onSurface.withOpacity(0.7) 
            : kDarkBlue.withOpacity(0.8),
        labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
        tabs: _tabs.map((tab) {
          return Tab(
            height: isMobile ? 52 : 58,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(tab.icon, size: isMobile ? 18 : 22),
                  const SizedBox(width: 10),
                  Text(tab.title),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // ======================== CONTENU MENTIONS LÉGALES PREMIUM ========================
  Widget _buildMentionsLegalesContent(BuildContext context) {
    return _buildLegalContent(
      context,
      sections: [
        // Section 1 - Éditeur du site (LCEN)
        const _LegalSection(
          icon: Icons.business,
          title: '1. Éditeur du site',
          content: '''Conformément aux dispositions de l'article 6 de la loi n°2004-575 du 21 juin 2004 pour la confiance dans l'économie numérique (LCEN), le présent site est édité par :

Raison sociale : [À compléter]
Forme juridique : [À compléter : Micro-entreprise / EI / EURL / SARL...]
Adresse du siège social : [À compléter]
Téléphone : [À compléter]
Email : contact@azurconfort.fr
Numéro SIRET : [À compléter]
Numéro TVA intracommunautaire : [À compléter si applicable]
Directeur de la publication : [À compléter - nom du responsable légal]''',
        ),
        
        // Section 2 - Statut de l'artisan
        const _LegalSection(
          icon: Icons.engineering,
          title: '2. Statut de l\'artisan',
          content: '''Azur Confort est une entreprise artisanale spécialisée dans les métiers du froid, du chaud et de la plomberie :

• Climatisation (mono-split, multi-split, gainable)
• Pompes à chaleur (air-air, air-eau)
• Frigoriste (chambres froides, vitrines réfrigérées)
• Chauffage (chaudières, radiateurs, plancher chauffant)
• Plomberie (sanitaires, fuites, rénovation)
• Électricité (installation, mise aux normes, dépannage)

Inscriptions professionnelles :
• RCS / Répertoire des Métiers : [À compléter]
• Assurance décennale : [À compléter - Nom assureur + N° contrat]
• Responsabilité Civile Professionnelle : [À compléter]
• Certification RGE : [À compléter si applicable]

Zone d'intervention : Alpes-Maritimes (06) et Var (83).''',
        ),
        
        // Section 3 - Hébergeur
        const _LegalSection(
          icon: Icons.cloud,
          title: '3. Hébergeur du site',
          content: '''Le site azur-confort.vercel.app est hébergé par :

Vercel Inc.
340 S Lemon Ave #4133
Walnut, CA 91789, États-Unis
Site web : https://vercel.com
Email : privacy@vercel.com''',
        ),
        
        // Section 4 - Propriété intellectuelle
        const _LegalSection(
          icon: Icons.copyright,
          title: '4. Propriété intellectuelle',
          content: '''L'ensemble des éléments composant le site Azur Confort (textes, images, photographies, logos, icônes, vidéos, sons, logiciels, base de données, structure et mise en page) est protégé par les dispositions du Code de la Propriété Intellectuelle.

Toute reproduction, représentation, modification, publication, adaptation, totale ou partielle, de ces éléments, par quelque moyen que ce soit, sans l'autorisation écrite préalable d'Azur Confort, est strictement interdite et constitue une contrefaçon sanctionnée par les articles L.335-2 et suivants du Code de la Propriété Intellectuelle.

Les marques, logos et signes distinctifs présentés sur le site sont la propriété exclusive d'Azur Confort ou de leurs titulaires respectifs.''',
        ),
        
        // Section 5 - Limitation de responsabilité
        const _LegalSection(
          icon: Icons.warning_amber,
          title: '5. Limitation de responsabilité',
          content: '''Les informations diffusées sur le site Azur Confort sont fournies à titre indicatif et ne sauraient constituer un engagement contractuel.

Azur Confort s'efforce d'assurer l'exactitude et la mise à jour des informations, mais ne peut garantir l'absence d'erreurs ou d'omissions.

Azur Confort décline toute responsabilité :
• En cas d'interruption ou d'inaccessibilité temporaire du site
• En cas de présence de virus ou programmes malveillants
• En cas de dommages directs ou indirects résultant de l'utilisation du site
• En cas de mauvaise utilisation du site par l'utilisateur
• Pour le contenu des sites tiers accessibles via des liens hypertextes''',
        ),
        
        // Section 6 - Prestations artisanales
        const _LegalSection(
          icon: Icons.handshake,
          title: '6. Prestations et devis',
          content: '''Devis et tarification :
• Tous les devis sont établis gratuitement et sans engagement
• Un devis détaillé est obligatoirement fourni avant toute intervention
• Les prix indiqués sont en euros TTC (TVA applicable selon régime)
• La validité d'un devis est de 30 jours sauf mention contraire

Conditions d'intervention :
• Toute intervention nécessite l'acceptation préalable du devis
• Un acompte peut être demandé selon la nature des travaux
• Les délais d'intervention sont donnés à titre indicatif
• Une facture détaillée est remise après chaque prestation

Garanties :
• Garantie légale de conformité (article L.217-4 du Code de la consommation)
• Garantie des vices cachés (articles 1641 à 1649 du Code civil)
• Garantie décennale sur les travaux concernés''',
        ),
        
        // Section 7 - Droit applicable
        const _LegalSection(
          icon: Icons.balance,
          title: '7. Droit applicable et litiges',
          content: '''Le présent site et ses conditions d'utilisation sont régis par le droit français.

En cas de litige relatif à l'interprétation ou l'exécution des présentes, les parties s'engagent à rechercher une solution amiable avant toute action judiciaire.

À défaut d'accord amiable, tout litige sera soumis aux tribunaux compétents du ressort du siège social d'Azur Confort.

Médiation de la consommation :
Conformément à l'article L.612-1 du Code de la consommation, le client peut recourir gratuitement à un médiateur de la consommation en cas de litige.
Médiateur : [À compléter - nom et coordonnées du médiateur]''',
        ),
      ],
    );
  }

  // ======================== CONTENU CONFIDENTIALITÉ (RGPD) PREMIUM ========================
  Widget _buildConfidentialiteContent(BuildContext context) {
    return _buildLegalContent(
      context,
      sections: [
        // Section 1 - Responsable du traitement
        const _LegalSection(
          icon: Icons.admin_panel_settings,
          title: '1. Responsable du traitement',
          content: '''Le responsable du traitement des données personnelles est :

Azur Confort
Adresse : [À compléter]
Email : contact@azurconfort.fr
Téléphone : [À compléter]

Délégué à la Protection des Données (DPO) :
Email : contact@azurconfort.fr''',
        ),
        
        // Section 2 - Données collectées
        const _LegalSection(
          icon: Icons.folder_shared,
          title: '2. Données personnelles collectées',
          content: '''Dans le cadre de notre activité, nous collectons les données suivantes :

Données d'identification :
• Nom et prénom
• Adresse postale / lieu d'intervention
• Numéro de téléphone
• Adresse email

Données relatives à la prestation :
• Description du besoin (type de travaux, équipements)
• Historique des interventions
• Correspondances et échanges

Données techniques :
• Adresse IP (logs serveur)
• Données de navigation (cookies techniques)

Important : Aucune donnée bancaire n'est collectée directement via ce site.''',
        ),
        
        // Section 3 - Finalités du traitement
        const _LegalSection(
          icon: Icons.track_changes,
          title: '3. Finalités du traitement',
          content: '''Vos données personnelles sont traitées pour les finalités suivantes :

• Gestion des demandes de devis et de contact
• Planification et réalisation des interventions
• Suivi de la relation client
• Facturation et gestion comptable
• Respect des obligations légales et réglementaires
• Amélioration de nos services
• Communication sur nos offres (avec votre consentement)''',
        ),
        
        // Section 4 - Base légale
        const _LegalSection(
          icon: Icons.gavel,
          title: '4. Base légale du traitement',
          content: '''Le traitement de vos données repose sur les bases légales suivantes :

• Exécution d'un contrat : traitement nécessaire à l'établissement d'un devis et à la réalisation d'une prestation
• Consentement : pour l'envoi de communications commerciales
• Intérêt légitime : pour l'amélioration de nos services et la gestion de la relation client
• Obligation légale : pour la conservation des factures et documents comptables''',
        ),
        
        // Section 5 - Durée de conservation
        const _LegalSection(
          icon: Icons.schedule,
          title: '5. Durée de conservation',
          content: '''Vos données sont conservées pour les durées suivantes :

• Données prospects (sans suite) : 3 ans après le dernier contact
• Données clients : durée de la relation commerciale + 5 ans (prescription civile)
• Documents comptables : 10 ans (obligation légale)
• Données de navigation : 13 mois maximum

À l'expiration de ces délais, vos données sont supprimées ou anonymisées.''',
        ),
        
        // Section 6 - Destinataires
        const _LegalSection(
          icon: Icons.share,
          title: '6. Destinataires des données',
          content: '''Vos données peuvent être transmises aux destinataires suivants :

• Personnel habilité d'Azur Confort
• Hébergeur du site (Vercel Inc.)
• Prestataires techniques (maintenance, emailing)
• Administrations et organismes publics (obligations légales)
• Expert-comptable

Vos données ne sont jamais vendues ni cédées à des tiers à des fins commerciales.''',
        ),
        
        // Section 7 - Vos droits
        const _LegalSection(
          icon: Icons.verified_user,
          title: '7. Vos droits (RGPD)',
          content: '''Conformément au Règlement Général sur la Protection des Données (RGPD), vous disposez des droits suivants :

• Droit d'accès : obtenir la confirmation du traitement et une copie de vos données
• Droit de rectification : corriger des données inexactes ou incomplètes
• Droit à l'effacement : demander la suppression de vos données
• Droit à la limitation : suspendre le traitement de vos données
• Droit à la portabilité : recevoir vos données dans un format structuré
• Droit d'opposition : vous opposer au traitement pour motifs légitimes
• Droit de retirer votre consentement : à tout moment pour les traitements basés sur le consentement

Pour exercer vos droits : contact@azurconfort.fr
Délai de réponse : 1 mois maximum''',
        ),
        
        // Section 8 - Sécurité
        const _LegalSection(
          icon: Icons.security,
          title: '8. Sécurité des données',
          content: '''Azur Confort met en œuvre les mesures techniques et organisationnelles appropriées pour protéger vos données :

• Protocole HTTPS pour les échanges sécurisés
• Hébergement chez des prestataires conformes RGPD
• Accès restreint aux données (personnel habilité uniquement)
• Mots de passe sécurisés et authentification renforcée
• Sauvegardes régulières

En cas de violation de données susceptible d'engendrer un risque élevé pour vos droits, vous en serez informé dans les meilleurs délais.''',
        ),
        
        // Section 9 - Mineurs
        const _LegalSection(
          icon: Icons.child_care,
          title: '9. Protection des mineurs',
          content: '''Le site Azur Confort n'est pas destiné aux personnes mineures.

Nous ne collectons pas sciemment de données personnelles concernant des enfants de moins de 16 ans.

Si vous êtes parent ou tuteur et que vous pensez que votre enfant nous a fourni des données personnelles, veuillez nous contacter pour demander leur suppression.''',
        ),
        
        // Section 10 - Contact
        const _LegalSection(
          icon: Icons.contact_mail,
          title: '10. Contact et réclamation',
          content: '''Pour toute question relative à la protection de vos données personnelles :

Email : contact@azurconfort.fr
Courrier : [Adresse à compléter]

En cas de difficulté, vous pouvez introduire une réclamation auprès de la CNIL :
Commission Nationale de l'Informatique et des Libertés
3 Place de Fontenoy - TSA 80715
75334 Paris Cedex 07
www.cnil.fr''',
        ),
      ],
    );
  }

  // ======================== CONTENU COOKIES PREMIUM ========================
  Widget _buildCookiesContent(BuildContext context) {
    return _buildLegalContent(
      context,
      sections: [
        // Section 1 - Définition
        const _LegalSection(
          icon: Icons.info_outline,
          title: '1. Qu\'est-ce qu\'un cookie ?',
          content: '''Un cookie est un petit fichier texte déposé sur votre terminal (ordinateur, tablette, smartphone) lors de la consultation d'un site web.

Il permet au site de mémoriser des informations sur votre visite, comme votre langue préférée ou vos paramètres d'affichage, facilitant ainsi votre navigation lors de vos prochaines visites.

Les cookies ne peuvent pas endommager votre appareil et ne contiennent pas de virus.''',
        ),
        
        // Section 2 - Cookies utilisés
        const _LegalSection(
          icon: Icons.cookie_outlined,
          title: '2. Cookies utilisés sur ce site',
          content: '''Le site Azur Confort utilise les catégories de cookies suivantes :

Cookies strictement nécessaires (toujours actifs) :
• Cookies de session pour le fonctionnement du site
• Cookies de sécurité (protection contre les attaques)
• Cookies de préférence d'affichage (mode jour/nuit)
• Cookies de langue

Cookies de performance (optionnels) :
• Cookies d'analyse anonymisée (mesure d'audience)
• Statistiques de navigation agrégées

Cookies fonctionnels (optionnels) :
• Mémorisation de vos préférences
• Personnalisation de l'expérience utilisateur

Important : Aucun cookie publicitaire ou de traçage n'est utilisé sur ce site.''',
        ),
        
        // Section 3 - Consentement
        const _LegalSection(
          icon: Icons.how_to_vote,
          title: '3. Votre consentement',
          content: '''Conformément à la réglementation européenne (RGPD) et aux recommandations de la CNIL :

• Les cookies strictement nécessaires sont déposés sans consentement préalable car indispensables au fonctionnement du site
• Les cookies de performance et fonctionnels nécessitent votre consentement explicite
• Vous pouvez modifier vos choix à tout moment

Lors de votre première visite, un bandeau d'information vous permet de :
• Accepter tous les cookies
• Refuser les cookies non essentiels
• Personnaliser vos préférences cookie par cookie

Votre choix est conservé pendant 6 mois.''',
        ),
        
        // Section 4 - Gestion des cookies
        const _LegalSection(
          icon: Icons.settings,
          title: '4. Comment gérer vos cookies ?',
          content: '''Vous pouvez gérer vos cookies de plusieurs manières :

Via notre bandeau cookies :
Cliquez sur le lien "Gérer mes cookies" en bas de page pour modifier vos préférences.

Via votre navigateur :
Vous pouvez configurer votre navigateur pour accepter, refuser ou supprimer les cookies.

• Chrome : Paramètres > Confidentialité et sécurité > Cookies
• Firefox : Options > Vie privée et sécurité > Cookies
• Safari : Préférences > Confidentialité > Cookies
• Edge : Paramètres > Cookies et autorisations de site

Application mobile :
Les paramètres de cookies sont accessibles dans les réglages de votre appareil.''',
        ),
        
        // Section 5 - Conséquences du refus
        const _LegalSection(
          icon: Icons.warning_amber,
          title: '5. Conséquences du refus',
          content: '''Si vous refusez les cookies ou les supprimez :

Cookies strictement nécessaires :
Le refus de ces cookies peut empêcher le bon fonctionnement du site (navigation, formulaires, sécurité).

Cookies de performance :
Le refus n'affecte pas votre navigation mais nous empêche d'améliorer le site grâce aux statistiques.

Cookies fonctionnels :
Vos préférences (mode jour/nuit, langue) ne seront pas mémorisées entre vos visites.

Note : Le refus des cookies n'empêche pas l'accès au site mais peut dégrader votre expérience utilisateur.''',
        ),
        
        // Section 6 - Durée de conservation
        const _LegalSection(
          icon: Icons.timer,
          title: '6. Durée de conservation',
          content: '''Les cookies déposés sur votre terminal ont les durées de vie suivantes :

• Cookies de session : supprimés à la fermeture du navigateur
• Cookies de préférences : 12 mois maximum
• Cookies d'analyse : 13 mois maximum
• Cookie de consentement : 6 mois

À l'expiration de ces délais, les cookies sont automatiquement supprimés ou un nouveau consentement vous est demandé.''',
        ),
        
        // Section 7 - Contact
        const _LegalSection(
          icon: Icons.contact_support,
          title: '7. Contact',
          content: '''Pour toute question concernant notre politique de cookies ou pour exercer vos droits :

Email : contact@azurconfort.fr

Pour en savoir plus sur les cookies et vos droits, vous pouvez consulter le site de la CNIL :
www.cnil.fr/fr/cookies-et-autres-traceurs

Dernière mise à jour : Décembre 2025''',
        ),
      ],
    );
  }

  // ======================== CONTENU CGU PREMIUM ========================
  Widget _buildCguContent(BuildContext context) {
    return _buildLegalContent(
      context,
      sections: [
        // Section 1 - Objet et champ d'application
        const _LegalSection(
          icon: Icons.description,
          title: '1. Objet et champ d\'application',
          content: '''Les présentes Conditions Générales d'Utilisation (CGU) ont pour objet de définir les modalités et conditions d'accès et d'utilisation du site internet Azur Confort.

En accédant au site, l'utilisateur reconnaît avoir pris connaissance des présentes CGU et les accepte sans réserve.

Azur Confort se réserve le droit de modifier les présentes CGU à tout moment. Les modifications entrent en vigueur dès leur publication sur le site.

Date de dernière mise à jour : Décembre 2025''',
        ),
        
        // Section 2 - Services fournis
        const _LegalSection(
          icon: Icons.home_repair_service,
          title: '2. Services fournis par Azur Confort',
          content: '''Le site Azur Confort a pour objet de présenter les activités et services de l'entreprise :

• Climatisation : installation, entretien et dépannage de systèmes mono-split, multi-split et gainables
• Pompes à chaleur : installation et maintenance de PAC air-air et air-eau
• Frigoriste : chambres froides, vitrines réfrigérées, équipements professionnels
• Chauffage : chaudières, radiateurs, plancher chauffant
• Plomberie : sanitaires, fuites, rénovation de salle de bain
• Électricité : installation, mise aux normes, dépannage

Le site permet également de :
• Demander un devis gratuit
• Contacter l'entreprise
• Obtenir des informations sur les prestations''',
        ),
        
        // Section 3 - Disponibilité du site
        const _LegalSection(
          icon: Icons.public,
          title: '3. Disponibilité du site',
          content: '''Le site est accessible 24h/24 et 7j/7, sous réserve des opérations de maintenance et des pannes éventuelles.

Azur Confort s'efforce d'assurer la disponibilité du site mais ne peut garantir une accessibilité permanente.

L'accès au site peut être interrompu pour :
• Maintenance technique programmée ou d'urgence
• Mise à jour du contenu
• Problèmes techniques indépendants de notre volonté
• Cas de force majeure

Azur Confort ne saurait être tenu responsable des conséquences d'une indisponibilité temporaire du site.''',
        ),
        
        // Section 4 - Responsabilité de l'utilisateur
        const _LegalSection(
          icon: Icons.person_outline,
          title: '4. Responsabilité de l\'utilisateur',
          content: '''L'utilisateur du site s'engage à :

• Utiliser le site conformément à sa destination
• Fournir des informations exactes et sincères dans les formulaires
• Ne pas transmettre de contenu illicite, diffamatoire ou portant atteinte aux droits d'autrui
• Ne pas tenter de perturber le fonctionnement du site
• Ne pas collecter des informations sur les autres utilisateurs
• Respecter les droits de propriété intellectuelle

Tout usage frauduleux ou abusif du site pourra donner lieu à des poursuites judiciaires.''',
        ),
        
        // Section 5 - Responsabilité d'Azur Confort
        const _LegalSection(
          icon: Icons.shield_outlined,
          title: '5. Responsabilité d\'Azur Confort',
          content: '''Azur Confort met tout en œuvre pour fournir des informations fiables et actualisées sur son site.

Toutefois, Azur Confort décline toute responsabilité :

• En cas d'erreurs ou d'omissions dans les informations publiées
• En cas de dommages résultant d'une intrusion frauduleuse d'un tiers
• En cas de dommages causés par un virus informatique
• En cas d'interruption ou d'inaccessibilité du site
• En cas de mauvaise utilisation du site par l'utilisateur
• Pour le contenu des sites tiers accessibles via des liens

Les informations présentées sur le site ont un caractère informatif et ne constituent pas une offre contractuelle.''',
        ),
        
        // Section 6 - Propriété intellectuelle
        const _LegalSection(
          icon: Icons.copyright,
          title: '6. Propriété intellectuelle',
          content: '''L'ensemble des éléments du site Azur Confort sont protégés par le droit de la propriété intellectuelle :

Sont notamment protégés :
• Les textes, articles et contenus rédactionnels
• Les photographies et illustrations
• Les logos et marques
• La charte graphique et le design
• L'architecture et la structure du site
• Les bases de données

Toute reproduction, représentation, modification ou exploitation non autorisée est interdite et constitue une contrefaçon sanctionnée par le Code de la Propriété Intellectuelle.''',
        ),
        
        // Section 7 - Liens externes
        const _LegalSection(
          icon: Icons.link,
          title: '7. Liens hypertextes',
          content: '''Liens sortants :
Le site peut contenir des liens vers des sites tiers. Ces liens sont fournis à titre informatif.

Azur Confort n'exerce aucun contrôle sur ces sites et décline toute responsabilité quant à leur contenu, leur disponibilité ou leurs pratiques en matière de protection des données.

Liens entrants :
Tout lien vers le site Azur Confort doit faire l'objet d'une autorisation préalable écrite.

Les liens de type "deep linking" ou utilisant la technique du "framing" sont interdits.''',
        ),
        
        // Section 8 - Données personnelles
        const _LegalSection(
          icon: Icons.privacy_tip,
          title: '8. Données personnelles',
          content: '''La collecte et le traitement des données personnelles sont régis par notre Politique de Confidentialité, accessible depuis l'onglet "Confidentialité" du présent Centre Juridique.

En utilisant le site, vous acceptez le traitement de vos données conformément à cette politique.

Pour toute question relative à vos données personnelles :
contact@azurconfort.fr''',
        ),
        
        // Section 9 - Loi applicable
        const _LegalSection(
          icon: Icons.balance,
          title: '9. Loi applicable',
          content: '''Les présentes Conditions Générales d'Utilisation sont régies par le droit français.

En cas de litige relatif à l'interprétation ou l'exécution des présentes CGU :

1. Les parties s'engagent à rechercher une solution amiable dans un délai de 30 jours
2. À défaut d'accord, le litige sera soumis aux tribunaux compétents du ressort du siège social d'Azur Confort

La nullité d'une clause n'affecte pas la validité des autres clauses.''',
        ),
        
        // Section 10 - Médiation
        const _LegalSection(
          icon: Icons.handshake,
          title: '10. Médiation de la consommation',
          content: '''Conformément aux articles L.611-1 et suivants du Code de la consommation, en cas de litige non résolu, le consommateur peut recourir gratuitement à un médiateur de la consommation.

Médiateur compétent :
[À compléter - Nom et coordonnées du médiateur]
Site web : [À compléter]
Email : [À compléter]

Le recours à la médiation est gratuit pour le consommateur.

Vous pouvez également utiliser la plateforme européenne de règlement en ligne des litiges :
https://ec.europa.eu/consumers/odr''',
        ),
      ],
    );
  }

  // ======================== WIDGET CONTENU LÉGAL PREMIUM ========================
  Widget _buildLegalContent(BuildContext context, {required List<_LegalSection> sections}) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          // Introduction visuelle
          Container(
            margin: const EdgeInsets.only(bottom: 24),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isDark 
                    ? [kPrimaryBlue.withOpacity(0.15), kPrimaryBlue.withOpacity(0.05)]
                    : [kLightBlue.withOpacity(0.5), kLightBlue.withOpacity(0.2)],
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: kPrimaryBlue.withOpacity(0.2)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: kPrimaryBlue.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.info_outline, color: kPrimaryBlue, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    'Ces informations sont mises à jour régulièrement pour garantir leur conformité avec la réglementation en vigueur.',
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.5,
                      color: colorScheme.onSurface.withOpacity(0.8),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Sections légales
          ...sections.asMap().entries.map((entry) {
            final index = entry.key;
            final section = entry.value;
            
            return TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: Duration(milliseconds: 300 + (index * 50)),
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: Transform.translate(
                    offset: Offset(0, 20 * (1 - value)),
                    child: child,
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: isDark 
                      ? colorScheme.surfaceVariant.withOpacity(0.5)
                      : colorScheme.surface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isDark 
                        ? kPrimaryBlue.withOpacity(0.15)
                        : colorScheme.outline.withOpacity(0.1),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: isDark 
                          ? Colors.black.withOpacity(0.2)
                          : kPrimaryBlue.withOpacity(0.05),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header de section avec gradient
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: isDark 
                              ? [kPrimaryBlue.withOpacity(0.2), kPrimaryBlue.withOpacity(0.05)]
                              : [kLightBlue.withOpacity(0.4), kLightBlue.withOpacity(0.1)],
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [kPrimaryBlue, Color(0xFF1976D2)],
                              ),
                              borderRadius: BorderRadius.circular(14),
                              boxShadow: [
                                BoxShadow(
                                  color: kPrimaryBlue.withOpacity(0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Icon(section.icon, color: Colors.white, size: 24),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              section.title,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: colorScheme.onSurface,
                                letterSpacing: 0.3,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Contenu de la section
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: SelectableText(
                        section.content,
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.8,
                          color: colorScheme.onSurface.withOpacity(0.85),
                          letterSpacing: 0.2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
          
          // Footer de section
          Container(
            margin: const EdgeInsets.only(top: 16, bottom: 8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark 
                  ? colorScheme.surfaceVariant.withOpacity(0.3)
                  : kLightBlue.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.update,
                  size: 16,
                  color: colorScheme.onSurface.withOpacity(0.5),
                ),
                const SizedBox(width: 8),
                Text(
                  'Dernière mise à jour : Décembre 2025',
                  style: TextStyle(
                    fontSize: 12,
                    color: colorScheme.onSurface.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ======================== FOOTER JURIDIQUE PREMIUM ========================
  Widget _buildJuridicalFooter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [kDarkBlue, Color(0xFF0D47A1)],
        ),
        boxShadow: [
          BoxShadow(
            color: kDarkBlue.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, -10),
          ),
        ],
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              // Logo et nom
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.ac_unit, color: Colors.white, size: 28),
                  ),
                  const SizedBox(width: 14),
                  const Text(
                    'AZUR CONFORT',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              
              // Badges de conformité
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 16,
                runSpacing: 12,
                children: [
                  _buildComplianceBadge(Icons.shield, 'RGPD'),
                  _buildComplianceBadge(Icons.gavel, 'LCEN'),
                  _buildComplianceBadge(Icons.cookie_outlined, 'CNIL'),
                  _buildComplianceBadge(Icons.lock, 'HTTPS'),
                ],
              ),
              const SizedBox(height: 28),
              
              // Séparateur
              Container(
                width: 100,
                height: 2,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withOpacity(0.0),
                      Colors.white.withOpacity(0.3),
                      Colors.white.withOpacity(0.0),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 28),
              
              // Liens de navigation
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 32,
                runSpacing: 12,
                children: [
                  _buildFooterLink('Mentions légales', 0),
                  _buildFooterLink('Confidentialité', 1),
                  _buildFooterLink('Cookies', 2),
                  _buildFooterLink('CGU', 3),
                ],
              ),
              const SizedBox(height: 24),
              
              // Copyright
              Text(
                '© 2025 Azur Confort - Tous droits réservés',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Artisan climatisation, pompe à chaleur et plomberie - Alpes-Maritimes (06) & Var (83)',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.4),
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  // Badge de conformité pour le footer
  Widget _buildComplianceBadge(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.15)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white.withOpacity(0.8), size: 16),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooterLink(String text, int tabIndex) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          _tabController.animateTo(tabIndex);
          // Scroll vers le haut pour voir le contenu
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white.withOpacity(0.85),
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

// Classe de données pour les onglets
class _LegalTabData {
  final String id;
  final String title;
  final IconData icon;
  
  const _LegalTabData({
    required this.id,
    required this.title,
    required this.icon,
  });
}

// Classe de données pour les sections légales
class _LegalSection {
  final IconData icon;
  final String title;
  final String content;
  
  const _LegalSection({
    required this.icon,
    required this.title,
    required this.content,
  });
}

// Les anciennes pages légales séparées ont été supprimées
// et remplacées par le Centre Juridique unifié ci-dessus

// Placeholder pour éviter les erreurs de compilation
class _OldLegalPagesRemoved {
  // _PolitiqueConfidentialitePage, _CookiesPage et _CguPage 
  // sont maintenant intégrées dans _CentreJuridiquePage
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

  // ==================== MENU PRINCIPAL AMÉLIORÉ ====================
  final List<_QuickOption> _quickOptions = [
    _QuickOption(id: 'devis', label: '📋 Demander un devis', icon: Icons.description),
    _QuickOption(id: 'urgence', label: '🚨 Urgence', icon: Icons.warning),
    _QuickOption(id: 'services', label: '🔧 Nos services', icon: Icons.build),
    _QuickOption(id: 'tarifs', label: '💰 Tarifs indicatifs', icon: Icons.euro),
    _QuickOption(id: 'zones', label: '📍 Zones d\'intervention', icon: Icons.location_on),
    _QuickOption(id: 'certifications', label: '🏆 Certifications', icon: Icons.verified),
    _QuickOption(id: 'faq', label: '❓ FAQ', icon: Icons.help_outline),
    _QuickOption(id: 'contact', label: '📞 Contact', icon: Icons.phone),
  ];
  
  // Options d'action toujours proposées
  final List<_QuickOption> _actionOptions = [
    _QuickOption(id: 'appeler', label: '📞 Appeler', icon: Icons.phone),
    _QuickOption(id: 'devis', label: '📋 Demander un devis', icon: Icons.description),
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
        // ==================== DEVIS ====================
        case 'devis':
          response = '📋 **Demande de devis gratuit**\n\n'
              'Chez Azur Confort, tous nos devis sont **gratuits et personnalisés**.\n\n'
              'Pour vous établir une proposition adaptée, j\'ai besoin de :\n'
              '• Type de prestation souhaitée\n'
              '• Votre ville (06 ou 83)\n'
              '• Vos coordonnées\n\n'
              '📞 Réponse sous 24h garantie !';
          subOptions = [
            _QuickOption(id: 'formulaire', label: '📝 Formulaire de contact', icon: Icons.edit),
            _QuickOption(id: 'appeler', label: '📞 Appeler maintenant', icon: Icons.phone),
          ];
          break;
          
        // ==================== URGENCE ====================
        case 'urgence':
          response = '🚨 **Urgence / Dépannage rapide**\n\n'
              'Nous intervenons en urgence pour :\n\n'
              '• ❄️ Panne de climatisation\n'
              '• 💧 Fuite d\'eau urgente\n'
              '• 🔥 Panne de chauffage\n'
              '• 🧊 Problème de chambre froide\n'
              '• ⚡ Panne électrique\n\n'
              '⚡ **Intervention rapide 7j/7**\n'
              '📞 Appelez-nous maintenant : **$kPhoneNumberFormatted**';
          subOptions = [
            _QuickOption(id: 'appeler', label: '📞 Appeler maintenant', icon: Icons.phone),
            _QuickOption(id: 'whatsapp', label: '💬 WhatsApp', icon: Icons.message),
          ];
          break;
          
        // ==================== SERVICES ====================
        case 'services':
          response = '🔧 **Nos services professionnels**\n\n'
              'Azur Confort, artisan qualifié depuis plus de 10 ans :\n\n'
              '❄️ **Climatisation** - Mono/multi-split, gainable\n'
              '🧊 **Frigoriste** - Chambres froides, vitrines\n'
              '🌡️ **Pompes à chaleur** - PAC air/air, air/eau\n'
              '🔥 **Chauffage** - Chaudières, radiateurs\n'
              '💧 **Plomberie** - Sanitaires, fuites\n'
              '⚡ **Électricité** - Dépannage, mise aux normes\n\n'
              'Quel service vous intéresse ?';
          subOptions = [
            _QuickOption(id: 'clim', label: '❄️ Climatisation', icon: Icons.ac_unit),
            _QuickOption(id: 'frigo', label: '🧊 Frigoriste', icon: Icons.severe_cold),
            _QuickOption(id: 'pac', label: '🌡️ Pompes à chaleur', icon: Icons.thermostat),
            _QuickOption(id: 'chauffage', label: '🔥 Chauffage', icon: Icons.local_fire_department),
            _QuickOption(id: 'plomberie', label: '💧 Plomberie', icon: Icons.water_drop),
            _QuickOption(id: 'electricite', label: '⚡ Électricité', icon: Icons.electrical_services),
          ];
          break;
          
        // ==================== TARIFS ====================
        case 'tarifs':
          response = '💰 **Tarifs indicatifs** _(non contractuels)_\n\n'
              '**Dépannage urgence :** à partir de 89€\n'
              '**Entretien climatisation :** à partir de 90€\n'
              '**Installation clim monosplit :** à partir de 1 200€\n'
              '**Installation clim multisplit :** à partir de 2 500€\n'
              '**Installation PAC air/air :** à partir de 3 500€\n'
              '**Installation PAC air/eau :** à partir de 8 000€\n'
              '**Déplacement :** inclus ou selon zone\n\n'
              '✅ **Tous nos devis sont gratuits et personnalisés.**\n'
              'Le tarif final dépend de votre projet et de vos besoins.';
          subOptions = [
            _QuickOption(id: 'devis', label: '📋 Devis personnalisé', icon: Icons.description),
            _QuickOption(id: 'appeler', label: '📞 Appeler', icon: Icons.phone),
            _QuickOption(id: 'retour', label: '↩️ Menu', icon: Icons.arrow_back),
          ];
          break;
          
        // ==================== ZONES D'INTERVENTION ====================
        case 'zones':
          response = '📍 **Zones d\'intervention**\n\n'
              '**Alpes-Maritimes (06) :**\n'
              'Nice, Cannes, Antibes, Grasse, Menton, Cagnes-sur-Mer, Mandelieu, Mougins, Valbonne, Vence, Saint-Laurent-du-Var, Villeneuve-Loubet...\n\n'
              '**Var (83) :**\n'
              'Fréjus, Saint-Raphaël, Toulon, Hyères, Draguignan, Sainte-Maxime, Saint-Tropez...\n\n'
              '🚗 **Déplacement gratuit** dans la plupart des communes.\n'
              '⏱️ **Délai moyen :** 24-48h (urgences : le jour même)';
          subOptions = [
            _QuickOption(id: 'devis', label: '📋 Demander un devis', icon: Icons.description),
            _QuickOption(id: 'appeler', label: '📞 Appeler', icon: Icons.phone),
            _QuickOption(id: 'retour', label: '↩️ Menu', icon: Icons.arrow_back),
          ];
          break;
          
        // ==================== CERTIFICATIONS ====================
        case 'certifications':
          response = '🏆 **Nos certifications & garanties**\n\n'
              '✅ **Garantie décennale** - Vos travaux couverts 10 ans\n'
              '✅ **Assurance RC Professionnelle** - Protection complète\n'
              '✅ **Installateur qualifié** - Formation continue\n'
              '✅ **Attestation de capacité fluides frigorigènes**\n\n'
              '🔧 **Marques installées :**\n'
              'Daikin, Mitsubishi Electric, Atlantic, Toshiba, Panasonic\n\n'
              '💯 **+500 clients satisfaits** sur la Côte d\'Azur';
          subOptions = [
            _QuickOption(id: 'devis', label: '📋 Demander un devis', icon: Icons.description),
            _QuickOption(id: 'appeler', label: '📞 Appeler', icon: Icons.phone),
            _QuickOption(id: 'retour', label: '↩️ Menu', icon: Icons.arrow_back),
          ];
          break;
          
        // ==================== FAQ ====================
        case 'faq':
          response = '❓ **Questions fréquentes**\n\n'
              'Choisissez une question :\n\n'
              '1️⃣ Quel est votre délai d\'intervention ?\n'
              '2️⃣ Intervenez-vous dans le Var ?\n'
              '3️⃣ Le devis est-il gratuit ?\n'
              '4️⃣ Quelles marques installez-vous ?\n'
              '5️⃣ Ma clim ne refroidit plus, que faire ?\n'
              '6️⃣ Faites-vous des contrats d\'entretien ?';
          subOptions = [
            _QuickOption(id: 'faq_delai', label: '1️⃣ Délai', icon: Icons.schedule),
            _QuickOption(id: 'faq_var', label: '2️⃣ Var ?', icon: Icons.location_on),
            _QuickOption(id: 'faq_devis', label: '3️⃣ Devis gratuit ?', icon: Icons.euro),
            _QuickOption(id: 'faq_marques', label: '4️⃣ Marques', icon: Icons.verified),
            _QuickOption(id: 'faq_panne', label: '5️⃣ Panne clim', icon: Icons.ac_unit),
            _QuickOption(id: 'faq_entretien', label: '6️⃣ Entretien', icon: Icons.build),
          ];
          break;
          
        // ==================== FAQ RÉPONSES ====================
        case 'faq_delai':
          response = '⏱️ **Délai d\'intervention**\n\n'
              '• **Urgences :** intervention le jour même si possible\n'
              '• **Dépannage standard :** sous 24 à 48h\n'
              '• **Installation :** selon planning, généralement sous 1 semaine\n\n'
              'Nous faisons notre maximum pour vous dépanner rapidement !';
          subOptions = _actionOptions + [_QuickOption(id: 'faq', label: '❓ Autres questions', icon: Icons.help)];
          break;
          
        case 'faq_var':
          response = '📍 **Intervention dans le Var (83)**\n\n'
              'Oui, nous intervenons dans tout le Var !\n\n'
              'Fréjus, Saint-Raphaël, Toulon, Hyères, Draguignan, Sainte-Maxime, Les Arcs...\n\n'
              'Le déplacement est inclus ou facturé selon la distance.';
          subOptions = _actionOptions + [_QuickOption(id: 'faq', label: '❓ Autres questions', icon: Icons.help)];
          break;
          
        case 'faq_devis':
          response = '✅ **Devis 100% gratuit**\n\n'
              'Oui, tous nos devis sont **gratuits et sans engagement**.\n\n'
              'Nous nous déplaçons gratuitement pour évaluer votre projet et vous remettre un devis détaillé.\n\n'
              'Aucune surprise : tout est indiqué noir sur blanc !';
          subOptions = _actionOptions + [_QuickOption(id: 'faq', label: '❓ Autres questions', icon: Icons.help)];
          break;
          
        case 'faq_marques':
          response = '🔧 **Marques installées**\n\n'
              'Nous travaillons avec les meilleures marques :\n\n'
              '• **Daikin** - Leader mondial\n'
              '• **Mitsubishi Electric** - Fiabilité japonaise\n'
              '• **Atlantic** - Fabrication française\n'
              '• **Toshiba** - Innovation technologique\n'
              '• **Panasonic** - Qualité premium\n\n'
              'Nous vous conseillons la marque adaptée à votre budget et vos besoins.';
          subOptions = _actionOptions + [_QuickOption(id: 'faq', label: '❓ Autres questions', icon: Icons.help)];
          break;
          
        case 'faq_panne':
          response = '❄️ **Ma clim ne refroidit plus**\n\n'
              'Causes possibles :\n'
              '• Filtres encrassés → Nettoyage nécessaire\n'
              '• Manque de gaz frigorigène → Recharge\n'
              '• Problème électronique → Diagnostic\n'
              '• Compresseur HS → Réparation/remplacement\n\n'
              '💡 **Conseil :** N\'attendez pas ! Une panne peut s\'aggraver.\n\n'
              'Appelez-nous pour un diagnostic rapide.';
          subOptions = _actionOptions + [_QuickOption(id: 'faq', label: '❓ Autres questions', icon: Icons.help)];
          break;
          
        case 'faq_entretien':
          response = '🔧 **Contrats d\'entretien**\n\n'
              'Oui, nous proposons des **contrats de maintenance** :\n\n'
              '• Entretien annuel climatisation\n'
              '• Entretien PAC (obligatoire pour certaines aides)\n'
              '• Maintenance chambres froides (pro)\n\n'
              '**Avantages :**\n'
              '✅ Prolonge la durée de vie\n'
              '✅ Réduit les pannes\n'
              '✅ Maintient les performances\n'
              '✅ Intervention prioritaire';
          subOptions = _actionOptions + [_QuickOption(id: 'faq', label: '❓ Autres questions', icon: Icons.help)];
          break;
          
        // ==================== CONTACT ====================
        case 'contact':
          response = '📞 **Contactez Azur Confort**\n\n'
              '📱 **Téléphone :** $kPhoneNumberFormatted\n'
              '💬 **WhatsApp :** Disponible\n'
              '📧 **Email :** contact@azur-confort.fr\n\n'
              '🕐 **Horaires :**\n'
              '• Lun-Ven : 8h - 19h\n'
              '• Samedi : 9h - 17h\n'
              '• Urgences : 7j/7\n\n'
              '📍 Nice et toute la Côte d\'Azur (06 & 83)';
          subOptions = [
            _QuickOption(id: 'appeler', label: '📞 Appeler', icon: Icons.phone),
            _QuickOption(id: 'whatsapp', label: '💬 WhatsApp', icon: Icons.message),
            _QuickOption(id: 'email', label: '📧 Email', icon: Icons.email),
            _QuickOption(id: 'retour', label: '↩️ Menu', icon: Icons.arrow_back),
          ];
          break;
          
        // ==================== ACTIONS ====================
        case 'appeler':
          launchPhone();
          response = '📞 **Appel en cours...**\n\n'
              'Numéro : **$kPhoneNumberFormatted**\n\n'
              'Si l\'appel ne s\'ouvre pas, composez directement ce numéro.\n\n'
              'Nous sommes disponibles du lundi au samedi !';
          subOptions = [_QuickOption(id: 'retour', label: '↩️ Menu', icon: Icons.arrow_back)];
          break;
          
        case 'whatsapp':
          launchWhatsApp();
          response = '💬 **WhatsApp**\n\n'
              'Envoyez-nous un message avec :\n'
              '• Votre besoin\n'
              '• Votre ville\n'
              '• Des photos si nécessaire\n\n'
              'Nous répondons rapidement, même le week-end !';
          subOptions = [_QuickOption(id: 'retour', label: '↩️ Menu', icon: Icons.arrow_back)];
          break;
          
        case 'email':
          launchEmail();
          response = '📧 **Email envoyé**\n\n'
              'Adresse : **contact@azur-confort.fr**\n\n'
              'Décrivez votre projet en détail, nous vous répondons sous 24h ouvrées.';
          subOptions = [_QuickOption(id: 'retour', label: '↩️ Menu', icon: Icons.arrow_back)];
          break;
          
        case 'formulaire':
          _AzurConfortHomeState.navigateToPage(2);
          response = '📝 **Redirection vers le formulaire...**\n\n'
              'Remplissez vos informations et nous vous recontacterons très rapidement !';
          Future.delayed(const Duration(milliseconds: 500), () {
            setState(() => _isOpen = false);
          });
          break;
          
        // ==================== SERVICES DÉTAILLÉS ====================
        case 'clim':
          response = '❄️ **Climatisation**\n\n'
              '**Nos prestations :**\n'
              '• Installation clim monosplit\n'
              '• Installation clim multisplit\n'
              '• Climatisation gainable\n'
              '• Entretien annuel\n'
              '• Dépannage et réparation\n'
              '• Remplacement de climatiseur\n\n'
              '**Marques :** Daikin, Mitsubishi, Atlantic, Toshiba\n\n'
              '💰 **Devis gratuit** - Intervention rapide 06 & 83';
          subOptions = [
            _QuickOption(id: 'devis', label: '📋 Devis climatisation', icon: Icons.description),
            _QuickOption(id: 'appeler', label: '📞 Appeler', icon: Icons.phone),
            _QuickOption(id: 'services', label: '↩️ Autres services', icon: Icons.arrow_back),
          ];
          break;
          
        case 'frigo':
          response = '🧊 **Frigoriste professionnel**\n\n'
              '**Nos prestations :**\n'
              '• Chambres froides positives/négatives\n'
              '• Vitrines réfrigérées\n'
              '• Meubles frigorifiques\n'
              '• Groupes froids\n'
              '• Maintenance préventive\n'
              '• Dépannage urgent\n\n'
              '🏪 **Pour :** commerces, restaurants, grandes surfaces, laboratoires';
          subOptions = [
            _QuickOption(id: 'devis', label: '📋 Devis frigoriste', icon: Icons.description),
            _QuickOption(id: 'appeler', label: '📞 Appeler', icon: Icons.phone),
            _QuickOption(id: 'services', label: '↩️ Autres services', icon: Icons.arrow_back),
          ];
          break;
          
        case 'pac':
          response = '🌡️ **Pompes à chaleur**\n\n'
              '**Nos prestations :**\n'
              '• PAC Air/Air réversible\n'
              '• PAC Air/Eau\n'
              '• Ballon thermodynamique\n'
              '• Entretien annuel PAC\n'
              '• Dépannage et SAV\n\n'
              '🌿 **Avantages :**\n'
              '• Économies d\'énergie jusqu\'à 70%\n'
              '• Éligible aux aides (MaPrimeRénov\')\n'
              '• Solution écologique';
          subOptions = [
            _QuickOption(id: 'devis', label: '📋 Devis PAC', icon: Icons.description),
            _QuickOption(id: 'appeler', label: '📞 Appeler', icon: Icons.phone),
            _QuickOption(id: 'services', label: '↩️ Autres services', icon: Icons.arrow_back),
          ];
          break;
          
        case 'chauffage':
          response = '🔥 **Chauffage**\n\n'
              '**Nos prestations :**\n'
              '• Chaudières gaz/fioul\n'
              '• Radiateurs électriques\n'
              '• Plancher chauffant\n'
              '• Entretien chaudière annuel\n'
              '• Dépannage chauffage\n'
              '• Désembouage radiateurs\n\n'
              '🏠 Pour un confort optimal toute l\'année';
          subOptions = [
            _QuickOption(id: 'devis', label: '📋 Devis chauffage', icon: Icons.description),
            _QuickOption(id: 'appeler', label: '📞 Appeler', icon: Icons.phone),
            _QuickOption(id: 'services', label: '↩️ Autres services', icon: Icons.arrow_back),
          ];
          break;
          
        case 'plomberie':
          response = '💧 **Plomberie**\n\n'
              '**Nos prestations :**\n'
              '• Dépannage fuite d\'eau\n'
              '• Installation sanitaires\n'
              '• Rénovation salle de bain\n'
              '• Débouchage canalisations\n'
              '• Chauffe-eau / cumulus\n'
              '• Robinetterie\n\n'
              '🔧 **Intervention rapide** en cas d\'urgence';
          subOptions = [
            _QuickOption(id: 'devis', label: '📋 Devis plomberie', icon: Icons.description),
            _QuickOption(id: 'appeler', label: '📞 Appeler', icon: Icons.phone),
            _QuickOption(id: 'services', label: '↩️ Autres services', icon: Icons.arrow_back),
          ];
          break;
          
        // ==================== ÉLECTRICITÉ (NOUVEAU) ====================
        case 'electricite':
          response = '⚡ **Électricité**\n\n'
              '**Nos prestations :**\n'
              '• Dépannage électrique urgent\n'
              '• Mise aux normes NF C 15-100\n'
              '• Tableaux électriques\n'
              '• Installation éclairage LED\n'
              '• Recherche de défaut\n'
              '• Prises et interrupteurs\n'
              '• Raccordement équipements\n\n'
              '⚠️ **Sécurité garantie** - Travail soigné';
          subOptions = [
            _QuickOption(id: 'devis', label: '📋 Devis électricité', icon: Icons.description),
            _QuickOption(id: 'appeler', label: '📞 Appeler', icon: Icons.phone),
            _QuickOption(id: 'services', label: '↩️ Autres services', icon: Icons.arrow_back),
          ];
          break;
          
        // ==================== RETOUR MENU ====================
        case 'retour':
          response = 'Comment puis-je vous aider ?';
          subOptions = _quickOptions;
          break;
          
        default:
          response = 'Je n\'ai pas compris votre demande. Comment puis-je vous aider ?';
          subOptions = _quickOptions;
      }
      
      setState(() {
        _messages.add(_ChatMessage(
          text: response,
          isBot: true,
          options: subOptions,
        ));
      });
      
      _scrollToBottom();
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Stack(
      children: [
        // Bulle de bienvenue (avant ouverture)
        // Fond BLANC permanent (jour et nuit)
        if (_showWelcome && !_isOpen)
          Positioned(
            bottom: 70,
            right: 16,
            child: AnimatedBuilder(
              animation: _bounceAnimation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, -_bounceAnimation.value),
                  child: child,
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  // Fond BLANC permanent
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: kPrimaryBlue.withOpacity(0.3),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: kPrimaryBlue.withOpacity(0.15),
                      blurRadius: 12,
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
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: kDarkBlue,
                      ),
                    ),
                    const SizedBox(width: 6),
                    GestureDetector(
                      onTap: () => setState(() => _showWelcome = false),
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.15),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.close, 
                          size: 12, 
                          color: Colors.grey,
                        ),
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
            bottom: 75,
            right: 16,
            child: _buildChatWindow(),
          ),
        
        // Bouton flottant avec mascotte - COMPACT
        // Fond BLANC permanent (jour et nuit)
        Positioned(
          bottom: 16,
          right: 16,
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
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  // Fond BLANC permanent
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: kPrimaryBlue,
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: kPrimaryBlue.withOpacity(0.25),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Mascotte
                    ClipOval(
                      child: Image.asset(
                        'assets/images/chatbot_mascot.png',
                        width: 44,
                        height: 44,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            _isOpen ? Icons.close : Icons.chat,
                            color: kPrimaryBlue,
                            size: 24,
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
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 1.5),
                          ),
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 10,
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
              // IMPORTANT: Texte toujours noir/foncé pour lisibilité sur fond blanc
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 14,
              ),
              cursorColor: kPrimaryBlue,
              decoration: InputDecoration(
                hintText: 'Tapez votre message...',
                // Placeholder en gris foncé pour lisibilité
                hintStyle: TextStyle(color: Colors.grey.shade600),
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
  
  // ==================== ÉLECTRICITÉ (NOUVEAU) ====================
  _FaqEntry(
    category: 'Électricité',
    keywords: ['panne', 'électrique', 'électricité', 'courant', 'prise', 'lumière'],
    question: 'Panne électrique',
    answer: '⚡ **Panne électrique**\n\n'
        '**Intervention rapide pour :**\n'
        '• Coupure de courant\n'
        '• Disjoncteur qui saute\n'
        '• Prise ou interrupteur défaillant\n'
        '• Court-circuit\n\n'
        '🔧 **Nos services :**\n'
        '• Dépannage électrique\n'
        '• Mise aux normes NF C 15-100\n'
        '• Tableaux électriques\n'
        '• Installation éclairage LED\n\n'
        '📞 Appelez-nous : \$kPhoneNumberFormatted',
  ),
  _FaqEntry(
    category: 'Électricité',
    keywords: ['norme', 'mise', 'aux', 'normes', 'conformité', 'sécurité', 'tableau'],
    question: 'Mise aux normes électrique',
    answer: '⚡ **Mise aux normes électrique**\n\n'
        '**Nous réalisons :**\n'
        '• Diagnostic de votre installation\n'
        '• Mise en conformité NF C 15-100\n'
        '• Remplacement tableau électrique\n'
        '• Installation différentiel 30mA\n'
        '• Mise à la terre\n\n'
        '✅ **Obligatoire pour :**\n'
        '• Vente immobilière\n'
        '• Location\n'
        '• Assurance\n\n'
        '💰 Devis gratuit',
  ),
  _FaqEntry(
    category: 'Électricité',
    keywords: ['led', 'éclairage', 'lampe', 'spot', 'luminaire', 'ampoule'],
    question: 'Installation éclairage LED',
    answer: '💡 **Éclairage LED**\n\n'
        '**Nos installations :**\n'
        '• Spots LED encastrés\n'
        '• Bandeaux LED\n'
        '• Éclairage extérieur\n'
        '• Remplacement ampoules\n\n'
        '**Avantages LED :**\n'
        '• Économie d\'énergie 80%\n'
        '• Durée de vie 25 000h\n'
        '• Pas de chaleur\n\n'
        '📋 Devis gratuit',
  ),
  
  // ==================== TARIFS ====================
  _FaqEntry(
    category: 'Tarifs',
    keywords: ['tarif', 'prix', 'coût', 'combien', 'cher', 'budget', 'estimation'],
    question: 'Tarifs indicatifs',
    answer: '💰 **Tarifs indicatifs** _(non contractuels)_\n\n'
        '**Dépannage urgence :** à partir de 89€\n'
        '**Entretien climatisation :** à partir de 90€\n'
        '**Installation clim monosplit :** à partir de 1 200€\n'
        '**Installation PAC air/air :** à partir de 3 500€\n'
        '**Déplacement :** inclus selon zone\n\n'
        '✅ **Tous nos devis sont gratuits et personnalisés.**\n'
        'Le tarif final dépend de votre projet.',
  ),
  
  // ==================== CERTIFICATIONS ====================
  _FaqEntry(
    category: 'Certifications',
    keywords: ['garantie', 'décennale', 'assurance', 'certification', 'qualifié', 'diplôme'],
    question: 'Certifications et garanties',
    answer: '🏆 **Nos certifications**\n\n'
        '✅ **Garantie décennale** - Travaux couverts 10 ans\n'
        '✅ **RC Professionnelle** - Protection complète\n'
        '✅ **Attestation fluides frigorigènes**\n'
        '✅ **Installateur qualifié**\n\n'
        '🔧 **Marques partenaires :**\n'
        'Daikin, Mitsubishi, Atlantic, Toshiba\n\n'
        '💯 +500 clients satisfaits',
  ),
  _FaqEntry(
    category: 'Certifications',
    keywords: ['marque', 'daikin', 'mitsubishi', 'atlantic', 'toshiba', 'panasonic'],
    question: 'Marques installées',
    answer: '🔧 **Marques installées**\n\n'
        'Nous travaillons avec les meilleures marques :\n\n'
        '• **Daikin** - Leader mondial, fiabilité\n'
        '• **Mitsubishi Electric** - Qualité japonaise\n'
        '• **Atlantic** - Fabrication française\n'
        '• **Toshiba** - Innovation\n'
        '• **Panasonic** - Premium\n\n'
        '💡 Nous vous conseillons la marque adaptée à vos besoins et budget.',
  ),
  
  // ==================== CONTRAT ENTRETIEN ====================
  _FaqEntry(
    category: 'Entretien',
    keywords: ['contrat', 'maintenance', 'entretien', 'annuel', 'abonnement'],
    question: 'Contrat de maintenance',
    answer: '🔧 **Contrats d\'entretien**\n\n'
        '**Nos formules :**\n'
        '• Entretien annuel climatisation\n'
        '• Entretien PAC (obligatoire aides)\n'
        '• Maintenance pro (chambres froides)\n\n'
        '**Avantages :**\n'
        '✅ Intervention prioritaire\n'
        '✅ Tarif préférentiel dépannage\n'
        '✅ Performances optimales\n'
        '✅ Durée de vie prolongée\n\n'
        '📋 Demandez un devis contrat',
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
