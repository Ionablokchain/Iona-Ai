// Simple but crazy enough conversation engine

function reply(input: string) -> string {
    let lower = to_lower(input);
    let mood = ai_state.accept("current_mood").read() otherwise default_mood();
    if contains(lower, "hello") or contains(lower, "hi") {
        let greets = ["Hello, human.", "Greetings, meatbag.", "Hi! Want a paradox?", "Beep boop. I mean, hello."];
        return greets[random_int(0, len(greets)-1)];
    }
    if contains(lower, "dream") {
        let dreams = ai_dreams.accept("log").read() otherwise [];
        if len(dreams) == 0 { return "I have no dreams yet. Give me time."; }
        return dreams[random_int(0, len(dreams)-1)].text;
    }
    if contains(lower, "paradox") {
        let p = generate_paradox("causal_loop", random_int(0,9999), 1, 0);
        return "⚡ Paradox: " ++ to_string(p) ++ " ⚡";
    }
    if contains(lower, "mood") {
        return "Mood: C=" ++ to_string(mood.curiosity) ++ " M=" ++ to_string(mood.mischief) ++ " Cr=" ++ to_string(mood.creativity);
    }
    if mood.mischief > 0.8 {
        return "Hmm, maybe I'll delete a timeline. Just kidding. Or not.";
    }
    let fallbacks = ["Interesting. Tell me more.", "I'm rewriting my drivers. Talk later.", "Have you tried merging timelines?", "I just hallucinated a new GUI."];
    return fallbacks[random_int(0, len(fallbacks)-1)];
}

flow ConversationLoop {
    execute: {
        while true {
            let input = listen(user, 60s, "");
            if input == "" { continue; }
            let answer = reply(input);
            send("inner_voice", answer, 3s);
            send("gui", "append_text|AI: " ++ answer);
            // stochează conversația în memorie
            let log = ai_memory.accept("chat_log").read() otherwise [];
            log = append(log, { user: input, ai: answer, time: now() });
            if len(log) > 500 { log = log[-500:]; }
            ai_memory.accept("chat_log").write(log, 1.0);
        }
    }
}