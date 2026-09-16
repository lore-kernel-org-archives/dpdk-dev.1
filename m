Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D42F6C88E5C
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Sep 2026 14:02:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 349AC40E12;
	Wed, 16 Sep 2026 16:02:58 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id BA9AA40264
 for <dev@dpdk.org>; Wed, 16 Sep 2026 16:02:56 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id AAB5F4CE3A; Wed, 16 Sep 2026 16:02:56 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 2031] cn10k: NPA_POOL_ERR_INT_RANGE on Pool 1
 during mbuf pool creation in testpmd
Date: Wed, 16 Sep 2026 14:02:56 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 24.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: critical
X-Bugzilla-Who: asekhar@marvell.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: INVALID
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc bug_status resolution
Message-ID: <bug-2031-3-gGuynGcjL9@https.bugs.dpdk.org/>
In-Reply-To: <bug-2031-3@https.bugs.dpdk.org/>
References: <bug-2031-3@https.bugs.dpdk.org/>
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

https://bugs.dpdk.org/show_bug.cgi?id=3D2031

Ashwin Sekhar T K (asekhar@marvell.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |asekhar@marvell.com
             Status|CONFIRMED                   |RESOLVED
         Resolution|---                         |INVALID

--- Comment #5 from Ashwin Sekhar T K (asekhar@marvell.com) ---
PCI_BUS:   Expecting 'VA' IOVA mode but current mode is 'PA', not initializ=
ing
EAL: Failed to probe device 0002:01:01.7
PCI_BUS:   Expecting 'VA' IOVA mode but current mode is 'PA', not initializ=
ing
EAL: Failed to probe device 0002:01:02.0
PCI_BUS:   Expecting 'VA' IOVA mode but current mode is 'PA', not initializ=
ing
EAL: Failed to probe device 0002:02:00.0
PCI_BUS:   Expecting 'VA' IOVA mode but current mode is 'PA', not initializ=
ing
EAL: Failed to probe device 0002:03:00.0
PCI_BUS:   Expecting 'VA' IOVA mode but current mode is 'PA', not initializ=
ing

These prints should be already coming. No further checks are required.

@Amiya,=20
It is not a supported mode. This means any address that you are configuring
(whether it be contexts or stacks or pointers) will run into all sorts of
issues.

You may print the pointers that you are trying to free to understand why the
Range error happened. Mostly probably there is a difference in the range
configured and the pointers being freed.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
