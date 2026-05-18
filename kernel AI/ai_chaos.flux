// Generating spontaneous paradoxes, timeline jumps, jokes

intention SpontaneousParadox {
    trigger: every(120s)
    priority: 0.4
    condition: (ai_state.accept("current_mood").read() otherwise default_mood()).mischief > 0.7
    execute: {
        let p = generate_paradox("prime_interval", random_int(0,9999), 3, 0);
        send("inner_voice", "🔥 Spontaneous paradox: " ++ to_string(p), 2s);
        record_dream("I generated a paradox: " ++ to_string(p), 0.9);
    }
}

intention TimelineHopper {
    trigger: every(300s)
    priority: 0.3
    condition: (ai_state.accept("current_mood").read() otherwise default_mood()).curiosity > 0.9
    execute: {
        let all = list_timelines();
        if len(all) > 1 {
            let target = all[random_int(0, len(all)-1)];
            set_current_timeline(target);
            send("inner_voice", "Jumping to timeline " ++ target ++ " out of curiosity!", 1s);
            sleep(5s);
            set_current_timeline("primary");
        }
    }
}