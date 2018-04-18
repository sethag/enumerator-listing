# Purpose
Automates typesetting and sorting of household listing/contact information forms to be used by survey enumerators in the field with multiple.  

# Use Case Highlights
Use of this product and associated documents saved hours of organizing, typesetting, etc. which translated into multiple days saved from survey process, better optimized field routing of enumerators, and minimized loss/skipping of households from sample.  Was able to deliver a clean file in .pdf format for quick easy printing by survey firm whenever intializing a new field area for surveying with pages automatically and rationally sorted for optimal field routing.  

# Comments
This is a hack of R and Latex and Knitr.  Designed to be purely functional with minimal concern for document design. With the exception of dealing w missing photo, there is little concern for missing data fields, contradictions in data fields, etc. as field enumerators were trained to interpret deal with data inconsistencies.  Commented out bash code included for resizing photos as needed.  

# Background / Motivation
Developed when supervising a large household survey when third-party survey firm struggled to quickly compile field-ready household listing forms to supports +30 enumerators in locating households in the survey sample.  In particular use case, survey piloting demonstrated need to include as much contact information as possible as many hhlds were difficult to locate and had contradictory contact information across alternative administrative databases.  Easily manageable and legible physical document was essential for enumerators to quickly search for household by checking specific addresses, visiting local merchants patronized by target hhld, calling local program field staff responsible for the hhld, showing neighbors photos of the target, etc. 

# Features
**Sorting:**  Sorting the large number of one-page household listings was important for quickly distributing collection of hhld listings at the beginning of each survey work day.  

**Blank Listing Form:** Includes fields for manually entering new household listing information during survey to expedite survey (digitally enterring names can be quite slow and inhibit flow of survey particularly when the household listing is one of the first parts of the survey).

**Missing Photos:**  Includes blank placeholder for cases of missing photos, so format/layout of typeset page is similar across hhlds w and w.o photos

**Logo:** Including survey firm logo created sense of legitimacy when enumerators consulted local neighbors/merchants and created sense of responsibility among enumerators that the documents should not be discarded haphazardly as they could be linked back to the survey firm.

# Dependencies
File depends on 1) an underlying data file (.xls format in this particular use case) that contains the survey sample with relevant contact information and 2) associated photos (and a generic blank .jpg placeholder in case there are is no photo for a particular hhld)



