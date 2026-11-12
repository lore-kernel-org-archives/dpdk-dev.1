Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC021606A321
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Nov 2026 17:43:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 985F3415D7;
	Thu, 12 Nov 2026 18:43:41 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTPS id D3EA640E32
 for <dev@dpdk.org>; Thu, 12 Nov 2026 18:43:39 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id CE81F4D2E1; Thu, 12 Nov 2026 18:43:39 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 2116] net/nfp: multiple issues detected with GCC 16
 and -fanalyzer
Date: Thu, 12 Nov 2026 17:43:39 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 26.11
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
Message-ID: <bug-2116-3@https.bugs.dpdk.org/>
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

https://bugs.dpdk.org/show_bug.cgi?id=3D2116

            Bug ID: 2116
           Summary: net/nfp: multiple issues detected with GCC 16 and
                    -fanalyzer
           Product: DPDK
           Version: 26.11
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: stephen@networkplumber.org
  Target Milestone: ---

26. net/nfp: double free on malformed firmware ELF
Component: ethdev | Severity: major | Confidence: confirmed

nfp_elf_read_section_headers() frees ectx->shdrs_host_endian, shdrs_data and
shdrs on its error labels (drivers/net/nfp/nfpcore/nfp_elf.c:866-870) witho=
ut
clearing them. nfp_elf_mutable_buf() then goes to elf_free: and nfp_elf_fre=
e()
(:275-277) frees the same pointers again.

27. net/nfp: txq leaked on NFDK Tx queue setup failure
Component: ethdev | Severity: minor | Confidence: single pass

nfp_net_nfdk_tx_queue_setup() allocates txq at
drivers/net/nfp/nfdk/nfp_nfdk_dp.c:460. On memzone (:476) or txbufs (:499)
failure it calls nfp_net_tx_queue_release(dev, queue_idx), which frees
dev->data->tx_queues[queue_idx]. That slot is only assigned at :513, so txq=
 is
not freed.

28. net/nfp: hw_priv/pf_dev leaked when firmware reports no ports in second=
ary
Component: ethdev | Severity: minor | Confidence: single pass

nfp_pf_secondary_init() (drivers/net/nfp/nfp_ethdev.c:2847): when
nfp_net_get_phyports_from_fw() returns 0, the port loop does not run and the
function returns 0 without attaching or freeing its allocations.

29. net/nfp: unchecked allocation in nfp_nsp_command_buf_dma_sg()
Component: ethdev | Severity: minor | Confidence: single pass

drivers/net/nfp/nfpcore/nfp_nsp.c:551 rte_zmalloc() result is dereferenced =
at
:555.

30. net/nfp: rte_pktmbuf_prepend() not checked in NFD3 Tx metadata
Component: ethdev | Severity: normal | Confidence: confirmed

nfp_net_nfd3_set_meta_data() (drivers/net/nfp/nfd3/nfp_nfd3_dp.c:184) writes
through the result of rte_pktmbuf_prepend(pkt, meta_data->length) without a
NULL check. A Tx mbuf with VLAN or IPsec offload and too little headroom
crashes.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
