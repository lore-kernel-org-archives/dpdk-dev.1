Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B36606A31F
	for <dpdk-dev@archiver.kernel.org>; Sat, 28 Nov 2026 00:44:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0589E402C1;
	Sat, 28 Nov 2026 01:44:44 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTPS id 51B24402B9
 for <dev@dpdk.org>; Sat, 28 Nov 2026 01:44:42 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 18DE54D4AF; Sat, 28 Nov 2026 01:44:42 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/other Bug 2164] common/sfc_efx: common misused as holding zone
 for extra code
Date: Sat, 28 Nov 2026 00:44:42 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: other
X-Bugzilla-Version: 26.11
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
Message-ID: <bug-2164-3@https.bugs.dpdk.org/>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
X-Bugzilla-URL: https://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

https://bugs.dpdk.org/show_bug.cgi?id=3D2164

            Bug ID: 2164
           Summary: common/sfc_efx: common misused as holding zone for
                    extra code
           Product: DPDK
           Version: 26.11
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: minor
          Priority: Normal
         Component: other
          Assignee: dev@dpdk.org
          Reporter: stephen@networkplumber.org
  Target Milestone: ---

Found while diagnosing unreachable code warnings.

The common/sfc_efx exports a large number of internal API's some of which a=
re
never used. It looks like common is being misused to carry a generic upstre=
am
API here.


  Six features are entirely unused =E2=80=94 every exported symbol has zero=
 consumers:

  efx_mon_*       (3/3)   efx_mon_init, efx_mon_fini, efx_mon_name
  efx_hash_*      (2/2)   efx_hash_bytes, efx_hash_dwords
  efx_sram_*      (2/2)   efx_sram_buf_tbl_set, efx_sram_buf_tbl_clear
  efx_loopback_*  (2/2)   efx_loopback_mask, efx_loopback_type_name
  efx_crc32_*     (1/1)   efx_crc32_calculate
  efx_family      (2)     efx_family, efx_family_probe_bar

  Partially unused, largest first:

  efx_filter_*  12/19  restore, spec_init_rx, spec_init_tx,
spec_set_encap_type,
                       spec_set_ether_type, spec_set_geneve,
spec_set_ipv4_full,
                       spec_set_ipv4_local, spec_set_nvgre,
spec_set_rss_context,
                       spec_set_uc_def, spec_set_vxlan
  efx_mcdi_*     9/14  client_mac_addr_get, fini, get_proxy_handle,
get_timeout,
                       init, reboot, request_abort, request_poll, request_s=
tart
  efx_tx_*       8/19  qdesc_checksum_create, qdesc_tso_create, qpace,
qpio_disable,
                       qpio_enable, qpio_post, qpio_write, qpost
  efx_nic_*      6/23  calculate_pcie_link_bandwidth, check_pcie_link_speed,
                       get_bar_region, hw_unavailable, set_drv_version,
                       set_hw_unavailable
  efx_ev_*       5/12  qcreate, qmoderate, qpending, qpost, usecs_to_ticks
  efx_phy_*      5/10  lp_cap_get, media_type_get, module_get_info, oui_get,
verify
  efx_evb_*       4/8  vport_mac_set, vport_reset, vport_stats, vport_vlan_=
set
  efx_intr_*      2/9  disable_unlocked, trigger
  efx_mac_*      2/20  pdu_get, up
  efx_mae_*      2/70  action_set_get_nb_count, counters_alloc
  efx_rx_*       1/20  scale_context_alloc
  efx_tunnel_*    1/6  config_clear
  efx_virtio_*    1/9  verify_features
  efx_evq_*       1/2  efx_evq_nbufs
  efx_rxq_*       1/2  efx_rxq_nbufs
  efx_txq_*       1/2  efx_txq_nbufs

The original purpose of common/ was to allow shared code when there was a
crypto/ and net/ driver on the same HW.   It is not meant to be a vendor dr=
op
zone for hardware library.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
