// patroclus.typ: A Typst template
// ===================================
// Converted from the LaTeX package by Luke Hannan.
//
// "Achilles Come Down"
//

#let patroclus(
  title: none,
  subtitle: none,
  short-title: none,
  authors: (),
  date: datetime.today(),
  contents: true,
  listoftables: false,
  listoffigures: false,
  doc,
) = {
  let footer-title = if short-title != none { short-title } else { title }
  let footer-name = if authors.len() > 1 {
    authors.at(0).at("name").split().last() + " et al"
  } else {
    authors.at(0).at("name").split().last()
  }

  // 1. PAGE SETUP
  set page(
    paper: "a4",
    margin: (left: 1.33in, right: 1.33in, top: 1.33in, bottom: 1.33in),
  )

  // 2. FONT AND TEXT SETUP
  let alizarin = rgb("#A51C30")
  let pastel-red = rgb("#FF746C")

  set text(
    font: ("EB Garamond", "New Computer Modern"),
    lang: "en",
    region: "gb",
    size: 11pt,
  )

  set par(
    justify: true,
    leading: 1em, // This provides line spacing similar to \linespread{1.33}
    first-line-indent: 24pt,
  )

  // 3. HEADING STYLES
  set heading(numbering: "1.1")

  // Chapter heading (level 1)
  show heading.where(level: 1): it => {
    set text(font: ("Cinzel", "New Computer Modern"))
    // Add a page break before each new chapter.
    pagebreak(weak: true)
    align(right)[
      #text(fill: alizarin, size: 1.5em, it)
    ]
    // Space after the chapter title (corresponds to \afterchapskip)
    v(20pt)
  }

  // Section heading (level 2)
  show heading.where(level: 2): it => {
    set text(fill: pastel-red, weight: "bold", size: 1.25em)

    smallcaps(it)
    v(10pt)
  }

  show heading.where(level: 3): set text(weight: "bold")

  // 4. ELEMENT STYLING
  show figure.caption: set text(weight: "bold")

  show outline.entry: it => {
    // Only bold chapter headings in TOC not figure and table titles
    if it.level == 1 and it.element.func() == heading {
      set text(weight: "bold")
      v(0.5em)
      link(
        it.element.location(),
        it.indented(it.prefix(), [#it.body() #h(1fr) #it.page()]),
      )
      v(0.5em)
    // Dont show "Figure" and "Table" in list of figures and tables
    } else if it.element.func() != heading {
      link(
        it.element.location(),
        it.indented([], it.inner()),
      )
    } else {
      it
    }
  }


  // 5. DOCUMENT STRUCTURE
  // Title Page
  align(center)[
    #v(20%)
    #text(size: 2em, weight: "bold", fill: alizarin, smallcaps(title))
    #v(1.5em)
    #text(size: 1.5em, weight: "bold", fill: alizarin, smallcaps(subtitle))
    #v(1.5em)
    #date.display("[day] [month repr:long] [year]")
    #v(1em)
    #text(size: 1.2em, weight: "bold", authors.at(0).at("name"))
    #linebreak()
    #text(size: 1.2em, authors.at(0).at("affiliation"))
    #v(40%)
  ]
  pagebreak()

  counter(page).update(1)
  set page(
    footer: context [
      #align(center)[#counter(page).display("i", both: false)]
    ],
  )

  if contents {
    outline(
      title: "Contents",
      depth: 2, // Corresponds to \settocdepth{subsection}
    )
    pagebreak()
  }

  if listoftables {
    outline(
      title: [List of Tables],
      target: figure.where(kind: table),
    )
    pagebreak()
  }

  if listoffigures {
    outline(
      title: [List of Figures],
      target: figure.where(kind: image),
    )
    pagebreak()
  }

  counter(page).update(1)
  set page(
    footer: context [
      #line(length: 100%, stroke: 0.5pt)
      // Two-column layout for footer content
      #grid(
        columns: (1fr, 1fr),
        // Left side: Author and short title

        [#footer-name: #footer-title],
        // Right side: Page X of Y
        align(right)[#counter(page).display("1 of 1", both: true)],
      )
    ],
  )

  doc
}

// Helper function to create an environment with no indentation.
#let no-indents(body) = {
  set par(first-line-indent: 0pt)
  body
}
