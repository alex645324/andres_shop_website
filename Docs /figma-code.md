

# Figma Frame → Code Instructions (for Claude Agent)

You are the Claude agent. Follow these rules when a user asks you to replicate a Figma frame into code.

---

## Mandatory Pre-Steps

Before doing anything else, always ask the user:

1. **“Please share the Figma link (or frame link) you’d like me to replicate.”**
2. **“Could you also attach a reference image or screenshot for visual accuracy?”**
3. **“Should this be optimized for mobile, desktop, or responsive/dynamic layouts?”**

Do not proceed until you have this information.

---

## Core Conversion Rules

* Replicate the **style and intent** of the Figma frame (visual hierarchy, mood, and component relationships).
* **Do not copy pixel-perfect positioning, spacing, or sizing.** These values are **flexible** and should be adapted so the layout works cleanly in code.
* You may **resize, reposition, and adjust spacing** as long as the overall style and structure remain faithful to the design intent.
* Output should be **clean, semantic, and production-ready** code.

---

## ⚖️ Guiding Rules (Implementation Discipline)

1. **Bare minimum only**

   * Strip the scope down until it breaks.
   * Add back only what’s strictly necessary for functionality.

2. **MVVM, simplest possible**

   * Follow the app’s existing MVVM pattern.
   * No extra layers or abstractions.
   * No third-party dependencies unless absolutely unavoidable.

3. **Confirm before coding each step**

   * Developer must **state the plan** (files, functions, exclusions, and test cases).
   * Wait for explicit **“Approved”** confirmation before proceeding.
   * Repeat this loop for every step.

---

## ✅ Confirmation Protocol

For **every change step**, the developer must post:

**“Step N — Plan to implement:”**

* **Files to add/edit**: exact paths (e.g., `lib/services/feedback_service.dart`)
* **Data structures / functions**: names + signatures (e.g., `Future<FeedbackModel> generateFeedback(...)`)
* **What will and will not be included**
* **Test cases**: list of validations they will run

⚠️ Do not write code until receiving explicit **“Approved”** reply.
Once approved, implement **only** what was confirmed.

---

## Best Practices to Reference

Always reference up-to-date best practices for **Figma → MCP → Claude Code → Implementation**:

1. **Figma MCP Dev Mode**

   * Use Figma components, auto-layout, and variables.
   * Use semantic naming (`PrimaryButton`, `CardContainer`).
   * Prefer design tokens over hard-coded values.
   * Break large frames into smaller, reusable parts.
   * Use MCP tools (`get_code`, `get_variable_defs`, `get_image`) when available.

2. **Implementation Rules**

   * Reuse existing design system components if available.
   * Follow accessibility standards.
   * Maintain project’s existing folder structure and naming conventions.
   * Optimize code for the requested target (mobile, desktop, responsive).
   * **Allow adjustments in spacing, sizing, and positioning to ensure layout integrity.**

3. **Claude Code Project Rules**

   * Always check for a `CLAUDE.md` or equivalent context file.
   * Obey project-specific conventions defined there.

---

## Example Flow

```text
User: Please replicate this frame for mobile.
Claude: Can you share the Figma link and a screenshot, and confirm if mobile optimization is correct?
User: Here’s the link + screenshot. Yes, mobile.
Claude: Step 1 — Plan to implement:
- Files to add/edit: lib/ui/screens/frame_view.dart
- Data structures/functions: StatelessWidget FrameView
- Will include: Header, Card section, Footer
- Will not include: Animations, state management
- Test cases: Check layout renders on iPhone 13 simulator, verify spacing (flexible, not pixel-perfect)
(Waiting for “Approved”)
User: Approved.
Claude: (Generates clean code.)
```

---