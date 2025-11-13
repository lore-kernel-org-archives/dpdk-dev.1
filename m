Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BDEDCD98D2
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 20:22:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1ECEF40E22;
	Thu, 13 Nov 2025 21:22:44 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id C271540151
 for <dev@dpdk.org>; Thu, 13 Nov 2025 21:22:42 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id AAF2E48AFE; Thu, 13 Nov 2025 21:22:42 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/DTS Bug 1828] Add additional vlan stripping tests to DTS
Date: Thu, 13 Nov 2025 20:22:42 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: DTS
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: minor
X-Bugzilla-Who: dmarx@iol.unh.edu
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter cc
 target_milestone
Message-ID: <bug-1828-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1828

            Bug ID: 1828
           Summary: Add additional vlan stripping tests to DTS
           Product: DPDK
           Version: unspecified
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: minor
          Priority: Normal
         Component: DTS
          Assignee: dev@dpdk.org
          Reporter: dmarx@iol.unh.edu
                CC: juraj.linkes@pantheon.tech, probb@iol.unh.edu
  Target Milestone: ---

Currently, the vlan test suite has a case for verifying vlan strip behavior=
 by
sending a basic vlan packet:

Ether() / Dot1Q(vlan=3Dvlan_id) / Raw(load=3D"xxxxx")

And checking that the Dot1Q layer is removed upon reception. Additionally, =
the
QinQ test suite (which will be merged in either 25.07 or 25.11) has a case
which sends a set of packets (vlan, double vlan, single 88a8, QinQ) with bo=
th
vlan and qinq strip enabled to verify behavior. Expanding the set of packets
being tested with vlan strip to match the coverage of the vlan/qinq strip c=
ase
would make the tests more consistent, whether that be in the vlan or QinQ
suite.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
