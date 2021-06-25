library(googlesheets4)
library(googledrive)
gs4_auth(
    scopes = "https://www.googleapis.com/auth/drive",
    path = "C:/Users/USUARIO/Downloads/prueba-316319-6cfb18e3241c.json",
    email = "sebastian.herrera.monterrosa@gmail.com",
    cache = ".secrets"
    )
drive_auth(
    token = gs4_token()
    )


ss <- "1FT3vDBIgorsTW-BUGnLmbz7XuxQJ_P-2E0IbnhNi6ug"
read_sheet(ss)
# Reading from "MyFile"
# Range "Hoja 1"
# # A tibble: 7 x 4
# a     b     c     d
# <dbl> <dbl> <dbl> <dbl>
#     1     2     2     2     2
# 2     3     3     3     3
# 3     4     4     4     4
# 4     5     5     5     5
# 5     6     6     6     6
# 6     7     7     7     7
# 7     8     8     8     8

df <- data.frame(
    "a" = 1,
    "b" = 2,
    "c" = 3,
    "d" = 4,
)


sheet_append(ss, data = df, sheet = 1)
# Writing to "MyFile"
# Appending 3 row(s) to "Hoja 1"


googledrive::drive_find("MyFile")
# # A tibble: 1 x 3
# name   id                                           drive_resource   
# * <chr>  <chr>                                        <list>           
#     1 MyFile 1FT3vDBIgorsTW-BUGnLmbz7XuxQJ_P-2E0IbnhNi6ug <named list [35]>



## Copy MyFile in a exiting folder x
googledrive::drive_mv(file = "MyFile", path = "~/x/MyFile")
# Error: Parent specified via `path` does not exist


googledrive::drive_mkdir("~/OtherFolder")
# Created Drive file:
#     * OtherFolder: 1vTONR8D-aJ30pTcknuYdAOSS0bSf1JDK
# with MIME type:
#     * application/vnd.google-apps.folder

## Not appear folder in my drive


x <- drive_get("MyFile")
x






range_write(
    ss,
    data = df,
    sheet = "Hoja 1",
    range = "H1",
    col_names = TRUE,
    reformat = TRUE
)







x<-googledrive::drive_get("MyFishFile")
x

x<-googledrive::drive_get("OTro")
x









googledrive::drive_mkdir("other-folder")

googledrive::drive_mv(file = "~/SpreadSheet Python/fluffy-bunny", path = "~/SpreadSheet Python/other-folder/fluffy-bunny")


