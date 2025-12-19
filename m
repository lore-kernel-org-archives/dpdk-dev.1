Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C79B5D767DC
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Dec 2025 11:31:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C6B7A4026A;
	Fri, 19 Dec 2025 12:31:39 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 7881740150
 for <dev@dpdk.org>; Fri, 19 Dec 2025 12:31:38 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 376B44708F; Fri, 19 Dec 2025 12:31:38 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1856] i40evf_check_api_version(): PF/VF API version
 mismatch:(0.0)-(1.1) with multiple DPDK instances using different VFs
 with the same PF
Date: Fri, 19 Dec 2025 11:31:37 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 24.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: srija.bhattacharyya@wipro.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1856-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1856

            Bug ID: 1856
           Summary: i40evf_check_api_version(): PF/VF API version
                    mismatch:(0.0)-(1.1) with multiple DPDK instances
                    using different VFs with the same PF
           Product: DPDK
           Version: 24.11
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: srija.bhattacharyya@wipro.com
  Target Milestone: ---

We encountered an issue with DPDK initialization, where a PF/VF API version
mismatch occurred for VFs from the same PF. This issue was previously repor=
ted
under Bug ID:578.
Below here is a list of firmware versions that we tested with DPDK 24.11:

Driver  Driver version  firmware version
i40e    2.22.18         6.00 0x800063b6 18.5.17
i40e    2.22.18         8.40 0x8000b1fb 20.5.16=20=20=20=20=20=20=20=20=20
i40e    2.22.18         8.40 0x8000b1fb 20.5.16
i40e    2.22.18         9.54 0x800063b6 24.0.5
i40e    2.22.18         7.10 0x80009d2d 19.5.15

We would like to confirm if this issue has been fixed in any of the newer
firmware or driver versions. If it has been resolved, kindly specify which
driver and firmware version contains the fix.
We would appreciate any guidance on whether the issue persists or is addres=
sed
in any of those versions.

Thanks,

--=20
You are receiving this mail because:
You are the assignee for the bug.=
