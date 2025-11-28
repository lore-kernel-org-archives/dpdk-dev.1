Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20947D116E2
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Nov 2025 18:10:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DB49540281;
	Fri, 28 Nov 2025 19:10:26 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id DE512400EF
 for <dev@dpdk.org>; Fri, 28 Nov 2025 19:10:25 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id BF72748BCF; Fri, 28 Nov 2025 19:10:25 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1837] mlx5: lots of global symbols
Date: Fri, 28 Nov 2025 18:10:25 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 25.07
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
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
Message-ID: <bug-1837-3@http.bugs.dpdk.org/>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
X-Bugzilla-URL: http://bugs.dpdk.org/
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1837

            Bug ID: 1837
           Summary: mlx5: lots of global symbols
           Product: DPDK
           Version: 25.07
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: stephen@networkplumber.org
  Target Milestone: ---

The mlx5 driver has lots of symbols that are global in the driver.
When DPDK is statically linked these symbols could conflict with other driv=
ers
and with the application. For example rte_hash_default_key is used is sever=
al
drivers.

$ nm librte_net_mlx5.a | grep ' [TBD] ' | grep -v 'mlx5'
0000000000000000 D devx_obj_ops
0000000000000000 B cb_list_head
0000000000006190 T flow_aso_age_get_by_idx
0000000000000000 D flow_drv_ops
0000000000002d00 T flow_drv_rxq_flags_set
0000000000006210 T flow_dv_mreg_clone_cb
00000000000062a0 T flow_dv_mreg_clone_free_cb
000000000000a4f0 T flow_dv_mreg_create_cb
0000000000006200 T flow_dv_mreg_match_cb
0000000000006c10 T flow_dv_mreg_remove_cb
0000000000007260 T flow_hw_rxq_flag_set
000000000000c340 T flow_legacy_list_create
0000000000006560 T flow_legacy_list_destroy
0000000000000036 T flow_null_counter_allocate
0000000000000069 T flow_null_counter_free
0000000000000097 T flow_null_counter_query
0000000000000000 T flow_null_get_aged_flows
0000000000007330 T flow_release_workspace
0000000000003d50 T flow_validate_modify_field_level
0000000000008e20 T save_dump_file
0000000000025b90 T flow_dv_action_create
0000000000006d00 T flow_dv_action_destroy
00000000000064c0 T flow_dv_action_query
0000000000023d20 T flow_dv_action_rss_hrxq_lookup
0000000000025a00 T flow_dv_action_rss_l34_hash_adjust
0000000000005cb0 T flow_dv_action_update
0000000000005180 T flow_dv_action_validate
0000000000019160 T flow_dv_convert_encap_data
000000000000c690 T flow_dv_convert_modify_action
0000000000023370 T flow_dv_dest_array_clone_cb
0000000000023440 T flow_dv_dest_array_clone_free_cb
00000000000247e0 T flow_dv_dest_array_create_cb
00000000000251e0 T flow_dv_dest_array_match_cb
00000000000256e0 T flow_dv_dest_array_remove_cb
0000000000019140 T flow_dv_get_item_hdr_len
000000000001e7a0 T flow_dv_hashfields_set
0000000000018ec0 T flow_dv_port_id_clone_cb
0000000000018f50 T flow_dv_port_id_clone_free_cb
0000000000018de0 T flow_dv_port_id_create_cb
0000000000018dc0 T flow_dv_port_id_match_cb
00000000000255d0 T flow_dv_port_id_remove_cb
00000000000190a0 T flow_dv_push_vlan_clone_cb
0000000000019130 T flow_dv_push_vlan_clone_free_cb
0000000000018f90 T flow_dv_push_vlan_create_cb
0000000000018f60 T flow_dv_push_vlan_match_cb
0000000000025610 T flow_dv_push_vlan_remove_cb
0000000000023280 T flow_dv_sample_clone_cb
0000000000023340 T flow_dv_sample_clone_free_cb
00000000000245c0 T flow_dv_sample_create_cb
0000000000024540 T flow_dv_sample_match_cb
0000000000025650 T flow_dv_sample_remove_cb
0000000000002200 T flow_dv_tag_clone_cb
0000000000000bc0 T flow_dv_tag_clone_free_cb
0000000000000af0 T flow_dv_tag_create_cb
0000000000000010 T flow_dv_tag_match_cb
0000000000000bd0 T flow_dv_tag_remove_cb
000000000001a3c0 T flow_dv_tbl_clone_cb
000000000001a450 T flow_dv_tbl_clone_free_cb
0000000000019fb0 T flow_dv_tbl_create_cb
000000000001a330 T flow_dv_tbl_match_cb
000000000001ce80 T flow_dv_tbl_remove_cb
000000000001a460 T flow_dv_tbl_resource_get
000000000001cf90 T flow_dv_tbl_resource_release
0000000000023470 T __flow_dv_translate_items_hws
0000000000023d00 T flow_dv_translate_items_hws
0000000000011f70 T flow_dv_validate
0000000000004f60 T flow_encap_decap_clone_cb
0000000000000ab0 T flow_encap_decap_clone_free_cb
00000000000008b0 T flow_encap_decap_create_cb
00000000000006f0 T flow_encap_decap_match_cb
0000000000001d00 T flow_encap_decap_remove_cb
0000000000018960 T __flow_encap_decap_resource_register
00000000000243c0 T flow_encap_decap_resource_release
0000000000002110 T flow_matcher_clone_cb
0000000000000000 T flow_matcher_clone_free_cb
0000000000001dc0 T flow_matcher_create_cb
00000000000007b0 T flow_matcher_match_cb
0000000000001ca0 T flow_matcher_remove_cb
0000000000002080 T flow_modify_clone_cb
0000000000000ad0 T flow_modify_clone_free_cb
0000000000000c30 T flow_modify_create_cb
0000000000019b70 T __flow_modify_hdr_resource_register
0000000000000760 T flow_modify_match_cb
0000000000001d60 T flow_modify_remove_cb
00000000000002e0 D modify_eth
0000000000000220 D modify_ipv4
0000000000000140 D modify_ipv6
0000000000000100 D modify_ipv6_traffic_class
0000000000000040 D modify_tcp
00000000000000c0 D modify_udp
00000000000002a0 D modify_vlan_out_first_vid
0000000000000000 D reg_to_field
0000000000001460 T flow_dv_item_create
0000000000002d50 T flow_dv_item_release
00000000000045e0 T flow_dv_meter_find_by_idx
0000000000000430 T flow_nta_handle_rss
0000000000000360 T flow_nta_locate_rss
0000000000000000 D rss_hash_default_key
0000000000000090 T rxq_alloc_elts
00000000000005c0 T rxq_sync_cq
0000000000000000 D txoff_func
0000000000000000 T txq_alloc_elts
0000000000000000 T txq_free_elts
000000000003f930 T flow_hw_clear_port_info
000000000003f9f0 T flow_hw_create_flow
000000000003ea60 T flow_hw_create_vport_action
0000000000040390 T flow_hw_destroy
000000000003eb40 T flow_hw_destroy_vport_action
00000000000438f0 T flow_hw_get_ecpri_parser_profile
000000000003e9b0 T flow_hw_grp_clone_cb
000000000003ea50 T flow_hw_grp_clone_free_cb
000000000003e540 T flow_hw_grp_create_cb
000000000003e950 T flow_hw_grp_match_cb
000000000003e900 T flow_hw_grp_remove_cb
0000000000001ff7 T flow_hw_init
0000000000040720 T flow_hw_list_destroy
000000000003e090 T flow_hw_q_flow_flush
000000000003f890 T flow_hw_resource_release
000000000003f8c0 T flow_hw_set_port_info
000000000003e2b0 T flow_hw_table_update
0000000000000360 T flow_nta_mreg_create_cb
00000000000005f0 T flow_nta_mreg_remove_cb
0000000000000000 B server_intr_handle
0000000000000000 D server_socket
0000000000000000 D ibv_obj_ops
0000000000000000 D dr_crc_inner_crc_tab16
0000000000000200 D dr_ste_crc_tab32


These symbols should be localized where possible, or add a prefix like mlx5_

--=20
You are receiving this mail because:
You are the assignee for the bug.=
