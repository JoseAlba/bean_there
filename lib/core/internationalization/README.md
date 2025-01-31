# Internationalization

This folder makes it easy to use different languages and to localize numerical values and dates, among other things.

## Features

- Quick access to different languages
- Quick access to translated strings
- Access to read and modify the current language
- Ability to localize dates
- Ability to localize numerical values of currency
- Easy to add new languages

## Getting started

[Install extension from the Visual Studio Code Marketplace](https://marketplace.visualstudio.com/items?itemName=localizely.flutter-intl)

### Running the script
In the skillstery package directory run `flutter pub get` or if that doesn't work try:

```bash
flutter gen-l10n
```

This will automatically detect any new values in the arb files and generate it in the dart files.

### Flutter Intl: Add locale
Adds another locale to your Flutter app. The command will ask you for a new locale.

The following file will be created:
l10n/\<new-locale>.arb

### Flutter Intl: Remove locale
Removes an existing locale from your Flutter app. The command will ask you to pick a locale from the list of existing locales.

The following file will be removed:
l10n/\<existing-locale>.arb

### Add keys to main ARB file
ARB files extension stands for Application Resource Bundle and is used by the Dart Intl package for holding the keys and the string value of your translations.

File content example:
```
{
    "pageHomeConfirm": "Confirm",
    "pageHomeWelcome": "Welcome {name}",
    "pageHomeWelcomeGender": "{gender, select, male {Hi man!} female {Hi woman!} other {Hi there!}}",
    "pageHomeWelcomeRole": "{role, select, admin {Hi admin!} manager {Hi manager!} other {Hi visitor!}}",
    "pageNotificationsCount": "{howMany, plural, one{1 message} other{{howMany} messages}}"
}
```

In the example above we have 5 keys:
- pageHomeConfirm - A very simple key
- pageHomeWelcome - A key which translation contains a placeholder name
- pageHomeWelcomeGender - A gender key whose translation depends on a placeholder gender. Genders are formatted in ICU format.
- pageHomeWelcomeRole - A select key whose translation depends on a placeholder role. Selects are formatted in ICU format.
- pageNotificationsCount - A plural key whose translation depends on a placeholder howMany. Plurals are formatted in ICU format.

Your main ARB file by default is lib/l10n/intl_en.arb. When you add new key-value pairs in it and save the file, those keys will be automatically available for auto-complete in your Dart code.

## Usage

### Initialize
If you want to use this package in a new app you first need to add these lines inside your `MaterialApp`
```
localizationsDelegates: Internationalization.localizationsDelegates,
supportedLocales: Internationalization.supportedLocales,
```

### Using strings
This is an example on how you can access the translations from the package in your code, just get the `strings` property inside `Internationalization`.
```
Text(Internationalization.of(context).example)
```
