# AI Agent Context & Instructions (AGENTS.md)

Welcome. If you are an AI assistant reading this, you are working on the personal portfolio, digital garden, and resume repository for Shajinder Singh Padda (Senior Systems Architect and Full Stack Developer). 

This document serves as the ground truth for the site's architecture, workflows, and the author's writing style. Always adhere to these guidelines when generating content, editing files, or altering the site's structure.

---

## 1. Project Overview & Architecture

### Purpose
This site is a professional landing page that hosts a dynamically generated resume, documents homelab infrastructure, and highlights technical projects. It is designed to prove architectural competence to recruiters and engineering managers while maintaining a distinct, hacker/terminal aesthetic.

### Tech Stack
*   **Static Site Generator:** Hugo (chosen for speed, Go-based architecture, and Page Bundle support).
*   **Theme:** `hugo-theme-nightfall` (terminal-inspired, heavily customized).
*   **Document Generation:** Typst. Used to generate the `resume.pdf` download directly from the data.
*   **Data Structure:** Markdown for content, YAML for configurations and data (specifically the resume).
*   **Hosting & CI/CD:** Netlify. The site builds and deploys automatically on commit.

### "Resume as Code"
A core architectural feature of this site is that the resume is treated as code. Both the HTML resume view and the downloadable PDF are generated from the exact same underlying YAML file using a CI/CD pipeline. 
The source of truth for all resume data is `data/resume.yml`.

### Resume Rules & Guidelines
Any modifications, evaluations, or improvements to the resume should strictly follow the rules outlined in `.ai/rules.md`. When interacting with the resume, always measure and update `data/resume.yml` against these guidelines.

---

## 2. Writing Guidelines: Tone & Vocabulary

When drafting or editing `notes`, maintain the author's distinct voice.

### The Persona
*   **Senior & Experienced:** The author has 20+ years of experience. Do not write like a junior developer discovering a tool for the first time. Write like an architect making pragmatic choices.
*   **Conversational yet Technical:** blend a relatable, slightly witty backstory with hard engineering facts. (e.g., Joking about "magnetic fridges" or "agentic AI bots", then transitioning into CI/CD pipelines and API abstraction).
*   **Direct & Pragmatic:** Focus on *why* a technology was chosen and the *problems* it solved, not just *what* it is. 

### Vocabulary to Use
*   *Architecture, system design, CI/CD, state management, abstraction, automation, payloads, native, pipelines.*
*   Use terms like "Resume as Code" or "Vibe Coding" where appropriate, but immediately back them up with actual engineering work so they don't sound hollow.

### What to Avoid
*   **Excessive Jargon:** Don't use buzzwords if a simpler explanation works.
*   **Robotic Summaries:** Avoid dry, Wikipedia-style descriptions of tools. 
*   **Pretentiousness:** Stay humble but confident. 

---

## 3. Rules for Creating Notes

### Structure (Page Bundles)
Hugo is configured to use **Page Bundles**. 
*   **NEVER** create a standalone `.md` file in `content/notes/`. 
*   **ALWAYS** create a directory for the post and an `index.md` inside it: `content/notes/YYYY-MM-DD-slug/index.md`.
*   Place all images and assets for that post directly alongside the `index.md` in that specific folder.

### Archetype Format
All new notes should follow the established archetype format (`archetypes/notes.md`):
1.  **The Hook:** A bolded link to the project and a 1-sentence summary of what it does.
2.  **Screenshot:** Use the custom image shortcode.
3.  **The Motivation:** The backstory, the missing gap, or the problem being solved.
4.  **Architecture & Tech Stack:** The bulleted list of technologies and *why* they were used.
5.  **Development Process & Challenges:** The hard engineering parts, how AI was leveraged, or clever workarounds.
6.  **What's Next:** Future plans.

### Image Handling
Do **not** use standard Markdown image tags like `![alt](url)`. 
Always use the custom Hugo shortcode to ensure proportional resizing and proper Page Bundle path resolution:
```go
{{< img src="filename.png" alt="Description" resize="800x800>" class="center" >}}
```

### Frontmatter
Ensure the frontmatter is complete before setting `draft = false`.
Required fields: `title`, `date`, `draft`, `tags` (array), and `categories` (array).

### Standard Categories & Tags
To maintain consistency, try to use the following standard categories and tags where appropriate:
*   **Categories:** `Engineering`, `Architecture`, `Portfolio`, `Homelab`, `Career`, `Opinion`
*   **Tags:** `CI/CD`, `Web Development`, `Hugo`, `Typst`, `AI`, `System Design`, `Automation`, `Mindset`

---

## 4. CSS and Theming
*   Do not edit the core theme files in `themes/hugo-theme-nightfall/` unless absolutely necessary.
*   All custom style overrides should be placed in `static/css/custom.css`. 
*   Menu layouts and icons are managed in `hugo.toml`. (Note: The site uses FontAwesome 6.5 loaded via CDN in `layouts/_partials/custom-head.html`).

---

## 5. Idea Backlog & Tasks
Future ideas, feature requests, and design tweaks (such as adding a 5-point TL;DR strictly to the HTML resume view) are stored in `ideas.md` at the project root. Always check or append to this file when brainstorming future iterations.