Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6095FCD4F50
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 May 2026 18:52:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8E2FA402D9;
	Mon, 18 May 2026 20:52:20 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 616B140041
 for <dev@dpdk.org>; Mon, 18 May 2026 20:52:19 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 586E04B1F6; Mon, 18 May 2026 20:52:19 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1947] bnxt: rte_eth_stats_get returns invalid
 counter values on BCM57608
Date: Mon, 18 May 2026 18:52:18 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 26.03
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: oleksandrn@interfacemasters.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1947-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1947

            Bug ID: 1947
           Summary: bnxt: rte_eth_stats_get returns invalid counter values
                    on BCM57608
           Product: DPDK
           Version: 26.03
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: oleksandrn@interfacemasters.com
  Target Milestone: ---

On BCM57608 rte_eth_stats_get occasionally returns a single statistic count=
er
with a value that doesn't make sense given the actual traffic sent. Only one
counter is bad per call; I have never seen two simultaneously, which maybe
suggests some sort of timing issue, and I don't think I even saw like 2 por=
ts
of 6 have bad values, always one port one counter. (but maybe I need to do =
more
runs to see this, so maybe it doesn't mean anything)

  Observed 2 cases:

  1. A counter returns an exact power of 2 that is far beyond what the traf=
fic
could produce in a short timeframe. For example, after 60 seconds of 6=C3=
=97100 Gbps
   traffic, we observe ierrors =3D 70368744177664 =3D 2^46 or 1407374883553=
28 =3D
2^47 on single port.=20=20=20
  2. ipackets is much larger than ibytes, which doesn't make sense, and sho=
uld
be impossible.

  Example for case 1:
  ipackets   1423589410
  opackets   1423588386
  ibytes     1452060153720
  obytes     1469240022904
  imissed    229789201
  ierrors    70368744177664 <<<<< 2^46
  oerrors    0
  rx_nombuf  0

  Additionally, rte_eth_stats_reset / rte_eth_xstats_reset do not prevent
recurrence.=20
  There is also a suspected issue with stats reset itself: running a second
60-second traffic burst after reset shows more packets reported by the NIC =
than
the traffic generator actually sent, suggesting the hardware counters are n=
ot
actually cleared, but I haven't investigated this enough to give more detai=
ls.


 Rough reproduction steps (we did this testing with our application, but
haven't seen anything similar for other NICs we use, so it shouldn't matter
much):

  1. Initialize port with BCM57608 NIC (we have 10rx queues per port)
  2. Optionally call rte_eth_stats_reset after port init
  3. Send 6=C3=97100 Gbps traffic for 60 seconds (1024bytes per packet in t=
his case,
but I don't think it should matter)
  4. Call rte_eth_stats_get -> observe inconsistent values sometimes

Seems to be the same with 25.11 and 26.03


  NIC :
  Part Number                         : BCM957608-P2100GQF20
  Chip Number                         : BCM57608
  Chip Name                           : THOR2
  Firmware Version                    : 236.1.153.0
  RoCE Firmware Version               : 236.1.153.0
  HWRM Interface Spec                 : 1.10.3
  Active Package Version              : 236.1.155.0
  Package Version on NVM              : 236.1.155.0
  Active NVM config version           : 236.0.2

--=20
You are receiving this mail because:
You are the assignee for the bug.=
