//// A simple example of sending a text message to Discord via webhook.
////
//// To run this example:
//// 1. Replace "YOUR_WEBHOOK_URL" with your actual Discord webhook URL
//// 2. Run: gleam run -m examples/basic

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
