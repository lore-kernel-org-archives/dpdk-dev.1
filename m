Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD2BCC43458
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Jul 2026 14:16:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0FF9D40268;
	Wed,  8 Jul 2026 16:16:38 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 342B740265
 for <dev@dpdk.org>; Wed,  8 Jul 2026 16:16:36 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 1C5344B84A; Wed,  8 Jul 2026 16:16:36 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1965] Repeated port link up/down flapping leads to
 segmentation fault and core dump in hns3 ethdev driver.
Date: Wed, 08 Jul 2026 14:16:36 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 25.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: major
X-Bugzilla-Who: qianwu9966@gmail.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1965-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1965

            Bug ID: 1965
           Summary: Repeated port link up/down flapping leads to
                    segmentation fault and core dump in hns3 ethdev
                    driver.
           Product: DPDK
           Version: 25.11
          Hardware: ARM
                OS: Linux
            Status: UNCONFIRMED
          Severity: major
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: qianwu9966@gmail.com
  Target Milestone: ---

HNS3_DRIVER: 0000:7d:00.5 hns3_update_link_status(): Link status change to =
up!
HNS3_DRIVER: 0000:7d:00.4 hns3_update_link_status(): Link status change to =
up!
HNS3_DRIVER: 0000:7d:00.1 hns3_update_link_status(): Link status change to =
up!
HNS3_DRIVER: 0000:7d:00.2 hns3_update_link_status(): Link status change to =
up!
HNS3_DRIVER: 0000:7d:00.3 hns3_update_link_status(): Link status change to =
up!
HNS3_DRIVER: 0000:7d:00.6 hns3_update_link_status(): Link status change to =
up!
HNS3_DRIVER: 0000:7d:00.7 hns3_update_link_status(): Link status change to =
up!

[Switching to Thread 0xffffc92c2f40 (LWP 7937)]
hns3_tx_bulk_free_buffers (txq=3D0x98d21a000) at
../drivers/net/hns3/hns3_rxtx_vec.h:22
22      ../drivers/net/hns3/hns3_rxtx_vec.h: No such file or directory.
(gdb) bt=20
#0  hns3_tx_bulk_free_buffers (txq=3D0x98d21a000) at
../drivers/net/hns3/hns3_rxtx_vec.h:22
#1  0x0000ffffcb5b8788 in hns3_tx_free_buffers (txq=3D0x98d21a000) at
../drivers/net/hns3/hns3_rxtx_vec.h:72
#2  0x0000ffffcb5ba2fc in hns3_xmit_fixed_burst_vec (tx_queue=3D0x98d21a000,
tx_pkts=3D0xffffc92c1f08, nb_pkts=3D1)
    at ../drivers/net/hns3/hns3_rxtx_vec_neon.h:41
#3  0x0000ffffcb5bb1c4 in hns3_xmit_pkts_vec (tx_queue=3D0x98d21a000,
tx_pkts=3D0xffffc92c1f08, nb_pkts=3D1)
    at ../drivers/net/hns3/hns3_rxtx_vec.c:47
#4  0x0000fffff768bdbc in safe_rte_eth_tx_burst (port=3D0, qid=3D0,
pkts=3D0xffffc92c1f08, nb=3D1)
    at /home/joy/ntas-gm/src/app/capture/readers/readers-dpdkplane.c:57
#5  0x0000fffff769906c in hwTxThreads_send_packet (arg=3D0x0) at
/home/joy/ntas-gm/src/app/capture/readers/readers-dpdkplane.c:2421
#6  0x0000fffff1616e80 in eal_thread_loop (arg=3D0x1) at
../lib/eal/common/eal_common_thread.c:199
#7  0x0000fffff1631f80 in eal_worker_thread_loop (arg=3D0x1) at
../lib/eal/linux/eal.c:517
#8  0x0000fffff7e82508 in  () at /usr/lib64/libc.so.6
#9  0x0000fffff7ee9cdc in  () at /usr/lib64/libc.so.6
(gdb) bt full
#0  hns3_tx_bulk_free_buffers (txq=3D0x98d21a000) at
../drivers/net/hns3/hns3_rxtx_vec.h:22
        free =3D 0x98d0d9d80
        tx_entry =3D 0x98d0dba00
        m =3D 0xffffc92c335c
        nb_free =3D 0
        i =3D 0
#1  0x0000ffffcb5b8788 in hns3_tx_free_buffers (txq=3D0x98d21a000) at
../drivers/net/hns3/hns3_rxtx_vec.h:72
        tx_desc =3D 0x98d120f80
        i =3D 32
#2  0x0000ffffcb5ba2fc in hns3_xmit_fixed_burst_vec (tx_queue=3D0x98d21a000,
tx_pkts=3D0xffffc92c1f08, nb_pkts=3D1)
    at ../drivers/net/hns3/hns3_rxtx_vec_neon.h:41
        txq =3D 0x98d21a000
        tx_desc =3D 0x98c704be0
        tx_entry =3D 0x98c6c4b10
        next_to_use =3D 3
        nb_commit =3D 1
        nb_tx =3D 1
        n =3D 32766
        i =3D 1
#3  0x0000ffffcb5bb1c4 in hns3_xmit_pkts_vec (tx_queue=3D0x98d21a000,
tx_pkts=3D0xffffc92c1f08, nb_pkts=3D1)
    at ../drivers/net/hns3/hns3_rxtx_vec.c:47
        ret =3D 1
        new_burst =3D 1
        txq =3D 0x98d21a000
        nb_tx =3D 0
#4  0x0000fffff768bdbc in safe_rte_eth_tx_burst (port=3D0, qid=3D0,
pkts=3D0xffffc92c1f08, nb=3D1)
    at /home/joy/ntas-gm/src/app/capture/readers/readers-dpdkplane.c:57
        p =3D 0xfffff19f5500 <rte_eth_fp_ops>
        burst_fn =3D 0xffffcb5bb14c <hns3_xmit_pkts_vec>
        qd =3D 0x98d21a000
#5  0x0000fffff769906c in hwTxThreads_send_packet (arg=3D0x0) at
/home/joy/ntas-gm/src/app/capture/readers/readers-dpdkplane.c:2421
        mbuf =3D 0xce1056780
        dfDpum =3D 0xce10567e0
        privDpum =3D 0xce1056800
        nb_tx =3D 1
        i =3D 0
        hwTxThreadsIdx =3D 0
        lcore_id =3D 1
        thrnamestr =3D "dpdkHwTxT0C1", '\000' <repeats 19 times>
        toHwTxRings =3D 0x77937150
        toHwTxRing =3D 0x98d35f280
        mbufs =3D {0xce1056780, 0x0 <repeats 63 times>}
        dequeCnt =3D 1
        mode =3D 0
        portidx =3D 0 '\000'
        hwdynamicPortidx =3D 0
        queueIdx =3D 0
        hwTxThreads =3D 0x777c9dd0
        pktegroup =3D 0
        pgidx =3D 0
#6  0x0000fffff1616e80 in eal_thread_loop (arg=3D0x1) at
../lib/eal/common/eal_common_thread.c:199
        f =3D 0xfffff7697980 <hwTxThreads_send_packet>
        fct_arg =3D 0x0
        lcore_id =3D 1
        cpuset =3D "1", '\000' <repeats 254 times>
        ret =3D 0
#7  0x0000fffff1631f80 in eal_worker_thread_loop (arg=3D0x1) at
../lib/eal/linux/eal.c:517
#8  0x0000fffff7e82508 in  () at /usr/lib64/libc.so.6
#9  0x0000fffff7ee9cdc in  () at /usr/lib64/libc.so.6
(gdb)

--=20
You are receiving this mail because:
You are the assignee for the bug.=
