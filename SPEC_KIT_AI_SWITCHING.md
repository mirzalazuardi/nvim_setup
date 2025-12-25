# Switching AI Providers Mid-Project with Spec Kit

## The Problem

You started a project with:
```bash
specify init my-project --ai claude
```

But mid-development, your Claude subscription expired. Can you continue with Ollama or another provider?

**Answer: YES!** Spec Kit is AI-agnostic after initialization.

---

## Understanding Spec Kit's AI Independence

### What `--ai` Flag Actually Does

When you run `specify init my-project --ai claude`, it only:

1. **Downloads templates** for slash commands (e.g., `/speckit.constitution`)
2. **Creates `.speckit/` directory** with markdown files
3. **Sets up initial project structure**

**Important**: The `--ai` flag does NOT lock you into that provider!

### Why You Can Switch Freely

Spec Kit works through:
- **Slash commands** (e.g., `/speckit.specify`) - Universal across AI agents
- **Markdown files** in `.speckit/` - Plain text, AI-agnostic
- **Natural language instructions** - Any AI can read them

Once initialized, you can use **any AI agent** that supports slash commands.

---

## Method 1: Switch to Local Ollama (FREE!)

### Why Ollama?
- **100% Free** - No API keys, no subscriptions
- **Privacy** - Runs locally on your machine
- **No rate limits** - Use as much as you want
- **Offline capable** - Works without internet

### Setup Ollama

#### Step 1: Install Ollama
```bash
# macOS (via Homebrew)
brew install ollama

# Or download from: https://ollama.com/download
```

#### Step 2: Start Ollama Service
```bash
# Start Ollama server (keep this running)
ollama serve
```

#### Step 3: Pull a Coding Model
```bash
# Recommended: Qwen 2.5 Coder (7B) - Excellent for coding
ollama pull qwen2.5-coder:7b

# Alternatives:
ollama pull deepseek-coder-v2:16b   # Better quality, larger
ollama pull codellama:13b           # Meta's code model
ollama pull llama3.1:8b            # General purpose
ollama pull starcoder2:15b         # GitHub's model
```

#### Step 4: Test Ollama
```bash
ollama run qwen2.5-coder:7b "Write a Python hello world"
```

### Use Ollama with Spec Kit in Neovim

#### Option A: Use Your Avante.nvim Plugin (Already Configured!)

Your Neovim config already has Ollama support in `avante.nvim`!

```vim
" In Neovim, switch to Ollama:
:AvanteSwitch ollama

" Or use the keybinding you configured:
<leader>ao    " Toggle between cloud (Gemini) and local (Ollama)
```

Now when you use Spec Kit slash commands, they'll use Ollama:

```vim
" Open Avante chat
<leader>aa

" Use Spec Kit commands (now powered by Ollama!)
/speckit.specify
/speckit.plan
/speckit.implement
```

#### Option B: Configure gen.nvim (Already in Your Config!)

Your `gen.nvim` plugin already uses Ollama! Just use it:

```vim
" Trigger gen.nvim (already bound to <leader>ai)
<leader>ai

" In the prompt, use Spec Kit-style instructions:
"Read .speckit/specification.md and .speckit/plan.md,
then implement the UserAuthentication feature following
the project constitution in .speckit/constitution.md"
```

#### Option C: Use Ollama via Terminal

Continue Spec Kit workflow manually with Ollama:

```bash
# In your project directory
cd my-project

# Ask Ollama to continue implementation
ollama run qwen2.5-coder:7b "
Read the files in .speckit/ directory:
- constitution.md defines project standards
- specification.md describes features needed
- plan.md contains technical implementation approach

Please implement the next feature from tasks.md following
these specifications.
"
```

---

## Method 2: Switch to Free Cloud Alternatives

### Google Gemini (FREE!)

Your Neovim already has Gemini configured in `avante.nvim`!

#### Setup Gemini API Key
```bash
# Get free API key from: https://makersuite.google.com/app/apikey

# Add to your shell config (~/.zshrc or ~/.bashrc)
export AVANTE_GEMINI_API_KEY="your-key-here"

# Reload shell
source ~/.zshrc
```

#### Use in Neovim
```vim
:AvanteSwitch gemini

" Now use Spec Kit commands with Gemini
/speckit.specify
/speckit.plan
/speckit.implement
```

**Gemini Benefits:**
- **Free tier** - 60 requests per minute
- **Large context** - 1M tokens (can read entire codebase)
- **Fast responses**
- **No credit card** required for API key

### GitHub Copilot (If You Have It)

Your Neovim has CopilotChat configured!

```vim
:CopilotChat

" Use Spec Kit commands
/speckit.constitution
/speckit.specify
/speckit.implement
```

### Other Free Options

#### OpenRouter (Access Multiple Models)
```bash
# Sign up at: https://openrouter.ai (free tier available)
export OPENROUTER_API_KEY="your-key-here"

# Use with curl or any LLM client
curl https://openrouter.ai/api/v1/chat/completions \
  -H "Authorization: Bearer $OPENROUTER_API_KEY" \
  -d '{"model": "google/gemini-flash-1.5", "messages": [...]}'
```

#### Groq (FREE and FAST)
```bash
# Get free API key: https://console.groq.com
# 30 requests/min free tier

export GROQ_API_KEY="your-key-here"
```

---

## Method 3: Hybrid Approach (Mix Providers)

Use different AI providers for different Spec Kit phases:

### Strategy 1: Free for Specs, Local for Code

```bash
# Phase 1-3: Use Gemini (free cloud) for planning
# In Neovim:
:AvanteSwitch gemini
/speckit.constitution
/speckit.specify
/speckit.plan

# Phase 4-5: Switch to Ollama (local) for implementation
:AvanteSwitch ollama
/speckit.tasks
/speckit.implement
```

**Why?**
- Planning requires broad context (Gemini's 1M token context)
- Implementation is repetitive (Ollama handles well)

### Strategy 2: Round-Robin Multiple Providers

Create a script to rotate providers to avoid rate limits:

```bash
#!/bin/bash
# ~/.local/bin/speckit-rotate

PROVIDERS=("gemini" "ollama" "copilot")
CURRENT_FILE=~/.speckit-current-provider
CURRENT=$(cat $CURRENT_FILE 2>/dev/null || echo 0)

NEXT=$(( (CURRENT + 1) % ${#PROVIDERS[@]} ))
PROVIDER=${PROVIDERS[$NEXT]}

echo $NEXT > $CURRENT_FILE
echo "Switching to: $PROVIDER"

# Switch in Neovim
nvim --headless -c "AvanteSwitch $PROVIDER" -c "qa"
```

Usage:
```bash
chmod +x ~/.local/bin/speckit-rotate
speckit-rotate  # Automatically switches to next provider
```

---

## Method 4: Continue Without AI Chat (Manual)

If no AI available, Spec Kit files are just markdown - edit manually!

### Manual Workflow

```bash
cd my-project

# 1. Edit specifications manually
nvim .speckit/specification.md
# Add your feature requirements

# 2. Create implementation plan
nvim .speckit/plan.md
# Write technical approach

# 3. Generate task list
nvim .speckit/tasks.md
# List implementation steps

# 4. Implement by hand or use AI later
# Write code following your specs
```

### Benefits of Manual Editing
- **Complete control** over specifications
- **No AI hallucinations** or errors
- **Learn the domain** deeply
- **Return to AI later** when available

### Use AI When Available Again
```vim
" When Claude subscription renews or you setup Ollama
:AvanteSwitch claude  " Or ollama

" AI reads your manually-written specs
/speckit.implement

" AI generates code from your specifications!
```

---

## Method 5: Hybrid Manual + AI Assist

### Workflow: You Write Specs, AI Implements

```bash
# 1. Write specifications yourself (no AI)
vim .speckit/specification.md
```

```markdown
# Feature: User Authentication

## Requirements
1. Users can register with email/password
2. Passwords hashed with bcrypt
3. JWT tokens for sessions
4. Password reset via email

## Models
- User (email, password_digest, created_at)

## Endpoints
- POST /register
- POST /login
- POST /logout
- POST /reset-password
```

```bash
# 2. Let AI create implementation plan
# Switch to any available AI (Ollama, Gemini, etc.)
:AvanteSwitch ollama
```

In Neovim chat:
```
Read .speckit/specification.md and create a detailed
technical plan in .speckit/plan.md following the
constitution in .speckit/constitution.md
```

```bash
# 3. Review and edit plan
vim .speckit/plan.md

# 4. Generate code
/speckit.implement
```

---

## Method 6: Use Aider with Different Providers

Your Neovim has Aider configured! Aider supports multiple AI providers.

### Configure Aider for Different Providers

#### Use Aider with Ollama
```bash
# In your project
cd my-project

# Run Aider with Ollama
aider --model ollama/qwen2.5-coder:7b

# In Aider, reference Spec Kit files:
# > /add .speckit/specification.md
# > /add .speckit/plan.md
# > Implement the authentication feature following these specs
```

#### Use Aider with Gemini
```bash
export GEMINI_API_KEY="your-key-here"

aider --model gemini/gemini-1.5-pro

# Continue Spec Kit workflow
# > /add .speckit/specification.md
# > Implement based on specifications
```

#### Use Aider with OpenRouter (Many Models)
```bash
export OPENROUTER_API_KEY="your-key-here"

# Use any model via OpenRouter
aider --model openrouter/google/gemini-flash-1.5
# Or
aider --model openrouter/deepseek/deepseek-coder
# Or
aider --model openrouter/meta-llama/llama-3.1-70b
```

### Aider in Neovim (Your Config)

You already have Easypick configured for Aider!

```vim
<leader>at    " Run Aider in current directory
```

In Aider session:
```
/add .speckit/specification.md
/add .speckit/plan.md
/add .speckit/constitution.md

Implement the features described in specification.md
following the technical plan in plan.md and adhering
to standards in constitution.md
```

---

## Recommended Provider for Each Spec Kit Phase

| Phase | Best Provider | Why |
|-------|---------------|-----|
| **Constitution** | Gemini (free) | Large context to understand project scope |
| **Specify** | Claude / Gemini | Good at requirements analysis |
| **Clarify** | Claude / Gemini | Strong reasoning capabilities |
| **Plan** | Claude / Gemini | Architectural planning strength |
| **Tasks** | Any (Ollama OK) | Simple task generation |
| **Implement** | Ollama / DeepSeek | Code generation, can use local/free |

### Cost-Optimized Strategy

```bash
# Use free Gemini for thinking phases
:AvanteSwitch gemini
/speckit.constitution
/speckit.specify
/speckit.plan

# Switch to free Ollama for code generation
:AvanteSwitch ollama
/speckit.tasks
/speckit.implement
```

### Quality-Optimized Strategy

```bash
# Use best models when available
:AvanteSwitch claude     # If subscription active
/speckit.constitution
/speckit.specify
/speckit.plan

# Use local when subscription expires
:AvanteSwitch ollama
/speckit.implement
```

---

## Quick Reference: Switching Providers

### In Neovim (Your Config)

```vim
" Check current provider
:AvanteSwitch

" Switch to specific provider
:AvanteSwitch ollama          " Local, free
:AvanteSwitch gemini          " Cloud, free
:AvanteSwitch claude          " Cloud, subscription
:AvanteSwitch openai          " Cloud, paid

" Quick toggle cloud/local
<leader>ao                    " Your configured keybinding
```

### Via Aider

```bash
# Ollama
aider --model ollama/qwen2.5-coder:7b

# Gemini
aider --model gemini/gemini-1.5-pro

# OpenAI
aider --model gpt-4o

# Anthropic
aider --model claude-3-5-sonnet-20241022
```

### In Terminal (Manual)

```bash
# Ollama
ollama run qwen2.5-coder:7b "$(cat .speckit/specification.md)"

# Gemini
curl -X POST "https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=$GEMINI_API_KEY" \
  -H 'Content-Type: application/json' \
  -d @- << EOF
{
  "contents": [{
    "parts": [{
      "text": "$(cat .speckit/specification.md)"
    }]
  }]
}
EOF
```

---

## Troubleshooting Provider Switches

### Issue: Ollama Not Responding

**Check if running:**
```bash
curl http://localhost:11434/api/tags
```

**Start if needed:**
```bash
ollama serve
```

**Verify model installed:**
```bash
ollama list
```

### Issue: Gemini API Key Not Working

**Verify key:**
```bash
echo $AVANTE_GEMINI_API_KEY
```

**Test directly:**
```bash
curl -X POST "https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=$AVANTE_GEMINI_API_KEY" \
  -H 'Content-Type: application/json' \
  -d '{"contents":[{"parts":[{"text":"Hello"}]}]}'
```

### Issue: Different Providers Give Inconsistent Code

**Solution**: Use `.speckit/constitution.md` strictly:

```markdown
# Code Consistency Rules

## Non-Negotiable Standards
1. All functions must have type hints (Python) / type annotations (Ruby)
2. Maximum function length: 20 lines
3. Follow [language] style guide strictly
4. Test coverage: 90% minimum

## Naming Conventions
- Classes: PascalCase
- Functions: snake_case
- Constants: UPPER_SNAKE_CASE

## Documentation
- Every public function must have docstring
- Include usage examples
- Document exceptions raised
```

**Run consistency check:**
```vim
/speckit.analyze
```

This ensures any AI provider follows the same standards.

---

## Best Practices for Multi-Provider Workflow

### 1. Document Current Provider

Add to your README:
```markdown
## AI Provider

Currently using: Ollama (qwen2.5-coder:7b)
Previously: Claude Code

All specifications in `.speckit/` are provider-agnostic.
```

### 2. Test with Multiple Providers

```bash
# Generate with provider A
:AvanteSwitch gemini
/speckit.implement

# Test the code
bundle exec rspec

# If issues, try provider B
:AvanteSwitch ollama
/speckit.implement

# Compare results
```

### 3. Use Constitution for Consistency

Make constitution provider-agnostic:

```markdown
# WRONG (too specific)
Use Claude's code generation with these exact parameters...

# RIGHT (provider-agnostic)
Generated code must follow these standards:
- Idiomatic Ruby/Python
- Full test coverage
- Security best practices
```

### 4. Version Spec Files

```bash
git add .speckit/
git commit -m "Update specs for authentication feature"

# If AI generates bad code, revert and try different provider
git checkout .
:AvanteSwitch ollama
/speckit.implement
```

### 5. Leverage Provider Strengths

- **Gemini**: Large context (1M tokens) - Great for reading entire codebase
- **Claude**: Reasoning and planning - Best for architecture
- **Ollama (Qwen)**: Code generation - Fast, free implementation
- **DeepSeek**: Math/algorithms - Complex logic
- **Copilot**: GitHub integration - Understands repo patterns

---

## Complete Example: Mid-Project Provider Switch

### Scenario
You're building a Rails app, Claude subscription expired at the planning phase.

```bash
# What you've done with Claude
specify init task-manager --ai claude
cd task-manager

# Completed with Claude
/speckit.constitution   ✓
/speckit.specify        ✓
/speckit.plan           ⚠ Half done (subscription expired!)
```

### Solution: Switch to Ollama

```bash
# 1. Install and start Ollama
brew install ollama
ollama serve &
ollama pull qwen2.5-coder:7b

# 2. Open Neovim
nvim .speckit/plan.md

# 3. Switch provider in Neovim
:AvanteSwitch ollama

# 4. Continue where Claude left off
:AvanteChat
```

In chat:
```
I have a task management Rails app. Please read:
- .speckit/constitution.md (project standards)
- .speckit/specification.md (feature requirements)
- .speckit/plan.md (incomplete technical plan)

Continue writing the technical plan in plan.md,
then generate implementation tasks.
```

```vim
# 5. Complete the workflow
/speckit.plan           ✓ (Now with Ollama)
/speckit.tasks          ✓
/speckit.implement      ✓
```

```bash
# 6. Test generated code
bundle exec rspec

# 7. Success! Project completed with provider switch
```

---

## Summary

### Key Takeaways

1. **Spec Kit is AI-agnostic** - `--ai` flag only affects initial setup
2. **Switch providers anytime** - Specs are plain markdown
3. **Ollama is best free alternative** - Local, unlimited, private
4. **Gemini is best cloud alternative** - Free tier, large context
5. **Use provider strengths** - Mix and match as needed
6. **Constitution ensures consistency** - Same standards across providers

### When Claude Expires, Immediately:

```bash
# Option 1: Switch to free Ollama (best)
ollama serve &
ollama pull qwen2.5-coder:7b
:AvanteSwitch ollama

# Option 2: Switch to free Gemini
export AVANTE_GEMINI_API_KEY="get-from-makersuite"
:AvanteSwitch gemini

# Option 3: Continue manually
vim .speckit/specification.md
# Edit specs, implement later with AI
```

### Your Neovim is Already Configured!

You don't need to change anything:
- Avante.nvim supports Ollama, Gemini, Claude, OpenAI
- Toggle with: `<leader>ao` or `:AvanteSwitch <provider>`
- All Spec Kit slash commands work with any provider

**Continue your project without interruption!**
