Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73944FF8875
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Apr 2026 09:19:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 95DA840285;
	Thu, 30 Apr 2026 11:19:31 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 99DB040280
 for <dev@dpdk.org>; Thu, 30 Apr 2026 11:19:29 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 81BCF4B0F9; Thu, 30 Apr 2026 11:19:29 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1938] The NIC's imissed counter increments when the
 x710 VF uses dpdk-l2fwd for data forwarding.
Date: Thu, 30 Apr 2026 09:19:29 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 24.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: major
X-Bugzilla-Who: laitianli2000@163.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: FIXED
X-Bugzilla-Priority: High
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: 24.11
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: resolution bug_status
Message-ID: <bug-1938-3-F0jyIV8euE@http.bugs.dpdk.org/>
In-Reply-To: <bug-1938-3@http.bugs.dpdk.org/>
References: <bug-1938-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1938

laitianli (laitianli2000@163.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
         Resolution|---                         |FIXED
             Status|UNCONFIRMED                 |RESOLVED

--- Comment #1 from laitianli (laitianli2000@163.com) ---
Fixed it by change IAVF_ALARM_INTERVAL to 1000

--=20
You are receiving this mail because:
You are the assignee for the bug.=
