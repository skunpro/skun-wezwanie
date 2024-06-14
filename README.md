# Skrypt FiveM (ESX): Wezwanie na kanał Poczekalanie!

### ![Screenshot of a comment on a GitHub issue showing an image, added in the Markdown, of an Octocat smiling and raising a tentacle.](https://myoctocat.com/assets/images/base-octocat.svg)

## Opis

Skrypt umożliwia administratorom serwera FiveM wysyłanie powiadomień do graczy za pomocą komendy `/wezwij`. Po użyciu tej komendy, gracz otrzymuje powiadomienie na ekranie oraz informację przez webhook Discord, jeśli posiada ustawione Discord ID.

## Wymagania

- Zasób `es_extended` lub inny framework, który umożliwia zarządzanie graczami i ich uprawnieniami.
- Dostęp do bazy danych MySQL, w której przechowywane są identyfikatory graczy oraz ich Discord ID.
- Dostęp do panelu administracyjnego Discord, aby utworzyć webhook do wysyłania powiadomień.
- Żeby skrypt działał potrzebujesz `es_extended` oraz `mysql-async`

## Instalacja

1. Skopiuj zawartość pliku `skun-wezwanie` do katalogu `resources` Twojego serwera FiveM.
2. Dodaj `start skun-wezwanie` do swojego `server.cfg`, aby uruchomić skrypt podczas startu serwera.

## Konfiguracja

- Szukasz linijki takiej jak `local webhookUrl = 'TWOJ_WEBHOOK_KANALU_WEZWANIA'`, następnie wklejasz tutaj swój link do Webhooka!
- Następnie szukasz `<#ID_TWOJEGO_KANALU_POCZEKALNIA>` i ustawiasz to na swoje!

## Użycie

1. W grze użyj komendy `/wezwij <ID_gracza>`, aby wysłać powiadomienie do wybranego gracza.
2. Gracz otrzyma powiadomienie na ekranie w grze oraz wiadomość przez webhook Discord.

## Autor

- Autor: notaskun / https://skun.pro/
- Kontakt: notaskun#0
