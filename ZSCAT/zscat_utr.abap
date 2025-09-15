*&---------------------------------------------------------------------*
*& Report ZSCAT_UTR
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zscat_utr.

INCLUDE zutn_scat_top.
INCLUDE zutn_scat_sel.
INCLUDE zutn_scat_sub.
INCLUDE zutn_scat_sub_src.

*&---------------------------------------------------------------------*
*& EVENT - INITIALIZATION
*&---------------------------------------------------------------------*

INITIALIZATION.

* Get master data table with PGMID/Object Type/Object Type Description

  CALL FUNCTION 'TR_OBJECT_TABLE'
    TABLES
      wt_object_text = it_obtab.

  SORT it_obtab BY object.

* Restrict the select options  for RFC Destination with no hig values

  it_optlist-name = 'OBJECTKEY1'.
  it_optlist-options-eq = 'X'.
  APPEND it_optlist TO wa_restrict-opt_list_tab.

  it_ass-kind = 'S'.
  it_ass-name = 'S_RFC'.
  it_ass-sg_main = 'I'.
  it_ass-sg_addy = space.
  it_ass-op_main = 'OBJECTKEY1'.
  APPEND it_ass TO wa_restrict-ass_tab.

  CALL FUNCTION 'SELECT_OPTIONS_RESTRICT'
    EXPORTING
      restriction            = wa_restrict
    EXCEPTIONS
      too_late               = 1
      repeated               = 2
      selopt_without_options = 3
      selopt_without_signs   = 4
      invalid_sign           = 5
      empty_option_list      = 6
      invalid_kind           = 7
      repeated_kind_a        = 8
      OTHERS                 = 9.
  IF sy-subrc NE 0.
    CLEAR wa_restrict.
  ENDIF.

  g_functxt-icon_id   = icon_information.
  g_functxt-quickinfo = 'Information about the SCAT Tool'.
  g_functxt-icon_text = 'Information'.

  sscrfields-functxt_01 = g_functxt.

  g_functxt-icon_id   = icon_display_text.
  g_functxt-quickinfo = 'Pre-Requistes of the SCAT Tool'.
  g_functxt-icon_text = 'Pre-Requistes'.

  sscrfields-functxt_02 = g_functxt.



*&---------------------------------------------------------------------*
*& EVENT - AT SELECTION-SCREEN OUTPUT
*&---------------------------------------------------------------------*

AT SELECTION-SCREEN OUTPUT.

*----------------------------------------------------
*RFC Connection Test
*----------------------------------------------------


  IF p_rfct = abap_true.
    CLEAR g_group1.
    g_group1 = 'RFC'.
    PERFORM screen USING g_group1.
  ENDIF.

*----------------------------------------------------
* Comparisons
*----------------------------------------------------

*Table Comparison
  IF p_comp = abap_true.
    IF p_gen = abap_true AND p_tab = abap_true.
      CLEAR g_group1.
      g_group1 = 'TAB'.
      PERFORM screen USING g_group1.
*Variant Comparison
    ELSEIF p_gen = abap_true AND p_cust = abap_true.
      CLEAR g_group1.
      g_group1 = 'OPT'.
      PERFORM screen USING g_group1.
    ELSEIF p_gen = abap_true AND p_var = abap_true.
      CLEAR g_group1.
      g_group1 = 'COP'.
      PERFORM screen USING g_group1.
*Graphics Comparison
    ELSEIF p_gen = abap_true AND p_grap = abap_true.
      CLEAR g_group1.
      g_group1 = 'COP'.
      PERFORM screen USING g_group1.
*Standard Text Comparison
    ELSEIF p_gen = abap_true AND p_text = abap_true.
      CLEAR g_group1.
      g_group1 = 'COP'.
      PERFORM screen USING g_group1.
*Custom Page Format Comparison
    ELSEIF p_gen = abap_true AND p_page = abap_true.
      CLEAR g_group1.
      g_group1 = 'COP'.
      PERFORM screen USING g_group1.
*Partner Profile Comparison
    ELSEIF p_int = abap_true AND p_pprf = abap_true.
      CLEAR g_group1.
      g_group1 = 'PPF'.
      PERFORM screen USING g_group1.
*Distribution Model Comparison
    ELSEIF p_int = abap_true AND p_dimo = abap_true.
      CLEAR g_group1.
      g_group1 = 'COP'.
      PERFORM screen USING g_group1.
*Ext. OS Commands Comparison
    ELSEIF p_gen = abap_true AND p_extc = abap_true.
      CLEAR g_group1.
      g_group1 = 'COP'.
      PERFORM screen USING g_group1.
*Message Classes Comparison
    ELSEIF p_gen = abap_true AND p_mesg = abap_true.
      CLEAR g_group1.
      g_group1 = 'COP'.
      PERFORM screen USING g_group1.
*Workflow Event Linkage Comparison
    ELSEIF p_gen = abap_true AND p_aelc = abap_true.
      CLEAR g_group1.
      g_group1 = 'COP'.
      PERFORM screen USING g_group1.
*Ports Comparison
    ELSEIF p_gen = abap_true AND p_port = abap_true.
      CLEAR g_group1.
      g_group1 = 'COP'.
      PERFORM screen USING g_group1.
*Fonts Comparison
    ELSEIF p_gen = abap_true AND p_font = abap_true.
      CLEAR g_group1.
      g_group1 = 'COP'.
      PERFORM screen USING g_group1.
*Barcode Comparison
    ELSEIF p_gen = abap_true AND p_barc = abap_true.
      CLEAR g_group1.
      g_group1 = 'COP'.
      PERFORM screen USING g_group1.
*Change Pointers Comparison
    ELSEIF p_gen = abap_true AND p_chpt = abap_true.
      CLEAR g_group1.
      g_group1 = 'COP'.
      PERFORM screen USING g_group1.
*VOFM Routines Comparison
    ELSEIF p_gen = abap_true AND p_vofm = abap_true.
      CLEAR g_group1.
      g_group1 = 'COP'.
      PERFORM screen USING g_group1.
    ENDIF.
  ENDIF.

*----------------------------------------------------
* Transport Utility
*----------------------------------------------------

*Status of Released Transports
  IF p_util = abap_true AND p_sort = abap_true.
    CLEAR g_group1.
    g_group1 = 'SRT'.
    PERFORM screen USING g_group1.
*List of Open Transports
  ELSEIF p_util = abap_true AND p_lopt = abap_true.
    CLEAR g_group1.
    g_group1 = 'LPT'.
    PERFORM screen USING g_group1..
*Dependency in Quality By Object
  ELSEIF p_util = abap_true AND p_dqob = abap_true.
    CLEAR g_group1.
    g_group1 = 'DOB'.
    PERFORM screen USING g_group1.
*Dependency in Development
  ELSEIF p_util = abap_true AND p_ddev = abap_true.
    IF p_trpt IS NOT INITIAL.
      CLEAR: g_group1.
      g_group1 = 'DEV'.
      PERFORM screen USING g_group1.
    ELSEIF p_objt IS NOT INITIAL.
      CLEAR: g_group1.
      g_group1 = 'DDP'.
      PERFORM screen USING g_group1.

    ENDIF.
  ENDIF.
*Conflict Check
  IF p_cchk = abap_true.
    CLEAR g_group1.
    g_group1 = 'CCK'.
    PERFORM screen USING g_group1.
  ENDIF.

*----------------------------------------------------
* Other Utilities
*----------------------------------------------------
  IF p_othr = abap_true.
    CLEAR g_group1.
    g_group1 = 'OTH'.
    PERFORM screen USING g_group1.
  ENDIF.

*Reset all the Parameters, Select Options and Radiobuttons on change

  IF g_ucomm = 'CMD1'  OR
     g_ucomm = 'OPT'   OR
     g_ucomm = 'CMD2'  OR
     g_ucomm = 'PPF'   OR
     g_ucomm = 'TUL'   OR
     g_ucomm = 'CHECK' OR
     g_ucomm = 'CMN1'  OR
     g_ucomm = 'OTHR'.

    REFRESH: s_rfc, s_owner, s_tran, s_sdate, s_own, s_trans, s_trns,
             s_ctrfc, s_objnam, s_pkg.
    CLEAR: p_tabnm, p_rrfc,  p_scrfc, p_tcrfc, p_sprfc, p_tprfc, p_psprfc, p_ptprfc,
           p_rc, p_rfc, p_clnt, p_sys, p_qual, p_prod, p_obj,  p_qua, p_prd, p_trsp, p_sysid,
           p_csrfc, s_ctrfc.

  ENDIF.

  IF g_ucomm = 'OPT'.

    IF p_comp EQ abap_true.
      PERFORM comp_reset.
    ELSEIF p_util EQ abap_true.
      PERFORM tul_reset.
    ELSEIF p_cchk EQ abap_true.
      PERFORM z_cck_reset.
    ELSEIF p_othr EQ abap_true.
      PERFORM z_oth_reset.
    ENDIF.
  ENDIF.

  IF g_ucomm = 'CMN1'.
    PERFORM comp_reset.
  ENDIF.

  IF g_ucomm = 'CMD1'.
    PERFORM ppf_reset.
  ENDIF.

  CLEAR g_ucomm.

*&---------------------------------------------------------------------*
*& EVENT - AT SELECTION-SCREEN ON VALUE REQUEST
*&---------------------------------------------------------------------*

AT SELECTION-SCREEN ON VALUE-REQUEST FOR s_rfc-low.

* Logic to display F4 help on the field for RFC Destinations
* F4 help here will only show for ABAP Connections - Type 3

  CLEAR:   it_rfc,
           it_rfc_ret.

  SELECT rfcdest
    FROM rfcdes
    INTO TABLE it_rfc
   WHERE rfctype EQ c_abap_conn.

  IF sy-subrc EQ 0.

    SORT it_rfc BY rfcdest.

    CALL FUNCTION 'F4IF_INT_TABLE_VALUE_REQUEST'
      EXPORTING
        retfield        = 'S_RFC-LOW'
        value_org       = 'S'
      TABLES
        value_tab       = it_rfc
        return_tab      = it_rfc_ret
      EXCEPTIONS
        parameter_error = 1
        no_values_found = 2.

    SORT it_rfc_ret BY fieldname.

    READ TABLE it_rfc_ret INTO wa_return
           WITH KEY fieldname = 'F0001' BINARY SEARCH.
    IF sy-subrc EQ 0.
      s_rfc-low = wa_return-fieldval.
    ENDIF. "sy-subrc EQ 0.

  ENDIF. "sy-subrc EQ 0.

*&---------------------------------------------------------------------*
*& EVENT - AT SELECTION-SCREEN ON VALUE REQUEST
*&---------------------------------------------------------------------*

AT SELECTION-SCREEN ON VALUE-REQUEST FOR s_objnam-low.

* Logic to display F4 help on the field for Object Name

  DATA: l_objtyp      TYPE euobj-id,
        l_selobj      TYPE trobj_name,
        l_sel_enclobj TYPE trobj_name.

  IF p_prog EQ abap_true.
    MOVE: c_prog TO l_objtyp.
  ELSEIF p_func EQ abap_true.
    MOVE: c_func TO l_objtyp.
  ELSEIF p_fugr EQ abap_true.
    MOVE: c_fugp TO l_objtyp.
  ELSEIF p_clas EQ abap_true.
    MOVE: c_clas TO l_objtyp.
  ENDIF. "p_prog EQ abap_true


  CALL FUNCTION 'REPOSITORY_INFO_SYSTEM_F4'
    EXPORTING
      object_type               = l_objtyp
      object_name               = s_objnam-low
    IMPORTING
      object_name_selected      = l_selobj
      enclosing_object_selected = l_sel_enclobj
    EXCEPTIONS
      cancel                    = 1
      wrong_type                = 2
      OTHERS                    = 3.
  IF sy-subrc EQ 0.
    MOVE: l_selobj TO s_objnam-low.
  ENDIF.

*&---------------------------------------------------------------------*
*& EVENT - AT SELECTION-SCREEN ON BLOCK
*&---------------------------------------------------------------------*


*----------------------------------------------------
* RFC Connection Test
*----------------------------------------------------


AT SELECTION-SCREEN ON BLOCK rfctest.

  IF p_rfct IS NOT INITIAL.

    PERFORM z_validate_rfc.

  ENDIF. "p_rfct IS NOT INITIAL

*----------------------------------------------------
* Comparisons
*----------------------------------------------------

AT SELECTION-SCREEN ON BLOCK tabcp.

  PERFORM z_validate_tabcp.


AT SELECTION-SCREEN ON BLOCK comp.

  PERFORM z_validate_comp.

AT SELECTION-SCREEN ON BLOCK partner.

  PERFORM z_validate_partner.

*----------------------------------------------------
* Transport Utility
*----------------------------------------------------

AT SELECTION-SCREEN ON BLOCK relstat.

  PERFORM z_validate_relstat.

AT SELECTION-SCREEN ON BLOCK opentr.

  PERFORM z_validate_opentr.

*at selection-screen on block deptr.
*
*  perform z_validate_deptr.

AT SELECTION-SCREEN ON BLOCK trobj.

  PERFORM z_validate_depobj.

AT SELECTION-SCREEN ON BLOCK depen.

  PERFORM z_validate_depen.

* Start of BSINGH-14-JAN-2017(+)
*----------------------------------------------------
* Source Code Comparison Utility
*----------------------------------------------------

AT SELECTION-SCREEN ON BLOCK confl.

  IF p_cchk IS NOT INITIAL.

    PERFORM z_validate_codecomp.

  ENDIF. "p_cchk IS NOT INITIAL.

* End of BSINGH-14-JAN-2017(+)

*&---------------------------------------------------------------------*
*& EVENT - AT SELECTION-SCREEN
*&---------------------------------------------------------------------*
AT SELECTION-SCREEN.

  CLEAR g_ucomm.
  g_ucomm = sy-ucomm.

*  Start of BSINGH-02-JAN-2016 (+)

*----------------------------------------------------
* For Push Buttons on Tool bar
*----------------------------------------------------

  CASE sscrfields-ucomm.

    WHEN 'FC01'.

      g_infoline1 = 'SCAT (SAP Cutover Activities Tool) is a tool to generate a'.
      g_infoline2 = 'variety of reports which will help the technical team to'.
      g_infoline3 = 'identify discrepancies between two systems in the landscape'.
      g_infoline4 = 'during cutover, testing, hypercare and support phases.'.
      g_infoline5 = 'The tool also has transport management and additional'.
      g_infoline6 = 'features to do a health check of your systems'.

      CALL FUNCTION 'POPUP_FOR_INTERACTION'
        EXPORTING
          headline = 'Information on the SCAT Tool'
          text1    = g_infoline1
          text2    = g_infoline2
          text3    = g_infoline3
          text4    = g_infoline4
          text5    = g_infoline5
          text6    = g_infoline6
          button_1 = 'OK'.

    WHEN 'FC02'.

      g_infoline1 = 'The development system (where the SCAT program resides)'.
      g_infoline2 = 'needs to be connected to other systems of Quality/Production'.
      g_infoline3 = 'with ABAP RFC Connections. The RFC Connections should have'.
      g_infoline4 = 'Logon credentials configured with a user of the type – '.
      g_infoline5 = 'System User.'.


      CALL FUNCTION 'POPUP_FOR_INTERACTION'
        EXPORTING
          headline = 'Pre-Requistes of the SCAT Tool'
          text1    = g_infoline1
          text2    = g_infoline2
          text3    = g_infoline3
          text4    = g_infoline4
          text5    = g_infoline5
          button_1 = 'OK'.

    WHEN OTHERS.
  ENDCASE.

*  End of BSINGH-02-JAN-2016

*&---------------------------------------------------------------------*
*& EVENT - START-OF-SELECTION
*&---------------------------------------------------------------------*

START-OF-SELECTION.

*Start of JTHAKKAR (Log Features in ZSCAT_LOG Table)
*----------------------------------------------------
* Log Features and Sub Features in ZSCAT_LOG Table
*----------------------------------------------------
*  PERFORM z_log_feature.

*End of JTHAKKAR (Log Features in ZSCAT_LOG Table)

  g_srcsys = p_scrfc.
  g_tgtsys = p_tcrfc.

*----------------------------------------------------
* RFC Connection Test
*----------------------------------------------------


  IF p_rfct IS NOT INITIAL.

    PERFORM z_rfc_test.

  ENDIF. "p_rfct IS NOT INITIAL.

*----------------------------------------------------
* Comparisons
*----------------------------------------------------

  IF p_comp IS NOT INITIAL AND p_gen IS NOT INITIAL.

*----------------------------------------------------
* Comparisons - Table Comparison
*----------------------------------------------------

    IF p_tab IS NOT INITIAL.

      PERFORM z_compare_table.

    ENDIF. "p_tab IS NOT INITIAL

*----------------------------------------------------
* Comparisons - Graphics Comparison
*----------------------------------------------------

    IF p_grap IS NOT INITIAL.

      PERFORM z_compare_graphics.

    ENDIF. "p_grap IS NOT INITIAL

*----------------------------------------------------
* Comparisons - Variant Comparison
*----------------------------------------------------

    IF p_var IS NOT INITIAL.

      PERFORM z_compare_variants.

    ENDIF."p_var IS NOT INITIAL.

*----------------------------------------------------
* Comparisons - Standard Text Comparison
*----------------------------------------------------

    IF p_text IS NOT INITIAL.

      PERFORM z_compare_sttexts.

    ENDIF. "p_text IS NOT INITIAL

*----------------------------------------------------
* Comparisons - Page Format Comparison
*----------------------------------------------------

    IF p_page IS NOT INITIAL.

      PERFORM z_compare_pformat.

    ENDIF. "p_page IS NOT INITIAL


*----------------------------------------------------
* Comparisons - External Commands Comparison
*----------------------------------------------------

    IF p_extc IS NOT INITIAL.

      PERFORM z_compare_extc.

    ENDIF. "p_extc IS NOT INITIAL

*----------------------------------------------------
* Comparisons - Message Class Comparison
*----------------------------------------------------

    IF p_mesg IS NOT INITIAL.

      PERFORM z_compare_mesg.

    ENDIF. "p_mesg IS NOT INITIAL

*----------------------------------------------------
* Comparisons - Workflow Event Linkage Comparison
*----------------------------------------------------

*{  Begin of Santosh
    IF p_aelc IS NOT INITIAL.

      PERFORM z_compare_wfevents.

    ENDIF. "p_grap IS NOT INITIAL  " End of Santosh

*{Begin of VenkatMani.P
*----------------------------------------------------
* Comparisons - Ports               ++04/05/2017
*----------------------------------------------------
    IF p_port IS NOT INITIAL.

      PERFORM z_compare_ports.

    ENDIF. "p_port IS NOT INITIAL.

*----------------------------------------------------
* Comparisons - Fonts               ++04/05/2017
*----------------------------------------------------
    IF p_font IS NOT INITIAL.

      PERFORM z_compare_fonts.

    ENDIF. "p_font IS NOT INITIAL.

*----------------------------------------------------
* Comparisons - Barcodes               ++04/05/2017
*----------------------------------------------------
    IF p_barc IS NOT INITIAL.

      PERFORM z_compare_barcodes.

    ENDIF. "p_barc IS NOT INITIAL.

*----------------------------------------------------
* Comparisons - Change Pointers               ++04/05/2017
*----------------------------------------------------
    IF p_chpt IS NOT INITIAL.

      PERFORM z_compare_changepointers.

    ENDIF. "p_chpt IS NOT INITIAL.

*----------------------------------------------------
* Comparisons - VOFM Routines               ++04/10/2017
*----------------------------------------------------
    IF p_vofm IS NOT INITIAL.

      PERFORM z_compare_vofmroutines.

    ENDIF. "p_vofm IS NOT INITIAL.   }*End of VenkatMani.P

  ENDIF. "p_comp IS NOT INITIAL.

  IF p_comp IS NOT INITIAL AND p_int IS NOT INITIAL.

*----------------------------------------------------
* Comparisons - Partner Profile Comparison
*----------------------------------------------------

    IF p_pprf IS NOT INITIAL.

      PERFORM z_compare_partners.

    ENDIF. "p_pprf IS NOT INITIAL

*----------------------------------------------------
* Comparisons - Distribution Model Comparison
*----------------------------------------------------

    IF p_dimo IS NOT INITIAL.

      PERFORM z_compare_dmodel.

    ENDIF. "p_dimo IS NOT INITIAL

  ENDIF.


*----------------------------------------------------
* Transport Utility
*----------------------------------------------------
*----------------------------------------------------
  IF p_util IS NOT INITIAL.

*----------------------------------------------------
* Transport Utility - Status of Released Transport
*----------------------------------------------------

    IF p_sort IS NOT INITIAL.

      PERFORM z_get_reltr_stat.

    ENDIF. "p_sort IS NOT INITIAL.

*----------------------------------------------------
* Transport Utility - List of Open Transport
*----------------------------------------------------

    IF p_lopt IS NOT INITIAL.

      PERFORM z_get_open_tr.

    ENDIF. "p_lopt IS NOT INITIAL.

*----------------------------------------------------
* Transport Utility - Dependency in Quality - TR#
*----------------------------------------------------

*    IF p_dqtr IS NOT INITIAL.
*
**      PERFORM z_get_dep_by_tr.
*
*    ENDIF. "p_dqob IS NOT INITIAL.

*----------------------------------------------------
* Transport Utility - Dependency in Quality - Object
*----------------------------------------------------

    IF p_dqob IS NOT INITIAL.

      PERFORM z_get_tr_by_obj.

    ENDIF. "p_dqob IS NOT INITIAL.

*----------------------------------------------------
* Transport Utility - Dependency in Development
*----------------------------------------------------

    IF p_ddev IS NOT INITIAL.

      PERFORM z_get_dev_dep.

    ENDIF. "p_ddev IS NOT INITIAL.

  ENDIF. "p_util IS NOT INITIAL.

* End of BSINGH-14-JAN-2017(+)

*----------------------------------------------------
* Code Comparison Utility
*----------------------------------------------------

  IF p_cchk IS NOT INITIAL.

    PERFORM z_code_compare.

  ENDIF. "p_cchk IS NOT INITIAL.

*  End of BSINGH-14-JAN-2017(+)
*----------------------------------------------------
* Other Utilities
*----------------------------------------------------

  IF p_othr IS NOT INITIAL.

    IF p_tmp IS NOT INITIAL.

      PERFORM z_tmp_list.

    ENDIF. "p_tmp IS NOT INITIAL.

    IF p_sttp IS NOT INITIAL.

      PERFORM z_unlck_std_txt.

    ENDIF. "p_tmp IS NOT INITIAL.

  ENDIF. "p_othr IS NOT INITIAL.
