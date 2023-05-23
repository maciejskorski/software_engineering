# Class 11: Code Profiling

In this class we will use code profiling to investigate problems with parallelization of NLP pipelines.

## Spacy NLP Pipeline 

Run the following snippet, comparing `n_process=1` versus `n_process=4`.
```python
import spacy
from spacy.tokens import Doc
from nltk.tokenize import TweetTokenizer

class MyTokenizer:

    def __init__(self, vocab):
        self.vocab = vocab
        self.rgx = TweetTokenizer().WORD_RE

    def __call__(self, text):
        words = self.rgx.findall(text)
        return Doc(self.vocab, words=words)

nlp = spacy.blank("en")
nlp.tokenizer = MyTokenizer(nlp.vocab)
doc = nlp("What's happened to me? he thought. It wasn't a dream.")
print([token.text for token in doc])

outs = ["What's happened to me? he thought. It wasn't a dream."]*100000

docs = nlp.pipe(outs,n_process=1,batch_size=10000)
docs = list(docs)
```

## Profilling tokenization

Use profiller to debug and understand the issue!
```python
import cProfile, pstats, io
from pstats import SortKey
import spacy

class MyTokenizer:

    def __init__(self, vocab):
        self.vocab = vocab
        self.rgx = TweetTokenizer().WORD_RE

    def __call__(self, text):
        words = self.rgx.findall(text)
        return Doc(self.vocab, words=words)

nlp = spacy.blank("en")
nlp.tokenizer = MyTokenizer(nlp.vocab)
texts = ["What's happened to me? he thought. It wasn't a dream."]*100000

def test_fn():
  docs = nlp.pipe(texts,n_process=2,batch_size=1000)
  docs = list(docs)


with cProfile.Profile() as pr:
  test_fn() # do something
  s = io.StringIO()
  sortby = SortKey.CUMULATIVE


stats = pstats.Stats(pr)
stats.sort_stats(pstats.SortKey.CUMULATIVE)
stats.print_stats()
```

```{note}
The code is also [availabe as a gist](https://colab.research.google.com/gist/maciejskorski/c8fb1b0d4470a1577be9d1610df4c348/profiling-parallel-spacy-tokenization.ipynb).
```