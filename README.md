# discord_webhook

[![Package
Version](https://img.shields.io/hexpm/v/discord_webhook)](https://hex.pm/packages/discord_webhook)
[![Hex
Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/discord_webhook/)
[![License:
MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![GitHub
Repo](https://img.shields.io/badge/github-dj--kaif%2Fdiscord__webhook-blue?logo=github)](https://github.com/dj-kaif/discord_webhook)

> A simple Gleam library for sending Discord webhook.

`discord_webhook` makes it easy to send messages and embeds to Discord from Gleam projects.

------------------------------------------------------------------------

## Installation

Add the package:

``` sh
gleam add discord_webhook
```

Import it:

``` gleam
import discord_webhook
```

------------------------------------------------------------------------

## Quick Example

``` gleam
// A simple example of sending a text message to Discord via webhook.

import discord_webhook
import gleam/io

pub fn main() {
  // Create a new webhook with your Discord webhook URL
  let webhook = discord_webhook.new("YOUR_WEBHOOK_URL")

  // Create a simple message with text content
  let msg = discord_webhook.message("Hello from Gleam library `discord_webhook`!")

  // Send the message and handle the result
  case discord_webhook.send(webhook, msg) {
    Ok(Nil) -> io.println("✓ Message sent successfully!")
    Error(err) -> io.println("✗ Error: " <> err)
  }
}
```
*Note*: This will be updated soon with the stable version v1.0.0 release.

------------------------------------------------------------------------

## Features

| Feature                  | Status |
| ------------------------ | ------ |
| Plain text messages      | ✅ Done|
| Embeds                   | ✅ Done|
| Rich embeds              | 🔨     |
| Name & avatar override   | 🔨     |
| Allowed mentions         | 🔨     |
| File attachments         | 🔨     |
| Rate limiting            | 🔨     |
| Detailed errors          | 📆     |

✅ - Done  
🔨 - In Progress  
📆 - Planned  
❌ - Not Planned

## Roadmap

### v0.1.0

-   [x] Basic send method
-   [x] Basic embed support

### v0.2.0

-   [ ] Username and avatar override per message
-   [ ] Permanent webhook username/avatar update
-   [ ] Per-webhook rate limiting
-   [ ] File attachments
-   [ ] Better error types (rate limits, bad requests, etc.)

### v0.3.0

- [ ] Allowed mentions
- [ ] Allow edits after sending
- [ ] Allow deleting messages & embeds

### v1.0.0

-   [ ] Complete planned features
-   [ ] Full documentation
-   [ ] Stable API

Have a feature request or suggestion? Open an issue on GitHub.

------------------------------------------------------------------------

## Contributing

Contributions are welcome!

1.  [Fork the repository](https://github.com/dj-kaif/discord_webhook/fork)

2.  Clone your fork:

``` sh
git clone https://github.com/YOUR_USERNAME/discord_webhook.git
cd discord_webhook
```

3.  Install dependencies:

``` sh
gleam deps download
```

4.  Create a branch:

``` sh
git checkout -b my-feature
```

5.  Make your changes and add tests if needed.

6.  Run tests:

``` sh
gleam test
```

7.  Push and open a pull request.

------------------------------------------------------------------------

## License

This project is licensed under the MIT License.

See the
[LICENSE](https://github.com/dj-kaif/discord_webhook/blob/main/LICENSE)
file for details.

------------------------------------------------------------------------

## Links

-   [Hex.pm Package](https://hex.pm/packages/discord_webhook)
-   [HexDocs](https://hexdocs.pm/discord_webhook/)
-   [GitHub Repository](https://github.com/dj-kaif/discord_webhook)
-   [Issue Tracker](https://github.com/dj-kaif/discord_webhook/issues)

------------------------------------------------------------------------

## Contact

If you have questions, suggestions, or need help:
-   **Discord Username:** `@dj.kaif`
-   **Direct Profile:** https://discord.com/users/1237644967422459996

------------------------------------------------------------------------

Built with Gleam by DJ KAIF.
