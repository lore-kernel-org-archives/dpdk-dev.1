Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9302BE98DE0
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Feb 2026 05:42:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 60B6F40288;
	Mon, 23 Feb 2026 06:42:05 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 736F2400EF
 for <dev@dpdk.org>; Mon, 23 Feb 2026 06:42:04 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 558864A6A3; Mon, 23 Feb 2026 06:42:04 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/other Bug 1893] Possible memory leak in ipv4_frag_reassemble
Date: Mon, 23 Feb 2026 05:42:04 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: other
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: critical
X-Bugzilla-Who: albe19021990@gmail.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1893-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1893

            Bug ID: 1893
           Summary: Possible memory leak in ipv4_frag_reassemble
           Product: DPDK
           Version: unspecified
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: critical
          Priority: Normal
         Component: other
          Assignee: dev@dpdk.org
          Reporter: albe19021990@gmail.com
  Target Milestone: ---

In current ipv4_frag_reassemble version in case of invalid data memory leak=
 is
possibble.

On every success packet search we remove mbuf from fp

https://github.com/DPDK/dpdk/blob/main/lib/ip_frag/rte_ipv4_reassembly.c#L48

and link it to result mbuf.

https://github.com/DPDK/dpdk/blob/main/lib/ip_frag/rte_ipv4_reassembly.c#L45

If for some reason on some fail iteration there will be invalid offset in s=
ome
packet=20

https://github.com/DPDK/dpdk/blob/main/lib/ip_frag/rte_ipv4_reassembly.c#L59

we will return NULL and all information chaned to m mbuf will be lost, as t=
his
information was also deleted from fp.

So using fragmentation some client can create DDOS attack.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
