Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F055DFF8861
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Apr 2026 08:11:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2DAE2402E1;
	Mon, 27 Apr 2026 10:11:07 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 12B994029F
 for <dev@dpdk.org>; Mon, 27 Apr 2026 10:11:06 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 0362B4B0B5; Mon, 27 Apr 2026 10:11:06 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1938] The NIC's imissed counter increments when the
 x710 VF uses dpdk-l2fwd for data forwarding.
Date: Mon, 27 Apr 2026 08:11:05 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 24.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: laitianli2000@163.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1938-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1938

            Bug ID: 1938
           Summary: The NIC's imissed counter increments when the x710 VF
                    uses dpdk-l2fwd for data forwarding.
           Product: DPDK
           Version: 24.11
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: laitianli2000@163.com
  Target Milestone: ---

With the i40e driver (v2.18.9, firmware 0x8000c407 1.3295.0) and DPDK
v24.11.5-rc1, aarch64 and ubuntu2204 system, when dpdk-l2fwd takes over the=
 VF
for forwarding, injecting 500 Mbps of UDP traffic via pktgen results in an
incrementing imissed counter retrieved via rte_eth_stats_get().=20

Port statistics =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Statistics for port 0 ------------------------------
Packets sent:                  6784279
Packets received:              6784279
Packets dropped:                     0
ipackets:          6784279      opackets:          6784279      ibytes:=20=
=20=20=20=20=20
9474046884        obytes:       9470853484
imissed:             2281      ierrors:                0       oerrors:=20=
=20=20=20=20=20=20=20
       0
Aggregate statistics =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Total packets sent:            6784279
Total packets received:        6784279
Total packets dropped:               0
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

Port statistics =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Statistics for port 0 ------------------------------
Packets sent:                  7223135
Packets received:              7223135
Packets dropped:                     0
ipackets:          7223135      opackets:          7223135      ibytes:=20=
=20=20=20=20
10087126660        obytes:      10083496460
imissed:             2593       ierrors:                0       oerrors:=20=
=20=20=20=20=20=20
        0
Aggregate statistics =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Total packets sent:            7223135
Total packets received:        7223135
Total packets dropped:               0
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

--=20
You are receiving this mail because:
You are the assignee for the bug.=
