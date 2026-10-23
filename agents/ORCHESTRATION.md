# Agent Orchestration Policy

## Core Principle

Default to a single agent.

Use subagents only when delegation provides a clear benefit in execution time, context isolation, or task quality that justifies the additional token consumption and coordination overhead.

## Delegation Decision

Before spawning subagents, evaluate:

1. **Complexity:** Does the task require multiple independent areas of expertise or substantial investigation?
2. **Independence:** Can the work be completed without frequent coordination or shared file modifications?
3. **Parallelism:** Can independent tasks execute concurrently and reduce overall completion time?
4. **Context isolation:** Would a separate context prevent unnecessary information from accumulating in the main agent?
5. **Cost:** Is the expected benefit worth the additional tokens and orchestration overhead?

Delegate only when at least one substantial benefit exists and the expected benefit outweighs the cost.

## When NOT to Delegate

- Small bug fixes or straightforward implementations.
- Simple CRUD operations.
- Minor refactoring within a single module.
- Documentation or configuration changes with limited scope.
- Tasks requiring frequent synchronization.
- Tasks where delegation would duplicate significant context.

## Delegation Rules

- Prefer one agent for small and medium tasks.
- Start with a maximum of 2 subagents when delegation is justified.
- Use additional subagents only when there is a clear, measurable benefit.
- Prefer read-only delegation for research, code review, and analysis.
- Avoid concurrent modifications to the same files.
- Do not create subagents merely to assign artificial roles.
- Do not delegate recursively unless explicitly requested.

## Execution Strategy

1. Analyze the task using the main agent.
2. Determine whether delegation is justified.
3. If not justified, execute directly.
4. If justified, define independent scopes and expected outputs.
5. Execute independent work in parallel when beneficial.
6. Integrate and validate the results using the main agent.

## Token Efficiency

- Minimize duplicated context across agents.
- Provide each subagent only the context necessary for its task.
- Prefer concise findings over verbose reports.
- Avoid redundant investigations.
- Reuse existing project documentation and test results.
- Do not spawn agents for work the main agent can complete efficiently.

## Reporting

At completion, report:
- Whether subagents were used.
- Why delegation was or was not justified.
- Number of subagents spawned.
- Tests and validation performed.

Do not produce lengthy orchestration reports unless requested.
