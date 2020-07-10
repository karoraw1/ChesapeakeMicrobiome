import pandas as pd; import numpy as np; import os;

mbase = '/Volumes/KeithSSD/ChesapeakeMicrobiome/data/environmental_raw_data/'

water_df2 = pd.read_csv(mbase + "merged_paired_water_quality_data.txt", sep="\t")
w2_cols = ['SampleID', 'SampleDate', 'CollectionAgency', 'Station', 'Latitude', 'Longitude', 
           'Depth', 'TotalDepth', 'PctTotalDepth', 'WaterColumnPosition', 'cruise_id', 
           'PHEO', 'TN', 'TP', 'CHLA', 'DOP', 'DON', 'NH4F', 'NO2F', 'NO3F', 'PC', 'PO4F', 
           'DO', 'PH', 'SALINITY', 'WTEMP', 'LinearTime', 'DayLength', 'FallPeak', 
           'Discharge_Rappahannock-instant','Discharge_Rappahannock-15', 'Discharge_Rappahannock-30',
           'Discharge_Rappahannock-60', 'Discharge_Potomac-instant', 'Discharge_Potomac-15',
           'Discharge_Potomac-30', 'Discharge_Potomac-60', 'Discharge_Susquehanna-instant', 
           'Discharge_Susquehanna-15','Discharge_Susquehanna-30', 'Discharge_Susquehanna-60',
           'measurement_PAR-instant', 'measurement_PAR-15', 'measurement_PAR-30',
           'measurement_PAR-60', 'WIND_RATIO_BWI-instant', 'WIND_RATIO_BWI-15',
           'WIND_RATIO_BWI-30', 'WIND_RATIO_BWI-60', 'PRECIP24HR_BWI-instant',
           'PRECIP24HR_BWI-15', 'PRECIP24HR_BWI-30', 'PRECIP24HR_BWI-60',
           'Discharge_Sum-instant', 'Discharge_Sum-15', 'Discharge_Sum-30', 'Discharge_Sum-60']
base_df = water_df2.copy()[w2_cols]
base_df = base_df.rename(columns={'FallPeak':'Seasonality_Fxn', 'cruise_id':'Cruise_Num'})

base_df = base_df.rename(columns={i:i.replace("-","_") for i in base_df.columns})
base_df = base_df.set_index('SampleID')

water_df1 = pd.read_csv(mbase + 'Transformed_WQVars_Hab_and_aDiv.txt', sep="\t")
w1_cols  = ['StatName', 'InvSimpson', 'FaithsPD', 'Observed.ASVs', 'Habitat', 'Microbial.Clusters']
base_df2 = water_df1.copy().loc[base_df.index, w1_cols]


sample_sheet = pd.read_csv('/Volumes/KeithSSD/CB_V4/otu_data/SampleSheet_052019.tsv', sep="\t")
ss_cols = ['SampleID', '2nd step barcode well','sequencing ID', 'data folder name', 
           'sequencing file forward name', 'sequencing file reverse name', 
           'sequencing file index name']

sample_sheet = sample_sheet.copy()[ss_cols].set_index('SampleID')
sample_sheet = sample_sheet.loc[base_df.index,]
sample_sheet = sample_sheet.rename(columns = {'2nd step barcode well': 'BarcodePrimerWell'})

barcode_lookup = "/Volumes/Macintosh HD/Users/login/Documents/Copy of Preheim_JHU_primer_barcode.xlsx"
barcode_df = pd.read_excel(barcode_lookup, skiprows=list(range(8))).iloc[:, 1:4]
barcode_df.columns = ['BarcodePrimerName', 'BarcodePrimerWell', 'BarcodePrimerSequence']
barcode_df['BarcodePrimerSequence'] = barcode_df['BarcodePrimerSequence'].apply(lambda x: "".join(x.split()))
barcode_df.set_index('BarcodePrimerWell', inplace=True)

sample_sheet['BarcodePrimerSequence'] = sample_sheet.BarcodePrimerWell.map(barcode_df['BarcodePrimerSequence'].to_dict())
sample_sheet['BarcodePrimerName'] = sample_sheet.BarcodePrimerWell.map(barcode_df['BarcodePrimerName'].to_dict())

s1Sheet1 = pd.concat([base_df.copy(), sample_sheet.copy(), base_df2.copy()], axis=1, verify_integrity=True)

s1Sheet1.to_csv('/Volumes/KeithSSD/thesis_mine/CB_Manuscript/Supplementary_Data/S1_provenance_raw.txt', sep="\t")





