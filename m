Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F4C2CAC5B8
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 09:05:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3F6DD40150;
	Tue, 30 Sep 2025 11:05:18 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 04B4A400D7
 for <dev@dpdk.org>; Tue, 30 Sep 2025 11:05:16 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id E066F48871; Tue, 30 Sep 2025 11:05:16 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1619] Unit test link_bonding_autotest will fail.
Date: Tue, 30 Sep 2025 09:05:17 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: ktraynor@redhat.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: WONTFIX
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc bug_status resolution
Message-ID: <bug-1619-3-fwBnwhKmbV@http.bugs.dpdk.org/>
In-Reply-To: <bug-1619-3@http.bugs.dpdk.org/>
References: <bug-1619-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1619

Kevin Traynor (ktraynor@redhat.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |ktraynor@redhat.com
             Status|UNCONFIRMED                 |RESOLVED
         Resolution|---                         |WONTFIX

--- Comment #2 from Kevin Traynor (ktraynor@redhat.com) ---
This is an old issue that was carried in the documented known issues and th=
en
transferred to Bugzilla.

Fedora 20 is EoL for more 10 years, so closing bug. Feel free to reopen if
someone hits this with a maintained distribution.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
