# DSH adaptation

What this skill assumes, and what holds in the DeepSeek Harness instead. Read this before the
first rewrite in a DSH session; the upstream references stay valid for everything else.

## Tool and invocation mapping

| Upstream (Claude Code) | DSH | Note |
|---|---|---|
| `Read` | `read` | paths resolve against the workspace |
| `Glob`, `Grep` | `glob`, `grep` | same intent |
| `Bash` | `pwsh` | PowerShell, not bash; `.ps1` files need `-ExecutionPolicy Bypass` |
| `Task` | `subagent` | a parallel second opinion on a rewrite, or a second model reading the same draft |
| `AskUserQuestion` | `ask_user_question` | still 1–3 questions, only when the answer changes the rewrite |
| `/prompt-engineering` slash command | the `skill` tool with `prompt-engineering` | people may still type the slash form; treat it as the same request |
| `~/.claude/skills/prompt-engineering/` | `~/.agents/skills/prompt-engineering/` (junction) | content lives in `units/skills/prompt-engineering-skill/` |

## Target model

Upstream defaults to Claude 4.x. In DSH the default target is **the session route** — whatever
model the person is talking to. The differences that matter for a rewrite:

- **Instruction following is literal.** Say what should happen, give explicit scope ("apply to
  every section, not only the first"), and state the output contract. Vague adjectives do less
  work than a concrete example.
- **Reasoning routes.** If the session model is a reasoning variant, do not prescribe manual
  chain-of-thought. Give the objective, the constraints, the evidence, and the output contract;
  the internal reasoning handles the middle. "Think step by step" belongs to non-reasoning
  targets only.
- **No prefill.** There is no assistant-prefill lever here. Structure the output with an
  explicit contract: exact format, field list, "result only, no preamble".
- **XML tags still help.** They delimit data, examples and instructions; they cost nothing and
  survive the copy into another harness.
- **Act instead of ask.** The word "should" reads as a question. "Rewrite the prompt", "change
  the function" — imperative, subject first.
- **Never inflate.** DeepSeek routes are already verbose when unconstrained. A lean rewrite with
  good structure beats a decorated one; the anti-overengineering rule upstream applies twice.

If the person names Claude, GPT or Gemini as the target, ignore this section and use
`model-profiles.md` — those profiles are upstream and current.

## Crew usage

The planner and the other crew roles produce texts that other agents execute: role prompts,
task briefs, acceptance criteria, hand-off notes. Those are prompts, so this skill applies to
them.

- **What to hand in:** the text that the other role will read, plus one line on which role
  reads it and what it must produce.
- **What to change:** role line, objective, inputs, output contract, success criteria. Do not
  re-plan the work — the crew skills (`crew-project-planning`, `crew-project-blueprint`,
  `crew-project-research`) own the document structure and the order. This skill sharpens the
  wording inside that structure.
- **What not to do:** don't rewrite the crew skill itself, and don't add a second planning
  document. A role prompt that duplicates the PRD wastes the reader's context.
- **Verification:** after the rewrite, ask whether the target role could execute the prompt with
  no other context. If not, the prompt is missing context, not decoration.

## What has no equivalent here

- Slash commands, the plugin marketplace, `/add-plugin`, `.claude/` discovery paths
- Assistant-message prefill
- Model effort knobs (`xhigh`/`high`) named as such — DSH exposes its own route and effort
  settings, and the person sets them, not the prompt

Anything else in `references/` is harness-neutral: techniques, task patterns, worked examples,
quality checklist, evaluation, prompt security, auto-optimization, sources.
