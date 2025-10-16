# patroclus

> Achilles Come Down

Personal document themes for LaTeX, Quarto, and Typst with consistent typography.

## Usage

**LaTeX**
```latex
% If using memoir class
\documentclass{memoir}
\usepackage[memoir]{patroclus}
% If using default class
\usepackage{patroclus}
```

**Quarto Document**
```yaml
format:
  pdf:
    include-in-header:
      - patroclus.sty
```

**Quarto Slides**
```yaml
format:
  revealjs:
    theme: [default, patroclus.scss]
```

**Typst**
```typst
#import "patroclus.typ": patroclus
#show: patroclus.with(title: "Title", authors: (...))
```

## Design Tokens

Colours and fonts defined in `patroclus.yaml`.
