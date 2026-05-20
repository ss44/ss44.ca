// ATS Friendly Single Column Resume
#let resume-data  = yaml("../data/resume.yml")
#let name         = resume-data.personal.name
#let primary-font = "Noto Serif" // Using a single clean font for maximum ATS compatibility

#set document(title: [#upper(name)])
#set text(font: primary-font, size: 10pt)
#set par(leading: 0.6em)

#show heading.where(level: 1): set text(size: 14pt, weight: "bold", tracking: 0.05em)
#show heading.where(level: 2): set text(size: 12pt, weight: "bold")

#set page(
  margin: (top: 0.5in, bottom: 0.5in, left: 0.5in, right: 0.5in),
  footer: context {
    set text(size: 8.5pt, style: "italic")
    let total = counter(page).final().first()
    if total > 1 {
      let current = counter(page).get().first()
      if current > 1 {
        grid(
          columns: (1fr, 1fr),
          align: (left, right),
          [#name],
          [Page #current of #total]
        )
      } else {
        align(right)[Page #current of #total]
      }
    }
  }
)

// Helper to replace markdown bold
#show regex("\*\*(.*?)\*\*"): it => strong(it.text.slice(2, -2))

// Header
#align(center)[
  #text(size: 20pt, weight: "bold")[#name]
  
  #v(-0.8em) // Negative vertical space to bring contacts closer without affecting the rest of the layout
  
  #let ats-contacts = ()
  #let phone-input = sys.inputs.at("phone", default: none)
  #if phone-input != none {
    ats-contacts.push("Phone: " + phone-input)
  }
  
  #for c in resume-data.personal.contact {
    if c.icon == "fa-map-marker-alt" {
      ats-contacts.push("Location: " + c.text)
    } else if c.icon == "fa-envelope" {
      ats-contacts.push("Email: " + c.text)
    } else if c.icon == "fa-globe" {
      ats-contacts.push("Website: " + c.text)
    }
  }
  
  #text(size: 10pt)[#ats-contacts.join("  |  ")]
]

#v(0.5em)
#line(length: 100%, stroke: 0.5pt)
#v(0.5em)

// Summary
#resume-data.summary

#v(1em)

// Skills
#block[
  = SKILLS
  #line(length: 100%, stroke: 0.5pt)
  #v(0.5em)
  #for skill in resume-data.skills [
    *#skill.category:* #skill.items.join(", ") \
  ]
]

#v(1em)

// Experience
#block[
  = EXPERIENCE
  #line(length: 100%, stroke: 0.5pt)
  #v(0.5em)
  
  #for exp in resume-data.experience {
    let date-str = ""
    if "start" in exp and exp.start != "" and "end" in exp and exp.end != "" {
      date-str = exp.start + " - " + exp.end
    } else if "start" in exp and exp.start != "" {
      date-str = exp.start
    } else if "end" in exp and exp.end != "" {
      date-str = exp.end
    }

    [
      *#exp.title* #h(1fr) #date-str \
      #emph[#exp.place] \
      #if "tech" in exp and exp.tech != none [
        _Stack: #exp.tech _ \
      ]
      
      #if "details" in exp and exp.details != none {
        for detail in exp.details {
          [- #detail]
        }
      }
      #v(0.5em)
    ]
  }
]

// Education
#block[
  = EDUCATION
  #line(length: 100%, stroke: 0.5pt)
  #v(0.5em)
  
  #for edu in resume-data.education {
    let date-str = ""
    if "start" in edu and edu.start != "" and "end" in edu and edu.end != "" {
      date-str = edu.start + " - " + edu.end
    } else if "start" in edu and edu.start != "" {
      date-str = edu.start
    } else if "end" in edu and edu.end != "" {
      date-str = edu.end
    }
    
    [
      *#edu.place* #h(1fr) #date-str \
      #edu.title \
      #if "details" in edu and edu.details != none [
        #edu.details
      ]
      #v(0.5em)
    ]
  }
]
