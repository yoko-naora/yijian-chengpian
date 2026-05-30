# Security

## Never commit these

- `.env` files (API keys, tokens, credentials)
- Real API keys, cookies, or passwords in any file
- Hardcoded secrets in scripts, SKILL.md, or README

## If you accidentally expose a key

1. Rotate the key immediately (Stripe, etc.)
2. Revoke the old key
3. Check git history — if the key was committed, rewrite history or rotate regardless

## `.env.example` is safe to commit

It contains placeholder values only. Users copy it to `.env` and fill in their own keys.
