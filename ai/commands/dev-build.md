---
description: Build a site in the dev/ folder of the Webship Workspace with one of the folder's builders, say what it is, and offer the Webship-js testing stack for it.
argument-hint: '<builder or family> <name> [flags of the builder]'
---

# /dev-build

Build a site in `~/workspace/dev` from: `$ARGUMENTS`

The arguments are the text typed after the command: the first word names the builder, the second
the site, and what follows is passed to the builder as it is. With no site name, stop and ask for one. The workspace is container-based (DDEV by default):
the builder runs the site in its own container, and nothing is run on the host for it.

## 1. Find the builder

```bash
cd ~/workspace/dev
ls cmd-*-project.sh
grep -H "^# workspace-name:" cmd-*-project.sh
```

The first word is a builder's file name, or enough of it to pick one: `drupal11` is
`cmd-drupal11-recommended-project.sh`, `drupalcms` is `cmd-drupalcms2-x-project.sh`, `webship` is
`cmd-webship11-0-x-project.sh`. When it fits more than one builder, list them with their
`workspace-name` and ask. If the folder has no `cmd-*-project.sh`, the Dev plugin is not installed:
say so and stop.

## 2. Read its flags

```bash
bash cmd-drupal11-recommended-project.sh --help
```

Use the builder that was picked. A flag that is not in its help is not passed on: say which one.

## 3. Make sure the name is free

```bash
ls -d ~/workspace/*/<name> 2>/dev/null
ddev list | grep -w <name>
```

A builder deletes a project of the same name first. If the name is taken, stop and ask.

## 4. Build

```bash
bash cmd-drupal11-recommended-project.sh <name> --install --add-users
```

With the builder that was picked and the flags that were typed; when no flag was typed, use
`--install --add-users` where the builder has them. Run it once. If it fails, show the line that
failed and stop.

## 5. Report

The builder, the address (`https://<name>.ddev.site`), whether the site is installed, and the
commands that go on from here:

```bash
bash cmd-tools-testing.sh <name>            # the Webship-js testing stack
bash cmd-tools-testing.sh <name> --run      # its suite
bash cmd-tools-remove.sh <name>             # when the site is no longer needed
```

Ask whether to set the testing stack up now. For more than one build, hand over to the
`dev-site-builder` agent; the `dev-workflow` skill lists every command of the folder.
