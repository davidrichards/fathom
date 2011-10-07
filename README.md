Fathom
======

Welcome to Fathom.  Fathom is a library for building decision support tools.  Fathom is the kind of tool you'd want to use when you:

* want to build a reliable knowledge base for any kind of information
* need to simplify a complex problem
* have more data than a spreadsheet likes to use

Stability Note
==============

I've recently refactored this library.  That makes the core Fathom quite stable, but much less useful.  The specific functionality (various databases, say, GSL support, various graphical model algorithms) will be in yet-to-be-released gems.  I'm going to stabilize these before releasing them to the public.

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