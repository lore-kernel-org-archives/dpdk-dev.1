Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295A1CFC296
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Nov 2025 17:53:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6F9044026F;
	Fri, 21 Nov 2025 18:53:34 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 51F6040267
 for <dev@dpdk.org>; Fri, 21 Nov 2025 18:53:33 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 4D28448B6D; Fri, 21 Nov 2025 18:53:33 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/DTS Bug 1828] Add additional vlan stripping tests to DTS
Date: Fri, 21 Nov 2025 17:53:33 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: DTS
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: minor
X-Bugzilla-Who: abailey@iol.unh.edu
X-Bugzilla-Status: CONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: resolution everconfirmed bug_status
Message-ID: <bug-1828-3-2TywujLJLD@http.bugs.dpdk.org/>
In-Reply-To: <bug-1828-3@http.bugs.dpdk.org/>
References: <bug-1828-3@http.bugs.dpdk.org/>
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

Andrew (abailey@iol.unh.edu) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
         Resolution|FIXED                       |---
     Ever confirmed|0                           |1
             Status|RESOLVED                    |CONFIRMED

--- Comment #3 from Andrew (abailey@iol.unh.edu) ---
Re-opening, we can close this when the patch for the QinQ testsuite is merg=
ed
in 26.03. This patch will add checks for the VLAN/QinQ tag storage in
TCI/OUTER_TCI.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
