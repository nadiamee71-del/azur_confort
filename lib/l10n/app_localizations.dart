import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_it.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('it'),
  ];

  /// Nom de l'application
  ///
  /// In fr, this message translates to:
  /// **'Azur Confort'**
  String get appName;

  /// Première ligne du titre hero
  ///
  /// In fr, this message translates to:
  /// **'Votre confort,'**
  String get heroTitle1;

  /// Deuxième ligne du titre hero
  ///
  /// In fr, this message translates to:
  /// **'notre priorité.'**
  String get heroTitle2;

  /// Sous-titre du hero
  ///
  /// In fr, this message translates to:
  /// **'Climatisation • Pompes à chaleur • Plomberie • Chauffage'**
  String get heroSubtitle;

  /// Badge du hero
  ///
  /// In fr, this message translates to:
  /// **'Intervention rapide 06 & 83'**
  String get heroBadge;

  /// Description artisan
  ///
  /// In fr, this message translates to:
  /// **'Artisan frigoriste qualifié sur toute la Côte d\'Azur'**
  String get heroArtisan;

  /// Bouton appeler
  ///
  /// In fr, this message translates to:
  /// **'Appeler maintenant'**
  String get buttonCall;

  /// Bouton devis
  ///
  /// In fr, this message translates to:
  /// **'Demander un devis'**
  String get buttonQuote;

  /// Statistique expérience
  ///
  /// In fr, this message translates to:
  /// **'Ans d\'expérience'**
  String get statExperience;

  /// Statistique clients
  ///
  /// In fr, this message translates to:
  /// **'Clients satisfaits'**
  String get statClients;

  /// Statistique intervention
  ///
  /// In fr, this message translates to:
  /// **'Intervention rapide'**
  String get statIntervention;

  /// Titre section services
  ///
  /// In fr, this message translates to:
  /// **'Nos services'**
  String get servicesTitle;

  /// Sous-titre section services
  ///
  /// In fr, this message translates to:
  /// **'Froid, chaud, eau : des solutions complètes pour votre confort'**
  String get servicesSubtitle;

  /// Service climatisation
  ///
  /// In fr, this message translates to:
  /// **'Climatisation'**
  String get serviceClimatisation;

  /// Service frigoriste
  ///
  /// In fr, this message translates to:
  /// **'Frigoriste'**
  String get serviceFrigoriste;

  /// Service pompes à chaleur
  ///
  /// In fr, this message translates to:
  /// **'Pompes à chaleur'**
  String get servicePac;

  /// Service chauffage
  ///
  /// In fr, this message translates to:
  /// **'Chauffage'**
  String get serviceChauffage;

  /// Service plomberie
  ///
  /// In fr, this message translates to:
  /// **'Plomberie'**
  String get servicePlomberie;

  /// Description climatisation
  ///
  /// In fr, this message translates to:
  /// **'Installation, entretien et dépannage de systèmes de climatisation pour particuliers et professionnels.'**
  String get climatisationDesc;

  /// Description frigoriste
  ///
  /// In fr, this message translates to:
  /// **'Expert en froid commercial et industriel : chambres froides, vitrines réfrigérées, équipements frigorifiques.'**
  String get frigoristeDesc;

  /// Description PAC
  ///
  /// In fr, this message translates to:
  /// **'Solutions écologiques et économiques pour chauffer et rafraîchir votre habitat toute l\'année.'**
  String get pacDesc;

  /// Description chauffage
  ///
  /// In fr, this message translates to:
  /// **'Installation et maintenance de systèmes de chauffage performants pour votre confort thermique.'**
  String get chauffageDesc;

  /// Description plomberie
  ///
  /// In fr, this message translates to:
  /// **'Plomberie générale, rénovation de salle de bain, dépannage et installation sanitaire.'**
  String get plomberieDesc;

  /// Titre section zones
  ///
  /// In fr, this message translates to:
  /// **'Zones d\'intervention'**
  String get zonesTitle;

  /// Sous-titre section zones
  ///
  /// In fr, this message translates to:
  /// **'Climatisation et plomberie dans les Alpes-Maritimes (06) et le Var (83)'**
  String get zonesSubtitle;

  /// Département 06
  ///
  /// In fr, this message translates to:
  /// **'Alpes-Maritimes'**
  String get alpesMaritimes;

  /// Département 83
  ///
  /// In fr, this message translates to:
  /// **'Var'**
  String get varDepartment;

  /// Légende carte
  ///
  /// In fr, this message translates to:
  /// **'Intervention dans tout le département'**
  String get interventionZone;

  /// Titre section pourquoi nous
  ///
  /// In fr, this message translates to:
  /// **'Pourquoi nous choisir ?'**
  String get whyUsTitle;

  /// Sous-titre section pourquoi nous
  ///
  /// In fr, this message translates to:
  /// **'Artisan frigoriste et plombier chauffagiste de confiance – Intervention rapide 06 & 83'**
  String get whyUsSubtitle;

  /// Avantage qualifié
  ///
  /// In fr, this message translates to:
  /// **'Artisan qualifié'**
  String get whyQualified;

  /// Description qualifié
  ///
  /// In fr, this message translates to:
  /// **'Frigoriste certifié'**
  String get whyQualifiedDesc;

  /// Avantage réactivité
  ///
  /// In fr, this message translates to:
  /// **'Réactivité'**
  String get whyReactive;

  /// Description réactivité
  ///
  /// In fr, this message translates to:
  /// **'Intervention sous 24h'**
  String get whyReactiveDesc;

  /// Avantage transparence
  ///
  /// In fr, this message translates to:
  /// **'Transparence'**
  String get whyTransparent;

  /// Description transparence
  ///
  /// In fr, this message translates to:
  /// **'Devis gratuit détaillé'**
  String get whyTransparentDesc;

  /// Avantage garantie
  ///
  /// In fr, this message translates to:
  /// **'Garantie'**
  String get whyGuarantee;

  /// Description garantie
  ///
  /// In fr, this message translates to:
  /// **'Satisfaction assurée'**
  String get whyGuaranteeDesc;

  /// Titre SEO
  ///
  /// In fr, this message translates to:
  /// **'Artisan climatisation, pompe à chaleur et plomberie – Alpes-Maritimes (06) & Var (83)'**
  String get seoTitle;

  /// Premier paragraphe SEO
  ///
  /// In fr, this message translates to:
  /// **'Azur Confort intervient dans toutes les Alpes-Maritimes (Nice, Cannes, Mandelieu, Grasse, Antibes, Menton…) et dans le Var (Fréjus, Saint-Raphaël, Toulon, Hyères…). L\'entreprise est spécialisée dans l\'installation, l\'entretien et le dépannage de climatisations mono-split et multi-split, pompes à chaleur air-air et air-eau, systèmes de chauffage domestique et travaux de plomberie (rénovation de salle de bain, recherche de fuites, remplacement de robinetterie, dépannage d\'urgence).'**
  String get seoParagraph1;

  /// Deuxième paragraphe SEO
  ///
  /// In fr, this message translates to:
  /// **'En choisissant Azur Confort, vous bénéficiez d\'un artisan frigoriste et plombier chauffagiste de proximité, à l\'écoute de vos besoins. Nous vous accompagnons dans le choix du matériel, l\'installation de clim réversible dans le 06 et le 83, la mise en service, l\'entretien annuel de climatisation et de pompe à chaleur, et le dépannage climatisation et plomberie. L\'objectif : garantir votre confort thermique toute l\'année, avec des interventions rapides, des conseils personnalisés et un travail soigné.'**
  String get seoParagraph2;

  /// Footer artisan
  ///
  /// In fr, this message translates to:
  /// **'Artisan frigoriste sur la Côte d\'Azur (06 & 83)'**
  String get footerArtisan;

  /// Footer droits
  ///
  /// In fr, this message translates to:
  /// **'© 2025 Azur Confort - Tous droits réservés'**
  String get footerRights;

  /// Lien mentions légales
  ///
  /// In fr, this message translates to:
  /// **'Mentions légales'**
  String get legalMentions;

  /// Texte chatbot
  ///
  /// In fr, this message translates to:
  /// **'Besoin d\'aide ?'**
  String get chatbotHelp;

  /// Message bienvenue chatbot
  ///
  /// In fr, this message translates to:
  /// **'Bonjour ! Je suis l\'assistant virtuel d\'Azur Confort. Comment puis-je vous aider ?'**
  String get chatbotWelcome;

  /// Navigation accueil
  ///
  /// In fr, this message translates to:
  /// **'Accueil'**
  String get navHome;

  /// Navigation services
  ///
  /// In fr, this message translates to:
  /// **'Services'**
  String get navServices;

  /// Navigation à propos
  ///
  /// In fr, this message translates to:
  /// **'À propos'**
  String get navAbout;

  /// Navigation contact
  ///
  /// In fr, this message translates to:
  /// **'Contact'**
  String get navContact;

  /// Sélecteur de langue
  ///
  /// In fr, this message translates to:
  /// **'Langue'**
  String get languageSelector;

  /// Titre page contact
  ///
  /// In fr, this message translates to:
  /// **'Contactez-nous'**
  String get contactTitle;

  /// Sous-titre page contact
  ///
  /// In fr, this message translates to:
  /// **'Une question ? Un projet ? Contactez Azur Confort'**
  String get contactSubtitle;

  /// Titre page à propos
  ///
  /// In fr, this message translates to:
  /// **'À propos d\'Azur Confort'**
  String get aboutTitle;

  /// Sous-titre page à propos
  ///
  /// In fr, this message translates to:
  /// **'Votre partenaire confort depuis plus de 10 ans'**
  String get aboutSubtitle;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en', 'es', 'fr', 'it'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'it':
      return AppLocalizationsIt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
