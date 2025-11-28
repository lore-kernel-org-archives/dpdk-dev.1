Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5443D116E2
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Nov 2025 18:29:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B7FA340281;
	Fri, 28 Nov 2025 19:29:40 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 6E625400EF
 for <dev@dpdk.org>; Fri, 28 Nov 2025 19:29:39 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 53ED448BCF; Fri, 28 Nov 2025 19:29:39 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1840] net/pcap: missing read_clock operation
Date: Fri, 28 Nov 2025 18:29:39 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 25.07
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
Message-ID: <bug-1840-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1840

            Bug ID: 1840
           Summary: net/pcap: missing read_clock operation
           Product: DPDK
           Version: 25.07
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: stephen@networkplumber.org
  Target Milestone: ---

The pcap PMD provides receive timestamps from the pcap interface into the m=
buf.
But there are a couple of issues with it.

The units of the timestamp are limited to microseconds now, but the pcap
library has a flag to provide nanosecond resolution. This should be used. O=
ne
caveat is that the API is misleading in reporting timestamp. The packet hea=
der
struct gives timestamp as a timeval (ie. usec) but if nanosecond mode flag =
is
used then the timestamp is really in timespec (ie nanoseconds).

The pcap PMD doesn't have a read_clock device operation so the application =
can
not determine the units of the receive timestamp. Pcap should behave like a
hardware PMD and return the underlying clock value.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
