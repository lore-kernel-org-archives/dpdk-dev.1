Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 991BCCCF9E3
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 05:16:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9B231402B6;
	Tue,  4 Nov 2025 06:16:58 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id A37F8402B1
 for <dev@dpdk.org>; Tue,  4 Nov 2025 06:16:57 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id A059448A9B; Tue,  4 Nov 2025 06:16:57 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/core Bug 1820] pcapng: compile warning with gcc-16
Date: Tue, 04 Nov 2025 05:16:57 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: core
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
Message-ID: <bug-1820-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1820

            Bug ID: 1820
           Summary: pcapng: compile warning with gcc-16
           Product: DPDK
           Version: 25.07
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: core
          Assignee: dev@dpdk.org
          Reporter: stephen@networkplumber.org
  Target Milestone: ---

../lib/pcapng/rte_pcapng.c:133:17: warning: =E2=80=98memcpy=E2=80=99 formin=
g offset [2048,
65551] is out of the bounds [0, 2048] of object =E2=80=98buf=E2=80=99 with =
type =E2=80=98uint32_t[512]=E2=80=99
{aka =E2=80=98unsigned int[512]=E2=80=99} [-Warray-bounds=3D]
  133 |                 memcpy(popt->data, data, len);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../lib/pcapng/rte_pcapng.c: In function =E2=80=98rte_pcapng_write_stats=E2=
=80=99:
../lib/pcapng/rte_pcapng.c:336:18: note: =E2=80=98buf=E2=80=99 declared here
  336 |         uint32_t buf[PCAPNG_BLKSIZ];
      |                  ^~~


Likely because comment could have a large size and overrun buffer?

--=20
You are receiving this mail because:
You are the assignee for the bug.=
