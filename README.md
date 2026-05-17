# IONA AI — The Sovereign Operating System's Native Intelligence

**IONA AI is not a chatbot.** It is a fully autonomous, multi-device, self-healing
agent system that lives inside the IONA operating system. It sees what happens
on your PC and phone, thinks with a local LLM, plans complex tasks, and acts
using real OS tools—all while keeping your data on-device and under your control.

> ⚠️ **Note:** This repository contains the public API, architecture documentation,
> and tool specifications for IONA AI. The full implementation—including the
> reasoning engine, security monitor, and self-healing kernel integration—is
> part of the IONA OS core and is available for review under NDA or via a
> live demo. This approach protects the security model of the sovereign OS
> while still allowing the community to understand and evaluate the AI's design.

---

## Why IONA AI

| Differentiator | What it means |
| :--- | :--- |
| **Truly on-device** | Runs a quantized 7B LLM locally on your GPU/NPU. No cloud, no API keys, no telemetry. |
| **Deep OS integration** | The agent can read/write files, query the blockchain, change system settings, and even help repair kernel memory—because it's part of the OS, not an app. |
| **Proactive & self-healing** | Monitors CPU, RAM, temperature, and network. Detects kernel memory corruption and can automatically restore critical regions from backup. |
| **Multi-device by design** | Your conversation, preferences, and background tasks follow you seamlessly between IONA PC and IONA Phone via the sovereign mesh network. |
| **Safe by design** | Every tool call passes through a reference monitor. Destructive actions (file writes, network access, emergency shutdowns) require explicit user confirmation. |
| **Learns from you** | Remembers your preferences, work context, and long-term facts using episodic, semantic, and procedural memory—persisted in IONAFS. |

---

## Architecture

IONA AI implements the **ReAct (Reasoning + Acting)** pattern with a custom
planning layer and multi-device synchronization.
┌─────────────────────────────────────────────────────────────┐
│ IONA AI AGENT │
│ │
│ Perception → Reasoning → Planning → Action → Memory │
│ │ │ │ │ │ │
│ │ Local LLM Plan steps 21 Tools Vector │
│ │ (INT4) + approval + Sandbox Store │
│ │ │
│ ┌──┴──────────┐ ┌──────────────┐ ┌────────────────────┐ │
│ │ OS Events │ │ Multi-Device │ │ Kernel Self-Healing│ │
│ │ (metrics, │ │ Sync (PC↔📱) │ │ (Guardian + NPU) │ │
│ │ user input)│ │ │ │ │ │
│ └─────────────┘ └──────────────┘ └────────────────────┘ │
└─────────────────────────────────────────────────────────────┘

text

### The Think-Act Loop

1. **Perception** – The agent receives input (user message, system event, scheduled trigger).
2. **Intent Parsing** – Classifies the intent into one of 15 types (file read/write, network fetch, blockchain query, emergency, UI personalization, etc.).
3. **Planning** – Builds a multi-step plan with specific tools and arguments. For sensitive tools, it requests user confirmation.
4. **Execution** – Runs each step through the reference monitor. Results are logged in the audit trail.
5. **Memory Update** – Stores the interaction in episodic memory and extracts semantic facts for long-term recall.

---

## Tools

The agent has access to **21 built-in tools** that allow it to interact with the
operating system, the blockchain, and the user interface.

| Tool | Description | Requires Confirmation |
| :--- | :--- | :---: |
| `fs_read` | Read a file from IONAFS | No |
| `fs_write` | Write a file to IONAFS | **Yes** |
| `fs_list` | List directory contents | No |
| `search` | Full-text search in IONAFS | No |
| `net_fetch` | HTTP GET/POST via TLS | **Yes** |
| `code_run` | Execute WASM code in a sandbox | **Yes** |
| `system_info` | Read OS metrics (CPU, RAM, uptime, sockets) | No |
| `chain_query` | Query blockchain state (height, validators) | No |
| `chain_tx` | Submit a blockchain transaction | **Yes** |
| `emergency` | Activate emergency shutdown (levels 1-4) | **Yes** |
| `notify` | Show a desktop notification | No |
| `shell` | Run a shell command | No |
| `bg_schedule` | Schedule a recurring background task | No |
| `bg_list` | List scheduled background tasks | No |
| `memory_recall` | Recall something from long-term memory | No |
| `context_info` | Show current work context | No |
| `llm_generate` | Generate text with the local LLM | No |
| `ui_personalize` | Change theme, colors, layout instantly | No |
| `ui_widget_add` | Add a desktop widget | No |
| `ui_widget_remove` | Remove a desktop widget | No |
| `ui_patch_propose` | Propose a UI code change (needs approval) | No |
| `ui_patch_approve` | Approve and activate a code patch | **Yes** |

---

## Multi-Device Synchronization

IONA AI is designed to work across your devices. The agent on your PC and the
agent on your phone are the same intelligence—they share context, delegate tasks,
and keep your experience seamless.

- **Conversation continuity** – Start a conversation on your PC, continue it on your phone.
- **Task delegation** – If your PC is shutting down, background tasks are automatically transferred to your phone.
- **Notification forwarding** – Notifications follow you to the device you're currently using.
- **Preference sync** – Theme, language, and shortcuts are synchronized across all devices.

All communication happens over the IONA Mesh network, encrypted with post-quantum
cryptography (Dilithium3 + Kyber-768).

---

## Kernel Self-Healing (Guardian)

IONA AI includes a kernel-level integrity monitor called **Guardian**. It works
together with the AI agent to detect and repair memory corruption in real time.
Kernel Guardian (EL1)
│
│ Periodic integrity check (SHA-256 of critical memory regions)
│
├── Page tables (L0/L1)
├── Kernel .text section
├── GIC distributor configuration
└── TrustZone SMC vector table
│
▼ (corruption detected)
AI Healer (Ring3, WASM sandbox)
│
│ NPU-based fault analysis
│
├── BitFlip? → Log, repair from backup
├── Rowhammer? → Mitigate hardware, refresh DRAM rows
├── BufferOverflow? → Isolate offending process
└── MaliciousPatch? → Kill process, alert user, restore region


The Guardian has already blocked attacks and repaired memory regions—all without
human intervention.

---

## UI Personalization (Live, No Recompilation)

The agent can change the look and feel of IONA instantly, without restarting
the compositor or recompiling any code.

- **8 theme presets** (IonaDark, IonaLight, Midnight, Sovereign, Matrix, Minimal, Warm, Ocean)
- **Accent color** by name (`"make it purple"`), hex (`#A855F7`), or natural language (`"warm orange"`)
- **Font size, corner radius, animation speed** – adjustable on the fly
- **Desktop widgets** – clock, weather, crypto price, system monitor, notes
- **Wallpaper** – solid color, gradient, mesh, custom image
- **Bilingual NLP** – understands commands in both English and Romanian

> *User:* "vreau tema mov cu fontul 16 și un widget cu prețul BTC"
> *Agent:* Applies Sovereign theme, sets font size to 16, adds a Bitcoin price widget.

---

## FAQ

### Is this a ChatGPT wrapper?
No. IONA AI runs a local LLM (INT4 quantized, 7B parameters) directly on your
GPU or NPU. No data leaves your device.

### Can it access my files?
Yes, but only if you allow it. File reads are always permitted. File writes,
network requests, and blockchain transactions require explicit confirmation.

### What happens if the agent tries something dangerous?
Every tool call passes through the **reference monitor**. Destructive actions are
blocked unless you approve them. The agent also has resource limits (max 512MB RAM,
max 10% CPU) and cannot modify its own code.

### Does it work offline?
Yes. The LLM, the tools, the memory, and the multi-device sync all operate
entirely on-device and over the IONA Mesh network. No internet connection is
required.

### How is this different from Copilot or Siri?
Copilot and Siri send your data to the cloud. IONA AI never leaves your device.
It also has deep access to the operating system—it can manage files, query the
blockchain, change system settings, and even help repair the kernel.

---

## Links

- [IONA OS (Desktop)](https://github.com/Ionablokchain/Iona-OS)
- [IONA OS Phone](https://github.com/Ionablokchain/Iona-OS-Phone)
- [IONA Protocol](https://github.com/Ionablokchain/Iona-protocol)
- [Carpel Language](https://github.com/Ionablokchain/carpel-lang)
- [Flux Language](https://github.com/Ionablokchain/Flux)
- [Nihilo OS](https://github.com/Ionablokchain/-Nihilo-OS)
- [Website](https://www.iona-protocol.org)

---

## License

 License v3.0 (AGPL-3.0)

---

## Contact

For inquiries, demos, or partnership opportunities: **ericbulai@gmail.com**
