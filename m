Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB0C6EE645E
	for <dpdk-dev@archiver.kernel.org>; Wed, 31 Dec 2025 18:23:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4AB23402A0;
	Wed, 31 Dec 2025 19:23:53 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 6CEBC40267
 for <dev@dpdk.org>; Wed, 31 Dec 2025 19:23:51 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 525DE4714B; Wed, 31 Dec 2025 19:23:51 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1863] common/cnxk: build errors with LTO
Date: Wed, 31 Dec 2025 18:23:51 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 25.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: stephen@networkplumber.org
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1863-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1863

            Bug ID: 1863
           Summary: common/cnxk: build errors with LTO
           Product: DPDK
           Version: 25.11
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: stephen@networkplumber.org
  Target Milestone: ---

Doing LTO release build detects errors in irq

../drivers/common/cnxk/roc_platform.c: In function =E2=80=98irq_config=E2=
=80=99:
../drivers/common/cnxk/roc_platform.c:56:14: warning: argument to
variable-length array is too large [-Wvla-larger-than=3D]
   56 |         char irq_set_buf[MSIX_IRQ_SET_BUF_LEN];
      |              ^
../drivers/common/cnxk/roc_platform.c:56:14: note: limit is 922337203685477=
5807
bytes, but argument is 18446744073709551548
../drivers/common/cnxk/roc_platform.c: In function =E2=80=98irq_init=E2=80=
=99:
../drivers/common/cnxk/roc_platform.c:92:14: warning: argument to
variable-length array is too large [-Wvla-larger-than=3D]
   92 |         char irq_set_buf[MSIX_IRQ_SET_BUF_LEN];
      |              ^
../drivers/common/cnxk/roc_platform.c:92:14: note: limit is 922337203685477=
5807
bytes, but argument is 18446744073709551548

Looks like MSIX_IRQ_SET_BUF_LEN is not a constant??

--=20
You are receiving this mail because:
You are the assignee for the bug.=
