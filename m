Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8978D3F083
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 17:23:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D812D4026F;
	Wed, 28 Jan 2026 18:23:04 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 865F94003C
 for <dev@dpdk.org>; Wed, 28 Jan 2026 18:23:03 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 6F3464A304; Wed, 28 Jan 2026 18:23:03 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/DTS Bug 1545] Docs are incorrect regarding how final testsuite
 list is produced
Date: Wed, 28 Jan 2026 17:23:02 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: DTS
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: minor
X-Bugzilla-Who: dmarx@iol.unh.edu
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: FIXED
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: resolution bug_status cc
Message-ID: <bug-1545-3-X2ezgqKQ0h@http.bugs.dpdk.org/>
In-Reply-To: <bug-1545-3@http.bugs.dpdk.org/>
References: <bug-1545-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1545

Dean Marx (dmarx@iol.unh.edu) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
         Resolution|---                         |FIXED
             Status|UNCONFIRMED                 |RESOLVED
                 CC|                            |dmarx@iol.unh.edu

--- Comment #1 from Dean Marx (dmarx@iol.unh.edu) ---
The DTS rst file has been updated to reflect this behavior.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
