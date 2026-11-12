Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6C6606A332
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Nov 2026 17:40:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AF728415D7;
	Thu, 12 Nov 2026 18:40:26 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTPS id 7B2ED40E32
 for <dev@dpdk.org>; Thu, 12 Nov 2026 18:40:25 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 6B2104D24A; Thu, 12 Nov 2026 18:40:25 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 2113] bnxt: multiple issues found with GCC analyzer
Date: Thu, 12 Nov 2026 17:40:25 +0000
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
Message-ID: <bug-2113-3@https.bugs.dpdk.org/>
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

https://bugs.dpdk.org/show_bug.cgi?id=3D2113

            Bug ID: 2113
           Summary: bnxt: multiple issues found with GCC analyzer
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

10. net/bnxt: double free in tfc_msg error path
Component: ethdev | Severity: major | Confidence: confirmed

tfc_msg_alloc_dma_buf() (drivers/net/bnxt/tf_core/v3/tfc_msg.c:151) frees
buf->va_addr at :160 when rte_mem_virt2iova() fails and leaves the pointer =
set.
Every caller then goes to cleanup: and calls tfc_msg_free_dma_buf() (:176),
freeing it again. Callers: tfc_msg_idx_tbl_alloc_set, tfc_msg_idx_tbl_set,
tfc_msg_idx_tbl_get, tfc_msg_tcam_alloc_set, tfc_msg_tcam_set.

11. net/bnxt: tfc_msg_idx_tbl_set() allocates the DMA buffer twice
Component: ethdev | Severity: normal | Confidence: confirmed

drivers/net/bnxt/tf_core/v3/tfc_msg.c:647 calls tfc_msg_alloc_dma_buf(&buf,
data_size) unconditionally, and :653 calls it again inside if (req.data_siz=
e >=3D
sizeof(req.dev_data)). The first buffer is overwritten and leaked on every
DMA-sized set.

12. net/bnxt: uninitialised rxcmp1 used in compressed CQE SSE Rx
Component: ethdev | Severity: major | Confidence: confirmed

crx_burst_vec_sse() declares __m128i rxcmp1[] at
drivers/net/bnxt/bnxt_rxtx_vec_sse.c:448 and passes it to crx_descs_to_mbuf=
s()
(:498) without ever writing it. GET_DESC_FIELDS (:51) blends rxcmp1 into the
vlan_tci word of rx_descriptor_fields1, so every mbuf on this path gets sta=
ck
garbage in vlan_tci.

13. net/bnxt: leaks in bnxt_alloc_ctx_mem_blk() error paths
Component: ethdev | Severity: minor | Confidence: single pass

drivers/net/bnxt/bnxt_ethdev.c: ctx_pg_arr (:5043) leaks when the ctx_dma_a=
rr
allocation fails (:5050), and ctx_dma_arr leaks when rte_memzone_reserve fa=
ils
(:5096). bnxt_free_ctx_mem() does not recover them because BNXT_CTX_FLAG_IN=
ITED
is not set.

14. net/bnxt: NULL check after dereference in bnxt_free_ctx_mem()
Component: ethdev | Severity: trivial | Confidence: confirmed

drivers/net/bnxt/bnxt_ethdev.c:5194-5196 dereferences bp->ctx->tqm_mem[i] t=
wice
and then tests it for NULL. The check is dead or the dereference is wrong.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
