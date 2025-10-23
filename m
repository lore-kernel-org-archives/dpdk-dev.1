Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D597CCD193
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Oct 2025 23:43:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7367D40151;
	Fri, 24 Oct 2025 01:43:52 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id ED87440144
 for <dev@dpdk.org>; Fri, 24 Oct 2025 01:43:50 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id E7D8B489BE; Fri, 24 Oct 2025 01:43:50 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1808] net/gve: possible misuse of comma
Date: Thu, 23 Oct 2025 23:43:51 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 20.11
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
Message-ID: <bug-1808-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1808

            Bug ID: 1808
           Summary: net/gve: possible misuse of comma
           Product: DPDK
           Version: 20.11
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: stephen@networkplumber.org
  Target Milestone: ---

If DPDK is built with clang and -Wcomma is enabled for drivers, then gve dr=
iver
has warnings:

[973/3622] Compiling C object drivers/...et_gve.a.p/net_gve_base_gve_adminq=
.c.o
../drivers/net/gve/base/gve_adminq.c:624:30: warning: possible misuse of co=
mma
operator here [-Wcomma]
  624 |                         cpu_to_be64(rxq->mz->iova),
      |                                                   ^
../drivers/net/gve/base/gve_adminq.c:623:3: note: cast expression to void to
silence warning
  623 |                 cmd.create_rx_queue.rx_desc_ring_addr =3D
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |                 (void)(
  624 |                         cpu_to_be64(rxq->mz->iova),
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~
      |                                                   )
../drivers/net/gve/base/gve_adminq.c:626:35: warning: possible misuse of co=
mma
operator here [-Wcomma]
  626 |                         cpu_to_be64(rxq->data_mz->iova),
      |                                                        ^
../drivers/net/gve/base/gve_adminq.c:625:3: note: cast expression to void to
silence warning
  625 |                 cmd.create_rx_queue.rx_data_ring_addr =3D
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |                 (void)(
  626 |                         cpu_to_be64(rxq->data_mz->iova),
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |                                                        )
2 warnings generated.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
