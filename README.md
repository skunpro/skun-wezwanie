# FiveM Script (ESX): Call to Waiting Channel!

## Changelog

[v1.0.1](https://github.com/skunpro/skun-wezwanie/releases/tag/v1.0.1) - Old  
[v2.0.0](https://github.com/skunpro/skun-wezwanie/releases/tag/v2.0.0) - Latest

## Description

This script allows server administrators to send notifications to players via the `/wezwij` command. When executed, the player will be frozen, receive an on-screen notification, and get a message through a Discord webhook if their Discord ID is set. The command also includes the ability to specify a reason for the call to the waiting channel.

## Requirements

- `es_extended` or any other framework that manages players and their permissions.
- Access to the Discord admin panel to create a webhook for sending notifications.
- For the script to work, you need `es_extended` and `mysql-async`.

## Installation

1. Copy the contents of the `skun-wezwanie` folder to the `resources` directory of your FiveM server.
2. Add `start skun-wezwanie` to your `server.cfg` to start the script when the server starts.

## Configuration

1. In the `server/main.lua` file, find the line:

   ```lua
   Main.Config.WebhookUrl = 'YOUR_WEBHOOK_URL'
   ```

   Replace `'YOUR_WEBHOOK_URL'` with your actual Discord webhook URL.

2. Next, find this line:

   ```lua
   Main.Config.ChannelId = 'YOUR_CHANNEL_ID'
   ```

   Replace `'YOUR_CHANNEL_ID'` with the ID of the Discord channel you want to notify.

3. Adjust the allowed roles in the configuration to fit your server setup by modifying the `AllowedRoles` array:

   ```lua
   Main.Config.AllowedRoles = {'support', 'mod', 'admin', 'superadmin', 'best'}
   ```

4. Set the duration for which players will be frozen in the `FreezeTime` variable (in milliseconds):

   ```lua
   Main.Config.FreezeTime = 30 * 1000
   ```

## Usage

1. In-game, use the following command to call a player to the waiting channel:

   ```
   /wezwij [ID] [REASON]
   ```

   - `[ID]`: The ID of the player you wish to call.
   - `[REASON]`: Optional. The reason for the call (e.g., breaking the rules).

2. The player will:

   - Receive an on-screen notification.
   - Be frozen for a set amount of time (configured as `FreezeTime` in the script).
   - Receive a message via the Discord webhook, with the reason for the call.

3. Administrators can use the command only if they have a role listed in the `AllowedRoles` configuration.

## Example

```
/wezwij 69 "Cheating"
```

This command would call the player with ID 69 to the waiting channel, with the reason "Cheating"

## Author

- Author: notaskun / https://skun.pro/
- Contact: notaskun#0
