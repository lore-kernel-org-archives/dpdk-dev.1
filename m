Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D58F36B9A
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Apr 2026 02:31:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D2C2A4060A;
	Fri, 10 Apr 2026 04:31:44 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id DB30E402D3
 for <dev@dpdk.org>; Fri, 10 Apr 2026 04:31:43 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id B68694AE72; Fri, 10 Apr 2026 04:31:43 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1933] Pollara 400 AI NIC does not transmit or recieve
Date: Fri, 10 Apr 2026 02:31:43 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 26.03
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: critical
X-Bugzilla-Who: vipin.varghese@amd.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1933-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1933

            Bug ID: 1933
           Summary: Pollara 400 AI NIC does not transmit or recieve
           Product: DPDK
           Version: 26.03
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: critical
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: vipin.varghese@amd.com
  Target Milestone: ---

DPDK version: 26.03
test application: testpmd <--> testpmd, testpmd<-->linux Kernel IONIC driver
(tcpdump)

expected behaviour: as per the DPDK patchwork commit
https://patchwork.dpdk.org/project/dpdk/patch/20251120183936.8699-1-andrew.=
boyer@amd.com/
Pollaro 400G nic card has to work without any DPDK changes.

testing scenarios:
1) testpmd=20
2) testpmd with 100G forced
3) testpmd with 400G forced

Observation:=20
on DPDK:
 a) On testpmd, both stats and xstats show packet transmit

Logs:
```=20=20
IONIC: ionic_adminq_check_err(): IONIC_CMD_Q_INIT (40) succeeded
IONIC: ionic_lif_txq_init_done(): txq->hw_type 1
IONIC: ionic_lif_txq_init_done(): txq->hw_index 0
IONIC: ionic_lif_txq_init_done(): txq->db 0x1180008008
IONIC: ionic_link_status_check(): Link up - 100000 Gbps
IONIC: ionic_dev_link_update():  >>
IONIC: ionic_dev_cmd_go(): Sending IONIC_CMD_PORT_SETATTR (14) via dev_cmd
IONIC: ionic_dev_cmd_wait(): DEVCMD 14 done took 1450 usecs
IONIC: ionic_dev_cmd_wait_check(): dev_cmd returned 0
IONIC: ionic_dev_cmd_go(): Sending IONIC_CMD_PORT_SETATTR (14) via dev_cmd
IONIC: ionic_dev_cmd_wait(): DEVCMD 14 done took 1430 usecs
IONIC: ionic_dev_cmd_wait_check(): dev_cmd returned 0
IONIC: ionic_dev_link_update():  >>
IONIC: ionic_dev_set_mac():  >>
IONIC: ionic_dev_set_mac(): Deleting mac addr 0x17ffc77d8M
IONIC: ionic_lif_addr_del():  >>
IONIC: ionic_dev_set_mac(): Updating mac addr
IONIC: ionic_adminq_post_wait(): Sending IONIC_CMD_RX_FILTER_ADD (31) via t=
he
admin queue
IONIC: ionic_adminq_check_err(): IONIC_CMD_RX_FILTER_ADD (31) succeeded
IONIC: ionic_lif_addr_add(): rx_filter add (id 0)
Port 0: 04:90:81:60:3A:08
Checking link statuses...
Done
IONIC: ionic_dev_promiscuous_enable():  >>
IONIC: ionic_lif_rx_mode(): rx_mode IONIC_RX_MODE_F_UNICAST
IONIC: ionic_lif_rx_mode(): rx_mode IONIC_RX_MODE_F_MULTICAST
IONIC: ionic_lif_rx_mode(): rx_mode IONIC_RX_MODE_F_BROADCAST
IONIC: ionic_lif_rx_mode(): rx_mode IONIC_RX_MODE_F_PROMISC
IONIC: ionic_adminq_post_wait(): Sending IONIC_CMD_RX_MODE_SET (30) via the
admin queue
IONIC: ionic_adminq_check_err(): IONIC_CMD_RX_MODE_SET (30) succeeded

######################## NIC statistics for port 0  ########################
  RX-packets: 0          RX-missed: 0          RX-bytes:  0
  RX-errors: 0
  RX-nombuf:  0
  TX-packets: 50412174   TX-errors: 0          TX-bytes:  3024730440

  Throughput (since last show)
  Rx-pps:            0          Rx-bps:            0
  Tx-pps:      3113885          Tx-bps:   1494664928
  #########################################################################=
###

testpmd> show port xstats all
###### NIC extended statistics for port 0
rx_good_packets: 0
tx_good_packets: 198056926
rx_good_bytes: 0
tx_good_bytes: 11883415560
rx_missed_errors: 0
rx_errors: 0
tx_errors: 0
rx_mbuf_allocation_errors: 0
rx_q0_packets: 0
rx_q0_bytes: 0
rx_q0_errors: 0
tx_q0_packets: 198335854
tx_q0_bytes: 11900151240
rx_ucast_bytes: 0
rx_ucast_packets: 0
rx_mcast_bytes: 0
rx_mcast_packets: 0
rx_bcast_bytes: 0
rx_bcast_packets: 0
rx_ucast_drop_bytes: 0
rx_ucast_drop_packets: 0
rx_mcast_drop_bytes: 0
rx_mcast_drop_packets: 0
rx_bcast_drop_bytes: 0
rx_bcast_drop_packets: 0
rx_dma_error: 0
tx_ucast_bytes: 11883415560
tx_ucast_packets: 198056926
tx_mcast_bytes: 0
tx_mcast_packets: 0
tx_bcast_bytes: 0
tx_bcast_packets: 0
tx_ucast_drop_bytes: 0
tx_ucast_drop_packets: 0
tx_mcast_drop_bytes: 0
tx_mcast_drop_packets: 0
tx_bcast_drop_bytes: 0
tx_bcast_drop_packets: 0
tx_dma_error: 0
rx_queue_disabled: 0
rx_queue_empty: 0
rx_queue_error: 0
rx_desc_fetch_error: 0
rx_desc_data_error: 0
tx_queue_disabled: 0
tx_queue_error: 0
tx_desc_fetch_error: 0
tx_desc_data_error: 0
```

on peer machine (dpdk testpmd):
 b) no packets received in stats or xstats
 c) dmesg complains - [35722.056529] ionic 0000:24:00.0: unknown xcvr type
pid=3D9 / 0x9

on peer machine (Linux TCPDump for default and 100Gbps):
 b) no packets received in tcpdump
 c) dmesg complains - [35722.056529] ionic 0000:24:00.0: unknown xcvr type
pid=3D9 / 0x9

Logs:
```
$  sudo dmesg
[35715.390315] ionic 0000:24:00.0: unknown xcvr type pid=3D9 / 0x9
[35715.390326] ionic 0000:24:00.0: unknown xcvr type pid=3D9 / 0x9
[35722.055985] ionic 0000:24:00.0 enp36s0np0: Link up - 100 Gbps
[35722.056529] ionic 0000:24:00.0: unknown xcvr type pid=3D9 / 0x9
[35729.003282] audit: type=3D1400 audit(1775786952.604:143): apparmor=3D"DE=
NIED"
operation=3D"open" class=3D"file" profile=3D"tcpdump" name=3D"/etc/libibver=
bs.d/"
pid=3D5717 comm=3D"tcpdump" requested_mask=3D"r" denied_mask=3D
"r" fsuid=3D0 ouid=3D0
[35792.962068] VFIO - User Level meta-driver version: 0.3
[36697.503027] ionic 0000:24:00.0: 504.112 Gb/s available PCIe bandwidth (3=
2.0
GT/s PCIe x16 link)
[36697.539479] ionic 0000:24:00.0: FW: 1.117.5-a-56
[36698.051369] ionic 0000:24:00.0 eth0: Link up - 100 Gbps
[36698.052372] ionic 0000:24:00.0 enp36s0np0: renamed from eth0
[36707.493621] ionic 0000:24:00.0: unknown xcvr type pid=3D9 / 0x9


$ sudo ethtool enp36s0np0
Settings for enp36s0np0:
        Supported ports: [ FIBRE ]
        Supported link modes:   Not reported
        Supported pause frame use: Symmetric
        Supports auto-negotiation: Yes
        Supported FEC modes: RS  BASER
        Advertised link modes:  Not reported
        Advertised pause frame use: No
        Advertised auto-negotiation: No
        Advertised FEC modes: RS
        Speed: 100000Mb/s
        Duplex: Full
        Auto-negotiation: off
        Port: Direct Attach Copper
        PHYAD: 0
        Transceiver: internal
        Link detected: yes
```

--=20
You are receiving this mail because:
You are the assignee for the bug.=
