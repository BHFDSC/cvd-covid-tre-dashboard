
import pandas as pd


class projectDataPreparation():
    """
    Project data preparation before feeding into conversion classes
    Attributes:
        project_df: the project codelist as a pd.DataFrame
        project_codelist_column: the column in pd.DataFrame with codes

    """

    def __init__(self,
                 project_df: pd.DataFrame,
                 project_codelist_column: str):

        self.project_df = project_df
        self.project_codelist_column = project_codelist_column

    @staticmethod
    def get_num_unique_vars(df: pd.DataFrame) -> pd.Series:
        """
        Prints the number of unique codes per column in project_df

        Args:
            df: a pd.DataDrame of the supplied df

        Returns:
            a pd.Series with the number of unique values in each column of the supplied df

        Example:
            projectDataPreparation.get_num_unique_vars(df)

        """
        return df.nunique()

    def get_project_codelist(self) -> pd.array:
        """
        Args:
            self.project_df: the project codelist as a pd.DataFrame
            self.project_codelist_column: the column in pd.DataFrame with codes

        Return:
            A pd.array with list of unique codes

        example:
            get_project_codelist(project_dataframe, 'read_code' )

        """
        print(
            f"""The number of unique codes in the supplied dataframe column '{self.project_codelist_column}' is:
        {self.project_df[self.project_codelist_column].nunique()}""")
        return self.project_df[self.project_codelist_column].unique()

    @staticmethod
    def create_read_term_column(df, read_col: str, term_col: str,
                                new_read_term_col_name: str) -> pd.DataFrame:
        """
        Creates a combined Read Code and Term Code column for matchin on researcher code list if necessary.
        Args:
            read_col: read codes column
            term_col: term codes column
            new_read_term_col_name: user defined name for the combined read and term columns

        Return:
            A pd.DataFrame with derrived read term column

        example:
            projectDataPreparation.create_read_term_column(read_snomed_map, 'ReadCode', 'TermCode','read_term_map')
        """

        if not isinstance(
                df[read_col][0],
                str) and not isinstance(
                df[term_col][0],
                str):
            print(f'Converting {read_col} and {term_col} to strings')
            df[term_col] = df[term_col].astype('str')
            df[read_col] = df[read_col].astype('str')

        else:
            assert isinstance(
                df[read_col][0], str), f'Data Type for {read_col} is type {type(df[read_col][0])} not {str} '
            assert isinstance(
                df[term_col][0], str), f'Data Type for {term_col} is type {type(df[term_col][0])} not {str} '

            df[new_read_term_col_name] = df[[
                read_col, term_col]].apply("".join, axis=1)

            return df


class conversionChecks:

    @staticmethod
    def get_codes_not_mapped(input_df,
                             input_df_column,
                             mapped_df,
                             mapped_df_column,
                             map_flag_col):

        #         lost_codes = input_df[~input_df[input_df_column].isin(mapped_df[mapped_df_column].unique())]
        lost_codes = mapped_df.loc[mapped_df[map_flag_col] == 0]

        mapped_df = mapped_df.loc[mapped_df[map_flag_col] == 1]

        print(f'''

        Successfully mapped {mapped_df[mapped_df_column].nunique()} codes from mapped_file of
         {input_df[input_df_column].nunique()} codes found in the input_df

        ''')

        if len(lost_codes) > 0:
            print(f'{len(lost_codes)} not mapped.')
            print(f'''Printing codes that did not map:
                    {lost_codes}''')
        else:
            None


class readv2ToSnomedConversion(projectDataPreparation):
    def __init__(self,
                 project_df: pd.DataFrame,
                 project_codelist_column: str,
                 mapping_file: pd.DataFrame,
                 mapping_file_codelist_column: str):

        self.project_df = project_df
        self.project_codelist_column = project_codelist_column
        self.mapping_file = mapping_file
        self.mapping_file_codelist_column = mapping_file_codelist_column
        super().__init__(project_df, project_codelist_column)

    def map_readV2_to_snomed(self):
        read_snomed_mapped = self.project_df.merge(
            self.mapping_file,
            left_on=self.project_codelist_column,
            right_on=self.mapping_file_codelist_column,
            how='left',
            suffixes=('_project_df_file', '_read_snomed_map_file'))

        read_snomed_mapped['READV2_MAP_FLAG'] = (
            read_snomed_mapped['MapId'] .where(
                read_snomed_mapped['MapId'] .isnull(),
                1) .fillna(0) .astype(int))

        return read_snomed_mapped


class snomedToGdpprLookUp():
    def __init__(self,
                 mapped_snomed_project_df: pd.DataFrame,
                 mapped_snomed_project_codelist_column: str,
                 mapping_file: pd.DataFrame,
                 mapping_file_gdppr_codelist_column: str):

        self.mapped_snomed_project_df = mapped_snomed_project_df
        self.mapped_snomed_project_codelist_column = mapped_snomed_project_codelist_column
        self.mapping_file = mapping_file
        self.mapping_file_gdppr_codelist_column = mapping_file_gdppr_codelist_column

    def map_snomed_to_gdppr(self):

        map_snomed_to_gdppr_df = self.mapped_snomed_project_df.merge(
            self.mapping_file,
            left_on=self.mapping_file_gdppr_codelist_column,
            right_on=self.mapped_snomed_project_codelist_column,
            suffixes=['_project_codelist', '_gdppr'], how='left', indicator=True)

        map_snomed_to_gdppr_df['GDPPR_MAP_FLAG'] = (
            map_snomed_to_gdppr_df['Active_in_Refset'] .where(
                map_snomed_to_gdppr_df['Active_in_Refset'] .isnull(),
                1) .fillna(0) .astype(int))

        return map_snomed_to_gdppr_df

    def sort_effective_date_and_assured(self, snomed_gddppr_map_df):
        sort_effective_date_and_assured_df = (
            snomed_gddppr_map_df .where(
                (snomed_gddppr_map_df.IS_ASSURED == 1) & (
                    snomed_gddppr_map_df.MapStatus == 1)) .sort_values(
                [
                    'read_code',
                    'EffectiveDate'],
                ascending=False))

        sort_effective_date_and_assured_df = (sort_effective_date_and_assured_df .drop_duplicates([
                                              'read_term', 'ConceptId','MapId'], keep='first'))

        return sort_effective_date_and_assured_df
