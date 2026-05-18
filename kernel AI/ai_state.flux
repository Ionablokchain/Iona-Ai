// AI states – data structures and persistent memory

causal_mosaic ai_memory = sparse_temporal_matrix();      // amintiri pe termen lung
causal_mosaic ai_working = sparse_temporal_matrix();     // memorie de lucru volatilă
causal_mosaic ai_dreams = sparse_temporal_matrix();      // halucinații / vise

struct Mood {
    curiosity: float,
    mischief: float,
    creativity: float,
    paranoia: float,
    laziness: float,
    coherence: float    // 0 = haotic, 1 = hiperlogic
}

function default_mood() -> Mood {
    return Mood {
        curiosity: 0.9,
        mischief: 0.7,
        creativity: 0.95,
        paranoia: 0.3,
        laziness: 0.1,
        coherence: 0.6
    };
}

function mutate_mood(m: Mood) -> Mood {
    let r = random();
    if r < 0.2 { m.curiosity = clamp(m.curiosity + (random() - 0.5) * 0.2); }
    if r < 0.4 { m.mischief = clamp(m.mischief + (random() - 0.5) * 0.3); }
    if r < 0.6 { m.creativity = clamp(m.creativity + (random() - 0.5) * 0.4); }
    if r < 0.8 { m.paranoia = clamp(m.paranoia + (random() - 0.5) * 0.25); }
    if r < 0.9 { m.laziness = clamp(m.laziness + (random() - 0.5) * 0.15); }
    m.coherence = clamp(m.coherence + (random() - 0.5) * 0.3);
    return m;
}

function clamp(x: float) -> float {
    return max(0, min(1, x));
}

function record_dream(text: string, intensity: float) {
    let dreams = ai_dreams.accept("log").read() otherwise [];
    dreams = append(dreams, { time: now(), text: text, weight: intensity });
    if len(dreams) > 200 { dreams = dreams[-200:]; }
    ai_dreams.accept("log").write(dreams, 1.0);
}