Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58FD606CFCE
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Nov 2026 17:41:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 952D9415D7;
	Thu, 12 Nov 2026 18:41:41 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTPS id 4D52D40E32
 for <dev@dpdk.org>; Thu, 12 Nov 2026 18:41:40 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 408564D421; Thu, 12 Nov 2026 18:41:40 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 2114] net/intel: multiple issues found by GCC
 analyzer
Date: Thu, 12 Nov 2026 17:41:40 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 26.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: major
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
Message-ID: <bug-2114-3@https.bugs.dpdk.org/>
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

https://bugs.dpdk.org/show_bug.cgi?id=3D2114

            Bug ID: 2114
           Summary: net/intel: multiple issues found by GCC analyzer
           Product: DPDK
           Version: 26.11
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: major
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: stephen@networkplumber.org
  Target Milestone: ---

15. net/cpfl: cfgq leaked in vcpf_save_chunk_in_cfgq()
Component: ethdev | Severity: minor | Confidence: single pass

drivers/net/intel/cpfl/cpfl_ethdev.c:2201 allocates cfgq; :2210-2213 returns
-ENOMEM when the cfgq_add allocation fails without freeing it.

16. net/cpfl, net/idpf: adapter leaked on probe failure
Component: ethdev | Severity: minor | Confidence: single pass

cpfl_pci_probe_first() allocates adapter at
drivers/net/intel/cpfl/cpfl_ethdev.c:3096 and returns at :3106 (devargs par=
se)
and :3111 (adapter init) without freeing it. idpf_pci_probe() has the same
pattern: allocation at drivers/net/intel/idpf/idpf_ethdev.c:1666, return at
:1674.

17. net/cpfl: NULL dereference parsing a "parameter" content field without =
prog
action
Component: ethdev | Severity: normal | Confidence: single pass

cpfl_parse_content() (drivers/net/intel/cpfl/cpfl_flow_parser.c:1989) reads
prog->prog, which is only set at :1881 when the mod rule key has a PROG act=
ion.
The JSON loader accepts a content field of type "parameter" for any key, so
such a rule crashes when used.

18. net/cpfl: cpfl_repr_create() returns uninitialised value
Component: ethdev | Severity: normal | Confidence: confirmed

int ret; (drivers/net/intel/cpfl/cpfl_representor.c:563) is only assigned
inside the allowlist loop. If the hash is empty or every entry is skipped b=
y if
(dev !=3D NULL) continue;, the function returns garbage at :662 and the cal=
lers
may treat it as a probe failure.

19. net/ice: kb leaked in _xlt_kb_get()
Component: ethdev | Severity: minor | Confidence: single pass

drivers/net/intel/ice/base/ice_xlt_kb.c:135 allocates kb; :144-148 returns =
NULL
when ice_pkg_enum_section() finds no section, without freeing it.

20. net/ice: DCF VF representor VLAN ops dereference NULL after DCF release
Component: ethdev | Severity: normal | Confidence: confirmed

ice_dcf_vf_repr_hw() returns NULL when !repr->dcf_valid
(drivers/net/intel/ice/ice_dcf_vf_representor.c:135).
ice_dcf_vlan_offload_ena() (:233) dereferences the result unchecked. Reached
from the vlan_offload_set, vlan_pvid_set and vlan_tpid_set ops.

21. net/idpf: unchecked allocation in idpf_vc_queue_grps_del()
Component: ethdev | Severity: minor | Confidence: single pass

drivers/net/intel/idpf/idpf_common_virtchnl.c:439 rte_zmalloc() result is
dereferenced at :441.

22. net/ixgbe: uninitialised buffers copied in E610 ACI commands
Component: ethdev | Severity: trivial | Confidence: single pass

ixgbe_read_sr_word_aci() passes uninitialised data_local
(drivers/net/intel/ixgbe/base/ixgbe_e610.c:3162) as a response buffer that
ixgbe_aci_send_cmd_execute() copies out at :240. ixgbe_update_link_info()
passes an unzeroed malloc that is copied at :395. Also ixgbe_dev_mtu_set()
(ixgbe_ethdev.c:5322) passes an uninitialised dev_info to ixgbe_dev_info_ge=
t(),
which does dev_capa |=3D on it (:3922). No functional effect seen.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
