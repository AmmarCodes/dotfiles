---
name: react-ts-init
description: Initialize greenfield React + TypeScript projects with strict linting, formatting, and Tailwind CSS. ALWAYS use this skill whenever a user is creating, setting up, or initializing a new React + TypeScript project. Trigger automatically for phrases like "new project", "new React app", "initialize React", "setup React", "create React", "scaffold", "greenfield", or any context where a fresh TypeScript + React codebase is being created. This includes when users run npm create vite, npx create-react-app, or any other project scaffolding tool. The skill sets up strict ESLint, Prettier, TypeScript, and Tailwind CSS configurations.
---

# React + TypeScript Project Initialization

Initialize a greenfield React + TypeScript project with strict linting, formatting, TypeScript, and Tailwind CSS.

## When to use this skill

- Creating a new React + TypeScript project
- Setting up linting/formatting for a fresh React app
- User mentions "greenfield", "new project", "initialize", "scaffold"
- User wants strict TypeScript + ESLint + Prettier + Tailwind setup

## Prerequisites

Assumes a React + TypeScript project exists (e.g., created via `npm create vite@latest` with React + TypeScript template). If not, create one first:

```bash
npm create vite@latest . -- --template react-ts
npm install
```

## Config Templates

This skill includes pre-configured templates in the `configs/` directory:

- `configs/eslint.config.js` - ESLint flat config with TypeScript, React, and Prettier
- `configs/prettier.config.js` - Prettier with import organization and Tailwind CSS class sorting
- `configs/tsconfig.json` - Strict TypeScript configuration

Copy these to your project and customize as needed.

## Steps

### 1. Install dependencies

```bash
npm install -D \
  eslint \
  @eslint/js \
  typescript-eslint \
  eslint-plugin-react \
  eslint-plugin-react-hooks \
  eslint-config-prettier \
  prettier \
  prettier-plugin-tailwindcss \
  prettier-plugin-organize-imports \
  tailwindcss \
  @tailwindcss/vite
```

### 2. Copy ESLint configuration

Copy `configs/eslint.config.js` to your project root, or create it with the contents from the skill's configs directory.

### 3. Copy Prettier configuration

Copy `configs/prettier.config.js` to your project root, or create it with the contents from the skill's configs directory.

### 4. Copy TypeScript configuration

Copy `configs/tsconfig.json` to your project root, or merge its strict settings with your existing tsconfig.json.

### 5. Configure Tailwind CSS in Vite

Add the Tailwind Vite plugin to `vite.config.ts`:

```typescript
import tailwindcss from "@tailwindcss/vite";
import react from "@vitejs/plugin-react";
import { defineConfig } from "vite";

export default defineConfig({
  plugins: [tailwindcss(), react()],
});
```

### 6. Set up the CSS entry point

Add `@import "tailwindcss"` to the top of your main CSS file (e.g., `src/index.css` or `src/App.css`):

```css
@import "tailwindcss";
```

This enables Tailwind utility classes alongside any existing custom CSS.

### 7. Add lint/format scripts to package.json

Add these scripts if not present:

```json
{
  "scripts": {
    "lint": "eslint .",
    "lint:fix": "eslint . --fix",
    "format": "prettier --write .",
    "format:check": "prettier --check ."
  }
}
```

### 8. Run initial lint fix and format

Fix any ESLint issues in the template code and format:

```bash
npm run lint:fix
npm run format
```

**Note:** Vite's default template may have a non-null assertion (`!`) that ESLint flags. Add this comment above that line to suppress the error:

```typescript
// eslint-disable-next-line @typescript-eslint/no-non-null-assertion
createRoot(document.getElementById('root')!).render(...)
```

Or handle the null case properly:

```typescript
const rootElement = document.getElementById('root');
if (!rootElement) throw new Error('Root element not found');
createRoot(rootElement).render(...)
```

## Verification

After setup, verify everything works:

```bash
npm run lint
npm run format:check
npm run build
```

All should pass without errors on a fresh project scaffolding.

## Notes

- This setup assumes Vite as the build tool
- Uses Tailwind CSS v4 with the Vite plugin (no separate `tailwind.config.js` needed)
- Uses the new ESLint flat config format
- TypeScript strict mode with additional safety checks enabled
- Prettier plugins handle import ordering and Tailwind class sorting
- Config templates are maintained in the skill's `configs/` directory for easy updates
