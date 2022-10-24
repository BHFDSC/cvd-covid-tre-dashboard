import pandas as pd
import pytest

def get_sorted_unique_input_codelist(data_file, sheet_name, codelist):
    '''Reseacher codelist'''
    df = pd.read_excel(data_file, sheet_name)
    df[codelist] = df[codelist].astype('str')
    return sorted(df[codelist].unique())


researcher_codelist_1 = get_sorted_unique_input_codelist('../input_data/codelist_converted.xlsx',
                                              sheet_name='table_1',
                                              codelist = 'read_code')
researcher_codelist_2 = get_sorted_unique_input_codelist('../input_data/codelist_converted.xlsx',
                                              sheet_name='table_2',
                                              codelist = 'read_code')

print(researcher_codelist_1)
print('run')

def get_sorted_unique_output_codelist(data_file, codelist):
    '''Output'''
    df = pd.read_csv(data_file)
    df[codelist] = df[codelist].astype('str')
    return sorted(df[codelist].unique())

output_codelist_1 = get_sorted_unique_output_codelist('../output_data/table_1_snomedct_to_gdppr.csv',
                                              codelist = 'read_code')

output_codelist_2 = get_sorted_unique_output_codelist('../output_data/table_1_snomedct_to_gdppr.csv',
                                              codelist = 'read_code')
#
def test_inputcodelist_equals_output_codelist():
    '''
    This test asserts the codelist outputs contain
    the same unique sorted list as the inputs
    '''
    assert researcher_codelist_1 == output_codelist_1, 'tough luck'
    assert researcher_codelist_2 == output_codelist_2, 'tough luck'
