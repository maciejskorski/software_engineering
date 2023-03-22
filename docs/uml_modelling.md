# Class 5: Modelling with UML diagrams

UML diagrams can be created by many tools. Those into graphic design may like drawing tools like [diagrams.net](https://www.diagrams.net/), 
while developers should appreciate *diagrams created from markup descriptions* via [PlantUML](https://plantuml.com/) or [Mermaid](https://mermaid.js.org/).
It is worth looking into examples shared online, see in particular https://real-world-plantuml.com/ or https://www.planttext.com/.
For more on UML modelling, see dedicated courses like [here](https://nus-cs2103-ay1718s2.github.io/website/book/uml/).

## Example: GitHub Game

As an exmple, let's model an educational game which challenges users with questions about coding practices based on Github repositories.

With the PlantUML code snippet shown below

```
@startuml
autonumber

actor User as user
participant "Application" as app
participant "GitHub" as github

loop until user ends
    user -> app: challenge request
    app -> github: sample a repo
    github -> app: return the repo information
    app -> user: puzzle
    note left of app: question about filetypes/locations
    user -> app: answer
    app -> user: evaluation
end 
@enduml
```
we create the following sequence diagram ([test it live here](http://www.plantuml.com/)):

![GitHub educational game](http://www.plantuml.com/plantuml/proxy?cache=no&src=https://raw.githubusercontent.com/maciejskorski/software_engineering/main/docs/figures/diagrams/game_github.iuml)

A very similar diagram is created by Mermaid, with slightly different syntax  ([test it live here](https://mermaid.live/)).
```
    autonumber

    actor user as User
    participant app as Application
    participant github as GitHub

    loop until user ends
        user ->> app: challenge request
        app ->> github: sample a repo
        github ->> app: return the repo information
        app ->> user: puzzle
        note left of app: question about filetypes/locations
        user ->> app: answer
        app ->> user: evaluation
    end
```
which renders as follows

![GitHub educational game](https://mermaid.live/edit#pako:eNp1UsFqwzAM_RXhc8fuORQGg-0-dstFcZTE4MieLW20pf8-O2mWQplO5r3H05Pki7GhJ9OYTF9KbOnV4ZhwbhlKoUpgnTtKLd8QKyGBZkqAGT5zZSoeMYmzLiILYIyVfInRO4viAj9qRieTdlX25uRdu83fhxBBWZxfmxD3eWVqLdDT8VhbNGAn9J54JEg1fJZdWCNU3dqmgYxz9ARYlDHssluKP8dEoolBJlqE4HgIab4b4d67hmkg6vnsaWc5CIGnQSAMq-kSrTgAdkEFBudJTpHysw_rdv4dEDn_bAt-7Ezf6PUuW1mVOZiZSmDXl4teKtyaMsxMrWnKs6cB1UtrWr4Wab3ux4mtaSQpHYzGHmX7ACt4_QUfk7MV)
