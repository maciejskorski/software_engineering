# Class 4: Software project management

Jira (also in its free plan) allows teams to organise tasks in sprints, track and document the progress.

During this class we will create a backlog of tasks, assign them to team memebers and map to sprints.

## User stories

```{note}
[Stories/tasks should occupy one sprint](https://community.atlassian.com/t5/Jira-Software-questions/Jira-Roadmaps-how-to-extend-stories-across-multiple-sprints/qaq-p/1793636).
```

What makes a good story is well-expressed by the [INVEST](https://www.agilealliance.org/glossary/invest/) acronym: a story is *I*ndependent, *N*egotiable, *V*aluable, *E*stimable, *S*mall and *T*estable.

The common pattern of a story is:
>As a {role} I need {functionality} so that {benefit}`.

For example:

> As a teaching assitance I need to prepare good materials so that I help my students to pass exams.

## Configuring Jira

See this roadmap with tasks mapped to sprints:

![planned_tasks](figures/class_harmonogram.png)

Jira offers a lot of configurable features. Under the project settings you can enable reporting modules, adjust notifications, and so on.

![configuring_jira](figures/Jira_configuration.png)

## Git Workflow

The recommended collaborative work strategy is to follow [github flow](https://docs.github.com/en/get-started/quickstart/github-flow).

Roughly speaking, developers *work on tasks in dedicated branches* and *integrate with main branch via reviewed pull requests*, once a feature or a bug fix is ready.

```{uml}
@startuml
start
:task;
:dedicated branch;
:code the feature;
:pull request;
repeat 
    :review;
    :address comments;
repeat while (approved?) is (no)
-> yes;
:merge into main;
stop
@enduml
```