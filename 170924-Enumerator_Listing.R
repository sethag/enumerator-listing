# Clear memory
rm(list = ls())

library("foreign")
library("readxl")
library("tools")

field <- "SUR" # province 
# area <- "SANTO DOMINGO ESTE" # municipality
setwd(paste("/Users/sethag/Dropbox/project_transfer/Data_Expert/raw/ipa/midline/hogares/tracking/",field,sep="")) # tracking data file path
base      <- data.frame(read_excel("./170924-midline_hogar_muestra_master-SUR_ONLY-EDITED.xls")) # tracking data source in xls format

# Subset
# base <- subset(base,base$muni==area) # allow for subsetting by municipality if more limited collection needed

# Sort data so forms are organized by municipality, supervisor number, neighborhood, and unique hhld ID
base <- base[order(base$prov,base$muni,base$SupervisorEnlaceNombreCompleto,base$nucleo,base$barr_id,base$survey_id),] 

# Create Inputs
id             <- base$survey_id
nucleo         <- base$nucleo
benef          <- base$cep    # progam beneficiary indicator (local program field supervisors less likely to be able to help w non-beneficiaries)
     benef[benef==1]     <- "SI"
     benef[benef%in%NA]  <- "NO"
asignado       <- base$nucleo    # assigned to a progam hhld group (local program field supervisors less likely to able to help w non-assigned)
     asignado[asignado!="NA"] <- "SI"
     asignado[asignado=="NA"] <- "NO"
foto           <- paste(base$cedula,".jpg", sep="")  # photo from admin system
nombre         <- base$nombre
edad           <- base$JefeEdad 
sexo           <- base$JefeSexo
tel1           <- base$HogarTelefono
prov           <- toupper(base$prov)
muni           <- base$muni
dist           <- base$dist
secc           <- base$secc
barr           <- base$barr
subbarr        <- toupper(base$subbarrio)
dir            <- toupper(paste(base$HogarCalle,base$HogarNumero))
dir.ref        <- base$HogarReferencia
enlace         <- toupper(base$EnlaceNombreCompleto)
enlace.tel     <- base$EnlaceTelefono
super          <- toupper(base$SupervisorEnlaceNombreCompleto)
super.tel      <- base$SupervisorEnlaceTelefono
supercampo     <- toupper(base$SupervisorCampoNombreCompleto)
supercampo.tel <- base$SupervisorCampoTelefono
comercio1      <- toupper(base$comercio_afil_1)  # last merchant where transfer was spent
direccion.afil1 <- base$direccion_afil_1
municipio.afil1 <- base$municipio_afil_1
paraje.afil1    <- base$paraje_afil_1
comercio2      <- toupper(base$comercio_afil_2)  # second last merchant where transfer was spent
direccion.afil2 <- base$direccion_afil_2
municipio.afil2 <- base$municipio_afil_2
paraje.afil2    <- base$paraje_afil_2
comercio3      <- toupper(base$comercio_afil_3)  # third last merchant where transfer was spent
direccion.afil3 <- base$direccion_afil_3
municipio.afil3 <- base$municipio_afil_3
paraje.afil3    <- base$paraje_afil_3
senasa_dir      <- base$direccion3   # alternative address from national health insurance database 

# transfer relevant photos from archive to temp file
from <- "/Users/sethag/Dropbox/project_transfer/Data_Expert/raw/ipa/midline/enlace/PROSOLI_DR-Cristian/01_Survey/01_Fotos/Originales/beneficiarios/"
to   <- "./fotos/"

# replace missing photos w blank placeholder to maintain common layout/formatting when typesetting
count <- nrow(base)
i <- 1
while (i<=count){
     if (file.exists(paste(from,foto[i],sep=""))!=T) {
          foto[i] <- paste("999.jpg",sep="")
     }
     i <- i+1
}

# Bash code for resizing photos as needed
# sips -Z 120 .jpg

# create individual latex files for each hhld 
z <- 1
while (z<count){
     cat("
         \\centering
         \\includegraphics[scale=1]{../gallup.jpg} \\\\
         \\vspace{.25cm}
         \\raggedright 
         NOMBRE: \\textbf{",nombre[z],"} \\hspace{0.5in} BARRIO: \\textbf{",barr[z],"} \\\\ BENEF? \\textbf{",benef[z],"} \\hspace{0.5in} ASIGNADO A ENLACE? \\textbf{",asignado[z],"} \\hspace{0.5in} NUCLEO: \\textbf{",nucleo[z],"} \\\\
         \\vspace{.5cm}
         \\includegraphics[scale=1]{",to,foto[z],"} \\par
         \\vspace{.5cm}
         ID: ",id[z]," \\par
         Provincia: ",prov[z]," \\par
         Municipio/DM: ",muni[z]," / ",dist[z]," \\par
         Barrio/SubBarrio: ",barr[z]," / ",subbarr[z],"  \\par
         Direccion: ",dir[z]," \\par \\par
         Dir. Ref.: ",dir.ref[z],"  \\vspace{.15cm} \\par
         Enlace: ",enlace[z],", Enlace Tel: ",enlace.tel[z]," \\par
         Supervisor Enlace: ",super[z]," / Sup. Tel: ",super.tel[z]," \\par
         Supervisor Campo: ",supercampo[z]," / Sup. Campo Tel: ",supercampo.tel[z]," \\vspace{.15cm} \\par
         Comercio 1: \\textbf{",comercio1[z],"} ",direccion.afil1[z]," ",paraje.afil1[z]," \\vspace{.15cm}  \\par
         Comercio 2: \\textbf{",comercio2[z],"} ",direccion.afil2[z]," ",paraje.afil2[z]," \\vspace{.15cm}  \\par
         Comercio 3: \\textbf{",comercio3[z],"} ",direccion.afil3[z]," ",paraje.afil3[z]," \\vspace{.15cm}  \\par
         Alt Direccion Hogar: ",senasa_dir[z]," \\vspace{.15cm}  \\par
         \\begin{table}[h!]
         \\begin{tabularx}{\\textwidth}{  p{0.15in} | p{2.25in} | p{0.3in} | p{0.15in} | p{2.25in} | p{0.3in}}
         \\hline
         No. & Miembro & Edad & No. & Miembro & Edad \\\\ 
         \\hline
        1 \\par \\par & \\par \\par & \\par \\par & 7  \\par \\par & \\par \\par & \\par \\par \\\\ \\hline
        2 \\par \\par & \\par \\par & \\par \\par & 8  \\par \\par & \\par \\par & \\par \\par \\\\ \\hline
        3 \\par \\par & \\par \\par & \\par \\par & 9  \\par \\par & \\par \\par & \\par \\par \\\\ \\hline
        4 \\par \\par & \\par \\par & \\par \\par & 10 \\par \\par & \\par \\par & \\par \\par \\\\ \\hline
        5 \\par \\par & \\par \\par & \\par \\par & 11 \\par \\par & \\par \\par & \\par \\par \\\\ \\hline
        6 \\par \\par & \\par \\par & \\par \\par & 12 \\par \\par & \\par \\par & \\par \\par \\\\ \\hline
        \\end{tabularx}
         \\end{table}
         "
         ,sep = ""
         ,file=paste("carita",id[z],".tex", sep="")
     )
     z <- z+1
}

# aggregate individual latex files for each hhld in a parent document
sink(paste("lista_hhld_",format(Sys.time(), "%y%m%d"),".tex",sep=""))
     cat("
         \\documentclass[10pt]{article}
         \\usepackage{graphicx}
         \\usepackage{tabularx}
         \\usepackage{multirow}
         \\usepackage[top=1in, bottom=1in, left=1in, right=1in,includefoot]{geometry}
         \\begin{document}"
         , sep=""
     )
y <- 1
while (y<count){
     cat("
          \\newpage
          \\input{carita"
          , sep=""
     )
     cat(id[y]
         , sep=""
         )
     cat(".tex}"
         , sep=""
         ) 
     y <- y+1
     
}
     cat("
          \\end{document}"
         , sep=""
     )
sink()

file <- paste("lista_hhld_",format(Sys.time(), "%y%m%d"),".tex",sep="") # named by date compiled
file.show(file)
texi2pdf(file) # compile latex file into pdf
file.pdf <- paste("lista_hhld_",format(Sys.time(), "%y%m%d"),".pdf",sep="") 
file.rename(file.pdf, paste("lista_hhld_",format(Sys.time(), "%y%m%d"),"-",field,".pdf",sep="")) # rename w province targeted
