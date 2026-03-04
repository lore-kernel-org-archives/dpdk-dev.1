Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58380EFCE33
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Mar 2026 18:05:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6CBEB40651;
	Wed,  4 Mar 2026 19:05:36 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id BDF1B402A9
 for <dev@dpdk.org>; Wed,  4 Mar 2026 19:05:35 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id A7F424AB57; Wed,  4 Mar 2026 19:05:35 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/other Bug 1897] iavf_execute_vf_cmd(): Return failure -22 for
 cmd 11
Date: Wed, 04 Mar 2026 18:05:35 +0000
X-Bugzilla-Reason: CC
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: other
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: anurag.mandal@intel.com
X-Bugzilla-Status: IN_PROGRESS
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: anurag.mandal@intel.com
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-1897-3-9vwtlkciVA@http.bugs.dpdk.org/>
In-Reply-To: <bug-1897-3@http.bugs.dpdk.org/>
References: <bug-1897-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1897

Anurag Mandal (anurag.mandal@intel.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |dev@dpdk.org

--=20
You are receiving this mail because:
You are on the CC list for the bug.=
