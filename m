Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D117EA3C4E
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Apr 2026 12:00:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A76414028F;
	Thu,  9 Apr 2026 14:00:57 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id AE6C140276
 for <dev@dpdk.org>; Thu,  9 Apr 2026 14:00:55 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 9E0754AE6C; Thu,  9 Apr 2026 14:00:55 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/core Bug 1931] Broadcom BCM57608 Ethernet 100Gb 2-port QSFP112
 Adapter - PCI-PT and SRIOV on VM Perf Degrade in 25.11 and 26.03
Date: Thu, 09 Apr 2026 12:00:55 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: core
X-Bugzilla-Version: 25.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: sandeepr@hpe.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone attachments.created
Message-ID: <bug-1931-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1931

            Bug ID: 1931
           Summary: Broadcom BCM57608 Ethernet 100Gb 2-port QSFP112
                    Adapter - PCI-PT and SRIOV on VM Perf Degrade in 25.11
                    and 26.03
           Product: DPDK
           Version: 25.11
          Hardware: All
                OS: Linux
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: core
          Assignee: dev@dpdk.org
          Reporter: sandeepr@hpe.com
  Target Milestone: ---

Created attachment 347
  --> http://bugs.dpdk.org/attachment.cgi?id=3D347&action=3Dedit
git bisect search offending commit perf test results

[Steps to Reproduce]

1. Install RHEL 10 - 6.12.0-55.43.1.el10_0.x86_64
2. Tested with following latest BCM57608 driver and firmware:
        Driver:1.10.3-236.1.155.0 || firmware:235.1.164.6/pkg 235.1.164.14
        Driver:1.10.3-237.1.131.0 || firmware:237.1.131.0/pkg 237.1.132.0
3. Install DPDK - Tested with 25.11 and 26.03
4. Start testpmd; command: with tuning params
   build/app/dpdk-testpmd -l 2-4 --main-lcore 2 -v -a 0000:07:00.0 -a
0000:08:00.0 --socket-mem=3D2048 -- -i --socket-num=3D0 --burst=3D64 --txd=
=3D2048
--rxd=3D2048 --mbcache=3D512 --rxq=3D1 --txq=3D1 --nb-cores=3D2 --port-topo=
logy=3Dpaired
--forward-mode=3Dio '--port-numa-config=3D(0,0),(1,0)' --ring-numa-config=
=3D0,0
--ring-numa-config=3D1,0 -a
5. Start RFC2544 Throughput Test - I used Hardware Traffic Gen [Xena]=20=20=
=20
6. Result from my lab test:
---------------------------------------------------------------------------=
------------------
Frame Size              25.11 - BAD             26.03 - BAD
64                      26.012                  25.838
128                     45.186                  45.383
256                     71.955                  81.777
512                     100.000                 100.000
1024                    100.000                 100.000
1280                    100.000                 100.000
1518                    100.000                 100.000
---------------------------------------------------------------------------=
------------------
Test Setup Info:
HPE ProLiant DL345 Gen12
AMD EPYC 9845 160-Core Processor 2100 MHz
Broadcom BCM57608 Ethernet 100Gb 2-port QSFP112 Adapter - PCIe Slot 1

[Additional Info]
This issue is not seen with DPDK 25.07.

DPDK 25.07 Result:

Frame Size      25.07 - GOOD
64              45.635
128             79.789
256             100.000
512             100.000
1024            100.000
1280            100.000
1518            100.000

Test results of git bisect search for the offending commit: Ref attachment

It looks like the performance degradation is mostly due to the multiple com=
mits
from both Intel and Broadcom between September and October 2025 around the
25.11-rc0-25.11-rc2 phase.

After this commit, the performance has remained BAD even with DPDK 26.03.
---------------------------------------------------------------------------=
----------------------------
Date            DPDK Version    Commit ID       Driver  Description=20=20=
=20=20=20=20=20=20=20=20=20=20
                Result
Oct 30, 2025    v25.11-rc2      ef86bb9c55      bnxt    Add feature bit Rx =
miss
handling        BAD
---------------------------------------------------------------------------=
----------------------------
[Expected result]
Result must be similar or better than 25.07 result.

[Actual result]
64b/128b/256b frame size performance degradation with 25.11 and 26.03.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
