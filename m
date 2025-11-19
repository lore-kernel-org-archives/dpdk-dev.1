Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DCBCCF2594
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Nov 2025 07:55:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6BFF34029D;
	Wed, 19 Nov 2025 08:54:58 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 77D6140265
 for <dev@dpdk.org>; Wed, 19 Nov 2025 08:54:57 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 7022E48B4B; Wed, 19 Nov 2025 08:54:57 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/testpmd Bug 1834] [dpdk-25.11-rc2] Segmentation fault in Rx
 offload testcase
Date: Wed, 19 Nov 2025 07:54:57 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: testpmd
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jiawenwu@trustnetic.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1834-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1834

            Bug ID: 1834
           Summary: [dpdk-25.11-rc2] Segmentation fault in Rx offload
                    testcase
           Product: DPDK
           Version: unspecified
          Hardware: All
                OS: Linux
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: testpmd
          Assignee: dev@dpdk.org
          Reporter: jiawenwu@trustnetic.com
  Target Milestone: ---

There is a bug introduced by:

Commit 066f3d9cc21c ("ethdev: remove callback checks from fast path")

In test case 139.4 <Rx offload per-port setting in command-line>, testpmd s=
et
fwd csum, and only enable Rx csum offload. Meanwhile, driver like txgbe set
'dev->tx_pkt_prepare =3D NULL' since Tx offload is disabled. Thus
rte_eth_tx_prepare() calls null pointer cause segmentation fault in
pkt_burst_checksum_forward(), bacause NULL check was removed.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
