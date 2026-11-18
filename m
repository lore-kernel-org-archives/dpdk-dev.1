Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2CA606A31C
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Nov 2026 04:28:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 412C5402BF;
	Wed, 18 Nov 2026 05:28:36 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTPS id F2B7B402BD
 for <dev@dpdk.org>; Wed, 18 Nov 2026 05:28:34 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id D3A144D5BE; Wed, 18 Nov 2026 05:28:34 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 2147] [Bug] net/e1000: queue-count regression on
 VMware Workstation 82545EM
Date: Wed, 18 Nov 2026 04:28:33 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 26.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: liuwf@ysxt.com.cn
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-2147-3@https.bugs.dpdk.org/>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
X-Bugzilla-URL: https://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

https://bugs.dpdk.org/show_bug.cgi?id=3D2147

            Bug ID: 2147
           Summary: [Bug] net/e1000: queue-count regression on VMware
                    Workstation 82545EM
           Product: DPDK
           Version: 26.11
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: liuwf@ysxt.com.cn
  Target Milestone: ---

Hi,

We observed a networking regression after upgrading an integrated DPDK
application from 22.11.1 to 22.11.11 on a virtual Intel 82545EM copper NIC
(net_e1000_em) in VMware Workstation. Limiting the application to one RX/TX
queue on 22.11.11 restores both ping and SSH connectivity on the affected V=
M.

Observed on 22.11.11:
- Device/application initialization reports no error.
- RX counters increase, but ping and SSH to the management IP fail.
- The application now configures two RX/TX queues; startup output confirms
  a binding for queue 1. It selects the queue count using the advertised
  RX/TX maximums and the available worker threads.

The relevant upstream change identified by source comparison is:
  c1a42d646472 ("net/e1000: fix queue number initialization")

That change unconditionally raises max_rx_queues and max_tx_queues from
1 to 2. However, the adjacent comment still describes limitations that
led to the single-queue implementation: extended RX descriptors are
required for multiple RX queues, 82540/82545 do not support those
extended descriptors, and the TX queues share a TX context.

The same unconditional values and comment remain in main at
c6d273ce156cc48ef90e64e93a2bba80c9d36345 (VERSION 26.11.0-rc3), and in
v26.07 and v25.11.4. These newer versions were inspected in source only;
we have not reproduced the runtime failure on them.

We applied an application-side workaround limiting EM ports to one RX
queue and one TX queue. Local tests using the production queue-selection and
TX-routing
functions show the original upgraded configuration selecting queue 1,
and the workaround keeping traffic on queue 0. Compilation with our
GCC 4.8.5 toolchain succeeds.

On-device results on VMware Workstation:
- 22.11.1 with the original single-queue behavior: networking worked.
- 22.11.11 with two queues, including an observed queue 1 binding:
  ping and SSH failed despite RX counters increasing.
- 22.11.11 with the single-queue workaround deployed:
  both ping and SSH connectivity recovered.

A stock testpmd reproduction and a commit-by-commit runtime bisection are
not yet available; the runtime results above are from our integrated
application on the affected VMware Workstation VM.

Could you confirm which devices were intended to support two queues in
c1a42d646472, and whether legacy/virtual 82545EM devices should still be
limited to one RX/TX queue? Should these capabilities be reported per
MAC/device type instead of unconditionally for the entire EM driver?

--=20
You are receiving this mail because:
You are the assignee for the bug.=
