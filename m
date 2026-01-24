Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF73D715F3
	for <dpdk-dev@archiver.kernel.org>; Sat, 24 Jan 2026 20:23:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8417D402B0;
	Sat, 24 Jan 2026 21:23:12 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 27B5D40278
 for <dev@dpdk.org>; Sat, 24 Jan 2026 21:23:11 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id EFEF04A2CC; Sat, 24 Jan 2026 21:23:10 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1699] Bonding device documentation missing
Date: Sat, 24 Jan 2026 20:23:10 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 25.03
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: minor
X-Bugzilla-Who: stephen@networkplumber.org
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: INVALID
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: resolution bug_status
Message-ID: <bug-1699-3-0zlAM2rw1c@http.bugs.dpdk.org/>
In-Reply-To: <bug-1699-3@http.bugs.dpdk.org/>
References: <bug-1699-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1699

Stephen Hemminger (stephen@networkplumber.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
         Resolution|---                         |INVALID
             Status|UNCONFIRMED                 |RESOLVED

--- Comment #1 from Stephen Hemminger (stephen@networkplumber.org) ---
This NIC was dropped from table intentionally by:

commit 7b103c4ccd98e3f3d457c74960acd28dac64392d
Author: Thomas Monjalon <thomas@monjalon.net>
Date:   Thu Mar 12 00:01:35 2020 +0100

    doc: remove empty columns from NIC features matrix

    The virtual PMDs bonding, KNI, null, ring, softnic and vdev_netvsc
    have no real feature to advertise so they can be removed
    from the (too) big matrix of ethdev features.

    Signed-off-by: Thomas Monjalon <thomas@monjalon.net>

--=20
You are receiving this mail because:
You are the assignee for the bug.=
