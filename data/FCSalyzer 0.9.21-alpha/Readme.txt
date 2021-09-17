FCSalyzer Version 0.9.21-alpha
Copyright (C) 2012-2021 Sven Mostböck
http://sourceforge.net/projects/FCSalyzer

FCSalyzer is a simple application for analysing flow cytometry data. It is based on the "What you see is what you get" principle and I hope it is intuitive to use. For more information, please visit the project web page at http://sourceforge.net/projects/FCSalyzer. FCSalyzer is a Java-based application, so you need to install Java (Version 7 or higher). To start, double-click the JAR file.

-------------
Version 0.9.21-alpha

This version only introduces and "alternative" JAR that uses a different dialog when loading/saving files. For major feature changes, see version 0.9.19-alpha.

GUI:
+ There is now an additional "FCSalyzer_alternative.jar" provided. The only difference between the two FCSalyzer JARs is the dialog used when the user opens or saves files. "FCSalyzer.JAR" uses a dialog provided by JAVA. However, I got reports that this JAVA-internal dialog might not work on some systems (the reported system was MacOS using Japanese as system language). This JAR requires Java version 6 or higher. "FCSalyzer_alternative.JAR" uses a system-provided dialog. This JAR requires Java version 7 or higher. Please see Exporting Data for an important usage difference in this version. Users can simply try both versions and see, which works better for them. All other aspects are identical, so all FCX analysis documents can be opened and edited with either version.

Improvements:
+ FCX documents can now be provided as command line arguments to be opened by FCSalyzer during startup. Maybe useful for some users.

-------------
Version 0.9.20-alpha

This is mainly a maintenance release for bugs that I missed in version 0.9.19-alpha. For major feature changes, see version 0.9.19-alpha.

Improvement:
+ Gates can now be re-arranged in the gate list, thus changing which gate is drawn on top.

Bug fixes:
+ Bug fixed with gate definition, that led to circular references freezing the program
+ many other smaller bugs from

-------------
Version 0.9.19-alpha

New Features:
+ Plots and Documents can now be exported in SVG format
+ Batch operations are now possible: when epxorting plots or documents, a list of FCS files can be selected, and the export happens for each of the files.
+ A step size can now be specified that defines the distance of FCS files when using "Previous/Next datafile" on selected plot(s). The default is "1", meaning that the next datafile in the directory list is used.
+ New data can be attached as additional parameters to existing FCS data files. The data can be imported from CSV text files. All attached parameter values are stored in a combined file that carries the extension ".FCXA", separate from the FCX document. Data can be numerical, or categorical. Details on importing data is found in the "Attach Parameters" dialog. ------>>>>> This is a very new feature and there are probably some bugs - please test carefully if the results match your expectations!

Improvement:
+ Each open FCX document is now shown in an independent top window, instead of all open FCS document being contained in one single top window.
+ The calculation of compensation was changed. In previous versions, the Compensation Matrix was entered and used for calculation. However, usually the Spillover Matrix is entered and the Compensation Matrix is then calculated based on the Spillover Matrix (see http://www.bioinformin.net/cytometry/compensation.php). The earlier behaviour of FCSalyzer also introduced a bug when reading the spillover matrix from an FCS file, as the matrix was then treated like a compensation matrix (my apologies for that mistake; errors like that are the reason why FCSalyzer continues to be in alpha status). With this version 0.9.19, matrixes are treated as spillover matrix. ------>>>>> This means that 0.9.19 calculates compensation different than earlier version. Be careful when opening old FCX files, as the data might change if compensation was used. As this is a new feature there are probably some bugs - please test carefully if the results match your expectations!
+ Regions can now be deleted in the "Regions/Gate" dialog
+ The Rainbow-color map is now the default for density graphs

Bug fixes:
+ Spillover matrix was interpreted correctly for compensation calculations (see above).
+ The compensation dialog had a few bugs
+ The Font Sizes were not applied correctly. In general, font sizes larger than 12 were shown too small. This has been repaired. ------>>>>> When opening FCX documents prepared in earlier FCSalyzer version, the text might be shown in slightly different font sizes.
+ Fixed a bug when opening large FCS3 files
+ multiple minor bugs

Side-effects:
+ The shortcuts for "Next/Previous datafile" had to be changed to using "Shift-Page Down" and "Shift-Page Up".
+ FCX documents generated in earlier versions might look different now, with changed font sizes (see above)
+ FCS documents generated in earlier version might calculate and display data differently, if compensation was used (see above).

-------------
Version 0.9.18-alpha

New Features:
+ Sysmex Ploidy Analyzer FCS files can be opened. For more, see "Datafiles.txt"

Bug fix:
+ selection of regions in one plot sometimes selected a region in a different plot

-------------
Version 0.9.17-alpha

This release contains only a couple of fixes for following bugs:
+ deleted regions still showed up in the plot
+ sometimes, plots could not be dragged into a new position with the mouse any longer

-------------
Version 0.9.16-alpha

New Features:
+ View file data: the event data can be listed in the form they are stored in the FCS file, as used for displaying the data (including compensation and data transformation), and as used for the statistics calculations (so including compensation but without transformation).
+ Format data files: parameter data can be multiplied by a fixed amount before any further processing takes place. This feature was mainly implemented for .MQD files, but can also be used as a simple zoom tool.
+ MACSQuant files (.MQD) can now be used as data files. Please note that all parameters are multiplied by 1000 by default with this file type.
+ MoFlo data files can now be used as data files. However, I only have two data files for testing and no experience how the data is supposed to look like. Hence, users are strongly advised to carefully check if these data files are processed as they should be.
+ Format data files: custom parameter descriptions can be entered
+ Parameters can be derived from existing parameters. Parameters can be added, subtracted, multiplied and divided with/by each other. For example, division of parameters is commonly used when analysing labels that change their fluorescence spectrum when pH levels or Ca2+ levels change.
+ For gradient plots, custom gradient colors can now be defined. Also, the gradient color can either be defined by the density of the event count (that's the usual way), or by the value of a third parameter (sort of a simple way to show three different parameters in one 2D plot).

Usability changes:
+ They dialog to apply transformations and compensation to data files has been changed

Bug fixes:
+ Several bug fixes, for example the Y-axis labeling was sometimes wrong for histogram plots

Compatibility problems with earlier versions
+ The way how regions, quadrants and markers are stored has been changed. They are now relative to the plot, not relative to the FCS data range. This means, that their "optical" position remains stable even when FCS files with different data ranges are used. However, when loading older FCX files, some regions might not be imported correctly. Users are advised to check regions when opening FCX files generated under older versions of FCSalyzer.

-------------
Version 0.9.15-alpha

Bug fixes:
+ A bug was repaired that prevented some FCX files from being loaded.

-------------
Version 0.9.14-alpha

New Features:
+ The event data that is shown in plots/overlays can be exported as CSV.
+ When selecting multiple FCS files during plot generation, or in the "add overlay(s)" dialog, the files are combined in one overlay plot.
+ When adding plots to an overlay, new plots now take the parameters and gate of the base plot.

Bug fixes:
+ A bug was repaired that prevented FCX files with multiple compensations from loading.
+ In the statistics table, %-gated now displays "N/A" when not calculated.
+ After exporting plots as PNG, the plot frame now disappear again
+ Markers in histograms are positioned relative to plot size, not the histogram event-count.
+ Export of overlay statistics does not have unnecessary repeats of data any longer.

-------------
Version 0.9.13-alpha

New Features:
+ The whole document or selected plots can now be exported as high resolution PNG files. See "Document - Export document as PNG" and "Plot - Export Plot/Overlay to PNG".

Bug fixes:
+ In statistics, the CV has been changed to %CV - in principle simply the CV*100.
+ A bug when setting the font size in plots on MacOS has been repaired. That bug had also prevented .FCX documents from loading.
+ A bug when changing the parameter of a plot has been repaired.
+ Accuri FCS files can be opened again. In the last version, FCS files from the BD Accuri were not opened due to a wrongly used $SPILLOVER keyword in the Accuri FCS files.

-------------
Version 0.9.12-alpha

New Features:
+ Compensation matrixes stored within FCS files are now loaded. Supported the $SPILLOVER keyword as defined in the FCS3.1 standard, and the SPILL keyword as used by FACS Diva. Please note that the matrix has to be stored within the FCS file. This may require that the FCS files get exported from the original acquisition software.
+ The CV (coefficient of variation) can now be calculated under statistics. As the CV requires that the means is calculated beforehand, statistics calculation might be slow for large data files or analysis documents.

Bug fixes:
+ Histogram plots are now updated when the displayed data file is changed (for example by 'previous/next data file')

-------------
Version 0.9.11-alpha

This version has only one small bug fix:
+ Some Partec data files could not be opened. This has been solved now.

-------------
Version 0.9.10-alpha

This version has only one small bug fix:
+ For FCS files with parameters of a very small data range, the densitiy plots were not drawn correctly. This error probably did not occur with regular data files from flow cytometers. However, this might have happened for articial FCS3 files created with tools like Data2FCS (https://sourceforge.net/projects/data2fcs/).

-------------
Version 0.9.9-alpha

This versions adds many new features. Please keep in mind that this is still an alpha version. Please evaluate carefully, if the FCSalyzer analysis matches your expectations! Strange bugs may still exist!

New features:
+ FCSalyzer now supports FCS datafiles from more flow cytometers and acquisitions software. For details, see 'datafiles.txt'.
+ Raw data from FCS data files can be inspected - under the menu 'Data Files' - 'List Raw Data'
+ The dialog for Transformations and Compensation has been moved to the menu 'Data Files'
+ All FCS data files can now be displayed on 'linear' scale, simple 'log' scale or 'logicle' scale. 
+ All FCS data files can be compensated
+ Changing plots now uses the hotkey CTRL+PG-DOWN and CTRL+PG-UP
+ Axis values higher than 9999 are now shorted with the suffix 'K'
+ For overlays, a legend of the separate plots can now be shown - select this under the menu 'Plot' - 'Annotate'.
+ Regions visibility in plots can be changed in the 'Format Plot' dialog
+ Statistics calculation are now possible for datafiles with a high number of events and/or high number of parameters. This came with the cost of decreased calculation speed. Also, statistics calculations now creates a lot of temporary files on the hard drive. Please make sure that there is free hardware space available to FCSalyzer!

Bug fixes:
+ Statistics are updated when an overlay is added/removed from a plot
+ The first overlay in a plot can be removed, if at least one additional overlay is present
+ Regions can be deleted when shown in multiple plots
+ Histograms and density plots do not have the option "multigate color" any longer. This option never worked. Also, it does not make sense for histograms.

Known issues:
- FCX analysis documents from former FCSalyzer versions are not fully compatibly with FCSalyzer 0.9.9-alpha. The log-transformation for some files may have changed. Control your analysis carefully, when opening an old FCX document!
- Changing the parameters displayed on an axis is applied to all selected plot, i.e. plots with red borders. When changing the parameter displayed on a plot-axis, make sure that the plot to be changed is acutally selected (i.e. marked with a red border). Else, the change is not done for that current plot.
- Compensation data stored within the FCS data file are currently not recognized. All compensation has to be done manually by the user.
- Markers, regions and quadrants are based on absolute range data. This means that mixing datafiles with different ranges in one analysis document may lead to unexpected results during analysis. For example, classical FCS2 files commonly have a range from 0-1023 for FSC and SSC, while FCS3 files often have 0-262144. Let's assume a region R1 is drawn into a plot of the FCS2 file (FSC vs. SSC). This region will be in the range of 0-1023 for both parameters. That same region will also be in the range of 0-1023 for the FCS3 file. As the FCS3 file has a much higher total range, a user will probably never properly see the region. 
- Mixing FCS datafiles with different parameters into one overlay can lead to errors: 
    - As the parameter order and description might be different, the x-axis might not be labeled correctly. 
	- If a keyword is missing in one file and that keyword is used for annotation, than the annotation has an empty line for that overlay file.
	- As markers, regions and quadrants work with absolute range values (see above), overlays that mix different ranges can lead to unexpected statistics: histogram markers will be drawn based on the top-most datafile of the overlay, but the statistics will be calculated on the actual data range. Hence, the markers shown do not reflect the calculated markers for all overlay data files.
- sometimes: change gate color or changing region name does not work

-------------
Version 0.9.8-alpha
+ the bugfix for opening FCS files in 0.9.7-alpha made the situation even worse. In this version, saving and opening FCX documents should actually work.
+ Compensations are now specifically associated with the FCX document. [In older versions, compensations were shared between all open documents.]
+ some visual changes

known bugs:
- sometimes: change gate color or changing region name does not work

-------------
Version 0.9.7-alpha
+ editing statistics did not work
+ sometimes, opening FCX documents did not work

known bugs:
- sometimes: change gate color or changing region name does not work

-------------
Version 0.9.6-alpha

This is a bugfix-release. Please note that this is an alpha Version. It probably contains a lot of bugs. It is not guaranteed that documents from earlier versions can be opened.

fixed bugs:
+ gate was not set correctly when copying statistics
+ statistics and annotations were not linked to the plot after loading
+ improved speed of statistics calculations
+ gates were not working with histograms
+ low event count made problems in histograms, in general, tick calculation is not good
+ font size of comments were not saved correctly
+ plots now always start with FCS/SSC
+ shift-click to select a plot did not work
+ parameters that are irrelevant for compensation were removed from the compensation dialog: time, FCS, SSC 
+ printing has been improved

known bugs:
- sometimes: change gate color or changing region name does not work

-------------
Version 0.9.5-alpha

This is an early release with FCS3 support. Please note that this is an alpha Version. It probably contains a lot of bugs. It is not guaranteed that documents from earlier versions can be opened.

new features:
+ FCS3 is now supported, including log-transformation and compensation
+ other stuff might have changed compared to earlier versions. It has been too long, I can't really remember.

-------------
Version 0.9.4

bug fixes:
+ files can be saved. I have no clue how or when that broke.
+ fixed cursor changes.

-------------
Version 0.9.3

new features:
+ Plots can now be arranged. They can be moved in small steps using the keyboard (CTRL- + arrow keys) or aligned along a border /left, right, top, bottom).
+ Statistics can now be exported to a tab-delimited text file. This can be done in the "File" menu.

bug fixes:
+ histogram and density plots now observe the "coloring according to aplied gate" option
+ density plots show overlay
+ fixed buggy font sizes of plots 
+ fixed color settings of plots after duplication
+ the cursor changes to the wait-cursor when drawing plots with a lot of events

-------------
Version 0.9.2

new features:
+ density graphs
+ overlays: all plots now support overlays. Please use "Format plot/overlay" in the "Plot" menu. 

multiple bug fixes, but I am sure plenty are still around.

-------------
Version 0.9.1

no new features, just bug fixes:
+ gates are updated when region or gate names change
+ histograms are redrawn when regions change
+ marker and quadrant changes are reflected in statistics
+ quadrant labels are correct in statistics
+ labels for histogram y-axis now work for very low event counts

-------------
Version 0.9.0

This is the first version to be released. It allows basic functionality, but also has some known issues.
Give it a try, but don't expect it to replace your regular analysis program (yet).

+ analyses FCS2.0 data files
+ allows dot plots and histograms
+ has regions and gates, quadrants and markers - and associated statistics

- sometimes a file document can't be loaded properly
- changing the data file and other things might not be reflected immediately in the respective plots

-------------
This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program (License.txt).  If not, see <http://www.gnu.org/licenses/>.
