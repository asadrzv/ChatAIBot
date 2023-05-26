# Chat AI

This is a basic iOS SwiftUI MVVM Chat AI bot made using the [OpenAI HTTP API](https://platform.openai.com/docs/api-reference). The user enter a prompt and recieve either a predicted completion response (GPT-3) or a generated image (DALL-E).

## User Stories

The following functionality is completed:

- [x] User is greeted by a demo image/text indicating how to use each AI bot
- [x] User can switch tabs to access Chat AI (GPT-3), Image AI (DALL-E), and Settings
- [x] User can enter a prompt and Chat AI will predict a response
- [x] User can enter a prompt and Image AI will generate an image
- [x] User can copy messages to their clipboard
- [x] User can clear all chat messages
- [x] User receives haptic feedback for clearing/copying messages

## 3rd Party Libraries
* [OpenAI HTTP API](https://platform.openai.com/docs/api-reference)
* [OpenAISwift Wrapper Library](https://github.com/adamrushy/OpenAISwift)
* [AlertToast](https://github.com/elai950/AlertToast)
* [ActivityIndicatorView](https://github.com/exyte/ActivityIndicatorView)

## Video Walkthrough

Here's a walkthrough of implemented user stories:

<img src='demo.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' /><br>

## License

    Copyright 2023 Asad Rizvi

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
