Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D5F9E9A02C
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Feb 2026 01:13:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 66A18402C6;
	Thu, 19 Feb 2026 02:13:26 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id BF418402BD
 for <dev@dpdk.org>; Thu, 19 Feb 2026 02:13:24 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 92C324A667; Thu, 19 Feb 2026 02:13:24 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1885] net/atlantic: atl_xmit_pkts stops on invalid
 mbuf instead of consuming it
Date: Thu, 19 Feb 2026 01:13:24 +0000
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
Message-ID: <bug-1885-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1885

            Bug ID: 1885
           Summary: net/atlantic: atl_xmit_pkts stops on invalid mbuf
                    instead of consuming it
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

Audit of tx_pkt_burst handling i drivers found this.

In atl_xmit_pkts() (atl_rxtx.c line 1332), when an mbuf fails
validation (nb_segs =3D=3D 0, or nb_segs > 1 with next =3D=3D NULL), the
driver breaks out of the transmit loop and returns the current
count without freeing the offending packet.

The standard caller pattern after rte_eth_tx_burst() is:

    n =3D rte_eth_tx_burst(port, qid, pkts, count);
    for (i =3D n; i < count; i++)
        rte_pktmbuf_free(pkts[i]);

Because the invalid mbuf is returned as unconsumed, the caller
will attempt to retransmit it on the next call. The packet is
inherently malformed, so it will fail the same check every time
and the caller loops forever, unable to make forward progress.

The descriptor-exhaustion break at line 1329 is fine =E2=80=94 that is a
transient resource condition that will resolve.  The mbuf
validation break at line 1333 is not =E2=80=94 a bad packet will never
become valid.

Per the rte_eth_tx_burst() contract (see ethdev: clarify
rte_eth_tx_burst return value and ownership semantics), the driver
should free the erroneous mbuf and continue processing the
remaining packets rather than stopping. The error should be
counted in tx_errors.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
