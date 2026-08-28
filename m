Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E5EC61DCB
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Aug 2026 17:35:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A98304025A;
	Fri, 28 Aug 2026 19:35:45 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 86ADD4025A
 for <dev@dpdk.org>; Fri, 28 Aug 2026 19:35:44 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 7BC2B4CF9E; Fri, 28 Aug 2026 19:35:44 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 2013] memif: accepts rings outside the region
Date: Fri, 28 Aug 2026 17:35:44 +0000
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
 target_milestone bug_group
Message-ID: <bug-2013-3@https.bugs.dpdk.org/>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
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

https://bugs.dpdk.org/show_bug.cgi?id=3D2013

            Bug ID: 2013
           Summary: memif: accepts rings outside the region
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
             Group: security

memif_msg_receive_add_ring() in drivers/net/memif/memif_socket.c checks
only that the ring index is below the configured ring count. Four
things a client controls are taken unchecked.

1. Ring index may repeat, and the counter is incremented unconditionally

The handler checks ar->index >=3D pmd->cfg.num_c2s_rings (or the s2c
equivalent) and then increments pmd->run.num_c2s_rings. Nothing requires
rings to be added in order, or at all, or only once. A client that sends
ADD_RING for index 0 repeatedly drives pmd->run.num_c2s_rings past
pmd->cfg.num_c2s_rings, and code that later iterates over the run
counters then indexes past the allocated queue arrays. This is the item
in this bug with a direct memory-safety consequence and it is worth
treating as the primary one.

2. Ring size is not bounded

ar->log2_ring_size is not checked against the maximum the server
advertised in its hello, so the ring described can be far larger than
anything the server expects.

3. The referenced region is not checked to exist, and the ring is not
   checked to fit inside it

ar->region is not checked against the regions actually added, and
mq->offset =3D ar->offset is taken as-is. Nothing verifies that the ring
header plus its descriptor table fit inside the named region, or that
the offset is naturally aligned. A bad region index or offset makes
mq->ring in memif_connect() point outside any mapping; the cookie read
there is then an out-of-bounds access, and the ring head and tail are
subsequently dereferenced through the same pointer.

4. private_hdr_size is not rejected

Private headers are not supported, but a non-zero ar->private_hdr_size
is accepted, which puts the descriptor table somewhere other than where
the driver computes it to be.

Suggested fix
-------------

  - require rings to be added in order, exactly once: reject unless
    ar->index equals the current run counter, and increment only after
    all checks pass;
  - bound ar->log2_ring_size by the value actually advertised in the
    hello, rather than by a separate constant that can drift from it;
  - reject non-zero ar->private_hdr_size;
  - require the named region to exist (regions are added before rings)
    and require sizeof(memif_ring_t) + sizeof(memif_desc_t) << log2_size
    to fit within region_size at the given offset, with the offset
    naturally aligned so the atomic head and tail accesses do not fault
    on platforms that require aligned access.

On alignment: both DPDK and VPP place rings on a cache line boundary in
practice, but the proposed fix only enforces 8-byte alignment, to avoid
rejecting configurations that are legal under the wire protocol as it
stands. Whether a stricter alignment can be relied on is one of the
interop questions that should be settled with VPP and libmemif.

Note for reviewers: ar->offset is uint32_t (memif_region_offset_t), so
offset + ring_size evaluated in 64-bit arithmetic cannot wrap today.
That is worth a comment in the code, so that a future widening of the
wire type does not silently turn the bound check into a bypass.

A candidate patch exists privately and has not been posted. It can be
shared with the security team on request.

Reported by Arthur Chan <arthur.chan@adalogics.com> (Ada Logics), via
fuzzing.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
