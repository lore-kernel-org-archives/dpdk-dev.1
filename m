Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC45FCA5FA5
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 08:37:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0408040276;
	Tue, 29 Sep 2026 10:37:36 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id BEA4B4013F
 for <dev@dpdk.org>; Tue, 29 Sep 2026 10:37:34 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id AAF114C3AE; Tue, 29 Sep 2026 10:37:34 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/core Bug 2048] Broadcom BCM57608 Ethernet 100Gb 2-port QSFP112
 Adapter - SRIOV on VM Perf Degrade in 26.07 for large packets(1280
 and 1518 byte).  - 85% instead of 100% line rate
Date: Tue, 29 Sep 2026 08:37:34 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: core
X-Bugzilla-Version: 26.07
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
Message-ID: <bug-2048-3@https.bugs.dpdk.org/>
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

https://bugs.dpdk.org/show_bug.cgi?id=3D2048

            Bug ID: 2048
           Summary: Broadcom BCM57608 Ethernet 100Gb 2-port QSFP112
                    Adapter - SRIOV on VM Perf Degrade in 26.07 for large
                    packets(1280 and 1518 byte).  - 85% instead of 100%
                    line rate
           Product: DPDK
           Version: 26.07
          Hardware: x86
                OS: Linux
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: core
          Assignee: dev@dpdk.org
          Reporter: sandeepr@hpe.com
  Target Milestone: ---

Created attachment 403
  --> https://bugs.dpdk.org/attachment.cgi?id=3D403&action=3Dedit
26.07_large_pkt_test_data.jpg

While validating https://bugs.dpdk.org/show_bug.cgi?id=3D1931, observed a n=
ew
issue in 26.07, where 1280b and 1518b frames performance has degraded.

Filing a new bug for the same.

Test setup [hardware and software], steps to reproduce, is the same as
used/mentioned in 1931.

Test data attached: 26.07_large_pkt_test_data.jpg

--=20
You are receiving this mail because:
You are the assignee for the bug.=
