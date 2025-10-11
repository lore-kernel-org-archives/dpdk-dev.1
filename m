Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF01CCD184
	for <dpdk-dev@archiver.kernel.org>; Sat, 11 Oct 2025 06:21:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D6A63402D7;
	Sat, 11 Oct 2025 08:21:01 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 1F829402D4
 for <dev@dpdk.org>; Sat, 11 Oct 2025 08:21:00 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 0CE874890A; Sat, 11 Oct 2025 08:21:00 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/vhost/virtio Bug 1800] Virtio: Packed Queue desc_event_flags
 Causing Testpmd Crash
Date: Sat, 11 Oct 2025 06:20:59 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: vhost/virtio
X-Bugzilla-Version: 19.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: major
X-Bugzilla-Who: 1104121601@qq.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1800-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1800

            Bug ID: 1800
           Summary: Virtio: Packed Queue desc_event_flags Causing Testpmd
                    Crash
           Product: DPDK
           Version: 19.11
          Hardware: x86
                OS: Linux
            Status: UNCONFIRMED
          Severity: major
          Priority: Normal
         Component: vhost/virtio
          Assignee: dev@dpdk.org
          Reporter: 1104121601@qq.com
  Target Milestone: ---

1.  Environment
DPDK version: dpdk-19.11.1
Other software versions: N/A
OS: CentOS Linux release 7.4.1708 (Core)
Compiler: gcc version 4.8.5 20150623 (Red Hat 4.8.5-44) (GCC)
Hardware platform: Intel(R) Xeon(R) D-1736  CPU @ 2.30GHz


2.  Test Setup
export RTE_SDK=3D/root/dpdk-19.11.1
export RTE_TARGET=3Dx86_64-native-linux-gcc=20
./dpdk-setup.sh
instasll and bind pci jump..


3.  Steps to reproduce:=20
Start testpmd with packed ring and test the ring -> desc_event_flags functi=
on
of the packed queue.

gdb --args testpmd -c 0xff -n 4 --huge-dir=3D/mnt/huge_dpdk --socket-mem=3D=
1024
--socket-limit=3D1024 -w 0000:15:00.1 --file-prefix=3Dtest3 -d
/usr/lib64/librte_pmd_virtio.so \=20
-- --total-num-mbufs=3D115200 --rxq=3D4 --txq=3D4 --forward-mode=3Dtxonly -=
-nb-cores=3D4
--stats-period 1 --burst=3D512 --rxd=3D512 --txd=3D512 --eth-peer=3D0,10:70=
:fd:2a:60:39

testpmd> set fwd txonly
Set txonly packet forwarding mode
testpmd> start


3.1 Actual Result
testpmd> start
txonly packet forwarding - ports=3D1 - cores=3D4 - streams=3D4 - NUMA suppo=
rt
enabled, MP allocation mode: native
Logical Core 1 (socket 0) forwards packets on 1 streams:
  RX P=3D0/Q=3D0 (socket 0) -> TX P=3D0/Q=3D0 (socket 0) peer=3D10:70:FD:2A=
:60:39
Logical Core 2 (socket 0) forwards packets on 1 streams:
  RX P=3D0/Q=3D1 (socket 0) -> TX P=3D0/Q=3D1 (socket 0) peer=3D10:70:FD:2A=
:60:39
Logical Core 3 (socket 0) forwards packets on 1 streams:
  RX P=3D0/Q=3D2 (socket 0) -> TX P=3D0/Q=3D2 (socket 0) peer=3D10:70:FD:2A=
:60:39
Logical Core 4 (socket 0) forwards packets on 1 streams:
  RX P=3D0/Q=3D3 (socket 0) -> TX P=3D0/Q=3D3 (socket 0) peer=3D10:70:FD:2A=
:60:39

  txonly packet forwarding packets/burst=3D1
  packet len=3D64 - nb packet segments=3D1
  nb forwarding cores=3D4 - nb forwarding ports=3D1
  port 0: RX queue number: 4 Tx queue number: 4
    Rx offloads=3D0x0 Tx offloads=3D0x0
    RX queue: 0
      RX desc=3D512 - RX free threshold=3D0
      RX threshold registers: pthresh=3D0 hthresh=3D0  wthresh=3D0
      RX Offloads=3D0x0
    TX queue: 0
      TX desc=3D512 - TX free threshold=3D0
      TX threshold registers: pthresh=3D0 hthresh=3D0  wthresh=3D0
      TX offloads=3D0x0 - TX RS bit threshold=3D0
testpmd>
Program received signal SIGSEGV, Segmentation fault.
[Switching to Thread 0x7fffe7f97700 (LWP 11521)]
virtio_xmit_cleanup_normal_packed (num=3D0, vq=3D0x17f99fac0) at
/usr/src/debug/dpdk-19.11.1/drivers/net/virtio/virtio_rxtx.c:327
327                             rte_pktmbuf_free(dxp->cookie);
(gdb) bt
#0  virtio_xmit_cleanup_normal_packed (num=3D0, vq=3D0x17f99fac0) at
/usr/src/debug/dpdk-19.11.1/drivers/net/virtio/virtio_rxtx.c:327
#1  virtio_xmit_cleanup_packed (in_order=3D0, num=3D1, vq=3D0x17f99fac0) at
/usr/src/debug/dpdk-19.11.1/drivers/net/virtio/virtio_rxtx.c:341
#2  virtio_xmit_pkts_packed (tx_queue=3D0x17f99fb40, tx_pkts=3D0x7fffe7f945=
50,
nb_pkts=3D<optimized out>) at
/usr/src/debug/dpdk-19.11.1/drivers/net/virtio/virtio_rxtx.c:2057
#3  0x0000000000471b55 in rte_eth_tx_burst (nb_pkts=3D<optimized out>,
tx_pkts=3D0x7fffe7f94550, queue_id=3D1, port_id=3D0)
    at
/usr/src/debug/dpdk-19.11.1/x86_64-default-linux-gcc/include/rte_ethdev.h:4=
666
#4  pkt_burst_transmit (fs=3D<optimized out>) at
/usr/src/debug/dpdk-19.11.1/app/test-pmd/txonly.c:305
#5  0x0000000000433d2a in run_pkt_fwd_on_lcore (fc=3D0x178f8fd00,
pkt_fwd=3D0x471270 <pkt_burst_transmit>) at
/usr/src/debug/dpdk-19.11.1/app/test-pmd/testpmd.c:1806
#6  0x0000000000433e57 in start_pkt_forward_on_core (fwd_arg=3D<optimized o=
ut>)
at /usr/src/debug/dpdk-19.11.1/app/test-pmd/testpmd.c:1832
#7  0x00007fffec96e7ef in eal_thread_loop (arg=3D<optimized out>) at
/usr/src/debug/dpdk-19.11.1/lib/librte_eal/linux/eal/eal_thread.c:153
#8  0x00007fffeaabdea5 in start_thread () from /lib64/libpthread.so.0
#9  0x00007fffea7e6b0d in clone () from /lib64/libc.so.6
(gdb) l
322                             vq->vq_used_cons_idx -=3D size;
323                             vq->vq_packed.used_wrap_counter ^=3D 1;
324                     }
325                     vq_ring_free_id_packed(vq, id);
326                     if (dxp->cookie !=3D NULL) {
327                             rte_pktmbuf_free(dxp->cookie);
328                             dxp->cookie =3D NULL;
329                     }
330                     used_idx =3D vq->vq_used_cons_idx;
331             }
(gdb) p dxp->cookie
$14 =3D (void *) 0x168e90000
(gdb) p vq[0]
$15 =3D {hw =3D 0x17fab9dc0, {vq_split =3D {ring =3D {num =3D 4096, desc =
=3D 0x17f98d000,
avail =3D 0x17f99d000, used =3D 0x17f99e000}}, vq_packed =3D {ring =3D {num=
 =3D 4096,
desc =3D 0x17f98d000,
        driver =3D 0x17f99d000, device =3D 0x17f99e000}, used_wrap_counter =
=3D true,
cached_flags =3D 128, event_flags_shadow =3D 1}}, vq_used_cons_idx =3D 51,
vq_nentries =3D 4096, vq_free_cnt =3D 1,
  vq_avail_idx =3D 562, vq_free_thresh =3D 32, vq_ring_virt_mem =3D 0x17f98=
d000,
vq_ring_size =3D 73728, {rxq =3D {vq =3D 0x17f99fac0, fake_mbuf =3D {cachel=
ine0 =3D
0x17f99fb80, buf_addr =3D 0x0, {
          buf_iova =3D 0, buf_physaddr =3D 0}, rearm_data =3D 0x17f99fb90, =
data_off =3D
57906, {refcnt_atomic =3D {cnt =3D 5}, refcnt =3D 5}, nb_segs =3D 0, port =
=3D 0, ol_flags
=3D 0,
        rx_descriptor_fields1 =3D 0x17f99fba0, {packet_type =3D 0, {l2_type=
 =3D 0,
l3_type =3D 0, l4_type =3D 0, tun_type =3D 0, {inner_esp_next_proto =3D 0 '=
\000',
{inner_l2_type =3D 0 '\000',
                inner_l3_type =3D 0 '\000'}}, inner_l4_type =3D 0}}, pkt_le=
n =3D 0,
data_len =3D 0, vlan_tci =3D 0, {hash =3D {rss =3D 0, fdir =3D {{{hash =3D =
0, id =3D 0}, lo =3D
0}, hi =3D 0}, sched =3D {
              queue_id =3D 0, traffic_class =3D 0 '\000', color =3D 0 '\000=
',
reserved =3D 0}, txadapter =3D {reserved1 =3D 0, reserved2 =3D 0, txq =3D 0=
}, usr =3D 0}},
vlan_tci_outer =3D 0, buf_len =3D 0,
        timestamp =3D 0, cacheline1 =3D 0x17f99fbc0, {userdata =3D 0x0, uda=
ta64 =3D 0},
pool =3D 0x100006168, next =3D 0x0, {tx_offload =3D 0, {l2_len =3D 0, l3_le=
n =3D 0,
l4_len =3D 0, tso_segsz =3D 0,
            outer_l3_len =3D 0, outer_l2_len =3D 0}}, priv_size =3D 0, time=
sync =3D 0,
seqn =3D 0, shinfo =3D 0x0, jd_flags =3D 0, dynfield1 =3D {0}}, mbuf_initia=
lizer =3D 0,
mpool =3D 0x0, queue_id =3D 0,
      port_id =3D 0, stats =3D {packets =3D 0, bytes =3D 0, errors =3D 0, m=
ulticast =3D 0,
broadcast =3D 0, size_bins =3D {0, 0, 0, 0, 0, 0, 0, 0}}, mz =3D 0x0}, txq =
=3D {vq =3D
0x17f99fac0,
      virtio_net_hdr_mz =3D 0x1000061b0, virtio_net_hdr_mem =3D 6435098496,
queue_id =3D 1, port_id =3D 0, stats =3D {packets =3D 385586, bytes =3D 246=
77504, errors
=3D 0, multicast =3D 0, broadcast =3D 0,
        size_bins =3D {0, 385586, 0, 0, 0, 0, 0, 0}}, mz =3D 0x100006168}, =
cq =3D {vq
=3D 0x17f99fac0, virtio_net_hdr_mz =3D 0x1000061b0, virtio_net_hdr_mem =3D
6435098496, port_id =3D 1,
      mz =3D 0x5e232, lock =3D {locked =3D 24677504}}}, vq_ring_mem =3D 643=
5688448,
vq_desc_head_idx =3D 562, vq_desc_tail_idx =3D 50, vq_queue_index =3D 3, of=
fset =3D 8,
notify_addr =3D 0x2200001000,
  sw_ring =3D 0x0, vq_descx =3D 0x17f99fce0}
(gdb) p vq->vq_descx[50]
$16 =3D {cookie =3D 0x168e90000, ndescs =3D 1, next =3D 32768} (bad mbuf ad=
dr)
(gdb) p vq->vq_descx[51]
$17 =3D {cookie =3D 0x168e95bc0, ndescs =3D 1, next =3D 52} (normal mbuf ad=
dr)
(gdb) p vq->vq_descx[52]
$18 =3D {cookie =3D 0x168e95280, ndescs =3D 1, next =3D 53}
(gdb) p vq->vq_descx[53]
$19 =3D {cookie =3D 0x168e94940, ndescs =3D 1, next =3D 54}
(gdb) p vq->vq_descx[54]
$20 =3D {cookie =3D 0x168e94000, ndescs =3D 1, next =3D 55}
(gdb)


3.2   Expected Result
Keep sending...

testpmd> show port stats all

  ######################## NIC statistics for port 0  #####################=
###
  RX-packets: 8          RX-missed: 0          RX-bytes:  934
  RX-errors: 0
  RX-nombuf:  0
  TX-packets: 440662528  TX-errors: 0          TX-bytes:  28202432512

  Throughput (since last show)
  Rx-pps:            0          Rx-bps:            0
  Tx-pps:     31153304          Tx-bps:  15950370552
  #########################################################################=
###
testpmd> show port stats all


4.  Detailed Analysis
  After Testpmd runs for several minutes, it crashes unexpectedly.=20
  Debugging shows that the content of vq_descx (within struct virtqueue) is
being modified unexpectedly=E2=80=94likely due to address mismatches in the=
 queue
memory layout.

  After debugging, it was found that the virtio-pci driver uses inconsistent
address calculation logic for two critical steps:
    When informing the hardware (via the modern_setup_queue interface) of t=
he
physical addresses for the driver and device of the packed queue.
    When calculating the virtual addresses of the driver and device for the
driver own use (via vring_init_packed).
  This mismatch leads to the hardware and the driver referencing different
memory for the device queue, causing unintended overwrites of vq_descx.

  Below is a detailed process.


4.1   Address Calculation in modern_setup_queue (Hardware-facing)
  The modern_setup_queue function configures the queue addresses and passes
them to the hardware.=20
  For packed queues, it calculates desc_addr, avail_addr (driver addr), and
used_addr (device addr) as follows:

  static int
  modern_setup_queue(struct virtio_hw *hw, struct virtqueue *vq)
  {
    uint64_t desc_addr, avail_addr, used_addr;
    uint16_t notify_off;

    if (!check_vq_phys_addr_ok(vq))
      return -1;

    desc_addr =3D vq->vq_ring_mem;
    avail_addr =3D desc_addr + vq->vq_nentries * sizeof(struct vring_desc);
    used_addr =3D RTE_ALIGN_CEIL(avail_addr + offsetof(struct vring_avail,
                ring[vq->vq_nentries]),
            VIRTIO_PCI_VRING_ALIGN);

    rte_write16(vq->vq_queue_index, &hw->common_cfg->queue_select);

    io_write64_twopart(desc_addr, &hw->common_cfg->queue_desc_lo,
                &hw->common_cfg->queue_desc_hi);
    io_write64_twopart(avail_addr, &hw->common_cfg->queue_avail_lo,
                &hw->common_cfg->queue_avail_hi);
    io_write64_twopart(used_addr, &hw->common_cfg->queue_used_lo,
                &hw->common_cfg->queue_used_hi);

    notify_off =3D rte_read16(&hw->common_cfg->queue_notify_off);
    vq->notify_addr =3D (void *)((uint8_t *)hw->notify_base +
          notify_off * hw->notify_off_multiplier);

    rte_write16(1, &hw->common_cfg->queue_enable);

    PMD_INIT_LOG(DEBUG, "queue %u addresses:", vq->vq_queue_index);
    PMD_INIT_LOG(DEBUG, "\t desc_addr: %" PRIx64, desc_addr);
    PMD_INIT_LOG(DEBUG, "\t aval_addr: %" PRIx64, avail_addr);
    PMD_INIT_LOG(DEBUG, "\t used_addr: %" PRIx64, used_addr);
    PMD_INIT_LOG(DEBUG, "\t notify addr: %p (notify offset: %u)",
      vq->notify_addr, notify_off);

    return 0;
  }

  Key parameters for our test:
    vq_nentries =3D 0x1000 (4096 entries)
    sizeof(struct vring_desc) =3D 16 (0x10 in hex)
    offsetof(struct vring_avail, ring[vq->vq_nentries]) =3D 4 + (0x1000 * 2)
(base offset 4 + 2 bytes per ring pointer)
    Alignment requirement: VIRTIO_PCI_VRING_ALIGN =3D 4096 (0x1000 in hex)

  Example calculation (assuming desc_addr =3D 0x0):
    avail_addr =3D 0x0 + (0x1000 * 0x10) =3D 0x10000 (driver address passed=
 to
hardware)
    used_addr =3D RTE_ALIGN_CEIL(0x10000 + 4 + (0x1000 * 2), 0x1000) =3D
RTE_ALIGN_CEIL(0x12004, 0x1000) =3D 0x13000 (device ddress passed to hardwa=
re)


4.2   Address Calculation in vring_init_packed (Driver-internal)
  The vring_init_packed function calculates the driver-internal virtual
addresses for the packed queue driver and device addr:

    static inline void
    vring_init_packed(struct vring_packed *vr, uint8_t *p, unsigned long al=
ign,
        unsigned int num)
    {
      vr->num =3D num;
      vr->desc =3D (struct vring_packed_desc *)p;
      vr->driver =3D (struct vring_packed_desc_event *)(p +
          vr->num * sizeof(struct vring_packed_desc));
      vr->device =3D (struct vring_packed_desc_event *)
        RTE_ALIGN_CEIL(((uintptr_t)vr->driver +
            sizeof(struct vring_packed_desc_event)), align);
    }

  Example calculation (same desc_addr =3D 0x0, p =3D 0x0):
    vr->driver =3D 0x0 + (0x1000 * 0x10) =3D 0x10000 (matches avail_addr fr=
om
modern_setup_queue)
    vr->device =3D RTE_ALIGN_CEIL(0x10000 + sizeof(struct
vring_packed_desc_event), 0x1000)
      sizeof(struct vring_packed_desc_event) =3D 4 (standard definition), t=
his
becomes RTE_ALIGN_CEIL(0x10004, 0x1000) =3D 0x11000 (driver-internal device
address)


4.3   Critical Mismatch
  Hardware uses 0x13000 as the device address.
  Driver uses 0x11000 as the device address.


4.4   Modification Applied to Fix the Issue
  We modified modern_setup_queue to use the same address logic as
vring_init_packed for packed queues. After this change, Testpmd runs stably
without crashes:

    static int
    modern_setup_queue(struct virtio_hw *hw, struct virtqueue *vq)
    {
      uint64_t desc_addr, avail_addr, used_addr;
      uint16_t notify_off;

      if (!check_vq_phys_addr_ok(vq))
        return -1;

      desc_addr =3D vq->vq_ring_mem;
      avail_addr =3D desc_addr + vq->vq_nentries * sizeof(struct vring_desc=
);
      if (vtpci_packed_queue(hw))
        used_addr =3D RTE_ALIGN_CEIL(((uintptr_t)avail_addr +=20
                    sizeof(struct vring_packed_desc_event)),=20
              VIRTIO_PCI_VRING_ALIGN);
      else
        used_addr =3D RTE_ALIGN_CEIL(avail_addr + offsetof(struct vring_ava=
il,
                    ring[vq->vq_nentries]),
              VIRTIO_PCI_VRING_ALIGN);

      rte_write16(vq->vq_queue_index, &hw->common_cfg->queue_select);

      io_write64_twopart(desc_addr, &hw->common_cfg->queue_desc_lo,
                  &hw->common_cfg->queue_desc_hi);
      io_write64_twopart(avail_addr, &hw->common_cfg->queue_avail_lo,
                  &hw->common_cfg->queue_avail_hi);
      io_write64_twopart(used_addr, &hw->common_cfg->queue_used_lo,
                  &hw->common_cfg->queue_used_hi);

      notify_off =3D rte_read16(&hw->common_cfg->queue_notify_off);
      vq->notify_addr =3D (void *)((uint8_t *)hw->notify_base +
            notify_off * hw->notify_off_multiplier);

      rte_write16(1, &hw->common_cfg->queue_enable);

      PMD_INIT_LOG(DEBUG, "queue %u addresses:", vq->vq_queue_index);
      PMD_INIT_LOG(DEBUG, "\t desc_addr: %" PRIx64, desc_addr);
      PMD_INIT_LOG(DEBUG, "\t aval_addr: %" PRIx64, avail_addr);
      PMD_INIT_LOG(DEBUG, "\t used_addr: %" PRIx64, used_addr);
      PMD_INIT_LOG(DEBUG, "\t notify addr: %p (notify offset: %u)",
        vq->notify_addr, notify_off);

      return 0;
    }


4.5   Reference from Virtio-User/Vhost-User
  We noticed that the virtio-user and vhost-user drivers already use the sa=
me
logic as our modified modern_setup_queue for packed queues. For example, in
virtio_user_setup_queue_packed:
    static void
    virtio_user_setup_queue_packed(struct virtqueue *vq,
                struct virtio_user_dev *dev)
    {
      uint16_t queue_idx =3D vq->vq_queue_index;
      struct vring_packed *vring;
      uint64_t desc_addr;
      uint64_t avail_addr;
      uint64_t used_addr;
      uint16_t i;

      vring  =3D &dev->packed_vrings[queue_idx];
      desc_addr =3D (uintptr_t)vq->vq_ring_virt_mem;
      avail_addr =3D desc_addr + vq->vq_nentries *
        sizeof(struct vring_packed_desc);
      used_addr =3D RTE_ALIGN_CEIL(avail_addr +
            sizeof(struct vring_packed_desc_event),
            VIRTIO_PCI_VRING_ALIGN);
      vring->num =3D vq->vq_nentries;
      vring->desc =3D (void *)(uintptr_t)desc_addr;
      vring->driver =3D (void *)(uintptr_t)avail_addr;
      vring->device =3D (void *)(uintptr_t)used_addr;
      dev->packed_queues[queue_idx].avail_wrap_counter =3D true;
      dev->packed_queues[queue_idx].used_wrap_counter =3D true;

      for (i =3D 0; i < vring->num; i++)
        vring->desc[i].flags =3D 0;
    }



Question for Clarification
  Both the higher and lower dpdk versions exhibit this behavior.

  Therefore, for packed queues, why do modern_setup_queue and vring_init_pa=
cked
use different logic to calculate the device address?
  Is this inconsistency due to incorrect usage on my part, or are there spe=
cial
considerations specific to packed queue mode (e.g., hardware compatibility,
protocol requirements)?
  We would greatly appreciate your help in clarifying this confusion. Thank
you!

--=20
You are receiving this mail because:
You are the assignee for the bug.=
