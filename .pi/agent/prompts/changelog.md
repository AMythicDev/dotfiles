---
description: Update CHANGELOG.md from the latest git tag
argument-hint: "<version> [date]"
---

# Changelog

You are updating the `CHANGELOG.md` for the active project.

## Task
1. Find the latest git tag in the current repository using `git describe --tags --abbrev=0`.
2. Collect the git log of all changes since that tag.
3. Get the {DATE} using the command `date -d "$2" +"%Y-%m-%d"`. If `$2` is empty, use `today` in its place.
3. Summarize those changes into a new `CHANGELOG.md` entry for version `$1` dated {DATE}.
4. Add the entry to `CHANGELOG.md` for the active project.

## Notes
- Use the existing changelog format if one already exists.
- If `CHANGELOG.md` does not exist, create it.
- Keep the entry concise, accurate, and grouped by meaningful change themes.
- Do not include unrelated commits or changes before the last tag
