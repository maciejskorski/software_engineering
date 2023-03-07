# Class 2: Advanced Debugging

## Development in Cloud

Recently [GitHub launched cloud-powered developent environments](https://github.com/features/codespaces) called Codespaces.
The environment can be created for every repo and is available as a `Codespaces` tab under the green button `Code`. 
![start Codespaces](figures/start_codespaces.png)

The environment, once built, looks like in the figure below (resembling VS Code).

![built Codespaces](figures/built_codespaces.png)

## Static Code Analysis: Fixing Machine-Learning Repo (Case Study)

We will use static code analysis to fix reproducibility problems of an [implementation from a major NLP conference](https://aclanthology.org/2020.emnlp-main.135.PDF). 
Note: the instruction below assume the use of VS Code locally / Codespaces remote, but you may adapt it to an IDE of your choice.

Fork `https://github.com/maciejskorski/Cluster-Analysis` and open in `Codespaces`. Create and activate a virtual environment in the repo root directory: 
```bash
python -m venv .venv
source .venv/bin/activate
```
Select this version `.venv/bin/python` as the active Python interpreter in the code editor.

Check `settings.json` of the editor to ensure that [Python linters](https://code.visualstudio.com/docs/python/linting) are enabled.
Open the main file: `code/score.py`, you should see about 100 problems reported by Python linters.

![linter report](figures/linter_report.png)

Some issues are opinionated (formatting), some are breaking (missing imports in view of no install instructions).
You can also run `pylint --errors-only --recursive=y code` to scan the whole code base.

Fix the reposity only up to the point when the basic call runs:
```bash 
python code/score.py --clustering_algo KMeans --entities word2vec --vocab vocab.txt
```

Try to *fix critical issues* by adding missing packages to the environment with `pip install <missing_package>`.
```{note}
To avoid out-of-memory issues, consider the following optimizations:
* comment out huge modules not used for this call, such as `tensorflow` or `fasttext` 
* adapt the code to work with [a smaller GoogleNews model](https://github.com/eyaler/word2vec-slim/raw/master/GoogleNews-vectors-negative300-SLIM.bin.gz)
```
For meaningful results, store an English dictionary in `vocab.txt` (for instance, copy the content of `/usr/share/dict/words`).

Once the command runs successfuly, you should see the output similar to
```bash
-0.3393 interface systems software devices hardware device technology components adapter computer
-0.57277 guess suppose thought damn stupid thinking yeah thing anymore afraid
-0.2009 wanted attempting unable hoping failed decided intended needed forced supposed
-0.4871 specific larger actual significant limited additional smaller multiple similar major
-0.74313 services operations business management agency organization service development company communications
-0.55365 discussion comments answers responses conclusions questions answer explanation suggestions recommendations
-0.40731 means simply reasoning implies context necessarily logic meaning sense essence
-0.14021 game play games season score playing league played team match
-0.76696 turned brought moved stuck thrown left leaving coming arrived caught
-0.39309 government religious religion democracy society political morality religions military citizens
-0.33467 children mother parents child kids patients doctor family father people
-0.34227 good great easy nice difficult decent perfect tough important excellent
-0.12439 give bring provide make accept find apply ignore obtain choose
-0.45445 inside front side line corner back wall edge rear angle
-0.8108 noted acknowledged suggested mentioned cited revealed stated referred confirmed presented
-0.65448 divine eternal evil humanity heaven gods soul lord scriptures scripture
-0.52838 north area south east west town city highway southern northern
-0.60428 costs rates prices rate cost price increases increase higher demand
0.10042 pages text copy page document articles read books quote book
-0.14741 month week months weeks year days years million earlier time
NPMI:-0.42526
NPMI Mean:-0.46147
NPMI Var:0.00123
```

Use `pip freeze > requirements.txt` to export requirements. 
Commit this file and changes to the source code. Congrats!

## Debugging CircleCI with SSH

Add a "build-test" job to the above reposiroty using [CircleCI jobs](https://circleci.com/docs/language-python/). Connect this job to a [CircleCI account](https://app.circleci.com/).

![circleci](figures/circleci.png)

The job should install dependencies and run a minimal model (downloading binaries when necessary).

Enter the CircleCI environment via SSH, try to connect with IDE.


## More examples

Check out this [implementation of ML models used in weather forecast](https://github.com/jieyu97/mvpp).
Run the Python linter. What errors/bugs have you spot?

TBD: more examples
