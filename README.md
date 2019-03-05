[![Circle CI](https://circleci.com/gh/caerusassociates/hypnos.svg?style=svg)](https://circleci.com/gh/caerusassociates/hypnos)
[![Code Health](https://landscape.io/github/openeventdata/hypnos/petrarch2/landscape.svg?style=flat)](https://landscape.io/github/openeventdata/hypnos/petrarch2)

hypnos
======

**Update 20190305: Revert PETRARCH Version to 1, to make example work**

当前示例程序不正常，为确保可用，还原成为Petrarch 1。此外，合并了petrarch与Web服务，在一个docker镜像中执行。


**Note: hypnos now works with PETRARCH2 by default.**

A RESTful API around the [PETRARCH2](https://github.com/openeventdata/petrarch2)
event data coder. Using `docker compose`, this setup also integrates the 
Stanford [CoreNLP](http://nlp.stanford.edu/software/corenlp.shtml) parser
using Casey Hilland's [docker container](https://github.com/chilland/ccNLP).
This setup allows the users to stream texts into the API, rather than the 
batch mode seen in applications such as the [Phoenix pipeline](https://github.com/openeventdata/phoenix_pipeline).

This software was developed by Caerus Associates and donated to the Open Event
Data Alliance.

Running
-------

Running the system is as simple as `cd`ing into the `hypnos` directory and using

`docker-compose up`

or 

`docker-compose up -d`

to run in the background.

This assumes that you have `docker-compose` and `docker` installed.

Example Python Usage
-----

```
import requests
import json

headers = {'Content-Type': 'application/json'}
data = {'text': "At least 37 people are dead after Islamist radical group Boko Haram assaulted a town in northeastern Nigeria.", 'id': 'abc123', 'date':
'20010101'}
data = json.dumps(data)
r = requests.get('http://localhost:5002/hypnos/extract', data=data,
                 headers=headers)
r.json()
```

Returns:

```
{u'abc123': {u'meta': {u'date': u'20010101'},
  u'sents': {u'0': {u'content': u'At least 37 people are dead after Islamist
  radical group Boko Haram assaulted a town in northeastern Nigeria .',
      u'events': [[u'NGAREBMUS', u'NGA', u'190']],
          u'issues': [[u'ID_EXTREMISM', 1], [u'NAMED_TERROR_GROUP', 1]],
              u'parsed': u'(ROOT (S (NP (QP (IN AT ) (JJS LEAST ) (CD 37 ) )
              (NNS PEOPLE ) ) (VP (VBP ARE ) (ADJP (JJ DEAD ) ) (SBAR (IN AFTER
              ) (S (NP (JJ ISLAMIST ) (JJ RADICAL ) (NN GROUP ) (NNP BOKO )
              (NNP HARAM ) ) (VP (VBD ASSAULTED ) (NP (NP (DT A ) (NN TOWN ) )
              (PP (IN IN ) (NP (JJ NORTHEASTERN ) (NNP NIGERIA ) ) ) ) ) ) ) )
              (. . ) ) )'}}}}
```
