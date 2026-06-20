//// An example of creating a more complex embed with many fields and inline formatting.
////
//// This shows how to use the `inline` parameter on fields to create
//// side-by-side field layouts in Discord.
////
//// To run this example:
//// 1. Copy and save this file
//// 2. Replace "YOUR_WEBHOOK_URL" with your actual Discord webhook URL
//// 3. Run: gleam run -m advanced_embed

import discord_webhook
import gleam/io

pub fn main() {
  let webhook = discord_webhook.new("YOUR_WEBHOOK_URL")

  // Create a detailed embed with inline fields
  let detailed_embed =
    discord_webhook.embed()
    |> discord_webhook.embed_title("Project Stats")
    |> discord_webhook.embed_description("Here are some metrics from the latest build.")
    // Discord colors in decimal. Common ones:
    // 3447003 = 0x5865F2 (Discord blurple)
    // 5763719 = 0x57F287 (green)
    // 15158332 = 0xE74C3C (red)
    |> discord_webhook.embed_color(3447003)
    // Regular fields (full width)
    |> discord_webhook.embed_field("Description", "This is a full-width field.", False)
    // Inline fields appear side-by-side (up to 3 per row)
    |> discord_webhook.embed_field("Tests Passed", "487", True)
    |> discord_webhook.embed_field("Tests Failed", "2", True)
    |> discord_webhook.embed_field("Coverage", "92%", True)
    // More inline fields
    |> discord_webhook.embed_field("Build Time", "42s", True)
    |> discord_webhook.embed_field("Size", "2.4MB", True)
    |> discord_webhook.embed_field("Status", "✓ Success", True)

  // Create a message with just the embed
  let msg = discord_webhook.empty() |> discord_webhook.add_embed(detailed_embed)

  // Send it
  case discord_webhook.send(webhook, msg) {
    Ok(Nil) -> io.println("✓ Advanced embed sent successfully!")
    Error(err) -> io.println("✗ Error: " <> err)
  }
}
