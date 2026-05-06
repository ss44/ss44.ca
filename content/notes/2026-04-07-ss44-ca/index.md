+++
title = 'SS44.ca: Building a Resume as Code'
date = 2026-04-06T17:32:26-04:00
draft = false
tags = ["Hugo", "Typst", "CI/CD", "Web Development"]
categories = ["Portfolio", "Engineering"]
+++

**[ss44.ca](https://github.com/ss44/ss44.ca)** is my professional landing page and digital garden. It's a place to host my resume, document my homelab, and highlight some technical projects to advertise my skills.

{{< img src="screenshot.png" alt="ss44.ca home page in 2026" resize="800x450" class="center" >}}

## The Motivation
I don't even know if professional personal websites are still a primary requirement, or if they are a relic of a bygone era. However, I vividly remember career counselors emphasizing: _"at least be able to prove you can do some of what you say you can, by having a domain with some of what you say you do on it."_ 

It's been a while since I've been actively in the job market, and whatever site I had prior has long been lost to the abyss of time, stranded on some forgotten self-hosted Git server. So I thought I'd spin up a new one—because why not?

I won't pretend to have a plethora of massive open-source contributions I can proudly stick on this proverbial magnetic fridge. Since most of my professional work is hidden away behind proprietary code and NDAs, the least I could do is put my architecture skills on display while creating a foundation to post future technical notes.

At the very least, it proves I'm not just an agentic AI bot spamming resume sites. As the saying goes: I exist, because I have a domain name that says I do.

## Architecture & Tech Stack
So what do we have here? _"A WordPress site? With some fancy plugins?"_ **NOPE.**

*   **Core Data:** Markdown and YAML. I was big on plain text files before AI made them cool again, and I refuse to let them steal my shine.
*   **Static Site Generator (SSG):** [Hugo](https://gohugo.io/). While I've used Jekyll heavily in the past, Hugo's Go-based architecture offers significantly better build times and superior asset management (like Page Bundles).
*   **Document Generation:** [Typst](https://typst.app/). Where has this been hiding my whole career? Long gone are the days of hacking HTML-to-PDF converters or managing heavy Puppeteer dependencies just to render a document.
*   **Migration Engine:** Custom Python scripts to automatically ingest old legacy Jekyll posts, parse Frontmatter, dynamically resize images, and rewrite paths to fit the modern Hugo ecosystem.

## Development Process & Challenges
The real engineering sauce here isn't just that it's a static site generator. The true value is treating my **Resume as Code**.

Both the `resume.html` page and the `resume.pdf` download are generated dynamically from the exact same underlying `resume.yml` data file. 

When explained like that, it might sound simple, but having my resume exist purely as structured text data within a Git repo—which automatically generates an updated, perfectly styled PDF via a CI/CD pipeline on every deploy—is a massive upgrade. It completely beats my old Google Docs workflow.

## What's Next
*   **Consistency:** Try to publish technical posts here semi-regularly to justify keeping the domain around.
*   **Expansion:** It was a fun distraction building this, and I leaned on AI tools to help write the migration scripts and clean up the CSS. I plan to document those AI integration workflows in future posts.

_Note: The home page slide layout and aesthetics were heavily inspired by [mnjul.net](https://mnjul.net/)._

[View the source code on GitHub &rarr;](https://github.com/ss44/ss44.ca)