This repository contains source data and a [PDF version](Andrei%20Kazakov.%20Comparison%20of%20performance%20of%20Ruby%20interpreters%20in%20high-load%20Rails%20applications.pdf) of my thesis “Comparison of performance of Ruby interpreters in high-load Rails applications” which I defended at the University of Tartu.

Permalink to this work in the university archive: https://hdl.handle.net/10062/91238

### Abstract
The topic of this paper is the performance comparison of Ruby interpreters in high-load Rails applications. This research is relevant for companies whose IT systems are written in the Ruby programming language and work under heavy load. The research problem of this work is relevant in the modern IT field, as according to GitHub, Ruby is the 10th most popular programming language as of 2022.

The paper discusses the low performance of the Ruby programming language in high-load IT systems and poses the research question of whether changing the interpreter can increase the performance of web applications. To answer this question, the performance of a web application is measured under different interpreters by modeling a single microservice in a cloud environment.

The main conclusion of this work is that using an alternative interpreter leads to a performance improvement of up to 94 percent, and JVM-based interpreters are the best in terms of performance. It is also concluded that performance improvement also entails trade-offs which means that changing the interpreter in the existing IT system also needs separate testing.

### Conclusion
This research is relevant for companies whose IT systems experience high load and are written in Ruby. It addresses the problem of Ruby’s low performance and poses the following research question: can using alternative Ruby interpreters show increased performance in such IT systems?

The research consists of three parts:

1. Preparing the benchmark. This part gives an overview of microservice architecture, which is a best-practice approach for building high-load IT systems, formulates functional and non-functional requirements for the benchmark application and chooses the benchmark application across these which were already used in other studies
2. Selecting suitable interpreters. This part discusses the issue that different interpreters implement slightly different versions of the language, sets the criteria for choosing the interpreters and chooses them for the experiment
3. Conducting the experiment. The experiment is designed as three Amazon AWS virtual servers within the same network, one hosting the PostgreSQL server, one hosting the benchmark application, and one hosting the benchmarking tool. The benchmarking tool sends 64 batches of 1024 requests, measuring each batch individually to also see the warmup dynamics. The experiment is repeated three times for each interpreter to confirm the reliability of the data. This part also describes caveats and analyses the experiment’s outcome.

Analysis of the experimental data allowed us to demonstrate that JRuby and TruffleRuby outperformed CRuby in the experiment. At the same time, some trade-offs were observed, such as longer startup time and long warmup period needed to reach peak performance. We concluded that better-performing interpreters might come with even more trade-offs, though deep analysis of these was out of the scope of this work, as these were likely to be individual for every IT system.

This research demonstrated clear direction for companies and engineers for further experimentation with their IT systems and suggests that using an alternative Ruby interpreter might be advantageous, potentially increasing a system’s performance and decreasing infrastructure costs.
