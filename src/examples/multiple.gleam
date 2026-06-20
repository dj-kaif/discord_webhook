//// An example of sending multiple text messages and multiple embeds in one webhook call.
////
//// You can build complex messages by chaining text and embeds together.
////
//// To run this example:
//// 1. Replace "YOUR_WEBHOOK_URL" with your actual Discord webhook URL
//// 2. Run: gleam run -m examples/multiple

import discord_webhook
import gleam/io

pub fn main() {
  let webhook = discord_webhook.new("YOUR_WEBHOOK_URL")

  // Create the first embed (info)
  let info_embed =
    discord_webhook.embed()
    |> discord_webhook.embed_title("Build Information")
    |> discord_webhook.embed_color(3447003)
    |> discord_webhook.embed_field("Language", "Gleam", False)
    |> discord_webhook.embed_field("Version", "1.0.0", False)

  // Create the second embed (status)
  let status_embed =
    discord_webhook.embed()
    |> discord_webhook.embed_title("System Status")
    |> discord_webhook.embed_color(5763719)
    // 5763719 = 0x57F287 (green)
    |> discord_webhook.embed_field("Status", "✓ Online", True)
    |> discord_webhook.embed_field("Uptime", "24h", True)

  // Build a message with multiple texts and embeds
  // The order matters: first text, then embeds, then more text, etc.
  let msg =
    discord_webhook.message("🎯 Status Update")
    |> discord_webhook.add_embed(info_embed)
    |> discord_webhook.add_message("Everything is running smoothly!")
    |> discord_webhook.add_embed(status_embed)
    |> discord_webhook.add_message("Last updated: Just now")

  // Send the complete message
  case discord_webhook.send(webhook, msg) {
    Ok(Nil) -> io.println("✓ Complete message sent successfully!")
    Error(err) -> io.println("✗ Error: " <> err)
  }
}
