Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52104C61DCB
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Aug 2026 17:37:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9C8CE4025A;
	Fri, 28 Aug 2026 19:37:11 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 3012040151
 for <dev@dpdk.org>; Fri, 28 Aug 2026 19:37:10 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 2C3C24CFA5; Fri, 28 Aug 2026 19:37:10 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 2014] memif: advertises incorrect queue pairs
Date: Fri, 28 Aug 2026 17:37:10 +0000
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
Message-ID: <bug-2014-3@https.bugs.dpdk.org/>
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

https://bugs.dpdk.org/show_bug.cgi?id=3D2014

            Bug ID: 2014
           Summary: memif: advertises incorrect queue pairs
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

Found while doing AI assisted review of memif.

memif_msg_enq_hello() in drivers/net/memif/memif_socket.c sends

    h->max_c2s_ring =3D ETH_MEMIF_MAX_NUM_Q_PAIRS;
    h->max_s2c_ring =3D ETH_MEMIF_MAX_NUM_Q_PAIRS;

that is, the driver-wide maximum (255), rather than the number of rings
the device is actually configured with, pmd->cfg.num_c2s_rings and
pmd->cfg.num_s2c_rings.

A conforming client negotiates its ring count as
RTE_MIN(h->max_c2s_ring + 1, its own count), so it can legitimately end
up sending more ADD_RING messages than the server has queues for. The
existing check in memif_msg_receive_add_ring(),

    if (ar->index >=3D pmd->cfg.num_c2s_rings)

then rejects the ring and disconnects the peer. The client did nothing
wrong; the server told it the wrong limit.

Fix: advertise the device's configured ring counts in the hello.

This is a functional bug, not a security one, but it becomes much more
visible as soon as the server starts validating client requests
strictly, so it is worth fixing alongside that work rather than after
it.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
