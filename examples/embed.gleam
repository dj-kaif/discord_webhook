//// An example of sending a message with an embed to Discord.
////
//// Embeds are rich formatted messages with titles, descriptions, colors, and fields.
////
//// To run this example:
//// 1. Copy and save this file
//// 2. Replace "YOUR_WEBHOOK_URL" with your actual Discord webhook URL
//// 3. Run: gleam run -m embed

import discord_webhook
import gleam/io

pub fn main() {
  let webhook = discord_webhook.new("YOUR_WEBHOOK_URL")

  // Create a new embed with a title
  let my_embed =
    discord_webhook.embed()
    |> discord_webhook.embed_title("Welcome to Discord Webhook!")
    |> discord_webhook.embed_description(
      "This is a rich embed message sent from a Gleam library discord_webhook.",
    )
    // Discord colors are in decimal (0xRRGGBB format as integer)
    // Example: 0x5865F2 = 3447003 (Discord blurple)
    |> discord_webhook.embed_color(3447003)
    // Add fields to the embed
    |> discord_webhook.embed_field("Language", "Gleam", False)
    |> discord_webhook.embed_field("Status", "🚀 Running", False)

  // Create a message and add the embed to it
  let msg =
    discord_webhook.message("Check out this embed!")
    |> discord_webhook.add_embed(my_embed)

  // Send the message
  case discord_webhook.send(webhook, msg) {
    Ok(Nil) -> io.println("✓ Embed sent successfully!")
    Error(err) -> io.println("✗ Error: " <> err)
  }
}
