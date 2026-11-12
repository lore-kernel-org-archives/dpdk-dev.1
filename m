Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04ADC606A889
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Nov 2026 17:42:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ABA9A415D7;
	Thu, 12 Nov 2026 18:42:46 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTPS id 7D544415D7
 for <dev@dpdk.org>; Thu, 12 Nov 2026 18:42:45 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 762AE4D48E; Thu, 12 Nov 2026 18:42:45 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 2115] net/ntnic: mulitple issues detected with GCC
 -fanalyzer
Date: Thu, 12 Nov 2026 17:42:45 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
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
Message-ID: <bug-2115-3@https.bugs.dpdk.org/>
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

https://bugs.dpdk.org/show_bug.cgi?id=3D2115

            Bug ID: 2115
           Summary: net/ntnic: mulitple issues detected with GCC
                    -fanalyzer
           Product: DPDK
           Version: 26.11
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: minor
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: stephen@networkplumber.org
  Target Milestone: ---

23. net/ntnic: FPGA model constructors return unchecked malloc
Component: ethdev | Severity: minor | Confidence: single pass

nthw_fpga_model_new, nthw_module_new, nthw_register_new, nthw_field_new,
nthw_param_new (drivers/net/ntnic/nthw/model/nthw_fpga_model.c) return mall=
oc()
directly and callers pass the result to *_init(), which dereferences it (:1=
86,
:245, :296, :317, :418). Same in nthw_id_table_create()
(nthw/flow_api/flow_id_table.c:68, calloc dereferenced at :70).

24. net/ntnic: p_drv leaked on init failure
Component: ethdev | Severity: minor | Confidence: single pass

nthw_pci_dev_init() allocates p_drv at drivers/net/ntnic/ntnic_ethdev.c:2326
and stores it with store_pdrv() (:2380). The later return -1 paths (:2388,
:2437, :2456, ...) do not free it or clear the stored pointer.

25. net/ntnic: NULL check after dereference in nthw_pci_dev_deinit()
Component: ethdev | Severity: trivial | Confidence: confirmed

drivers/net/ntnic/ntnic_ethdev.c:2680 dereferences internals; :2688 then lo=
ops
on while (internals).

--=20
You are receiving this mail because:
You are the assignee for the bug.=
