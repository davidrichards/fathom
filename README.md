Fathom
======

Welcome to Fathom.  Fathom is a library for building decision support tools.  Fathom is the kind of tool you'd want to use when you:

* want to build a reliable knowledge base for any kind of information
* need to simplify a complex problem
* have more data than a spreadsheet likes to use

Stability Note
==============

I've recently re-published this code base.  It has quite a few additions.  It is currently being used for mission-critical, commercial systems in a beta state right now.  I'll make updates as necessary.

Availability Note
=================

This code base is also being packaged for a [Ubalo Pods](http://ubalo.io).  This means that any dependent libraries, common configuration options, and data management tools will be worked out in various practical ways.  The concept behind Ubalo is that we can do analytical work by example: start with something close to what we're interested in, clone it, have full ownership of the code base, and run it on our own servers.  All this, delivered in seconds rather than hours or days.  Stay tuned to [Ubalo](http://ubalo.io) for a more-public release of our work there.

Inspiration for the Project
---------------------------

The ideas for this gem are coming from a lot of places:

* Judea Pearl's work on causal graphs and belief networks.  See [Causality](http://www.amazon.com/Causality-Reasoning-Inference-Judea-Pearl/dp/052189560X/ref=sr_1_1?s=books&ie=UTF8&qid=1288840948&sr=1-1) and [Probabilistic Reasoning in Intelligent Systems](http://www.amazon.com/Probabilistic-Reasoning-Intelligent-Systems-Plausible/dp/1558604790/ref=ntt_at_ep_dpi_2)
* Douglas Hubbard's ideas on decision support.  See [How to Measure Anything](http://www.amazon.com/How-Measure-Anything-Intangibles-Business/dp/0470539399/ref=sr_1_1?ie=UTF8&qid=1288840870&sr=8-1)
* Ben Klemens' ideas on data analysis.  See [Modeling with Data](http://modelingwithdata.org/about_the_book.html)
* Daphne Koller and Nir Friedman's ideas on [Probabilistic Graphical Models](http://mitpress.mit.edu/catalog/item/default.asp?ttype=2&tid=11886)

The goals of this project are:

* Build a decoupled library with Ruby and the GSL (currently optional)
* Make it easy to gather information of all types
* Add tools to analyze the integration of knowledge

Decoupled Library with Ruby and the GSL
--------------------------------------------------------

I use Ruby because it's very flexible and fast to write.  I use the GSL because it's very fast, robust, and well-tested.  I decouple the library so that it's easy to use the parts that are worthwhile for your problem and ignore the rest.

Most of the library is about coordinating data nodes.  So, an educated guess or the data that came out of a spreadsheet will sit in a particular kind of node.  The system then allows us to relate this information.  For example, a node that defines the income for a company would relate to the nodes that define the revenue and expenses of the company.  All of this is done with some simple Ruby libraries to make things easy to coordinate.

The statistics that we run are usually run on a GSL::Vector using various random number generators coming from the GSL.  This is really the heart of what the GSL does for Fathom.  A lot of the other tools may be used by some plugins for Fathom, and anyone using their computer to do open source data analysis probably has a good installation of the GSL in it.

There are two bindings for Ruby and the GSL that I know of: [Ruby/GSL](http://rb-gsl.rubyforge.org/) and [ruby-gsl](https://github.com/codahale/ruby-gsl).  Ruby/GSL is still maintained and has the syntax that we're using here.

The decoupling is based on making every file as stand-alone as possible.  What that means is we use autoload quite a bit in the library.  Each file references the main lib/fathom.rb file, so that it can autoload any dependencies it may have.  Also, most files have a test to see if they are being run from the command line at the bottom of the file.  The goal is to make it fairly easy to run a single class in a message queue system, say, or as part of another script to get data into our knowledge base.  In this sense, we're trying to follow some of the design principles of Unix: simple scripts that do one thing well and can combine with other scripts.

Gathering Information
-----------------------------

Decision support is about making rational choices from the information available.  This means that we do several things:

* Make it fairly easy to load spreadsheet data in a CSV format
* Add support for listing assumptions in a YAML file
* Make it possible to link to RDF data and all of the external context that can be useful
* Create links to richer data, such as ERP installations, databases, and web crawlers

The data we gather is organized as a bunch of nodes in a graph.  We also try to create ranges or probability distributions for everything, so that things become comparable and we can add things together fairly well.  We also always know explicitly what our uncertainty is, so that we're not misleading ourselves.  Importing conflicting data should be manageable if you're careful to document what you're loading.

Also, we keep track of meta data.  So, specific decisions are described in the knowledge base, as are references to other material, or other ways to describe what we're doing.  In this way, we should be able to work on convincing the appropriate people (employees, executives, review boards) that we've made sound decisions and that we should commit resources to execute the plan.

Using Fathom
------------

The core fathom gem doesn't do much.  We can define a knowledge base in memory and store a graph of facts, notes, and distributions in that knowledge base.  

Most of the power of Fathom comes from the plugins.  For example, if you wanted to persist your knowledge base in MongoDB, you'd use fm-mongo.  If you wanted to define a budgeting strategy, you'd probably require fm-rl for reinforcement learning algorithms and fm-etl-csv or fm-etl-openerp to import your business information from a spreadsheet or your ERP installation.










Tools for Analysis and Integration
--------------------------------------------

The integration tools in Fathom are:

* Monte Carlo Simulations
* Agent Based Models
* Belief Networks
* Causal Graphs

These tools allow us to combine information in our knowledge base and run simulations or update beliefs to be able to see the larger perspective.  These tools also offer insight into areas where more information should have the most return on investment.  So, given a fairly limited amount of information, we can draw conclusions about what's going on, and pinpoint areas where we can refine our models and get more certain results.

We are also adding Apophenia to the library.  We'll be able to build data analysis tools outside of Fathom and then bring their results into our knowledge base and integrate it with the bigger picture.  In this way, we'll be able to do all sorts of statistical analysis, machine learning, data mining, and other information-generating tasks without making Fathom too complicated.  

Apophenia is the pragmatic analysts dream.  It's a C-based library that uses the GSL to do its analysis very quickly.  It uses SQLite for data management, which makes set operations in memory optimal.  It stores the models in consistent ways, so that it won't be hard to use this information inside of Fathom.

There are also other kinds of external libraries whose analysis could be brought into Fathom through the import tools.

The ultimate integration tool for Fathom is the web service.  We are exposing access to all of the tools through a RESTful, JSON interface so that Fathom can be part of any sort of application.  We also expect to publish basic HTML support for these same functions so that users can input and read their knowledge base without too much trouble. 

Further Information
-------------------

* You can use our [Wiki](https://github.com/davidrichards/fathom/wiki) to get code examples and see how things are coming along.
* You can go to the [TODO](https://github.com/davidrichards/fathom/blob/master/TODO.md) page to see how current development is mapped out.
* You can go to the [Fleet Ventures Blog](http://fleetventures.com) to get more in-depth tutorials and commentary about how to use these types of tools in business as well as a broader perspective of other technologies we use to solve these kinds of problems.

Dependencies and Extensions
---------------------------

This project relies on the [GNU Scientific Library](http://www.gnu.org/software/gsl/) and the [ruby/gsl](http://rb-gsl.rubyforge.org/) bindings for the GSL.  

Fathom has only minimal extensions on external libraries:

* Array responds to rand (so [1,2,3].rand returns a random value from that array)      
* OpenStruct exposes it's underlying table, keys, and values
* FasterCSV has a :strip header converter now
* String has the constantize method added to it from the ActiveSupport library

In the future, more optional dependencies will be introduced for parts of the library:

* EventMachine is one that I'm sure will be added. 
* RDF.rb and related gems will be used for some of the KnowledgeBase
* SQLite will be available for some set operations
* One of the key/value data stores will be used for the KnowledgeBase (Riak, CouchDB, MongDO, Redis, or similar)

It should be easy to avoid the parts of the library that use dependencies that you don't want to have.  The goal for dependencies is:

* To use the best tool available for the job
* Make it easy to avoid those parts of the library that use those dependencies

For example, the in-memory version of the Knowledge Base will remain available for quick and dirty analysis.  

Note on Patches/Pull Requests
-----------------------------
 
* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but
   bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

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