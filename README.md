Fathom
======

Welcome to Fathom.  Fathom is a library for building decision support tools.  Fathom is the kind of tool you'd want to use when you:

* want to build a reliable knowledge base for any kind of information
* need to simplify a complex problem
* have more data than a spreadsheet likes to use

About the Delay
===============

So, I haven't committed for a while.  You might be wondering, is David committed to getting this done?  I am.  The thing I found was that I was solving two problems, and wanted only one.  I was building a knowedge base at the same time as building an analytics toolset.  So, I've been busy daily getting Gearbox working, which I'll use in Fathom for managing a lot of these data.  So, I still wake up with ideas for Fathom, after all these years, and I've written a lot of them privately in little scratch projects here.  When I have Gearbox ready to capture the full richness of what I want to do, I'll come back and deliver a better Fathom than I originally thought was possible.

Stability Note
==============

I've recently refactored this library.  That makes the core Fathom quite stable, but much less useful.  The specific functionality (various databases, say, GSL support, various graphical model algorithms) will be in yet-to-be-released gems.  I'm going to stabilize these before releasing them to the public.

The gems I am actively working on are:

* fm-belief-network: a general gem for Bayesian inference
* fm-amalgalite-beliefs: a specific gem for Bayesian networks using SQLite3 and [Amalgalite](https://github.com/copiousfreetime/amalgalite)
* fm-goliath: A simple web service API using the wonderful network of gems associated with [Goliath](https://github.com/postrank-labs/goliath)

There are at least another dozen fm-* gems that live in some level of development.  These are gems like fm-redis-beliefs, fm-clinical-decision-support, and fm-apophenia.  I'll release these slowly and carefully as they go into production on real systems.  That helps keep me from getting ahead of myself.  If you're starting to see the power of how these tools can be used for your work, drop me a note and I could see if I can get your kind of analysis out in the Fathom set of gems.

Inspiration for the Project
===========================

The ideas for this gem are coming from a lot of places:

* Judea Pearl's work on causal graphs and belief networks.  See [Causality](http://www.amazon.com/Causality-Reasoning-Inference-Judea-Pearl/dp/052189560X/ref=sr_1_1?s=books&ie=UTF8&qid=1288840948&sr=1-1) and [Probabilistic Reasoning in Intelligent Systems](http://www.amazon.com/Probabilistic-Reasoning-Intelligent-Systems-Plausible/dp/1558604790/ref=ntt_at_ep_dpi_2)
* Douglas Hubbard's ideas on decision support.  See [How to Measure Anything](http://www.amazon.com/How-Measure-Anything-Intangibles-Business/dp/0470539399/ref=sr_1_1?ie=UTF8&qid=1288840870&sr=8-1)
* Ben Klemens' ideas on data analysis.  See [Modeling with Data](http://modelingwithdata.org/about_the_book.html)
* Daphne Koller and Nir Friedman's ideas on [Probabilistic Graphical Models](http://mitpress.mit.edu/catalog/item/default.asp?ttype=2&tid=11886)

Goals
=====

The goals of this project are:

* Build a decoupled library with Ruby and the GSL (currently optional)
* Make it easy to gather information of all types
* Add tools to analyze the integration of knowledge

Architecture
============

I've worked on this system for several years, rewriting it every once in a while.  It has taught me more about analysis and software architecture than any other endeavor of my life.  I've come to appreciate a few things in my work:

* Testing: I have thrown away a lot of hastily-written work that I could not come back and test properly.  It's hard enough to have solid software with solid tests, it's insane to work on this kind of software without testing.
* Modularity: I'm learning a style of development that loosely follows [DCI](http://en.wikipedia.org/wiki/Data,_Context_and_Interaction) philosophies.  I don't know if I've mastered these ideas, but it is a lot easier for me to have thin data models, contexts that support business goals, and interactions that can be well-monitored.
* Incremental Enhancement: It's nice when an idea can be expressed simply.  If I need to get more complicated, I can mix in more specific code, or require another gem.  In this way, I have Fathom that knows a little about graph algorithms, but fm-belief-networks that knows more about prior and posterior probabilities, conditional probability tables, and the workings of a Bayesian network.  I further enhance these ideas in fm-amalgalite-beliefs with specific implementations of this data, stored in SQLite tables for the flexibility and speed of set operations in this embedded system.  fm-redis-beliefs won't have the benefit of SQL for a query language, but will have the benefit of a federated key-value store for larger networks.

I probably could/should write a book someday about what I'm learning about architecture.  What this means for the practicing analyst is that we should have a fairly easy way of building models with tools that are appropriate to your problem.  There should be little coupling, and lot of graceful experimentation between various tools that are being produced.  

Contributing
============

If you'd like to contribute, you're welcome to do lots of things:

* fork a Fathom branch, write code with tests, and submit a merge request.
* write another fm-* gem that adds these tools with other tools you use.
* drop me a line and setup a pair programming session.  We can build some tools together and get you on your way quickly.

Copyright
---------

* The GSL is released under the [GNU General Public License](http://www.gnu.org/copyleft/gpl.html).
* Ruby/GSL is released under the [GNU General Public License](http://www.gnu.org/copyleft/gpl.html).
* FasterCSV is released under the [GPL Version 2](http://www.gnu.org/licenses/old-licenses/gpl-2.0.html) license.
* Ruby is released under [this license](http://www.ruby-lang.org/en/LICENSE.txt).

Copyright (c) 2010-2011 Fleet Ventures, Inc.

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

