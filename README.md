# Skrypt FiveM: Wezwanie na kanał Poczeklani!

## Opis

Skrypt umożliwia administratorom serwera FiveM wysyłanie powiadomień do graczy za pomocą komendy `/wezwij`. Po użyciu tej komendy, gracz otrzymuje powiadomienie na ekranie oraz informację przez webhook Discord, jeśli posiada ustawione Discord ID.

## Wymagania

- Zasób `es_extended` lub inny framework, który umożliwia zarządzanie graczami i ich uprawnieniami.
- Dostęp do bazy danych MySQL, w której przechowywane są identyfikatory graczy oraz ich Discord ID.
- Dostęp do panelu administracyjnego Discord, aby utworzyć webhook do wysyłania powiadomień.

## Instalacja

1. Skopiuj zawartość pliku `skun-wezwanie` do katalogu `resources` Twojego serwera FiveM.
2. Dodaj `start skun-wezwanie` do swojego `server.cfg`, aby uruchomić skrypt podczas startu serwera.

## Konfiguracja

### Konfiguracja Webhook

- Szukasz linijki takiej jak `local webhookUrl = 'TWOJ_URL_WEBHOOKA_DISCORD'`, następnie wklejasz tutaj swój link do Webhooka!

## Użycie

1. W grze użyj komendy `/wezwij <ID_gracza>`, aby wysłać powiadomienie do wybranego gracza.
2. Gracz otrzyma powiadomienie na ekranie w grze oraz wiadomość przez webhook Discord.

## Autor

- Autor: notaskun / https://skun.pro/
- Kontakt: notaskun#0
