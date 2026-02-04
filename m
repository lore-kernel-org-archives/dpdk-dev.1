Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 517BCE9D41F
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Feb 2026 17:31:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 66B26402F2;
	Wed,  4 Feb 2026 18:31:51 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 89BAF402E1
 for <dev@dpdk.org>; Wed,  4 Feb 2026 18:31:50 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 7285B4A59F; Wed,  4 Feb 2026 18:31:50 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1877] virtio: potential integer overflow
Date: Wed, 04 Feb 2026 17:31:50 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 25.11
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
Message-ID: <bug-1877-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1877

            Bug ID: 1877
           Summary: virtio: potential integer overflow
           Product: DPDK
           Version: 25.11
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: stephen@networkplumber.org
  Target Milestone: ---

While reusing this code snippet in another driver, AI review noticed possib=
le
overflow:

        if (hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) {
                hdrlen =3D hdr_lens.l2_len + hdr_lens.l3_len + hdr_lens.l4_=
len;
                if (hdr->csum_start <=3D hdrlen && l4_supported) {
                        m->ol_flags |=3D RTE_MBUF_F_RX_L4_CKSUM_NONE;
                } else {
                        /* Unknown proto or tunnel, do sw cksum. We can ass=
ume
                         * the cksum field is in the first segment since the
                         * buffers we provided to the host are large enough.
                         * In case of SCTP, this will be wrong since it's a=
 CRC
                         * but there's nothing we can do.
                         */
                        uint16_t csum =3D 0, off;

                        if (rte_raw_cksum_mbuf(m, hdr->csum_start,
                                rte_pktmbuf_pkt_len(m) - hdr->csum_start,
                                &csum) < 0)
                                return -EINVAL;
                        if (likely(csum !=3D 0xffff))
                                csum =3D ~csum;
                        off =3D hdr->csum_offset + hdr->csum_start;

1. **Potential integer overflow** in eth_ioring_rx_offload
   ```c
   off =3D hdr->csum_offset + hdr->csum_start;
   ```
   Both are uint16_t from untrusted source; sum could overflow.

---

--=20
You are receiving this mail because:
You are the assignee for the bug.=
