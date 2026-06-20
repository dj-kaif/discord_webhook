import gleam/http
import gleam/http/request
import gleam/httpc
import gleam/json
import gleam/int
import gleam/list
import gleam/string
import gleam/option.{ type Option, None, Some }

// Main webhook object 
pub opaque type Webhook {
  Webhook(url: String)
}

// Embed type 
pub opaque type Embed {
  Embed(
    title: Option(String),
    description: Option(String),
    color: Option(Int),
    fields: List(#(String, String, Bool)),
  )
}

// Message type 
pub opaque type Message {
  Message(content: List(String), embeds: List(Embed))
}

// Initialize an empty embed
pub fn embed() -> Embed {
  Embed(title: None, description: None, color: None, fields: [])
}

// Add embed title
pub fn embed_title(embed: Embed, title: String) -> Embed {
  Embed(..embed, title: Some(title))
}

// Add embed description
pub fn embed_description(embed: Embed, description: String) -> Embed {
  Embed(..embed, description: Some(description))
}

// Add embed color 
pub fn embed_color(embed: Embed, color: Int) -> Embed {
  Embed(..embed, color: Some(color))
}

// Appends a new field to the end of the embed's fields list
pub fn embed_field(
  embed: Embed,
  name: String,
  value: String,
  inline: Bool,
) -> Embed {
  let new_field = #(name, value, inline)
  Embed(..embed, fields: list.append(embed.fields, [new_field]))
}

// Create a message with text content
pub fn message(content: String) -> Message {
  Message(content: [content], embeds: [])
}

// Create an empty message for building from scratch
pub fn empty() -> Message {
  Message(content: [], embeds: [])
}

// Add more text to the message
pub fn add_message(msg: Message, content: String) -> Message {
  Message(..msg, content: list.append(msg.content, [content]))
}

// Add embed to message
pub fn add_embed(msg: Message, embed: Embed) -> Message {
  Message(..msg, embeds: list.append(msg.embeds, [embed]))
}

// .new() function to declare a webhook 
pub fn new(url: String) -> Webhook {
  Webhook(url: url)
}

// Private helper to convert Embed type into raw JSON format
fn embed_to_json(embed: Embed) -> json.Json {
  let title_field = case embed.title {
    Some(t) -> [#("title", json.string(t))]
    None -> []
  }

  let description_field = case embed.description {
    Some(d) -> [#("description", json.string(d))]
    None -> []
  }

  let color_field = case embed.color {
    Some(c) -> [#("color", json.int(c))]
    None -> []
  }

  let fields_json = case embed.fields {
    [] -> []
    fields ->
      [
        #(
          "fields",
          json.array(
            fields,
            fn(field) {
              json.object([
                #("name", json.string(field.0)),
                #("value", json.string(field.1)),
                #("inline", json.bool(field.2)),
              ])
            },
          ),
        )
      ]
  }

  let all_fields =
    list.flatten([title_field, description_field, color_field, fields_json])

  json.object(all_fields)
}

// Private helper to convert Message type into raw JSON text format
fn convert_json(message: Message) -> String {
  let content_field = case message.content {
    [] -> []
    [single] -> [#("content", json.string(single))]
    multiple -> [#("content", json.string(string.join(multiple, "\n")))]
  }

  let embeds_field = case message.embeds {
    [] -> []
    embeds -> [#("embeds", json.array(embeds, embed_to_json))]
  }

  json.object(list.flatten([content_field, embeds_field]))
  |> json.to_string
}

// .send() function to send the webhook
pub fn send(webhook: Webhook, msg: Message) -> Result(Nil, String) {
  let json_payload = convert_json(msg)

  case request.to(webhook.url) {
    Error(_) -> Error("Failed to parse webhook URL.\nHint: Check the webhook url.")
    Ok(base_req) -> {
      let req =
        base_req
        |> request.set_method(http.Post)
        |> request.set_header("content-type", "application/json")
        |> request.set_body(json_payload)

      case httpc.send(req) {
        Ok(response) -> case response.status {
          204 -> Ok(Nil)
          _ ->
            Error(
              "Expected status 204, got " <> int.to_string(response.status),
            )
        }
        Error(_) -> Error("Failed to fire HTTP request entirely.")
      }
    }
  }
}
