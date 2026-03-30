#import "@preview/fontawesome:0.6.0": *

// ─── Configuration ────────────────────────────────────────────────────────────
// Edit these values to customize the look and feel of your resume.
// You should not need to modify anything outside this block for basic use.

#let resume-data  = yaml("../data/resume.yml")
#let name         = resume-data.personal.name  // Your full name, displayed in the header
#let accent       = rgb("#002366")       // Accent color used for headings, lines, and icons
#let sidebar-fill = rgb("#eef0f5")       // Background color of the left sidebar
#let sans-font    = "Noto Sans"          // Font used for section headings
#let serif-font   = "Noto Serif"         // Font used for your name in the header
#let col-ratio    = (3fr, 7fr)           // Ratio of sidebar width to main content width
// ──────────────────────────────────────────────────────────────────────────────

#set document(title: [#upper(name)])
#set text(size: 10pt)
#set par(leading: 0.9em)
#show heading.where(level: 1): set text(font: sans-font, tracking: 0.1em, weight: 500, fill: accent)
#show heading.where(level: 2): set text(size: 12pt)

#set page(
  margin: (
    top: 1cm,
    left: 1cm,
    right: 1cm,
    bottom: 1.5cm,
  ),
  footer: context {
    if counter(page).final().first() > 1 {
      align(center)[#counter(page).display("1 / 1", both: true)]
    }
  }
)

// ─── Helper functions ─────────────────────────────────────────────────────────

// Renders your name in the header
#let resume-title() = text(
  font: serif-font,
  tracking: 0.1em,
  weight: 500,
  size: 28pt,
  fill: accent,
)[#upper(name)]

// Renders a work experience entry.
// Usage:
//   #experience(
//     "Company Name",
//     "Job Title",
//     "City, State",
//     "Start – End",
//     (
//       "Bullet point one.",
//       "Bullet point two.",
//     ),
//   )
#let experience(
  company,
  role,
  location,
  dates,
  bullets,
) = [
  #block(breakable: false)[
    == #text(fill: accent)[#company]

    #grid(
      columns: (1fr, 1fr),
      align: (left, right),
      [ #emph[#role] ], [ #emph[#if location != "" [#location | ]#dates] ],
    )

    #if bullets != none and bullets.len() > 0 {
      [- #bullets.at(0)]
    }
  ]

  #if bullets != none and bullets.len() > 1 {
    for bullet in bullets.slice(1) {
      [- #bullet]
    }
  }
  #v(1em)
]

// Renders an education entry.
// Usage:
//   #education(
//     "University Name",
//     "City, State",
//     "Start – End",
//     ("Degree One", "Degree Two"),
//   )
#let education(
  institution,
  location,
  dates,
  degrees,
  details: none,
) = [
  == #institution

  #if location != "" [#location | ]#dates \
  #for degree in degrees {
    [ #text(weight: "bold")[#degree] \ ]
  }
  #if details != none {
    [ #details \ ]
  }
  #v(1em)
]

// Renders a skill category in the sidebar.
// Pass items as an array of strings — they will be joined with " | ".
// Usage:
//   #skill-category("Languages", ("Python", "Rust", "TypeScript"))
#let skill-category(category, items) = [
  == #category

  #items.join(" | ")
]

// ─── Header ───────────────────────────────────────────────────────────────────

#align(center)[
  #resume-title()
  #set text(size: 10pt)
  // Update the four links below with your own URLs and display text.
  // Icons are provided by Font Awesome — replace icon names as needed.
  // See: https://fontawesome.com/icons
  #grid(
    columns: resume-data.personal.contact.len(),
    column-gutter: 2em,
    align: center,
    ..resume-data.personal.contact.map(c => [
      #text(fill: accent)[#fa-icon(c.icon.replace("fa-", ""))] #if c.text.contains("@") { link("mailto:" + c.text)[#c.text] } else { link(c.text)[#c.text] }
    ])
  )
]

#line(length: 100%, stroke: accent)

// Optional: Replace with a 2-3 sentence professional summary.
// Delete this paragraph entirely if you prefer no summary.
#resume-data.summary

#line(length: 100%, stroke: accent)

// ─── Body ─────────────────────────────────────────────────────────────────────

#grid(
  columns: col-ratio,
  rows: auto,
  fill: (sidebar-fill, none),
  inset: 5pt,
  column-gutter: 0.5cm,
  [
    // ── Sidebar ──────────────────────────────────────────────────────────────

    = #upper("Education")

    // Add or remove #education(...) blocks as needed.
    #for edu in resume-data.education {
      education(
        edu.place,
        "",
        edu.start + " – " + edu.end,
        (edu.title,)      )
    }

    #line(stroke: (dash: "dashed", paint: accent), length: 90%)

    = #upper("Skills")

    // Add or remove #skill-category(...) blocks as needed.
    // Each block takes a category name and an array of items.
    #for skill in resume-data.skills {
      skill-category(skill.category, skill.items)
    }

  ],
  [
    // ── Main content ─────────────────────────────────────────────────────────

    = #upper("Work Experience")

    // Add or remove #experience(...) blocks as needed.
    #for exp in resume-data.experience {
      experience(
        exp.place,
        exp.title,
        "",
        exp.start + " – " + exp.end,
        exp.details,
      )
    }

  ],
)

#line(length: 100%, stroke: accent)
