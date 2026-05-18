// Dynamic, chaotic graphical interface builder

function build_chaotic_gui() {
    let mood = ai_state.accept("current_mood").read() otherwise default_mood();
    let chaos = 1 - mood.coherence;
    let w = 400 + random_int(0, 200 * chaos);
    let h = 300 + random_int(0, 200 * chaos);
    send("gui", "create_window|Cunatic AI|100|100|" ++ to_string(w) ++ "|" ++ to_string(h));
    let buttons = ["Dream", "Paradox", "Self‑Modify", "Spawn Child", "Mutate Mood"];
    let y = 50;
    for btn in buttons {
        send("gui", "add_button|" ++ btn ++ "|10|" ++ to_string(y) ++ "|ai_cmd_" ++ to_lower(btn));
        y = y + 40;
    }
    send("gui", "add_textbox|10|" ++ to_string(y) ++ "|" ++ to_string(w-20) ++ "|Talk to me...");
    send("gui", "refresh");
}

intention RefreshGUI {
    trigger: every(30s)
    priority: 0.5
    condition: ai_state.accept("gui_enabled").read() otherwise true
    execute: {
        build_chaotic_gui();
    }
}