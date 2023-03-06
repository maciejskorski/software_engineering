# Class 2: Advanced Debugging

## Development in Cloud

Recently [GitHub lunched cloud-powered developent environments](https://github.com/features/codespaces) called Codespaces.
The environment can be created for every repo and is available as a `Codespaces` tab under the green button `Code`. 
![start Codespaces](figures/start_codespaces.png)

The environment, once built, looks like in the figure below (resembling VS Code).

![built Codespaces](figures/built_codespaces.png)

## Static Code Analysis: Fixing Machine-Learning Repo (Case Study)

We will use static code analysis to fix reproducibility problems of an [implementation from a major NLP conference](https://aclanthology.org/2020.emnlp-main.135.PDF). 
Note: the instruction below assume the use of VS Code locally / Codespaces remote, but you may adapt it to an IDE of your choice.

Fork `https://github.com/maciejskorski/Cluster-Analysis` and open in `Codespaces`. Create a virtual environment in the repo root directory, by `python -m venv .venv` and activate with `source .venv/bin/activate`. Select this version `.venv/bin/python` as the active Python interpreter.

Check `settings.json` of the editor to ensure that [Python linters](https://code.visualstudio.com/docs/python/linting) are enabled.
Open the main file: `code/score.py`, you should see about 100 problems reported by Python linters.

![linter report](figures/linter_report.png)

Some issues are opinionated (formatting), some are breaking (missing imports in view of no install instructions).
You can also run `pylint --errors-only --recursive=y code` to scan the whole code base.

We consider the repository fixed once the basic call `python code/score.py --clustering_algo KMeans --entities word2vec --vocab vocab.txt` runs.

Try to *fix critical issues* by adding missing packages to the environment with `pip install <missing_package>`.
Comment out huge modules not used for this call, such as `tensorflow` or `fasttext` (to avoid out-of-memory). 
Once the command runs, use `pip freeze > requirements.txt` to export requirements.




## More examples

Check out this [implementation of ML models used in weather forecast](https://github.com/jieyu97/mvpp).
Run the Python linter. What errors/bugs have you spot?

TBD: more examples
