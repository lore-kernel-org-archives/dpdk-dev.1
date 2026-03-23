Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB162F46101
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Mar 2026 13:34:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C5DEA40268;
	Mon, 23 Mar 2026 14:34:45 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 2B60E4025F
 for <dev@dpdk.org>; Mon, 23 Mar 2026 14:34:45 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 1897F4AD7F; Mon, 23 Mar 2026 14:34:45 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/eventdev Bug 1909] bnxt: crash in bnxt_alloc_async_cp_ring
Date: Mon, 23 Mar 2026 13:34:44 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: eventdev
X-Bugzilla-Version: 26.03
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: oleksandrn@interfacemasters.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1909-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1909

            Bug ID: 1909
           Summary: bnxt: crash in bnxt_alloc_async_cp_ring
           Product: DPDK
           Version: 26.03
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: eventdev
          Assignee: dev@dpdk.org
          Reporter: oleksandrn@interfacemasters.com
  Target Milestone: ---

commit 7a1f9c782b50a1045a560782717fab20bc370877 (HEAD) net/bnxt: add
multi-doorbell support, causing crash in bnxt_alloc_async_cp_ring, on 57608.

dpdk-testpmd -l 0-5 -a 0000:04:00.1 -- -i


#0  bnxt_alloc_async_cp_ring (bp=3D0x17ffc9740) at
../drivers/net/bnxt/bnxt_ring.c:839
#1  0x00005555559e5cc1 in bnxt_alloc_mem (reconfig=3D<optimized out>,
bp=3D0x17ffc9740)
    at ../drivers/net/bnxt/bnxt_ethdev.c:429
#2  bnxt_init_resources (reconfig_dev=3D<optimized out>, bp=3D<optimized ou=
t>)
    at ../drivers/net/bnxt/bnxt_ethdev.c:5988
#3  bnxt_init_resources (bp=3D0x17ffc9740, reconfig_dev=3D<optimized out>)
    at ../drivers/net/bnxt/bnxt_ethdev.c:5929
#4  0x00005555559e64fa in bnxt_dev_init (eth_dev=3D0x555556736ac0
<rte_eth_devices>,
    params=3D0x16c640510) at ../drivers/net/bnxt/bnxt_ethdev.c:6727
#5  0x00005555558fc95d in rte_eth_dev_create
(device=3Ddevice@entry=3D0x5555569e77b0,
    name=3D0x5555569e78b0 "0000:04:00.1",
priv_data_size=3Dpriv_data_size@entry=3D968,
    bus_specific_init=3Dbus_specific_init@entry=3D0x5555559e2ab0
<eth_dev_pci_specific_init>,
    bus_init_params=3Dbus_init_params@entry=3D0x5555569e77a0,
    ethdev_init=3Dethdev_init@entry=3D0x5555559e5f90 <bnxt_dev_init>,
init_params=3D0x0)
    at ../lib/ethdev/ethdev_driver.c:370
#6  0x00005555556eb51d in bnxt_pci_probe (pci_drv=3D<optimized out>,
pci_dev=3D0x5555569e77a0)
    at ../drivers/net/bnxt/bnxt_ethdev.c:7140
#7  0x00005555556b1cb0 in rte_pci_probe_one_driver (dr=3Ddr@entry=3D0x55555=
6108cc0
<bnxt_rte_pmd>,
    dev=3Ddev@entry=3D0x5555569e77a0) at ../drivers/bus/pci/pci_common.c:299
#8  0x000055555597590c in pci_probe_all_drivers (dev=3D0x5555569e77a0)
    at ../drivers/bus/pci/pci_common.c:383
#9  pci_probe () at ../drivers/bus/pci/pci_common.c:410
#10 0x0000555555941963 in rte_bus_probe () at
../lib/eal/common/eal_common_bus.c:84
--Type <RET> for more, q to quit, c to continue without paging--
#11 0x00005555556ad01c in rte_eal_init (argc=3Dargc@entry=3D20,
argv=3Dargv@entry=3D0x7fffffffe3b8)
    at ../lib/eal/linux/eal.c:894
#12 0x0000555555846770 in main (argc=3D20, argv=3D0x7fffffffe3b8) at
../app/test-pmd/testpmd.c:4584

--=20
You are receiving this mail because:
You are the assignee for the bug.=
