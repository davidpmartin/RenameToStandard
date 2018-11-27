# rename-to-standard

### Purpose
Powershell script to rename a directory of image files based on user input values in accordance with the defined naming standard. This was created for work purposes. The naming standard organises image files as to allow easy identification of the site, the room, content, and number of a given photo. Regex pattern matching is used to enforce the standard.

Naming standard is as follows:

\####-XXXXXX-XXXX-###
  
\#### - Site Code: 4 digit site code
\XXXXXX - Room Code: AMS room code (6-8 alphanumeric characters)
\XXXX - Descriptor: A brief description of content ie BD, CD, CD2, WAP
\### - Batch and Index: First car is batch number (1st visit, 2nd visit, etc). Index is a zero padded number representing the photo number for the respective batch
