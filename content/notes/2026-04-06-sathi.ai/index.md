+++
date = '2026-04-06T15:34:34-04:00'
draft = false
title = 'Sathi.ai: A Multi-Provider AI Desktop Client'
tags = ["AI", "System Design"]
categories = ["Engineering", "Portfolio"]
+++

**[Sathi.ai](https://github.com/ss44/Sathi.Ai)** is a Generative AI client plugin I built for [Dank Material Shell (DMS)](https://github.com/AvengeMedia/DankMaterialShell). It allows users to interact with multiple Large Language Models (LLMs) directly from their Linux desktop shell, bypassing the need to constantly context-switch into a browser.

{{< img src="image.png" alt="Sathi AI Interface" class="center" resize="1280x800">}}

## The Motivation
Over the last few months, I grew increasingly frustrated with Windows 11 and decided to transition my primary workstations to Arch Linux. During this shift, I discovered [Niri](https://github.com/niri-wm/niri) (a scrollable-tiling Wayland compositor) and fell in love with Dank Material Shell—a clean, slightly opinionated, and highly customizable desktop environment.

While the ecosystem was fantastic, I noticed a gap: I needed a fast, lightweight Linux AI client. I wanted something I could ping with a quick query instantly, rather than relying on heavy web wrappers. DMS's plugin system provided the perfect foundation, so I decided to build it myself.

## Architecture & Tech Stack
The core application is built using **QML**. The most significant architectural challenge was designing a unified interface that could seamlessly communicate with completely different AI backends. 

Currently, Sathi.ai supports:
*   **Cloud Providers:** Google Gemini, OpenAI, and Anthropic.
*   **Local Models:** [Ollama](https://ollama.com/) and [LMStudio](https://lmstudio.ai/).

By abstracting the API layers, users can select their preferred model from a single dropdown, set custom System Prompts to control context, and receive responses formatted in full Markdown.

## "Vibe Coding" and AI-Assisted Development
Building Sathi.ai was my first real foray into what the community calls "vibe coding." 

As someone who still gets a dopamine hit from coding and watching things come to life, I took pride in architecting the core engine, designing the state management, and resolving the complex logic by hand. Also just making the initial UI work how I wanted. However, once the primary shell and the initial Gemini integration were working, I leveraged AI as a force multiplier. I used LLMs to rapidly scaffold the repetitive API client boilerplates for OpenAI and Anthropic based on my initial design patterns. 

It worked out great: I did the heavy lifting and systems architecture, and the AI handled the tedious, monotonous tasks.

## What's Next
The widget was originally conceived as the only AI widget for DMS, and I am still really happy with the daily utility it provides. A recent DMS update introduced some breaking changes that I am currently working on resolving. Once stabilized, my next target is implementing multi-modal support to handle image generation directly from the desktop - and re-jig the settings screen.

[View the source code on GitHub &rarr;](https://github.com/ss44/Sathi.Ai)
