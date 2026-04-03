Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E58E7E34E
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Apr 2026 08:55:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3DE9240296;
	Fri,  3 Apr 2026 10:55:55 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 9A0684028B
 for <dev@dpdk.org>; Fri,  3 Apr 2026 10:55:53 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 847BF4AE16; Fri,  3 Apr 2026 10:55:53 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/core Bug 1925] parameters of macros in
 lib/eal/include/rte_test.h are not parenthesized
Date: Fri, 03 Apr 2026 08:55:53 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: core
X-Bugzilla-Version: 26.03
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: marat.khalili@huawei.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1925-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1925

            Bug ID: 1925
           Summary: parameters of macros in lib/eal/include/rte_test.h are
                    not parenthesized
           Product: DPDK
           Version: 26.03
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: core
          Assignee: dev@dpdk.org
          Reporter: marat.khalili@huawei.com
  Target Milestone: ---

Parameters of macros like RTE_TEST_ASSERT_EQUAL defined in
lib/eal/include/rte_test.h are not enclosed in parentheses, which potential=
ly
may result in unintended operator precedence after substitution and in the
worst case scenario false negatives in library and user tests. E.g. the
following statement:
```c
RTE_TEST_ASSERT_EQUAL(port_status & FLAG_UP, FLAG_UP, "Port is not UP!");
```
will check bit 1 (FLAG_UP =3D=3D FLAG_UP) of port_status, not FLAG_UP.

See https://gcc.gnu.org/onlinedocs/cpp/Operator-Precedence-Problems.html

Same problem in app/test/test.h

--=20
You are receiving this mail because:
You are the assignee for the bug.=
