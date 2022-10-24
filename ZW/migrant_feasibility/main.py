from src.readv2_to_snomed_search_gdppr import *
import pandas as pd
import os


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

    #   refactor output location and name into main parameter.
    project_read_to_snomed_df.to_csv(
        f'output_data/{output_prefix}_read_v2_to_snomedct.csv')

    print('For read_v2_to_snomedct mapping')
    conversionChecks.get_codes_not_mapped(project_csv,
                                          project_codelist_column,
                                          project_read_to_snomed_df,
                                          mapping_file_codelist_column,
                                          map_flag_col='READV2_MAP_FLAG')

    #   refactor to bring the mapping file ingestion into a parameter.
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

    print('''For snomedct_to_gdppr mapping
                adding a change''')
    conversionChecks.get_codes_not_mapped(
        project_read_to_snomed_df,
        mapped_snomed_project_codelist_column,
        snomed_to_gdppr_df,
        mapping_file_gdppr_codelist_column,
        map_flag_col='GDPPR_MAP_FLAG')

    #   refactor output location and name into main parameter.
    snomed_to_gdppr_df.to_csv(
        f'output_data/{output_prefix}_snomedct_to_gdppr.csv')

    # formatting output for reseacher convience.
    # format_output(researcher_dir,
    #               researcher_file,
    #               output_dir = f'output_data/',
    #               output_file =  f'{output_prefix}_snomedct_to_gdppr.csv'),
    #               left_on,
    #               right_on)


def get_project_code_list_1(data_dir='input_data'):
    '''
    Reads the codelist as an excel (.xlsx) file.
    Args:
        data_dir:

    Returns:
        the reseachers codelist

    '''
    converted_project_codelist_1 = pd.read_excel(
        # pass the sheet_name to input param
        f'{data_dir}/codelist_converted.xlsx', sheet_name='table_1')
    converted_project_codelist_1['read_code'] = converted_project_codelist_1['read_code'].astype(
        str)
    return converted_project_codelist_1

# replacing some code is specific to the migrant phenotyping work


def get_project_code_list_2(data_dir='input_data'):
    converted_project_codelist_2 = pd.read_excel(
        # pass the sheet_name to input param
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


def prepare_mapping_file(data_dir='mapping_files'):
    read_snomed_map = pd.read_csv(
        f'{data_dir}/rcsctmap2_uk_20200401000001.txt',
        sep='\t',
        encoding='unicode_escape')
    prepared_read_snomed_map = (projectDataPreparation
                                .create_read_term_column(read_snomed_map,
                                                         'ReadCode',
                                                         'TermCode',
                                                         'read_term_map'))
    return prepared_read_snomed_map

# def format_output(researcher_dir ,researcher_file, output_dir, output_file, left_on, right_on):
#     '''
#
#     Args:
#         researcher_dir: codelist_dir
#         researcher_file: codelist_file
#         output_dir: output directory for the final mapping result
#         output_file: final mapping result
#         left_on: left join column
#         right_on: right join column
#
#
#     Returns:
#
#     '''
#     researcher_file = pd.read_excel(os.path.join(researcher_dir, researcher_file))
#     output_file pd.read_excel(os.path.join(output_dir,output_file))
#     return researcher_file.merge(output_file, left_on, right_on, how='left')


# Pass through arg_parse: see ccu_dq repo for an example
main(project_csv=get_project_code_list_2(),
     project_codelist_column='read_code',
     mapping_file=prepare_mapping_file(),
     mapping_file_codelist_column='read_term_map',
     mapped_snomed_project_codelist_column='ConceptId',
     mapping_file_gdppr_codelist_column='ConceptId',
     output_prefix='table_2')

# main(project_csv = get_project_code_list_2(),
#      project_codelist_column='read_code',
#      mapping_file=prepare_mapping_file(),
#      mapping_file_codelist_column='read_term_map',
#      mapped_snomed_project_codelist_column='ConceptId',
#      mapping_file_gdppr_codelist_column='ConceptId',
#      output_prefix='table_2')
