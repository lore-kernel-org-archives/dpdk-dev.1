Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3315CAC5AE
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Sep 2025 15:56:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 09E1140677;
	Fri, 26 Sep 2025 17:56:56 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id B038340261
 for <dev@dpdk.org>; Fri, 26 Sep 2025 17:56:53 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 9F42946F8B; Fri, 26 Sep 2025 17:56:53 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1794] mlx5 PMD does not follow global symbol naming
 conventions
Date: Fri, 26 Sep 2025 15:56:53 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 25.07
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: minor
X-Bugzilla-Who: stephen@networkplumber.org
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1794-3@https.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17589022130.c1Ec2.2695879
Content-Transfer-Encoding: 7bit
X-Bugzilla-URL: https://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All
MIME-Version: 1.0
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org


--17589022130.c1Ec2.2695879
Date: Fri, 26 Sep 2025 17:56:53 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1794

            Bug ID: 1794
           Summary: mlx5 PMD does not follow global symbol naming
                    conventions
           Product: DPDK
           Version: 25.07
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: minor
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: stephen@networkplumber.org
  Target Milestone: ---

To avoid potential symbol name conflicts all drivers should use a consistent
prefix on global symbols. These functions and variable names should either =
be
renamed or better yet made static where possible.


 The MLX5 device has some problematic symbols:

nm librte_net_mlx5.a | grep ' [TDB] ' | grep -v 'mlx5'

0000000000000000 D devx_obj_ops
0000000000005760 T flow_aso_age_get_by_idx
0000000000000000 D flow_drv_ops
0000000000002dd0 T flow_drv_rxq_flags_set
00000000000057e0 T flow_dv_mreg_clone_cb
0000000000005880 T flow_dv_mreg_clone_free_cb
0000000000005920 T flow_dv_mreg_create_cb
00000000000057d0 T flow_dv_mreg_match_cb
0000000000006450 T flow_dv_mreg_remove_cb
0000000000006a00 T flow_hw_rxq_flag_set
000000000000b180 T flow_legacy_list_create
0000000000005d90 T flow_legacy_list_destroy
0000000000000036 T flow_null_counter_allocate
0000000000000069 T flow_null_counter_free
0000000000000097 T flow_null_counter_query
0000000000000000 T flow_null_get_aged_flows
0000000000006d60 T flow_release_workspace
0000000000003bf0 T flow_validate_modify_field_level
0000000000008850 T save_dump_file
0000000000022fc0 T flow_dv_action_create
0000000000006730 T flow_dv_action_destroy
0000000000005f40 T flow_dv_action_query
00000000000212f0 T flow_dv_action_rss_hrxq_lookup
0000000000022e20 T flow_dv_action_rss_l34_hash_adjust
0000000000005790 T flow_dv_action_update
0000000000004ce0 T flow_dv_action_validate
0000000000016b80 T flow_dv_convert_encap_data
000000000000bea0 T flow_dv_convert_modify_action
0000000000020920 T flow_dv_dest_array_clone_cb
0000000000020a10 T flow_dv_dest_array_clone_free_cb
0000000000021d00 T flow_dv_dest_array_create_cb
0000000000022780 T flow_dv_dest_array_match_cb
0000000000022b40 T flow_dv_dest_array_remove_cb
0000000000016b60 T flow_dv_get_item_hdr_len
000000000001bdd0 T flow_dv_hashfields_set
0000000000016910 T flow_dv_port_id_clone_cb
0000000000016990 T flow_dv_port_id_clone_free_cb
0000000000016830 T flow_dv_port_id_create_cb
0000000000016810 T flow_dv_port_id_match_cb
0000000000022a30 T flow_dv_port_id_remove_cb
0000000000016ad0 T flow_dv_push_vlan_clone_cb
0000000000016b50 T flow_dv_push_vlan_clone_free_cb
00000000000169c0 T flow_dv_push_vlan_create_cb
00000000000169a0 T flow_dv_push_vlan_match_cb
0000000000022a70 T flow_dv_push_vlan_remove_cb
0000000000020810 T flow_dv_sample_clone_cb
00000000000208f0 T flow_dv_sample_clone_free_cb
0000000000021ad0 T flow_dv_sample_create_cb
0000000000021a40 T flow_dv_sample_match_cb
0000000000022ab0 T flow_dv_sample_remove_cb
00000000000020c0 T flow_dv_tag_clone_cb
0000000000000b80 T flow_dv_tag_clone_free_cb
0000000000000ac0 T flow_dv_tag_create_cb
0000000000000010 T flow_dv_tag_match_cb
0000000000000b90 T flow_dv_tag_remove_cb
0000000000017ce0 T flow_dv_tbl_clone_cb
0000000000017d70 T flow_dv_tbl_clone_free_cb
0000000000017900 T flow_dv_tbl_create_cb
0000000000017c60 T flow_dv_tbl_match_cb
000000000001a3e0 T flow_dv_tbl_remove_cb
0000000000017d80 T flow_dv_tbl_resource_get
000000000001a4f0 T flow_dv_tbl_resource_release
0000000000020a40 T __flow_dv_translate_items_hws
00000000000212d0 T flow_dv_translate_items_hws
00000000000112f0 T flow_dv_validate
0000000000004ac0 T flow_encap_decap_clone_cb
0000000000000a80 T flow_encap_decap_clone_free_cb
0000000000000860 T flow_encap_decap_create_cb
0000000000000580 T flow_encap_decap_match_cb
0000000000001ab0 T flow_encap_decap_remove_cb
0000000000016490 T __flow_encap_decap_resource_register
00000000000218d0 T flow_encap_decap_resource_release
0000000000001f40 T flow_matcher_clone_cb
0000000000000000 T flow_matcher_clone_free_cb
0000000000001b70 T flow_matcher_create_cb
0000000000000620 T flow_matcher_match_cb
0000000000001a60 T flow_matcher_remove_cb
0000000000001eb0 T flow_modify_clone_cb
0000000000000aa0 T flow_modify_clone_free_cb
0000000000000bf0 T flow_modify_create_cb
0000000000017570 T __flow_modify_hdr_resource_register
00000000000005e0 T flow_modify_match_cb
0000000000001b10 T flow_modify_remove_cb
00000000000002e0 D modify_eth
0000000000000220 D modify_ipv4
0000000000000140 D modify_ipv6
0000000000000100 D modify_ipv6_traffic_class
0000000000000040 D modify_tcp
00000000000000c0 D modify_udp
00000000000002a0 D modify_vlan_out_first_vid
0000000000000000 D reg_to_field
0000000000000fd0 T flow_dv_item_create
0000000000002430 T flow_dv_item_release
00000000000042e0 T flow_dv_meter_find_by_idx
00000000000003a0 T flow_nta_handle_rss
00000000000002f0 T flow_nta_locate_rss
0000000000000000 D rss_hash_default_key
0000000000000090 T rxq_alloc_elts
00000000000005c0 T rxq_sync_cq
0000000000000000 D txoff_func
0000000000000000 T txq_alloc_elts
00000000000001d6 T txq_free_elts
000000000003e6a0 T flow_hw_clear_port_info
000000000003e760 T flow_hw_create_flow
000000000003e3f0 T flow_hw_create_vport_action
000000000003f020 T flow_hw_destroy
000000000003e4c0 T flow_hw_destroy_vport_action
0000000000041e10 T flow_hw_get_ecpri_parser_profile
000000000003e340 T flow_hw_grp_clone_cb
000000000003e3e0 T flow_hw_grp_clone_free_cb
000000000003dec0 T flow_hw_grp_create_cb
000000000003e2f0 T flow_hw_grp_match_cb
000000000003e2a0 T flow_hw_grp_remove_cb
0000000000002271 T flow_hw_init
000000000003f350 T flow_hw_list_destroy
000000000003da40 T flow_hw_q_flow_flush
000000000003e600 T flow_hw_resource_release
000000000003e630 T flow_hw_set_port_info
000000000003dc50 T flow_hw_table_update
0000000000000330 T flow_nta_mreg_create_cb
00000000000005c0 T flow_nta_mreg_remove_cb
0000000000000000 B server_intr_handle
0000000000000000 D server_socket
0000000000000000 D ibv_obj_ops
0000000000000000 D dr_crc_inner_crc_tab16
0000000000000200 D dr_ste_crc_tab32

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17589022130.c1Ec2.2695879
Date: Fri, 26 Sep 2025 17:56:53 +0200
MIME-Version: 1.0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

<html>
    <head>
      <base href=3D"https://bugs.dpdk.org/">
    </head>
    <body><table border=3D"1" cellspacing=3D"0" cellpadding=3D"8" class=3D"=
bz_new_table">
        <tr>
          <th>Bug ID</th>
          <td><a class=3D"bz_bug_link=20
          bz_status_UNCONFIRMED "
   title=3D"UNCONFIRMED - mlx5 PMD does not follow global symbol naming con=
ventions"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1794">1794</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>mlx5 PMD does not follow global symbol naming conventions
          </td>
        </tr>

        <tr>
          <th>Product</th>
          <td>DPDK
          </td>
        </tr>

        <tr>
          <th>Version</th>
          <td>25.07
          </td>
        </tr>

        <tr>
          <th>Hardware</th>
          <td>All
          </td>
        </tr>

        <tr>
          <th>OS</th>
          <td>All
          </td>
        </tr>

        <tr>
          <th>Status</th>
          <td>UNCONFIRMED
          </td>
        </tr>

        <tr>
          <th>Severity</th>
          <td>minor
          </td>
        </tr>

        <tr>
          <th>Priority</th>
          <td>Normal
          </td>
        </tr>

        <tr>
          <th>Component</th>
          <td>ethdev
          </td>
        </tr>

        <tr>
          <th>Assignee</th>
          <td>dev&#64;dpdk.org
          </td>
        </tr>

        <tr>
          <th>Reporter</th>
          <td>stephen&#64;networkplumber.org
          </td>
        </tr>

        <tr>
          <th>Target Milestone</th>
          <td>---
          </td>
        </tr></table>
      <p>
        <div class=3D"bz_comment_block">
          <pre class=3D"bz_comment_text">To avoid potential symbol name con=
flicts all drivers should use a consistent
prefix on global symbols. These functions and variable names should either =
be
renamed or better yet made static where possible.


 The MLX5 device has some problematic symbols:

nm librte_net_mlx5.a | grep ' [TDB] ' | grep -v 'mlx5'

0000000000000000 D devx_obj_ops
0000000000005760 T flow_aso_age_get_by_idx
0000000000000000 D flow_drv_ops
0000000000002dd0 T flow_drv_rxq_flags_set
00000000000057e0 T flow_dv_mreg_clone_cb
0000000000005880 T flow_dv_mreg_clone_free_cb
0000000000005920 T flow_dv_mreg_create_cb
00000000000057d0 T flow_dv_mreg_match_cb
0000000000006450 T flow_dv_mreg_remove_cb
0000000000006a00 T flow_hw_rxq_flag_set
000000000000b180 T flow_legacy_list_create
0000000000005d90 T flow_legacy_list_destroy
0000000000000036 T flow_null_counter_allocate
0000000000000069 T flow_null_counter_free
0000000000000097 T flow_null_counter_query
0000000000000000 T flow_null_get_aged_flows
0000000000006d60 T flow_release_workspace
0000000000003bf0 T flow_validate_modify_field_level
0000000000008850 T save_dump_file
0000000000022fc0 T flow_dv_action_create
0000000000006730 T flow_dv_action_destroy
0000000000005f40 T flow_dv_action_query
00000000000212f0 T flow_dv_action_rss_hrxq_lookup
0000000000022e20 T flow_dv_action_rss_l34_hash_adjust
0000000000005790 T flow_dv_action_update
0000000000004ce0 T flow_dv_action_validate
0000000000016b80 T flow_dv_convert_encap_data
000000000000bea0 T flow_dv_convert_modify_action
0000000000020920 T flow_dv_dest_array_clone_cb
0000000000020a10 T flow_dv_dest_array_clone_free_cb
0000000000021d00 T flow_dv_dest_array_create_cb
0000000000022780 T flow_dv_dest_array_match_cb
0000000000022b40 T flow_dv_dest_array_remove_cb
0000000000016b60 T flow_dv_get_item_hdr_len
000000000001bdd0 T flow_dv_hashfields_set
0000000000016910 T flow_dv_port_id_clone_cb
0000000000016990 T flow_dv_port_id_clone_free_cb
0000000000016830 T flow_dv_port_id_create_cb
0000000000016810 T flow_dv_port_id_match_cb
0000000000022a30 T flow_dv_port_id_remove_cb
0000000000016ad0 T flow_dv_push_vlan_clone_cb
0000000000016b50 T flow_dv_push_vlan_clone_free_cb
00000000000169c0 T flow_dv_push_vlan_create_cb
00000000000169a0 T flow_dv_push_vlan_match_cb
0000000000022a70 T flow_dv_push_vlan_remove_cb
0000000000020810 T flow_dv_sample_clone_cb
00000000000208f0 T flow_dv_sample_clone_free_cb
0000000000021ad0 T flow_dv_sample_create_cb
0000000000021a40 T flow_dv_sample_match_cb
0000000000022ab0 T flow_dv_sample_remove_cb
00000000000020c0 T flow_dv_tag_clone_cb
0000000000000b80 T flow_dv_tag_clone_free_cb
0000000000000ac0 T flow_dv_tag_create_cb
0000000000000010 T flow_dv_tag_match_cb
0000000000000b90 T flow_dv_tag_remove_cb
0000000000017ce0 T flow_dv_tbl_clone_cb
0000000000017d70 T flow_dv_tbl_clone_free_cb
0000000000017900 T flow_dv_tbl_create_cb
0000000000017c60 T flow_dv_tbl_match_cb
000000000001a3e0 T flow_dv_tbl_remove_cb
0000000000017d80 T flow_dv_tbl_resource_get
000000000001a4f0 T flow_dv_tbl_resource_release
0000000000020a40 T __flow_dv_translate_items_hws
00000000000212d0 T flow_dv_translate_items_hws
00000000000112f0 T flow_dv_validate
0000000000004ac0 T flow_encap_decap_clone_cb
0000000000000a80 T flow_encap_decap_clone_free_cb
0000000000000860 T flow_encap_decap_create_cb
0000000000000580 T flow_encap_decap_match_cb
0000000000001ab0 T flow_encap_decap_remove_cb
0000000000016490 T __flow_encap_decap_resource_register
00000000000218d0 T flow_encap_decap_resource_release
0000000000001f40 T flow_matcher_clone_cb
0000000000000000 T flow_matcher_clone_free_cb
0000000000001b70 T flow_matcher_create_cb
0000000000000620 T flow_matcher_match_cb
0000000000001a60 T flow_matcher_remove_cb
0000000000001eb0 T flow_modify_clone_cb
0000000000000aa0 T flow_modify_clone_free_cb
0000000000000bf0 T flow_modify_create_cb
0000000000017570 T __flow_modify_hdr_resource_register
00000000000005e0 T flow_modify_match_cb
0000000000001b10 T flow_modify_remove_cb
00000000000002e0 D modify_eth
0000000000000220 D modify_ipv4
0000000000000140 D modify_ipv6
0000000000000100 D modify_ipv6_traffic_class
0000000000000040 D modify_tcp
00000000000000c0 D modify_udp
00000000000002a0 D modify_vlan_out_first_vid
0000000000000000 D reg_to_field
0000000000000fd0 T flow_dv_item_create
0000000000002430 T flow_dv_item_release
00000000000042e0 T flow_dv_meter_find_by_idx
00000000000003a0 T flow_nta_handle_rss
00000000000002f0 T flow_nta_locate_rss
0000000000000000 D rss_hash_default_key
0000000000000090 T rxq_alloc_elts
00000000000005c0 T rxq_sync_cq
0000000000000000 D txoff_func
0000000000000000 T txq_alloc_elts
00000000000001d6 T txq_free_elts
000000000003e6a0 T flow_hw_clear_port_info
000000000003e760 T flow_hw_create_flow
000000000003e3f0 T flow_hw_create_vport_action
000000000003f020 T flow_hw_destroy
000000000003e4c0 T flow_hw_destroy_vport_action
0000000000041e10 T flow_hw_get_ecpri_parser_profile
000000000003e340 T flow_hw_grp_clone_cb
000000000003e3e0 T flow_hw_grp_clone_free_cb
000000000003dec0 T flow_hw_grp_create_cb
000000000003e2f0 T flow_hw_grp_match_cb
000000000003e2a0 T flow_hw_grp_remove_cb
0000000000002271 T flow_hw_init
000000000003f350 T flow_hw_list_destroy
000000000003da40 T flow_hw_q_flow_flush
000000000003e600 T flow_hw_resource_release
000000000003e630 T flow_hw_set_port_info
000000000003dc50 T flow_hw_table_update
0000000000000330 T flow_nta_mreg_create_cb
00000000000005c0 T flow_nta_mreg_remove_cb
0000000000000000 B server_intr_handle
0000000000000000 D server_socket
0000000000000000 D ibv_obj_ops
0000000000000000 D dr_crc_inner_crc_tab16
0000000000000200 D dr_ste_crc_tab32
          </pre>
        </div>
      </p>


      <hr>
      <span>You are receiving this mail because:</span>

      <ul>
          <li>You are the assignee for the bug.</li>
      </ul>
      <div itemscope itemtype=3D"http://schema.org/EmailMessage">
        <div itemprop=3D"action" itemscope itemtype=3D"http://schema.org/Vi=
ewAction">
=20=20=20=20=20=20=20=20=20=20
          <link itemprop=3D"url" href=3D"https://bugs.dpdk.org/show_bug.cgi=
?id=3D1794">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17589022130.c1Ec2.2695879--
