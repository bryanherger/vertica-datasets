# vertica-datasets
Example data for Vertica projects such as UDX, datasketches, ML, etc.

### adsb: Approximate count distinct using air traffic (ADS-B) data

This dataset demonstrates how to use Vertica approximate functions to quickly perform count distinct estimates over single and multiple ranges.  The LogLogBeta implementation offers functions similar to Apache datasketches HLL algorithm, though Vertica implements using LogLogBeta internally.
