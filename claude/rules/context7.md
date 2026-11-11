Use Context7 to fetch current documentation whenever the user asks about a library, framework, SDK, API, CLI tool, or cloud service — even well-known ones like React, Next.js, Prisma, Express, Tailwind, Django, or Spring Boot. This includes API syntax, configuration, version migration, porting code between libraries, platforms, or SQL dialects, library-specific debugging, setup instructions, and CLI tool usage. Use even when you think you know the answer — your training data may not reflect recent changes. Prefer this over web search for library docs.

Do not use for: refactoring, debugging, or reviewing code that does not depend on a library or platform API, or general programming concepts.

## How

Use the `context7` skill (its `scripts/context7.sh`, which calls the Context7 REST API and needs no sign-in). Use the Context7 MCP tools only if they are connected in the session; never stop to ask for MCP sign-in.

## Steps

1. Search for the library ID (`context7.sh search <name>`), unless the user gives an exact `/org/project` ID
2. Pick the best match by exact name, description relevance, snippet count and score. If results look wrong, try alternate names (e.g. "next.js" not "nextjs"). Use version-specific IDs when the user names a version
3. Fetch docs (`context7.sh docs <id> <topic>`) scoped to one concept per call; split questions that span several distinct concepts, unless the question is about how they interact
4. Answer using the fetched docs
