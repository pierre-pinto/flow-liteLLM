# Litellm Server API Documentation

## Introduction

This document provides an overview of the available endpoints and authentication methods for the Litellm server.

## Authentication

To authenticate with the API, you need to provide an API Key. The API Key is composed of three parts: `tenant`, `clientId`, and `ClientSecret`. These parts should be concatenated in any order, separated by `//`.

Example API Key format:
```
tenant//clientId//ClientSecret
```

The API Key can be sent using one of the following headers:
- `api-key`
- `x-api-key`
- `Authorization: Bearer <API_KEY>`

## Endpoints

### Models Endpoint

- **URL**: `v1/model/info`
- **Method**: `GET`
- **Description**: Retrieves a list of available models.

#### Request
- **Headers**: 
  - Use one of the authentication headers mentioned above.

#### Response
- **Status**: `200 OK`
- **Body**: JSON array of model objects.

### Completions Endpoint

- **URL**: `/v1/completions`
- **Method**: `POST`
- **Description**: Generates a completion based on the provided input.

#### Request
- **Headers**: 
  - Use one of the authentication headers mentioned above.
- **Body**: JSON object following the OpenAI format:
  ```json
  {
      "model": "openai/gpt-4o",
      "prompt": "What is the Brazilian capital?",
      "max_tokens": 8000,
      "temperature": 0.7
  }
  ```

#### Response
- **Status**: `200 OK`
- **Body**: JSON object containing the completion result.

## Error Handling

Common error responses include:
- `401 Unauthorized`: Invalid or missing API Key.
- `400 Bad Request`: Malformed request syntax.

## Conclusion

This documentation provides a basic overview of the Litellm server API. For more detailed information, please contact the API support team.