![alt text](https://s3-ap-southeast-1.amazonaws.com/porthos/public/assets/logo/favicon.ico "Logo") Porthos Home Image Import Documentation 
======

The website can be found here: [https://porthoshome.com/](https://porthoshome.com/)





## This documents the `slim` branch of this project

* [- Directory / Bucket](https://github.com/setclockpm/spree_datashift_prod_import/tree/slim#directory)
* [- File Format](https://github.com/setclockpm/spree_datashift_prod_import/tree/slim#format "Installed Gems")



## Files
###The 'Dropbox' folder that image files should be placed in is
- porthos/public/dropbox/product_photos

---
## Format

The importer will pick up a files in a particular format, namely a combinations of hyphens and spaces.

A typical SKU is know to have the format of:

    ABC123Z ORG
what is generally accepted is:
5-7 Alphanumeric characters a separator(space or hyphen) then 3 alphanumeric characters then another separator followed by a number then the '.jpg'
    
    FD234A GRY 3.JPG



It is known that many image files can exist for one variant also.
Taking into consideration these two, the correct format should be for the files in the dropbox should be:

    ABC123D GRN - 1.jpg
  
The script will also accept some variations of this format (in reason):

    GKC003B - BLU - 2.jpg
    GKC003B-BLU-2.jpg
    GKC003B BLU 2.jpg
    GKC003B BLU-2.jpg

... again pretty much reasonable combination of hyphens and spaces.

**Important**
**Whatever combination you decide to use, It is recommended to at least keep thst combination consistent within the variant so the best image is displayed first.
This is OK (although total consistency across all SKUs/Variants is still recommended)
    
    KCH333B - BLU - 1.jpg
    KCH333B - BLU - 2.jpg
    KCH333B - BLU - 3.jpg
    KCH333B - BLU - 4.jpg
    
    KCH333B BLK - 1.jpg
    KCH333B BLK - 2.jpg
    KCH333B BLK - 3.jpg
    KCH333B BLK - 4.jpg

**Bonus**

**The script can also deal with images that have the letters
    
    ALL or GRP
eg

    KCH556P ALL - 1.JPG
    
in the file name instead of the color name. This image will be created under the master variant and not associated with a specific variant (one that has a color property typically)
So the image will belong to KCK555P and not randomly assigned to KCH555P NAT or any othe color


SpreeDatashiftProdImport
========================

This is the same gem just with the user_import and order_import tabs removed and also the Shopify methods removed.
Some Styling has also been added to the forms. 
Added export functionality and pathways to image import

Because I am using Spree -v ~>3.1.0, I had to update the table names in the controllers to match the version of Spree I have.
(They've renamed a few) That's why I added the dependency parameter in the gemspec of ~> 3.1.0


