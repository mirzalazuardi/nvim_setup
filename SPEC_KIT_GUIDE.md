# Spec Kit Guide: Ruby, Rails & Python Project Starter

## Table of Contents
1. [What is Spec Kit?](#what-is-spec-kit)
2. [Installation](#installation)
3. [Starting Ruby Projects](#starting-ruby-projects)
4. [Starting Rails Projects](#starting-rails-projects)
5. [Starting Python Projects](#starting-python-projects)
6. [Neovim Integration](#neovim-integration)
7. [Workflow Overview](#workflow-overview)
8. [Advanced Usage](#advanced-usage)

---

## What is Spec Kit?

**Spec Kit** (GitHub Spec Kit) is an open-source toolkit for **Spec-Driven Development (SDD)** that transforms specifications into executable code using AI coding agents. Instead of writing code first, you define requirements and let AI generate implementations.

### Key Benefits
- Write specifications, not code first
- AI generates working implementations from specs
- Consistent project structure across languages
- Built-in quality governance through "constitution"
- Works with multiple AI agents (Claude Code, Copilot, Gemini, etc.)

### Supported AI Agents
- **Claude Code** ✅ (Recommended for this config)
- GitHub Copilot ✅
- Gemini CLI ✅
- Cursor ✅
- Qwen Code ✅
- Windsurf ✅
- Roo Code ✅
- And more...

---

## Installation

### Prerequisites
- **Python 3.8+** (check: `python3 --version`)
- **Git 2.20+** (check: `git --version`)
- **uv package manager** (install: `curl -LsSf https://astral.sh/uv/install.sh | sh`)
- **AI agent** (Claude Code, Copilot, etc.)

### Method 1: Persistent Installation (Recommended)
```bash
# Install spec-kit CLI globally
uv tool install specify-cli --from git+https://github.com/github/spec-kit.git

# Verify installation
specify --version

# Update later with:
uv tool upgrade specify-cli

# Uninstall if needed:
uv tool uninstall specify-cli
```

### Method 2: One-Time Usage
```bash
# Run without installing (for testing)
uvx --from git+https://github.com/github/spec-kit.git specify init my-project --ai claude
```

---

## Starting Ruby Projects

### Method 1: Standard Ruby Project

#### Step 1: Initialize Project
```bash
# Create new Ruby project with Claude Code integration
specify init my-ruby-app --ai claude

# Or use other AI agents:
specify init my-ruby-app --ai copilot
specify init my-ruby-app --ai gemini
```

#### Step 2: Project Structure Created
```
my-ruby-app/
├── .speckit/
│   ├── constitution.md      # Project governance rules
│   ├── specification.md     # Feature requirements
│   ├── plan.md             # Technical implementation plan
│   └── tasks.md            # Actionable task list
├── lib/
│   └── my_ruby_app/        # Your Ruby code here
├── spec/                    # RSpec tests
├── Gemfile
├── Rakefile
└── README.md
```

#### Step 3: Define Your Project Constitution
```bash
cd my-ruby-app

# In your terminal with Claude Code:
/speckit.constitution
```

This creates `.speckit/constitution.md` with governance rules:
```markdown
# Project Constitution

## Core Principles
1. Write idiomatic Ruby code following community standards
2. Test coverage must be >90% with RSpec
3. Follow Rubocop style guide
4. Document all public APIs with YARD

## Testing Standards
- Unit tests for all classes/modules
- Integration tests for workflows
- Use FactoryBot for test data

## Code Quality
- Run Rubocop before commits
- Use semantic versioning
- Keep methods under 10 lines
```

#### Step 4: Specify Features
```bash
# Define what you want to build
/speckit.specify
```

Example specification:
```markdown
# Feature: User Authentication System

## Description
Build a secure authentication system for Ruby applications.

## Requirements
1. Users can register with email and password
2. Passwords are hashed with bcrypt
3. Session management with secure tokens
4. Password reset functionality
5. Rate limiting for login attempts

## Success Criteria
- All authentication flows work correctly
- Security best practices followed
- Full test coverage
```

#### Step 5: Create Implementation Plan
```bash
/speckit.plan
```

Spec Kit generates technical plan:
```markdown
# Implementation Plan

## Architecture
- Use bcrypt gem for password hashing
- Redis for session storage
- Rack::Attack for rate limiting

## File Structure
lib/
├── authentication/
│   ├── user.rb
│   ├── session.rb
│   ├── password_reset.rb
│   └── rate_limiter.rb

## Dependencies
- bcrypt (~> 3.1)
- redis (~> 5.0)
- rack-attack (~> 6.7)
```

#### Step 6: Generate Tasks
```bash
/speckit.tasks
```

Creates actionable checklist:
```markdown
# Tasks

- [ ] Set up Gemfile with dependencies
- [ ] Create User class with password hashing
- [ ] Implement Session management
- [ ] Add rate limiting middleware
- [ ] Write RSpec tests for all components
- [ ] Add YARD documentation
```

#### Step 7: Implement
```bash
/speckit.implement
```

AI generates all code based on specs, plan, and tasks.

---

### Method 2: Ruby Gem Project

#### Create Gem with Spec Kit
```bash
# Initialize gem project
specify init my-awesome-gem --ai claude

# Then follow spec-driven workflow
cd my-awesome-gem

# Define gem purpose and API
/speckit.constitution
# Example: "Build a lightweight HTTP client with retry logic"

/speckit.specify
# Define gem features, API design, usage examples

/speckit.plan
# Technical architecture, dependencies, version support

/speckit.tasks
# Implementation steps

/speckit.implement
# Generate gem structure: lib/, spec/, gemspec, etc.
```

#### Standard Gem Structure Created
```
my-awesome-gem/
├── .speckit/
├── lib/
│   ├── my_awesome_gem.rb
│   ├── my_awesome_gem/
│   │   ├── version.rb
│   │   ├── client.rb
│   │   └── ...
├── spec/
│   ├── spec_helper.rb
│   └── my_awesome_gem_spec.rb
├── Gemfile
├── Rakefile
├── my-awesome-gem.gemspec
├── LICENSE.txt
└── README.md
```

---

## Starting Rails Projects

### Method 1: New Rails Application from Scratch

#### Step 1: Initialize with Spec Kit
```bash
# Create Rails project structure
specify init my-rails-app --ai claude
cd my-rails-app
```

#### Step 2: Define Rails-Specific Constitution
```bash
/speckit.constitution
```

Example Rails constitution:
```markdown
# Rails Application Constitution

## Framework Standards
1. Ruby 3.3+, Rails 7.1+
2. Use Rails conventions (don't fight the framework)
3. Keep controllers thin, models fat (with service objects)
4. Use concerns for shared behavior

## Architecture
- Service objects for complex business logic
- Presenters/decorators for view logic
- Background jobs with Sidekiq
- RESTful API design

## Testing
- RSpec for unit/integration tests
- FactoryBot for test data
- VCR for external API mocking
- System tests with Capybara

## Database
- PostgreSQL primary database
- Migrations always reversible
- Index foreign keys
- Use database constraints
```

#### Step 3: Specify Your Application
```bash
/speckit.specify
```

Example Rails app specification:
```markdown
# Project: Task Management Application

## Description
A collaborative task management system with teams, projects, and tasks.

## Core Features

### User Management
- User registration and authentication (Devise)
- Role-based authorization (admin, manager, member)
- User profiles with avatars

### Teams & Projects
- Create teams with multiple members
- Projects belong to teams
- Invite members via email

### Tasks
- Create tasks with title, description, due date
- Assign tasks to team members
- Task status workflow (todo → in_progress → review → done)
- Comments and attachments
- Real-time updates (Action Cable)

### Notifications
- Email notifications for assignments
- In-app notifications
- Daily digest emails

## Technical Requirements
- API-first design (JSON API)
- Background job processing
- File uploads to cloud storage
- Search functionality
- Mobile-responsive UI
```

#### Step 4: Generate Technical Plan
```bash
/speckit.plan
```

Spec Kit creates detailed Rails plan:
```markdown
# Technical Implementation Plan

## Tech Stack
- Ruby 3.3.9
- Rails 7.1+
- PostgreSQL 16
- Redis (Sidekiq, Action Cable, caching)
- AWS S3 (file storage)

## Gems
- devise (authentication)
- pundit (authorization)
- sidekiq (background jobs)
- active_storage (file uploads)
- searchkick + elasticsearch (search)
- kaminari (pagination)
- active_model_serializers (JSON API)

## Database Schema
```ruby
# Users table
create_table :users do |t|
  t.string :email, null: false, index: { unique: true }
  t.string :encrypted_password, null: false
  t.string :name
  t.integer :role, default: 0
  t.timestamps
end

# Teams table
create_table :teams do |t|
  t.string :name, null: false
  t.references :owner, foreign_key: { to_table: :users }
  t.timestamps
end

# Projects table
create_table :projects do |t|
  t.string :name, null: false
  t.text :description
  t.references :team, foreign_key: true
  t.timestamps
end

# Tasks table
create_table :tasks do |t|
  t.string :title, null: false
  t.text :description
  t.integer :status, default: 0
  t.date :due_date
  t.references :project, foreign_key: true
  t.references :assignee, foreign_key: { to_table: :users }
  t.timestamps
end
```

## Application Structure
```
app/
├── models/
│   ├── user.rb
│   ├── team.rb
│   ├── project.rb
│   └── task.rb
├── controllers/
│   ├── api/
│   │   └── v1/
│   │       ├── tasks_controller.rb
│   │       ├── projects_controller.rb
│   │       └── teams_controller.rb
│   └── application_controller.rb
├── services/
│   ├── task_creator.rb
│   ├── task_updater.rb
│   └── notification_sender.rb
├── policies/
│   ├── task_policy.rb
│   └── project_policy.rb
└── jobs/
    ├── notification_job.rb
    └── digest_email_job.rb
```

#### Step 5: Generate Task List
```bash
/speckit.tasks
```

Detailed implementation checklist:
```markdown
# Implementation Tasks

## Setup
- [ ] Create Rails app: `rails new my-rails-app --database=postgresql --skip-test`
- [ ] Add required gems to Gemfile
- [ ] Configure Redis connection
- [ ] Set up AWS S3 credentials

## Database
- [ ] Generate User model with Devise
- [ ] Create Team, Project, Task models
- [ ] Generate and run migrations
- [ ] Add database indexes
- [ ] Set up associations

## Authentication & Authorization
- [ ] Install and configure Devise
- [ ] Add Pundit policies
- [ ] Implement role-based permissions

## Core Features
- [ ] Implement TaskCreator service
- [ ] Build API controllers
- [ ] Add JSON serializers
- [ ] Set up Action Cable for real-time
- [ ] Configure Active Storage

## Background Jobs
- [ ] Set up Sidekiq
- [ ] Create NotificationJob
- [ ] Implement email mailers

## Testing
- [ ] Set up RSpec with FactoryBot
- [ ] Write model specs
- [ ] Write controller specs
- [ ] Write service object specs
- [ ] Add system tests

## Frontend
- [ ] Set up Tailwind CSS
- [ ] Build task board UI
- [ ] Add JavaScript interactions
- [ ] Implement WebSocket connections
```

#### Step 6: Implement Everything
```bash
/speckit.implement
```

AI generates complete Rails application:
- All models with associations
- Controllers with proper authorization
- Service objects for business logic
- Background jobs
- Tests with FactoryBot
- Views and frontend code

---

### Method 2: Add Feature to Existing Rails App

If you already have a Rails app, use Spec Kit to add new features:

```bash
cd existing-rails-app

# Initialize Spec Kit in existing project
specify init . --ai claude

# Define new feature
/speckit.specify
# Example: "Add two-factor authentication to existing user system"

# Plan the implementation
/speckit.plan
# Reviews existing code, suggests integration approach

# Generate tasks
/speckit.tasks
# Lists modifications needed

# Implement
/speckit.implement
# Adds new code without breaking existing features
```

---

## Starting Python Projects

### Method 1: Standard Python Application

#### Step 1: Initialize Project
```bash
# Create Python project with Claude Code
specify init my-python-app --ai claude
cd my-python-app
```

#### Step 2: Define Python Constitution
```bash
/speckit.constitution
```

Example Python constitution:
```markdown
# Python Project Constitution

## Code Standards
1. Python 3.10+ required
2. Follow PEP 8 style guide
3. Type hints for all functions (mypy strict mode)
4. Docstrings in Google format

## Project Structure
- Use Poetry for dependency management
- src/ layout for application code
- tests/ with pytest
- 100% test coverage goal

## Quality Tools
- black (formatting)
- ruff (linting)
- mypy (type checking)
- pytest (testing)
- coverage.py (coverage reports)

## Dependencies
- Prefer standard library
- Pin dependency versions
- Regular security audits
```

#### Step 3: Specify Application
```bash
/speckit.specify
```

Example Python app specification:
```markdown
# Project: CLI Tool for API Testing

## Description
Command-line tool to test REST APIs with various HTTP methods,
authentication, and response validation.

## Features

### HTTP Requests
- Support GET, POST, PUT, PATCH, DELETE methods
- Custom headers and query parameters
- Request body (JSON, form data, multipart)
- File uploads

### Authentication
- Basic auth
- Bearer tokens
- API keys
- OAuth 2.0

### Response Validation
- Status code assertions
- JSON schema validation
- Response time tracking
- Save responses to file

### Output Formats
- Colorized terminal output
- JSON output for scripting
- Detailed verbose mode
- Summary statistics

## Usage Example
```bash
api-test get https://api.example.com/users \
  --header "Authorization: Bearer TOKEN" \
  --expect-status 200 \
  --validate-schema user-schema.json
```

#### Step 4: Generate Plan
```bash
/speckit.plan
```

Technical plan created:
```markdown
# Implementation Plan

## Project Structure
```
my-python-app/
├── pyproject.toml
├── src/
│   └── api_test/
│       ├── __init__.py
│       ├── cli.py          # Click CLI interface
│       ├── client.py       # HTTP client (httpx)
│       ├── auth.py         # Authentication handlers
│       ├── validators.py   # Response validation
│       └── formatters.py   # Output formatting
├── tests/
│   ├── test_cli.py
│   ├── test_client.py
│   └── fixtures/
└── README.md
```

## Dependencies
- click (CLI framework)
- httpx (async HTTP client)
- rich (terminal formatting)
- jsonschema (validation)
- pydantic (data models)

## Architecture
- Use Click for CLI argument parsing
- Async HTTP requests with httpx
- Rich for colored output
- Pydantic models for configuration
```

#### Step 5: Tasks & Implementation
```bash
/speckit.tasks
/speckit.implement
```

Generates complete Python application with:
- Poetry/pip configuration
- CLI with Click
- Async HTTP client
- Full pytest test suite
- Type hints throughout
- Documentation

---

### Method 2: Python Package/Library

#### Create Python Package
```bash
# Initialize package project
specify init awesome-python-lib --ai claude
cd awesome-python-lib

/speckit.constitution
# Define package standards: versioning, API stability, Python versions

/speckit.specify
# Define package purpose, API design, usage examples

/speckit.plan
# Architecture, dependencies, build system (Poetry/setuptools)

/speckit.tasks
/speckit.implement
```

Generated package structure:
```
awesome-python-lib/
├── pyproject.toml
├── README.md
├── LICENSE
├── src/
│   └── awesome_lib/
│       ├── __init__.py
│       ├── __version__.py
│       ├── core.py
│       └── utils.py
├── tests/
│   ├── __init__.py
│   ├── test_core.py
│   └── test_utils.py
├── docs/
│   ├── conf.py
│   └── index.md
└── .github/
    └── workflows/
        └── ci.yml
```

---

### Method 3: Python Web Application (Django/Flask)

#### Django Project Example
```bash
specify init django-blog --ai claude
cd django-blog

/speckit.constitution
```

Django constitution:
```markdown
# Django Project Constitution

## Framework
- Django 5.0+
- Python 3.11+
- PostgreSQL database

## Architecture
- Class-based views preferred
- Django REST Framework for APIs
- Celery for async tasks
- Django templates with HTMX

## Apps Structure
- One app per major feature
- Keep apps reusable
- Use Django's built-in features first

## Testing
- pytest-django
- Factory Boy for fixtures
- Coverage >90%
```

```bash
/speckit.specify
# Specify blog features: posts, comments, categories, search, etc.

/speckit.plan
# Django apps layout, models, views, URLs

/speckit.tasks
/speckit.implement
# Generates full Django project
```

#### Flask Project Example
```bash
specify init flask-api --ai claude
cd flask-api

/speckit.constitution
```

Flask constitution:
```markdown
# Flask API Constitution

## Framework
- Flask 3.0+
- Flask-SQLAlchemy (ORM)
- Flask-Migrate (migrations)
- Flask-JWT-Extended (auth)

## Architecture
- Application factory pattern
- Blueprints for routing
- Marshmallow for serialization
- RESTful API design

## Structure
```python
app/
├── __init__.py      # App factory
├── models/
├── routes/
├── schemas/
└── services/
```

```bash
/speckit.specify
# API endpoints, authentication, database models

/speckit.plan
# Flask app structure, extensions, database schema

/speckit.tasks
/speckit.implement
```

---

## Neovim Integration

### Setting Up Spec Kit with Claude Code in Neovim

Since your Neovim config already uses Claude Code (via AI tools), Spec Kit slash commands work natively!

#### Method 1: Use Slash Commands in Chat

1. **Open AI chat interface** (depends on your plugin):
   ```vim
   :CopilotChat
   " Or whatever AI chat plugin you use
   ```

2. **Use Spec Kit commands directly**:
   ```
   /speckit.constitution
   /speckit.specify
   /speckit.plan
   /speckit.tasks
   /speckit.implement
   ```

#### Method 2: Custom Neovim Keybindings

Add these to `lua/mappings.lua`:

```lua
-- Spec Kit keybindings
local map = vim.keymap.set

-- Spec Kit workflow shortcuts
map("n", "<leader>sc", function()
  -- Open AI chat and insert /speckit.constitution
  vim.cmd("CopilotChat")
  vim.api.nvim_feedkeys("/speckit.constitution", "n", false)
end, { desc = "Spec Kit: Constitution" })

map("n", "<leader>ss", function()
  vim.cmd("CopilotChat")
  vim.api.nvim_feedkeys("/speckit.specify", "n", false)
end, { desc = "Spec Kit: Specify" })

map("n", "<leader>sp", function()
  vim.cmd("CopilotChat")
  vim.api.nvim_feedkeys("/speckit.plan", "n", false)
end, { desc = "Spec Kit: Plan" })

map("n", "<leader>st", function()
  vim.cmd("CopilotChat")
  vim.api.nvim_feedkeys("/speckit.tasks", "n", false)
end, { desc = "Spec Kit: Tasks" })

map("n", "<leader>si", function()
  vim.cmd("CopilotChat")
  vim.api.nvim_feedkeys("/speckit.implement", "n", false)
end, { desc = "Spec Kit: Implement" })

-- Quick access to spec files
map("n", "<leader>sC", ":e .speckit/constitution.md<CR>", { desc = "Edit Constitution" })
map("n", "<leader>sS", ":e .speckit/specification.md<CR>", { desc = "Edit Specification" })
map("n", "<leader>sP", ":e .speckit/plan.md<CR>", { desc = "Edit Plan" })
map("n", "<leader>sT", ":e .speckit/tasks.md<CR>", { desc = "Edit Tasks" })
```

#### Method 3: Telescope Integration

Add Spec Kit file picker to `lua/plugins/init.lua`:

```lua
{
  "nvim-telescope/telescope.nvim",
  opts = function()
    local conf = require "nvchad.configs.telescope"

    -- Add Spec Kit picker
    conf.pickers = {
      speckit = {
        find_files = {
          cwd = ".speckit",
          prompt_title = "Spec Kit Files",
        },
      },
    }

    return conf
  end,
}
```

Add keybinding:
```lua
map("n", "<leader>sk", ":Telescope find_files cwd=.speckit<CR>",
  { desc = "Find Spec Kit files" })
```

#### Method 4: Auto-Commands for Spec Files

Auto-format and validate Spec Kit markdown files in `lua/autocmds.lua`:

```lua
-- Spec Kit file detection
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { ".speckit/*.md" },
  callback = function()
    -- Set buffer options for Spec Kit files
    vim.bo.filetype = "markdown"
    vim.bo.textwidth = 80
    vim.wo.wrap = true
    vim.wo.linebreak = true

    -- Enable spell checking
    vim.wo.spell = true
    vim.bo.spelllang = "en_us"

    -- Add buffer-local keymaps
    local map = vim.keymap.set
    local opts = { buffer = true, silent = true }

    map("n", "<leader>sr", ":!specify refresh<CR>",
      vim.tbl_extend("force", opts, { desc = "Refresh Spec Kit" }))
  end,
})

-- Auto-save Spec Kit files
vim.api.nvim_create_autocmd("TextChanged", {
  pattern = { ".speckit/*.md" },
  callback = function()
    vim.cmd("silent! write")
  end,
})
```

#### Method 5: Status Line Integration

Show current Spec Kit phase in status line (add to `lua/chadrc.lua`):

```lua
local function speckit_status()
  local cwd = vim.fn.getcwd()
  local speckit_dir = cwd .. "/.speckit"

  if vim.fn.isdirectory(speckit_dir) == 0 then
    return ""
  end

  -- Check which files exist to determine phase
  local files = {
    { file = "constitution.md", icon = "󰈙", label = "CONST" },
    { file = "specification.md", icon = "", label = "SPEC" },
    { file = "plan.md", icon = "", label = "PLAN" },
    { file = "tasks.md", icon = "", label = "TASKS" },
  }

  local status = "󰓅 SpecKit:"
  for _, item in ipairs(files) do
    if vim.fn.filereadable(speckit_dir .. "/" .. item.file) == 1 then
      status = status .. " " .. item.icon
    end
  end

  return status
end

-- Add to your statusline config
M.ui = {
  statusline = {
    theme = "default",
    separator_style = "default",
    overriden_modules = function(modules)
      table.insert(modules, 9, speckit_status())
    end,
  },
}
```

#### Method 6: Easypick Integration for Spec Kit

Add to `lua/plugins/ai.lua` (with your existing Easypick config):

```lua
{
  "axkirillov/easypick.nvim",
  dependencies = "nvim-telescope/telescope.nvim",
  config = function()
    local easypick = require("easypick")

    easypick.setup({
      pickers = {
        -- Your existing Aider picker
        {
          name = "aider",
          command = "aider",
          opts = require("easypick").opts.default,
        },

        -- Add Spec Kit picker
        {
          name = "speckit_init",
          command = "specify init",
          action = easypick.actions.nvim_command_file,
          opts = {
            prompt_title = "Initialize Spec Kit Project",
          },
        },
        {
          name = "speckit_files",
          command = "find .speckit -type f -name '*.md' 2>/dev/null",
          action = easypick.actions.nvim_edit_file,
          opts = {
            prompt_title = "Spec Kit Files",
          },
        },
      },
    })
  end,
}
```

Add keybindings:
```lua
map("n", "<leader>sK", ":Easypick speckit_files<CR>",
  { desc = "Pick Spec Kit file" })
map("n", "<leader>sI", ":Easypick speckit_init<CR>",
  { desc = "Init Spec Kit project" })
```

#### Method 7: Which-Key Integration

Register Spec Kit mappings with which-key for better discovery:

Add to `lua/plugins/init.lua` or create new file:

```lua
{
  "folke/which-key.nvim",
  config = function()
    local wk = require("which-key")

    wk.register({
      s = {
        name = "Spec Kit",
        c = { "Constitution" },
        s = { "Specify" },
        p = { "Plan" },
        t = { "Tasks" },
        i = { "Implement" },
        C = { "Edit Constitution" },
        S = { "Edit Specification" },
        P = { "Edit Plan" },
        T = { "Edit Tasks" },
        k = { "Find Spec Kit files" },
        r = { "Refresh Spec Kit" },
        I = { "Initialize Spec Kit" },
        K = { "Pick Spec Kit file" },
      },
    }, { prefix = "<leader>" })
  end,
}
```

---

## Workflow Overview

### Complete Spec-Driven Development Cycle

```
┌─────────────────────────────────────────────────────┐
│  1. CONSTITUTION                                    │
│  Define project principles and standards            │
│  Command: /speckit.constitution                     │
│  Output: .speckit/constitution.md                   │
└────────────────┬────────────────────────────────────┘
                 │
                 ▼
┌─────────────────────────────────────────────────────┐
│  2. SPECIFY                                         │
│  Describe features and requirements                 │
│  Command: /speckit.specify                          │
│  Output: .speckit/specification.md                  │
└────────────────┬────────────────────────────────────┘
                 │
                 ▼
┌─────────────────────────────────────────────────────┐
│  3. CLARIFY (Optional)                              │
│  Resolve ambiguities in specification               │
│  Command: /speckit.clarify                          │
│  Output: Updates to specification.md                │
└────────────────┬────────────────────────────────────┘
                 │
                 ▼
┌─────────────────────────────────────────────────────┐
│  4. PLAN                                            │
│  Create technical implementation strategy           │
│  Command: /speckit.plan                             │
│  Output: .speckit/plan.md                           │
└────────────────┬────────────────────────────────────┘
                 │
                 ▼
┌─────────────────────────────────────────────────────┐
│  5. TASKS                                           │
│  Generate actionable checklist                      │
│  Command: /speckit.tasks                            │
│  Output: .speckit/tasks.md                          │
└────────────────┬────────────────────────────────────┘
                 │
                 ▼
┌─────────────────────────────────────────────────────┐
│  6. IMPLEMENT                                       │
│  AI generates code from specs                       │
│  Command: /speckit.implement                        │
│  Output: Working application code                   │
└─────────────────────────────────────────────────────┘
```

### Iterative Development

After initial implementation:

1. **Add new features**: Update `specification.md` → `/speckit.plan` → `/speckit.implement`
2. **Refactor**: Update `constitution.md` → `/speckit.analyze` → refactor
3. **Fix issues**: Add to `tasks.md` → `/speckit.implement`

---

## Advanced Usage

### Multi-Language Projects

For projects with multiple languages (e.g., Rails API + Python ML service):

```bash
# Initialize with primary language
specify init my-fullstack-app --ai claude

# In constitution, specify multi-language structure
/speckit.constitution
```

```markdown
# Multi-Language Project Constitution

## Languages
- Ruby on Rails (API backend)
- Python (ML service)
- TypeScript (Frontend)

## Project Structure
```
my-fullstack-app/
├── backend/          # Rails API
├── ml-service/       # Python ML
├── frontend/         # React/TypeScript
└── .speckit/         # Shared specs
```

## Integration
- gRPC for Rails ↔ Python communication
- REST API for frontend ↔ backend
- Shared OpenAPI specification
```

### Team Collaboration

Commit `.speckit/` directory to version control:

```bash
git add .speckit/
git commit -m "Add project specifications"
```

Team members can:
1. Read specs to understand project goals
2. Suggest changes via PRs to spec files
3. Use `/speckit.implement` to regenerate code consistently

### CI/CD Integration

Add validation to CI pipeline:

```yaml
# .github/workflows/speckit-validate.yml
name: Validate Spec Kit

on: [push, pull_request]

jobs:
  validate:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Install uv
        run: curl -LsSf https://astral.sh/uv/install.sh | sh

      - name: Install Spec Kit
        run: uv tool install specify-cli --from git+https://github.com/github/spec-kit.git

      - name: Validate specifications
        run: specify validate

      - name: Check consistency
        run: specify analyze
```

### Custom Slash Commands

Create project-specific commands in `.speckit/commands/`:

```bash
mkdir -p .speckit/commands

cat > .speckit/commands/deploy.md << 'EOF'
# Custom Command: Deploy

Review the current implementation against the specification and plan,
then generate deployment configuration (Dockerfile, docker-compose.yml,
Kubernetes manifests) following the project constitution.

Ensure:
- Environment variables documented
- Health checks configured
- Logging and monitoring set up
- Security best practices followed
EOF
```

Use with: `/speckit.commands.deploy`

### Spec Kit with Existing Test Runners

#### Rails + RSpec Integration

After `/speckit.implement`, run tests:

```bash
# Using your existing RSpec setup
<leader>tS  # Run full suite (rspec-integrated.nvim)

# Or Neotest
<leader>ts  # Toggle test summary
```

Spec Kit generates tests automatically, but you can iterate:

```bash
# If tests fail, update specification and regenerate
vim .speckit/specification.md
# Add: "Ensure all edge cases are handled"

/speckit.tasks
/speckit.implement
```

#### Python + Pytest Integration

```bash
# After spec-kit generates code
pytest

# If coverage is low
vim .speckit/constitution.md
# Update: "Test coverage must be 100%"

/speckit.implement
# Regenerates with more comprehensive tests
```

---

## Tips & Best Practices

### 1. Write Clear Specifications
- Focus on "what" and "why", not "how"
- Include examples and use cases
- Define success criteria explicitly

### 2. Leverage Constitution
- Document non-negotiable principles early
- Include testing/quality standards
- Reference style guides and conventions

### 3. Iterate Gradually
- Start with small features
- Test generated code thoroughly
- Refine specs based on results

### 4. Review Generated Code
- AI is powerful but not perfect
- Always review implementations
- Adjust specs if output isn't right

### 5. Version Control Everything
- Commit all `.speckit/` files
- Track changes to specs over time
- Use PRs for specification changes

### 6. Use Analyze Command
- Run `/speckit.analyze` periodically
- Ensures specs, plan, and code align
- Catches inconsistencies early

### 7. Document Deviations
If you manually change generated code, update specs:
```bash
# After manual code change
vim .speckit/specification.md
# Document why manual change was needed

/speckit.analyze
# Verify everything still aligns
```

---

## Troubleshooting

### Issue: "specify command not found"

**Solution**: Install with uv:
```bash
uv tool install specify-cli --from git+https://github.com/github/spec-kit.git
```

### Issue: Slash commands not working in Neovim

**Solution**: Ensure AI agent supports slash commands. Claude Code supports them natively.

### Issue: Generated code doesn't match expectations

**Solution**:
1. Refine `.speckit/specification.md` with more details
2. Update `.speckit/constitution.md` with specific requirements
3. Run `/speckit.clarify` to resolve ambiguities
4. Regenerate with `/speckit.implement`

### Issue: Can't initialize in existing project

**Solution**: Run `specify init . --ai claude` (note the dot for current directory)

### Issue: Tests failing after generation

**Solution**:
1. Check `.speckit/constitution.md` testing standards
2. Update specification with missing test cases
3. Run `/speckit.tasks` to see what was implemented
4. Regenerate specific components: "/speckit.implement tests only"

---

## Quick Reference

### Spec Kit Commands
| Command | Purpose | Output |
|---------|---------|--------|
| `/speckit.constitution` | Define project principles | `.speckit/constitution.md` |
| `/speckit.specify` | Describe requirements | `.speckit/specification.md` |
| `/speckit.clarify` | Resolve ambiguities | Updates specs |
| `/speckit.plan` | Create technical plan | `.speckit/plan.md` |
| `/speckit.tasks` | Generate task list | `.speckit/tasks.md` |
| `/speckit.implement` | Generate code | Application code |
| `/speckit.analyze` | Check consistency | Analysis report |
| `/speckit.checklist` | Quality validation | QA checklist |

### Neovim Keybindings (if configured)
| Key | Action |
|-----|--------|
| `<leader>sc` | Start constitution |
| `<leader>ss` | Start specification |
| `<leader>sp` | Start planning |
| `<leader>st` | Generate tasks |
| `<leader>si` | Implement |
| `<leader>sC` | Edit constitution.md |
| `<leader>sS` | Edit specification.md |
| `<leader>sP` | Edit plan.md |
| `<leader>sT` | Edit tasks.md |
| `<leader>sk` | Find spec files (Telescope) |

### CLI Commands
```bash
# Initialize project
specify init <project> --ai claude

# Validate specs
specify validate

# Analyze consistency
specify analyze

# Update Spec Kit
uv tool upgrade specify-cli
```

---

## Resources

- **Spec Kit GitHub**: https://github.com/github/spec-kit
- **Official Docs**: https://speckit.org/
- **Tutorial**: https://github.blog/ai-and-ml/generative-ai/spec-driven-development-with-ai-get-started-with-a-new-open-source-toolkit/
- **uv Installer**: https://astral.sh/uv

---

## Summary

Spec Kit revolutionizes development by making specifications executable:

1. **Write what you want** (not how to build it)
2. **AI generates implementation** (following your standards)
3. **Iterate quickly** (update specs, regenerate code)
4. **Works with any language** (Ruby, Rails, Python, etc.)
5. **Integrates with Neovim** (use Claude Code natively)

Get started:
```bash
uv tool install specify-cli --from git+https://github.com/github/spec-kit.git
specify init my-project --ai claude
cd my-project
# Start spec-driven development!
```
