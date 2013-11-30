pro test_gest_batch 
  compile_opt idl2
    
  ;Specify fully qualified path to source image file
  in_file = 'C:\Program Files\ITT\IDL708\products\envizoom46\data\qb_boulder_msi'

  ;Open file and get full image dimensions array
  envi_open_file, in_file, r_fid=fid
  envi_file_query, fid, dims=dims

  ;*********************************************************************
  ;If you want to specify a DEM for orthorectification, do it here.
  ;Otherwise, don't include this section
  ;NOTE: If the image file already has a DEM associated with it (in its ENVI header), 
  ;the DEM will be used automatically--there's no need to specify it here
  ;*********************************************************************
  dem_file = 'C:\Program Files\ITT\IDL708\products\envi46\data\world_dem'
  envi_open_file, dem_file, r_fid=dem_fid  
  dem_pos = 0  
  ;*********************************************************************
  
  ;Specify the band positions to use.
  ;For one-band output, provide a single scalar value (e.g., 0)
  ;Example: pos = 0
  ;For three-band output, desired RGB band positions should be arranged as follows: [Red,Green,Blue]
  ;Example: pos = [2,1,0], where the third band goes to Red, the second to Green, and the first to Blue
  pos = [2,1,0]
  
  ;Specify fully qualified path to desired output folder
  ;Note: Folder must already exist
  ;Warning: Be sure to include appropriate path separator for your OS at the end of the string
  out_folder = 'C:\GEST\'

  ;Provide fully qualified path to desired Super KML output file
  ;Note: This file will be created by GEST during the conversion process
  ;Warning: Super KML file should reside in the output folder specified above
  super_kml = 'C:\GEST\sample_super_overlay_output_file.kml'
  
  ;Select stretch type
  ;Options are:
  ;0 -> Linear
  ;1 -> Linear 0-255 (no stretch)
  ;2 -> Linear 2%
  ;3 -> Gaussian
  ;4 -> Equalization
  ;5 -> Square Root
  ;6 -> ENVI Classification Image
  stretch_type = 2
  
  ;Select tile size
  ;Options are:
  ;0 -> 256 x 256
  ;1 -> 512 x 512
  ;2 -> 1024 x 1024
  tile_size = 1
  
  ;call the batch version of GEST
  gest_batch, fid=fid, pos=pos, out_folder=out_folder, super_kml=super_kml, $
    dims=dims, tile_size=tile_size, stretch_type=stretch_type, dem_fid=dem_fid, $
    dem_pos=dem_pos
  
end