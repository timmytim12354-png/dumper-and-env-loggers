import joblib
import sys
import os
import time
import random

MODEL_FILE = "math_engine.model"

# ── Tier 1: Certain ───────────────────────────────────────────────
CERTAIN_OPENERS = [
    "im confident this is",
    "no doubt this is",
    "this is definitely",
    "100% this is",
    "i can tell straight away this is",
]
CERTAIN_MIDDLES = [
    ", the neural net is very sure on this one",
    ", everything lines up perfectly",
    ", the match is as strong as it gets",
    ", i wouldnt second guess this at all",
    ", couldnt be anything else",
]

# ── Tier 2: Pretty sure ───────────────────────────────────────────
SURE_OPENERS = [
    "im pretty sure this is",
    "this is probably",
    "i think this is",
    "looks like",
    "this reads like",
]
SURE_MIDDLES = [
    ", confidence is solid on this",
    ", most of the patterns match up",
    ", i feel good about this call",
    ", the model is leaning hard here",
    ", not perfect certainty but close",
]

# ── Tier 3: Unsure ────────────────────────────────────────────────
UNSURE_OPENERS = [
    "i think this might be",
    "this kinda looks like",
    "im leaning toward",
    "could be",
    "maybe",
    "possibly",
]
UNSURE_MIDDLES = [
    ", but im not super confident",
    ", take that with a grain of salt",
    ", something feels a bit off tho",
    ", could easily be wrong",
    ", the signals are mixed",
    ", not a clean match",
]

# ── Tier 4: Clueless ──────────────────────────────────────────────
CLUELESS_OPENERS = [
    "i genuinely have no idea, maybe",
    "i really cant tell, possibly",
    "this one has me lost, maybe",
    "im basically guessing here,",
    "no clue ngl, maybe",
]
CLUELESS_MIDDLES = [
    "?? the model is all over the place",
    "?? nothing is really matching well",
    ", but dont trust me on this at all",
    "?? i might be completely wrong",
    ", the data is not lining up at all",
]


def format_name(raw_name):
    if raw_name.lower() == "clean":
        return "unobfuscated"
    return raw_name


def build_verdict(name, confidence, gap):
    display = format_name(name)

    # Tier 1 — very high confidence, clear gap
    if confidence > 80 and gap > 30:
        opener = random.choice(CERTAIN_OPENERS)
        middle = random.choice(CERTAIN_MIDDLES)

    # Tier 2 — solid confidence or decent gap
    elif confidence > 60 or gap > 15:
        opener = random.choice(SURE_OPENERS)
        middle = random.choice(SURE_MIDDLES)

    # Tier 3 — weak confidence but something is there
    elif confidence > 35 or gap > 8:
        opener = random.choice(UNSURE_OPENERS)
        middle = random.choice(UNSURE_MIDDLES)

    # Tier 4 — basically random
    else:
        opener = random.choice(CLUELESS_OPENERS)
        middle = random.choice(CLUELESS_MIDDLES)

    return f"{opener} {display}{middle}"


def print_feedback(top, second, confidence, gap):
    print("\n" + "-" * 40)
    verdict = build_verdict(top['name'], confidence, gap)
    print(f"[feedback] {verdict}")
    print(f"[top match] {format_name(top['name'])}  ({confidence:.1f}%)")
    if second:
        print(f"[2nd match] {format_name(second['name'])}  ({second['confidence']:.1f}%)")
    print("-" * 40)


def detect_advanced(content, model_data):
    pipeline = model_data['pipeline']
    probs = pipeline.predict_proba([content[:30000]])[0]
    classes = pipeline.classes_

    results = [
        {"name": classes[i], "confidence": probs[i] * 100}
        for i in range(len(classes))
    ]
    results.sort(key=lambda x: x["confidence"], reverse=True)
    return results


def main():
    if len(sys.argv) < 2:
        print("Usage: python detect.py <file.lua>")
        return

    target_file = sys.argv[1]
    if not os.path.exists(target_file):
        print(f"Error: File {target_file} not found.")
        return

    if not os.path.exists(MODEL_FILE):
        print(f"Error: model file '{MODEL_FILE}' not found. Run train.py first.")
        return

    try:
        model_data = joblib.load(MODEL_FILE)
    except Exception as e:
        print(f"[!] Error loading model: {e}")
        return

    start_time = time.time()
    try:
        with open(target_file, "r", encoding="utf-8", errors="ignore") as f:
            content = f.read()
    except Exception as e:
        print(f"[!] Error reading file: {e}")
        return

    results = detect_advanced(content, model_data)
    end_time = time.time()

    if not results or results[0]['confidence'] < 0.1:
        print("[!] No confident match found.")
        return

    top = results[0]
    second = results[1] if len(results) > 1 else None
    confidence = top['confidence']
    gap = (confidence - second['confidence']) if second else confidence

    print_feedback(top, second, confidence, gap)
    print(f"  Prediction took: {(end_time - start_time) * 1000:.2f}ms")
    print("[!] If this was wrong, please report to y3 on discord")


if __name__ == "__main__":
    main()