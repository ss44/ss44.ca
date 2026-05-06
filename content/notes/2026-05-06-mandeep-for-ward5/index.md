---
title: "Vibe Coding a Political Campaign: Mandeep For Ward 5"
date: 2026-05-06
draft: true
tags: ["AI", "Web Development", "Hugo", "CI/CD", "Automation"]
categories: ["Portfolio", "Engineering", "Architecture"]
---

**[Mandeep For Ward 5](https://mandeepforward5.com)** is a lightning-fast, single-page political campaign website built to demonstrate the rapid deployment capabilities of AI-assisted "vibe coding."

{{< img src="placeholder.png" alt="Mandeep Forward 5 Website Screenshot" resize="800x450" class="center" >}}

### The Motivation

When a friend needed a political campaign website spun up rapidly for their run in Ward 5, the standard approach would have been reaching for a heavy CMS or a bloated site builder. But a political campaign needs speed, reliability, and absolute simplicity. The real objective was to treat this as an architectural experiment: could I use pure "vibe coding" to generate the entire front-end aesthetics while I focused strictly on the deployment architecture, CI/CD pipeline, and best practices? 

The answer was a resounding yes. It proved my ability to leverage AI not just as a glorified autocomplete, but as a rapid prototyping engine that gets out of the way of the actual engineering.

### Architecture & Tech Stack

This wasn't just about throwing HTML at a server; it was about building a robust, zero-maintenance pipeline.

*   **Google AI Studio:** Used for the initial "vibe coding." By carefully prompting the AI with the exact mood, aesthetic, and structural requirements of a political landing page, I generated a clean, responsive single-page template.
*   **Tailwind CSS:** Employed for styling, loaded via CDN to prioritize extreme development speed and rapid prototyping without the overhead of a complex build step.
*   **Hugo:** The static site generator of choice. It compiles in milliseconds, has zero runtime dependencies, and its Page Bundle architecture keeps the repository incredibly clean.
*   **Netlify:** For the CI/CD pipeline and global edge hosting. Every git commit automatically triggers a strict build process and atomic deployment.

### Development Process & Challenges

The core challenge was marrying the AI-generated "vibe" with strict architectural standards. Vibe coding is powerful, but AI output can often lack structural discipline. 

I used Google AI Studio to lay down the initial styling and responsive grid based on the campaign's theme. Once the raw HTML/CSS was generated, I stripped it down and integrated it into Hugo's templating engine. This allowed me to abstract the data layers away from the layout. Instead of hardcoding text, I mapped the campaign promises, bios, and event details into YAML/Markdown data files. 

By offloading the visual boilerplate to AI, I was able to spend my engineering cycles on critical infrastructure and best practices. This included setting up the Netlify CI/CD pipeline, securing high Lighthouse scores specifically for SEO and Best Practices, and deeply integrating social sharing. For a political campaign, shareability is paramount, so I implemented full Open Graph (OG) meta tags and Twitter Cards into the Hugo layout. This guaranteed that every link shared on social media populated perfectly with the campaign's high-res imagery and messaging. 

It’s a perfect example of how senior engineers should use AI: abstract the tedious frontend tasks to focus on system design, robust infrastructure, and essential technical optimizations.

### What's Next

This project serves as a foundational template for future rapid-deployment sites. The abstraction between the AI-generated UI and the Hugo data layer means I can now spin up similar high-performance, vibe-coded websites in minutes, complete with enterprise-grade CI/CD out of the box.

### Screenshots

{{< gallery >}}
{{< img src="mobile.png" alt="Mobile View" resize="600x600" >}}
{{< img src="mobile2.png" alt="Mobile View" resize="600x600" >}}
{{< img src="seo.png" alt="SEO Scores" resize="600x600" >}}

{{< /gallery >}}
