Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C000C1099B37
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Mar 2026 20:09:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 75C08402BB;
	Fri, 20 Mar 2026 21:09:07 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 59CB9402B2
 for <dev@dpdk.org>; Fri, 20 Mar 2026 21:09:06 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 185F94AD58; Fri, 20 Mar 2026 21:09:06 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/DTS Bug 1907] filter_tests filtering out testcases, but
 leaving empty testsuites in result list
Date: Fri, 20 Mar 2026 20:09:06 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: DTS
X-Bugzilla-Version: 25.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: minor
X-Bugzilla-Who: probb@iol.unh.edu
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter cc
 target_milestone
Message-ID: <bug-1907-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1907

            Bug ID: 1907
           Summary: filter_tests filtering out testcases, but leaving
                    empty testsuites in result list
           Product: DPDK
           Version: 25.11
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: minor
          Priority: Normal
         Component: DTS
          Assignee: dev@dpdk.org
          Reporter: probb@iol.unh.edu
                CC: juraj.linkes@pantheon.tech, probb@iol.unh.edu
  Target Milestone: ---

When one comments out the test_suites field entirely in test_run.yaml (to
default to running the complete set of testsuites in DTS) filter_tests() on=
ly
does part of its job. It will filter out the testcases which are disallowed=
 per
the test_run.yaml config (i.e. remove crypto tests if crypto =3D=3D False i=
n the
config). However, using the crypto example, it will remove all crypto testc=
ases
from the execution, but leave the testsuite in the list of testsuites to ru=
n.
The result is an "empty" testsuite run.

Example (see cryptodev throughput):

 blocklist: PASS
    all_but_one_port_blocklisted: SKIP
      reason: Required capability '{LinkTopology.TWO_LINKS}' not found.
    no_blocklisted: PASS
    one_port_blocklisted: SKIP
      reason: Required capability '{LinkTopology.TWO_LINKS}' not found.
  checksum_offload: PASS
    insert_checksums: PASS
    l3_rx_checksum: PASS
    l4_rx_checksum: PASS
    no_insert_checksums: PASS
    validate_rx_checksum: PASS
    validate_sctp_checksum: SKIP
      reason: Required capability '{PORT_RX_OFFLOAD_SCTP_CKSUM}' not found.
    vlan_checksum: SKIP
      reason: Required capability '{PORT_RX_OFFLOAD_VLAN}' not found.
  cryptodev_throughput: PASS
  dual_vlan: PASS
    all_vlan_functions: PASS
    insert_second_vlan: SKIP
      reason: Required capability '{LinkTopology.TWO_LINKS}' not found.
    maintains_priority: PASS

--=20
You are receiving this mail because:
You are the assignee for the bug.=
