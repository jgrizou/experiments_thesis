Experiments from my thesis work
===

This repository contains the source code to reproduce most of the experiments presented in my thesis work. It includes the analysis and plotting of the figures. You need the [lfui](https://github.com/jgrizou/lfui), the [matlab\_tools](https://github.com/jgrizou/matlab_tools), and the [matlab\_datasets](https://github.com/jgrizou/matlab_datasets) repositories, at the commit tagged as "thesis".

```
mkdir foldername
cd foldername
git clone https://github.com/jgrizou/experiments_thesis
cd experiments_thesis
git checkout tags/thesis
cd ..
git clone https://github.com/jgrizou/lfui
cd lfui
git checkout tags/thesis
cd ..
git clone https://github.com/jgrizou/matlab_tools
cd matlab_tools
git checkout tags/thesis
cd ..
git clone https://github.com/jgrizou/matlab_datasets
cd matlab_datasets
git checkout tags/thesis
cd ..
```

However, the results of each experiments are not included because this is git and not a hardrive (some takes up to 5Go). This code allows you to run the experiments on your computer and reproduce the results.

The usual way to run my code is:

- In an experimental folder: run the "create_jobs.m" file that creates a "wait_jobs" folders and fill it with jobs (i.e. matfiles containing the command to be executed) for each run of the experiments.  Do not forget to change the nJobs variable to adapt to your needs. Of course always try to understand what the script is doing prior to running it.

- In the root folder: use the "run_jobs_in_folder.m" function which will execute all jobs in the experiment folder you gave. It runs the files in the "wait_jobs" folder, and once finish put them in the "end_jobs" folder. During execution, files are in the "run_jobs" folder. My jobs are saving results in a "results" foldder.

- Once jobs are done, you can run the "analysis.m" script, which process the data and store them in an "analysis" folder.

- Finally, run the "plot_*.m" script to generates the plots, that should be saved in a "plots" folder (if the corresponding lines are not commented).

As you have understood this architecture is made to be used with several instances of Matlab on several computers. A simple, slighlty ugly, way is to synchonize your code folder using Dropbox or BitTorrentSync. It worked for me.

I am available by e-mail if you have question.

Have fun!
