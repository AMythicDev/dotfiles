import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

// Set the mode before other extensions (like pi-fff) load, 
// if this extension is loaded early enough.
process.env.PI_FFF_MODE = "override";

export default function defaultToolsExtension(pi: ExtensionAPI) {
	pi.on("session_start", (event, ctx) => {
		const allTools = pi.getAllTools().map((t) => t.name);
		pi.setActiveTools(allTools);
	});
}
