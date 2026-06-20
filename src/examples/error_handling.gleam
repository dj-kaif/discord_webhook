//// An example of proper error handling when sending webhooks.
////
//// Errors can happen for various reasons:
//// - Invalid webhook URL
//// - Network issues
//// - Discord API returning an unexpected status code
////
//// To run this example:
//// 1. You can test with an invalid URL to see error handling
//// 2. Run: gleam run -m examples/error_handling

import discord_webhook
import gleam/io

pub fn main() {
  io.println("Example 1: Valid message")
  send_message("YOUR_WEBHOOK_URL", "This should work!")

  io.println("\nExample 2: Invalid webhook URL")
  send_message("not-a-valid-url", "This will fail!")

  io.println("\nExample 3: Handling different error types")
  handle_complex_send()
}

// Helper function that sends a message and prints the result
fn send_message(url: String, content: String) -> Nil {
  let webhook = discord_webhook.new(url)
  let msg = discord_webhook.message(content)

  case discord_webhook.send(webhook, msg) {
    Ok(Nil) -> io.println("✓ Success!")
    Error(err) -> io.println("✗ " <> err)
  }
}

// More complex example showing different error scenarios
fn handle_complex_send() -> Nil {
  let webhook = discord_webhook.new("YOUR_WEBHOOK_URL")

  // Build an embed
  let embed =
    discord_webhook.embed()
    |> discord_webhook.embed_title("Error Handling Demo")

  // Build message
  let msg =
    discord_webhook.message("Attempting to send...")
    |> discord_webhook.add_embed(embed)

  // Send and handle with detailed match
  case discord_webhook.send(webhook, msg) {
    Ok(Nil) -> {
      io.println("✓ Webhook fired successfully")
      io.println("✓ Discord received status: 204 No Content")
    }
    Error(msg) -> {
      io.println("✗ Failed to send webhook")
      io.println("✗ Reason: " <> msg)
      // In a real app, you might:
      // - Log this to a file
      // - Retry with exponential backoff
      // - Alert an admin
      Nil
    }
  }
}
