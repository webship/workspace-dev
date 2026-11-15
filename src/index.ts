/**
 * The Dev workspace for Webship Workspace: the `dev/` folder as a plugin.
 *
 * What the package carries is placed by the installer from the manifest (the folder's settings file,
 * its commands, its docs and its AI items, each in the folder of its kind) and listed by --activate; the dashboard draws the workspace from the
 * settings file like any other. Nothing to register at run time yet: this is where the folder's own
 * rail buttons, row menus or assistant context would go.
 */

import type { PluginApi } from '@webship.co/workspace-plugin-api';

export const WORKSPACE_KEY = 'dev';

/** The AI items the installer places, each in the workspace folder of its kind (ai/ in this package). */
export const AGENTS = ['dev-site-builder'];
export const SKILLS = ['dev-workflow'];
export const AI_COMMANDS = ['dev-build'];
export const PROMPTS = ['dev-build-and-test'];

export function register(api: PluginApi): void {
  api.addAssistantContext(() => `The dev/ workspace is the Dev workspace (a plugin, @webship.co/workspace-dev); its commands are the cmd-*.sh scripts in that folder. It comes with AI items for work in this folder: the agent \`dev-site-builder\` (ai-agents/), the skill \`dev-workflow\` (ai-skills/), the command \`/dev-build\` (ai-commands/) and the prompt \`dev-build-and-test\` (ai-prompts/).`);
}
