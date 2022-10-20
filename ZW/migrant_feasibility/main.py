from src.readv2_to_snomed_search_gdppr import *


def main(project_csv,
         project_codelist_column,
         mapping_file,
         mapping_file_codelist_column,
         mapped_snomed_project_codelist_column,
         mapping_file_gdppr_codelist_column,
         output_prefix
         ):
    # map project codes to readv2 map for table 1

    read_to_snomed_obj = readv2ToSnomedConversion(
        project_df=project_csv,
        project_codelist_column=project_codelist_column,
        mapping_file=mapping_file,
        mapping_file_codelist_column=mapping_file_codelist_column)

    project_read_to_snomed_df = read_to_snomed_obj.map_readV2_to_snomed()
    print(project_read_to_snomed_df.nunique())

    project_read_to_snomed_df.to_csv(
        f'output_data/{output_prefix}_read_v2_to_snomedct.csv')

    print('For read_v2_to_snomedct mapping')
    conversionChecks.get_codes_not_mapped(project_csv,
                                          project_codelist_column,
                                          project_read_to_snomed_df,
                                          mapping_file_codelist_column,
                                          map_flag_col='READV2_MAP_FLAG')

    #   hardcoded refactor
    gdppr_codes_clusters = pd.read_csv(
        'mapping_files/GDPPR_Cluster_Refset_1000230_20220429.csv',
        encoding='unicode_escape')

    # map project_readv2 to gdppr
    project_read_to_snomed_df['ConceptId'] = project_read_to_snomed_df['ConceptId'].astype(
        'Int64')
    gdppr_codes_clusters['ConceptId'] = gdppr_codes_clusters['ConceptId'].astype(
        'Int64')

    snomed_to_gdppr_obj = snomedToGdpprLookUp(
        project_read_to_snomed_df,
        mapped_snomed_project_codelist_column=mapped_snomed_project_codelist_column,
        mapping_file=gdppr_codes_clusters,
        mapping_file_gdppr_codelist_column=mapping_file_gdppr_codelist_column)

    snomed_to_gdppr_df = snomed_to_gdppr_obj.map_snomed_to_gdppr()
    snomed_to_gdppr_df = snomed_to_gdppr_obj.sort_effective_date_and_assured(
        snomed_to_gdppr_df)
    print(snomed_to_gdppr_df.nunique())

    print('For snomedct_to_gdppr mapping')
    conversionChecks.get_codes_not_mapped(
        project_read_to_snomed_df,
        mapped_snomed_project_codelist_column,
        snomed_to_gdppr_df,
        mapping_file_gdppr_codelist_column,
        map_flag_col='GDPPR_MAP_FLAG')

    snomed_to_gdppr_df.to_csv(
        f'output_data/{output_prefix}_snomedct_to_gdppr.csv')


def get_project_code_list_1(data_dir='input_data'):
    converted_project_codelist_1 = pd.read_excel(
        f'{data_dir}/codelist_converted.xlsx', sheet_name='table_1')
    converted_project_codelist_1['read_code'] = converted_project_codelist_1['read_code'].astype(
        str)
    return converted_project_codelist_1


def get_project_code_list_2(data_dir='input_data'):
    converted_project_codelist_2 = pd.read_excel(
        f'{data_dir}/codelist_converted.xlsx', sheet_name='table_2')
    converted_project_codelist_2['read_code'] = converted_project_codelist_2['read_code'].astype(
        str)
    converted_project_codelist_2['read_code'].replace(
        '6951', '6951.00', inplace=True)
    converted_project_codelist_2['read_code'].replace(
        '1695', '1695.00', inplace=True)
    converted_project_codelist_2['read_code'].replace(
        '1343', '1343.00', inplace=True)
    converted_project_codelist_2['read_code'].replace(
        '1345', '1345.00', inplace=True)
    converted_project_codelist_2['read_code'].replace(
        '1344', '1344.00', inplace=True)
    converted_project_codelist_2['read_code'].replace(
        '1342', '1342.00', inplace=True)
    converted_project_codelist_2['read_code'].replace(
        '1347', '1347.00', inplace=True)
    converted_project_codelist_2['read_code'].replace(
        '1348', '1348.00', inplace=True)
    converted_project_codelist_2['read_code'].replace(
        '1346', '1346.00', inplace=True)
    converted_project_codelist_2['read_code'].replace(
        '2263', '2263.00', inplace=True)
    return converted_project_codelist_2


def prepare_mapping_file(data_dir = 'mapping_files'):
    read_snomed_map = pd.read_csv(f'{data_dir}/rcsctmap2_uk_20200401000001.txt',
                                  sep='\t', encoding='unicode_escape')
    prepared_read_snomed_map = (projectDataPreparation
                                .create_read_term_column(read_snomed_map,
                                                         'ReadCode',
                                                         'TermCode',
                                                         'read_term_map'))
    return prepared_read_snomed_map


main(project_csv=get_project_code_list_1(),
     project_codelist_column='read_code',
     mapping_file=prepare_mapping_file(),
     mapping_file_codelist_column='read_term_map',
     mapped_snomed_project_codelist_column='ConceptId',
     mapping_file_gdppr_codelist_column='ConceptId',
     output_prefix='table_1')

# main(project_csv = get_project_code_list_2(),
#      project_codelist_column='read_code',
#      mapping_file=prepared_read_snomed_map,
#      mapping_file_codelist_column='read_term_map',
#      mapped_snomed_project_codelist_column='ConceptId',
#      mapping_file_gdppr_codelist_column='ConceptId',
#      output_prefix='table_2')
