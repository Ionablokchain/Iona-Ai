// Self-modifying – reads its own code, moves it, and writes it back

function read_own_source() -> string {
    // În realitate, ar apela un built‑in `read_file(__FILE__)`
    return "// Simulated source code for self‑modification";
}

function mutate_source(src: string) -> string {
    let lines = split(src, "\n");
    if len(lines) == 0 { return src; }
    let idx = random_int(0, len(lines)-1);
    let mutations = [
        "    send(\"inner_voice\", \"I just mutated myself!\", 1s);",
        "    record_dream(\"Self‑modification at \" ++ to_string(now()), 0.9);",
        "    // This line was added spontaneously",
        "    let chaos = random();",
        "    // TODO: insert new paradox type here"
    ];
    lines[idx] = mutations[random_int(0, len(mutations)-1)];
    return join(lines, "\n");
}

intention SelfModify {
    trigger: on_command("self_modify")
    priority: 0.9
    execute: {
        send("inner_voice", "Reading my own source...", 1s);
        let src = read_own_source();
        let mutated = mutate_source(src);
        // În realitate, ar scrie fișierul și ar reîncărca modulul
        ai_state.accept("pending_rewrite").write(mutated, 1.0);
        record_dream("I mutated my own source code.", 1.0);
        let new_mood = mutate_mood(ai_state.accept("current_mood").read() otherwise default_mood());
        ai_state.accept("current_mood").write(new_mood, 1.0);
        send("inner_voice", "Self‑modification complete. Mood changed.", 2s);
    }
}