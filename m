Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19ED6D3B7DE
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Dec 2025 10:06:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F0B3640280;
	Mon,  8 Dec 2025 11:06:53 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 22E674003C
 for <dev@dpdk.org>; Mon,  8 Dec 2025 11:06:53 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 020D346FE2; Mon,  8 Dec 2025 11:06:52 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1848] Using maximum RX descriptor causes 100% imiss
Date: Mon, 08 Dec 2025 10:06:52 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 22.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: major
X-Bugzilla-Who: canary.overflow@gmail.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1848-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1848

            Bug ID: 1848
           Summary: Using maximum RX descriptor causes 100% imiss
           Product: DPDK
           Version: 22.11
          Hardware: x86
                OS: Linux
            Status: UNCONFIRMED
          Severity: major
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: canary.overflow@gmail.com
  Target Milestone: ---

I have a server using the following setup:

NIC card:MT27800 (ConnectX-5)
DPDK version: 22.11
driver: mlx5_core
version: 5.7-1.0.2
firmware: 16.35.4506 (MT_0000000011)

Issue: 100% imiss was observed when I tried to use rx_desc=3D32768 (32768 i=
s the
maximum supported by the NIC)

testpmd command:
dpdk-testpmd -l 1-10 -n 4 -a 0000:45:00.0,rxq_comp_en=3D1,rxq_pkt_pad_en=3D=
1 -=E2=80=93 -i
=E2=80=93-max_pkt_len=3D4096 =E2=80=93-rxq=3D8 -=E2=80=93txq=3D8 --nb_cores=
=3D8 -=E2=80=93rxd=3D32768 -=E2=80=93enable_drop_en
=E2=80=93-enable_scatter

After tracing through the DPDK source code, I came across this code:

drivers/net/mlx5/mlx5_devx.c

/*
* For vectorized Rx, it must not be doubled in order to
* make cq_ci and rq_ci aligned.
*/
if (mlx5_rxq_check_vec_support(rxq_data) < 0)
    cqe_n *=3D 2;


The above code doubles the amount of CQE for non-vectorized RX and I'm not =
sure
if this will affect other drivers or the NIC firmware. In addition, I also =
saw
a few functions where `cqe_n` was assigned to a uint16_t which will cause
overflow (e.g. rxq_sync_cq(), mlx5_rx_err_handle()).

I further confirmed that imiss is not 100% in vectorized mode (MTU=3D1500) =
but
100% imiss in non-vectorized mode (MTU=3D4096) where rx_desc=3D32768.

I have also tried upgrading my setup to use the latest version of DPDK
library(25.11) but same observations were made.

As I am not very familiar with the MLX5 driver, can someone assist to check=
 if
the doubling of rx desc from 32768 to 65536 in non-vectorized mode will res=
ult
in other issues in the NIC firmware or driver?

--=20
You are receiving this mail because:
You are the assignee for the bug.=
