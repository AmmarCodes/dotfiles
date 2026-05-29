---
name: firecrawl-deep-research
description: Run multi-source deep research with Firecrawl. Use when the user asks to research a topic, compare perspectives, produce a sourced briefing, investigate a technical or market question, or synthesize web evidence across many sources.
license: ISC
metadata:
  author: firecrawl
  version: "0.1.0"
  homepage: https://www.firecrawl.dev
  source: https://github.com/firecrawl/firecrawl-workflows
inputs:
  - name: FIRECRAWL_API_KEY
    description: Firecrawl API key for hosted Firecrawl requests.
    required: true
---

# Firecrawl Deep Research

Use this when the user wants a sourced research report, not raw search results.

## Onboarding Interview

Infer the topic, depth, and output format from context. If the topic is clear, proceed immediately.

Ask at most 1-3 concise questions only if blocked, such as the research topic, required depth, or a critical angle/source constraint.

## Firecrawl Collection Plan

Use Firecrawl search and scrape through the CLI or equivalent tool surface.

- Quick: search 3-5 queries and scrape 5-10 high-quality sources.
- Thorough: search 5-10 queries from different angles and scrape 15-25 sources.
- Exhaustive: search 10+ queries and scrape 25+ sources, including primary sources, research papers, expert views, and contrarian sources.

Avoid re-scraping URLs already returned with full content from a search-with-scrape result.

## Parallel Work

If appropriate, use sub-agents or equivalent parallel task runners by research angle:

- overview and definitions
- technical or implementation details
- market and industry context
- contrarian views, risks, and limitations
- primary sources and official docs

Each researcher should return claims, source URLs, source quality notes, and uncertainty.

## Final Deliverable

Default structure:

```markdown
# Deep Research: [Topic]

## Executive Summary
[2-3 paragraphs]

## Key Findings
[Numbered findings with source links]

## Detailed Analysis
[Themes, evidence, and synthesis]

## Contrarian Views And Risks
[Counterarguments, limitations, failure modes]

## Open Questions
[What remains uncertain]

## Sources
[Every URL used with a one-line note]

## Rerun Inputs
workflow: firecrawl-deep-research
topic: [topic]
depth: [quick/thorough/exhaustive]
output: [markdown/json/brief]
```

## Quality Bar

- Cite sources for factual claims.
- Prefer primary sources when available.
- Flag uncertainty and conflicting evidence.
- Synthesize instead of listing scrape summaries.
