Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D94C369C2
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Apr 2025 15:39:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9C7BC40156;
	Tue, 22 Apr 2025 17:39:42 +0200 (CEST)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50]) by mails.dpdk.org (Postfix) with ESMTP id BE9C540151
 for <dev@dpdk.org>; Tue, 22 Apr 2025 17:39:40 +0200 (CEST)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-30332dfc820so6424278a91.2
 for <dev@dpdk.org>; Tue, 22 Apr 2025 08:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=6wind.com; s=google; t=1745336379; x=1745941179; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=+V0vcvW6Di3QCo+e92gHPK1YOqzQtWvi5piuXQO4t4k=;
 b=Gu14hh3FOjWleFmpD0TMro5/23IRL9b37c60PWRPAG8ZeUqp5XE+juLrjcdlGMLHff
 6pRyVZMiW/VqzG1xcJE0D32wQFmwsZoK1RE2z7yMBFnmcfi1pCDzxD7OkyHHeRzbI0HQ
 rE8U2uN2SaHmqvMSf7xK6jVEIDvWJJFho7TIQLB6zFTC1g4HwnLxkf2Wt+logKIhZVL/
 UnccJLQScbL3n9gxzzgnS9ZbK4G8ZSoLUiyr03PAuO/i3bA6xrKDstk2XHtd/4oUOpRv
 X1Zo+eZGmHXuAOGREj/gOFmFs81Wy66uMAxhM1i3Nw4oPVQ7xxwfD00bWuYW0u61Er/f
 7z0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745336379; x=1745941179;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+V0vcvW6Di3QCo+e92gHPK1YOqzQtWvi5piuXQO4t4k=;
 b=DkrJEzHMPN/XePlVdiagleQ3Z510fnixbXyayLQhdTfNX5DjgQNCWr4v3nXclO81yk
 wwMafMa98ojOf/me+GrPhd7MSfDRZqz6LNoHeLGIHfKCIQ3Is43CCjKa1C/5Pp0zFHca
 Ky2sA/rEyb2xaHGWNSaGGRRb51ODg6dn1WzuWl7pL2nn2I++B0PyaMENXmHkQCZzJ7D0
 sRQy+J/5wa0wq6iCzugPQo+WTiTAtuYyIsnUgT+sf86olWuo0ahRQwiqOsw1WN1v9y/s
 4ugCJd+HQnuyuePCOYO7bdflpW3IoqoUYCcCa8HMPZzNVZhbcAM1Eks7o1swkgVfjuS1
 wjsg==
X-Gm-Message-State: AOJu0Yx8TuWJNkd+Y1lHcGilo3ESz82j1Mt0ko+7C/Dj1ZeNEcNuIZyb
 2JnxzxFQR3Cr+YS2i5QUPh0BSEYE2H9drz50sx+bb1+BuNn1xpv4NPOjUibo9/LOGykp/6nmWS4
 kzLKEfu2SIKd4TbHZhsC0THSzPaU5A5mdlziur7gYkRY2cB0M+Sk=
X-Gm-Gg: ASbGnctod0rg5oht27zpHo1bNnrQR371gszRn0mQNCuRiwKTR26BoomfWqv7g0Z1hEm
 Qb0aU4RRgDYWWyBUBp6LJFgwRPz8zYnyqwBCePee3kQeCOk7FiQMVkXPkLjd2DQTUYEBKNLVR6p
 1aitbXleZB0mQrjfVEk4rQ
X-Google-Smtp-Source: AGHT+IGQo4HE2BPSkhtc4ZB9+RtXpbDSS7Kev7WB6XqHwumyK2DaUKVjQVIjoaxCCNYYkSzMeNTWvM+7iOuI+4Aaf6c=
X-Received: by 2002:a17:90b:3508:b0:2ee:5bc9:75c3 with SMTP id
 98e67ed59e1d1-3087bb413cfmr21914221a91.5.1745336379249; Tue, 22 Apr 2025
 08:39:39 -0700 (PDT)
MIME-Version: 1.0
From: Edwin Brossette <edwin.brossette@6wind.com>
Date: Tue, 22 Apr 2025 17:39:28 +0200
X-Gm-Features: ATxdqUEWCQndyojNDdcH7ekIt9SyB4WUgkTb9VKl_HjSKWnXnqbIcQ5CHMtCAZM
Message-ID: <CANDF9xDNq9Yy+FujvGcc3r1ycjbJDJmnP4_ih+LEm-07=jHDcA@mail.gmail.com>
Subject: QEDE bug report
To: dev@dpdk.org
Cc: dsinghrawat@marvell.com, palok@marvell.com, 
 Olivier Matz <olivier.matz@6wind.com>, Laurent Hardy <laurent.hardy@6wind.com>,
 Didier Pallard <didier.pallard@6wind.com>
Content-Type: multipart/alternative; boundary="000000000000e6326406335fcaa7"
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

--000000000000e6326406335fcaa7
Content-Type: text/plain; charset="UTF-8"

Hello,

I have several issues to report concerning the qede pmd as well as
potential solutions for them. Most of them have to do with configuring the
MTU.

========== Abort on mtu change ===========

First, the qede_assign_rxtx_handlers() seems to be working wrong since an
API change in the rte_eth lib. The commit linked bellow changes the way
packet receive and transmit functions are handled:
https://git.dpdk.org/dpdk/commit/?id=c87d435a4d79739c0cec2ed280b94b41cb908af7

Originally, the Rx/Tx handlers were located in rte_eth_dev struct. This is
currently no longer the case and the polling of incoming packets is done
with functions registered in rte_eth_fp_ops instead. The rte lib change is
supposed to be transparent for the individual pmds, but the polling
functions in rte_eth_dev are only synchronized with the ones in
rte_eth_fp_ops at the device start. This leads to an issue when trying to
configure the MTU while there is ongoing traffic:
-> Trying to change the MTU triggers a port restart.
-> qede_assign_rxtx_handlers() assign dummy polling functions in
dev->rx_pkt_burst and dev->tx_pkt_burst while the port is down.
-> However, rte_eth_rx_burst() polls in
&rte_eth_fp_ops[port_id].rx_pkt_burst which still points to
qede_recv_pkts_regular()
-> The application keep polling packets in the receive function and
triggers an assert(rx_mb != NULL) which caused an abort.

Since rte_eth_fp_ops is reset in rte_eth_dev_stop(), it may be better to
call this function instead of qede_dev_stop(). However the dummy functions
defined in lib/ethdev/ethdev_private.c log an error and dump stack when
called so they might not be intended to be used this way.
The way I fixed this issue in our applications is by forcing a complete
stop of the port before configuring the MTU. I have no DPDK patch to
suggest for this

-------------- Reproduction ------------------

    1) Start testpmd:
dpdk-testpmd --log-level=pmd.net.qede.driver:7 -a 0000:17:00.0 -a
0000:17:00.1 -- -i --rxq=2 --txq=2 --coremask=0x0c --total-num-mbufs=250000

    2) Start packet forwarding:
start
io packet forwarding - ports=2 - cores=2 - streams=4 - NUMA support
enabled, MP allocation mode: native
Logical Core 2 (socket 0) forwards packets on 2 streams:
  RX P=0/Q=0 (socket 0) -> TX P=1/Q=0 (socket 0) peer=02:00:00:00:00:01
  RX P=1/Q=0 (socket 0) -> TX P=0/Q=0 (socket 0) peer=02:00:00:00:00:00
Logical Core 3 (socket 1) forwards packets on 2 streams:
  RX P=0/Q=1 (socket 0) -> TX P=1/Q=1 (socket 0) peer=02:00:00:00:00:01
  RX P=1/Q=1 (socket 0) -> TX P=0/Q=1 (socket 0) peer=02:00:00:00:00:00

  io packet forwarding packets/burst=32
  nb forwarding cores=2 - nb forwarding ports=2
  port 0: RX queue number: 2 Tx queue number: 2
    Rx offloads=0x80000 Tx offloads=0x0
    RX queue: 0
      RX desc=0 - RX free threshold=0
      RX threshold registers: pthresh=0 hthresh=0  wthresh=0
      RX Offloads=0x80000
    TX queue: 0
      TX desc=0 - TX free threshold=0
      TX threshold registers: pthresh=0 hthresh=0  wthresh=0
      TX offloads=0x8000 - TX RS bit threshold=0
  port 1: RX queue number: 2 Tx queue number: 2
    Rx offloads=0x80000 Tx offloads=0x0
    RX queue: 0
      RX desc=0 - RX free threshold=0
      RX threshold registers: pthresh=0 hthresh=0  wthresh=0
      RX Offloads=0x80000
    TX queue: 0
      TX desc=0 - TX free threshold=0
      TX threshold registers: pthresh=0 hthresh=0  wthresh=0
      TX offloads=0x8000 - TX RS bit threshold=0

    3) Send a continuous stream of packets and change the mtu while they
are being forwarded:

p = Ether()/IP(src='10.100.0.1', dst='10.200.0.1')/UDP(sport=11111,
dport=22222)/Raw(load='A'*100)
sendp(p, iface='ntfp1', count=5000000, inter=0.001)

port config mtu 0 1500
[qede_dev_set_link_state:1842(17:00.0:dpdk-port-0)]setting link state 0
[qede_link_update:1483(17:00.0:dpdk-port-0)]Link - Speed 0 Mode 1 AN 1
Status 0
[ecore_int_attentions:1239(17:00.0:dpdk-port-0-0)]MFW indication via
attention
[qede_link_update:1483(17:00.0:dpdk-port-0)]Link - Speed 0 Mode 1 AN 1
Status 0
[qede_activate_vport:536(17:00.0:dpdk-port-0)]vport is deactivated
[qede_tx_queue_reset:509(17:00.0:dpdk-port-0)]Reset TX queue 0
[qede_tx_queue_stop:991(17:00.0:dpdk-port-0)]TX queue 0 stopped
[qede_tx_queue_reset:509(17:00.0:dpdk-port-0)]Reset TX queue 1
[qede_tx_queue_stop:991(17:00.0:dpdk-port-0)]TX queue 1 stopped
[qede_rx_queue_reset:293(17:00.0:dpdk-port-0)]Reset RX queue 0
[qede_rx_queue_stop:371(17:00.0:dpdk-port-0)]RX queue 0 stopped
[qede_rx_queue_reset:293(17:00.0:dpdk-port-0)]Reset RX queue 1
[qede_rx_queue_stop:371(17:00.0:dpdk-port-0)]RX queue 1 stopped
dpdk-testpmd: ../../../source/dpdk-24.11/drivers/net/qede/qede_rxtx.c:1600:
qede_recv_pkts_regular: Assertion `rx_mb != NULL' failed.
Aborted (core dumped)  <=======

As you can see, the application is aborted.


========= Bad Rx buffer size for mbufs ===========

Another issue I had when trying to set the MTU was that I got bad sanity
checks on mbufs when sending large packets, causing aborts. These checks
are only done when compiling in debug mode with RTE_LIBRTE_MBUF_DEBUG set,
so they may be easy to miss. Even without using this debugging config,
there are problems when transmitting those packets. This problem occurs
when calculating the size of the rx buffer, which was reworked in this
patch:
https://git.dpdk.org/dpdk/commit/drivers/net/qede?id=318d7da3122bac04772418c5eda9f50fcd175d18

-> First, the max Rx buffer size is configured at two different places in
the code, and the calculation is not consistant between them. In
qede_rx_queue_setup(), RTE_ETHER_CRC_LEN is added to max_rx_pktlen but not
in qede_set_mtu(). The commit above mentions that HW does not include CRC
in received frame when passed to host, meaning the CRC should not be added.
Also, QEDE_ETH_OVERHEAD is added twice, once when frame_size is initialized
with QEDE_MAX_ETHER_HDR_LEN and another time in qede_calc_rx_buf_size.

-> Furthermore, the commit mentions applying a flooring on rx_buf_size to
align its value. This will cause an issue when receiving large packets
nearing MTU size limit, as the rx_buffer will not be large enough for some
MTU values. What I observed when debugging the pmd is that the nic would do
Rx scatter to compensate for the insufficient buffer size, although the pmd
was not configured to handle this. I  saw mbufs with m->nb_segs = 2 and
m->next = NULL being received, which was unsurprising, given the wrong
receive function was used as Rx scatter was not enabled:
qede_recv_pkts_regular() instead of qede_recv_pkts(). I would suggest
restoring the use of QEDE_CEIL_TO_CACHE_LINE_SIZE and force-enabling Rx
scatter in case this value would exceed mbuf size. This would ensure the
buffer is large enough to receive MTU-sized packets without fragmentation.

I will submit patches to improve the calculation of the rx buffer size.

-------------- Reproduction ------------------

Sadly, I did not manage to reproduce this issue with testpmd because Rx
scatter gets forcefully enabled by qede when started. This happens because
mtu is set at maximum possible value by default.
With a sufficient log level, this is visible at start:

Configuring Port 0 (socket 0)
[qede_check_fdir_support:149(17:00.0:dpdk-port-0)]flowdir is disabled
[qed_sb_init:500(17:00.0:dpdk-port-0)]hwfn [0] <--[init]-- SB 0000 [0x0000
upper]
[qede_alloc_fp_resc:656(17:00.0:dpdk-port-0)]sb_info idx 0x1 initialized
[qed_sb_init:500(17:00.0:dpdk-port-0)]hwfn [0] <--[init]-- SB 0001 [0x0001
upper]
[qede_alloc_fp_resc:656(17:00.0:dpdk-port-0)]sb_info idx 0x2 initialized
[qede_start_vport:498(17:00.0:dpdk-port-0)]VPORT started with MTU = 2154
[qede_vlan_stripping:906(17:00.0:dpdk-port-0)]VLAN stripping disabled
[qede_vlan_filter_set:970(17:00.0:dpdk-port-0)]No VLAN filters configured
yet
[qede_vlan_offload_set:1035(17:00.0:dpdk-port-0)]VLAN offload mask 3
[qede_dev_configure:1329(17:00.0:dpdk-port-0)]Device configured with RSS=2
TSS=2
[qede_alloc_tx_queue_mem:446(17:00.0:dpdk-port-0)]txq 0 num_desc 512
tx_free_thresh 480 socket 0
[qede_alloc_tx_queue_mem:446(17:00.0:dpdk-port-0)]txq 1 num_desc 512
tx_free_thresh 480 socket 0
[qede_rx_queue_setup:247(17:00.0:dpdk-port-0)]Forcing scatter-gather mode
<=========================
[qede_alloc_rx_queue_mem:155(17:00.0:dpdk-port-0)]mtu 2154 mbufsz 2048
bd_max_bytes 2048 scatter_mode 1
[qede_rx_queue_setup:283(17:00.0:dpdk-port-0)]rxq 0 num_desc 512
rx_buf_size=2048 socket 0
[qede_alloc_rx_queue_mem:155(17:00.0:dpdk-port-0)]mtu 2154 mbufsz 2048
bd_max_bytes 2048 scatter_mode 1
[qede_rx_queue_setup:283(17:00.0:dpdk-port-0)]rxq 1 num_desc 512
rx_buf_size=2048 socket 0
[qede_rx_queue_start:778(17:00.0:dpdk-port-0)]rxq 0 igu_sb_id 0x1
[qede_rx_queue_start:805(17:00.0:dpdk-port-0)]RX queue 0 started
[qede_rx_queue_start:778(17:00.0:dpdk-port-0)]rxq 1 igu_sb_id 0x2
[qede_rx_queue_start:805(17:00.0:dpdk-port-0)]RX queue 1 started
[qede_tx_queue_start:837(17:00.0:dpdk-port-0)]txq 0 igu_sb_id 0x1
[qede_tx_queue_start:870(17:00.0:dpdk-port-0)]TX queue 0 started
[qede_tx_queue_start:837(17:00.0:dpdk-port-0)]txq 1 igu_sb_id 0x2
[qede_tx_queue_start:870(17:00.0:dpdk-port-0)]TX queue 1 started
[qede_config_rss:1059(17:00.0:dpdk-port-0)]Applying driver default key
[qede_rss_hash_update:2121(17:00.0:dpdk-port-0)]RSS hf = 0x104 len = 40 key
= 0x7ffc5980db90
[qede_rss_hash_update:2126(17:00.0:dpdk-port-0)]Enabling rss
[qede_rss_hash_update:2140(17:00.0:dpdk-port-0)]Applying user supplied hash
key
[qede_rss_hash_update:2187(17:00.0:dpdk-port-0)]Storing RSS key
[qede_activate_vport:536(17:00.0:dpdk-port-0)]vport is activated
[qede_dev_set_link_state:1842(17:00.0:dpdk-port-0)]setting link state 1
[qede_link_update:1483(17:00.0:dpdk-port-0)]Link - Speed 0 Mode 1 AN 1
Status 0
[qede_link_update:1483(17:00.0:dpdk-port-0)]Link - Speed 0 Mode 1 AN 1
Status 0
[qede_assign_rxtx_handlers:338(17:00.0:dpdk-port-0)]Assigning qede_recv_pkts
[qede_assign_rxtx_handlers:354(17:00.0:dpdk-port-0)]Assigning
qede_xmit_pkts_regular
[qede_dev_start:1155(17:00.0:dpdk-port-0)]Device started
[qede_ucast_filter:682(17:00.0:dpdk-port-0)]Unicast MAC is not found
Port 0: F4:E9:D4:7A:A1:E6


========= Bad sanity check on port stop ===========

There is another sanity check which break the program on port stop when
releasing mbufs: If large traffic has been sent, it's possible to see
packets with m->pkt_len = 0 but non-zero m->data_len. It is probably
because mbufs are not reset when allocated in qede_alloc_rx_buffer() and
their value is only set at the end of qede_recv_pkts(). Calling
rte_pktmbuf_reset() before freeing the mbufs is enough to avoid this issue.
I will submit a patch doing this.

-------------- Reproduction ------------------

1) Start testpmd:
dpdk-testpmd --log-level=pmd.net.qede.driver:7 -a 0000:17:00.0 -a
0000:17:00.1 -- -i --rxq=2 --txq=2 --coremask=0x0c --total-num-mbufs=250000
--max-pkt-len 2172

show port info 0

********************* Infos for port 0  *********************
MAC address: F4:E9:D4:7A:A1:E6
Device name: 0000:17:00.0
Driver name: net_qede
Firmware-version: 8.40.33.0 MFW: 8.24.21.0
Devargs:
Connect to socket: 0
memory allocation on the socket: 0
Link status: up
Link speed: 10 Gbps
Link duplex: full-duplex
Autoneg status: On
MTU: 2154
Promiscuous mode: enabled
Allmulticast mode: disabled
Maximum number of MAC addresses: 256
Maximum number of MAC addresses of hash filtering: 0
VLAN offload:
  strip off, filter off, extend off, qinq strip off
Hash key size in bytes: 40
Redirection table size: 128
Supported RSS offload flow types:
  ipv4  ipv4-tcp  ipv4-udp  ipv6  ipv6-tcp  ipv6-udp  vxlan
  geneve
Minimum size of RX buffer: 1024
Maximum configurable length of RX packet: 9672
Maximum configurable size of LRO aggregated packet: 0
Current number of RX queues: 2
Max possible RX queues: 32
Max possible number of RXDs per queue: 32768
Min possible number of RXDs per queue: 128
RXDs number alignment: 128
Current number of TX queues: 2
Max possible TX queues: 32
Max possible number of TXDs per queue: 32768
Min possible number of TXDs per queue: 256
TXDs number alignment: 256
Max segment number per packet: 255
Max segment number per MTU/TSO: 18
Device capabilities: 0x0( )
Device error handling mode: none
Device private info:
  none

2) Start packet forwarding:
start
io packet forwarding - ports=2 - cores=2 - streams=4 - NUMA support
enabled, MP allocation mode: native
Logical Core 2 (socket 0) forwards packets on 2 streams:
  RX P=0/Q=0 (socket 0) -> TX P=1/Q=0 (socket 0) peer=02:00:00:00:00:01
  RX P=1/Q=0 (socket 0) -> TX P=0/Q=0 (socket 0) peer=02:00:00:00:00:00
Logical Core 3 (socket 1) forwards packets on 2 streams:
  RX P=0/Q=1 (socket 0) -> TX P=1/Q=1 (socket 0) peer=02:00:00:00:00:01
  RX P=1/Q=1 (socket 0) -> TX P=0/Q=1 (socket 0) peer=02:00:00:00:00:00

  io packet forwarding packets/burst=32
  nb forwarding cores=2 - nb forwarding ports=2
  port 0: RX queue number: 2 Tx queue number: 2
    Rx offloads=0x80000 Tx offloads=0x0
    RX queue: 0
      RX desc=0 - RX free threshold=0
      RX threshold registers: pthresh=0 hthresh=0  wthresh=0
      RX Offloads=0x80000
    TX queue: 0
      TX desc=0 - TX free threshold=0
      TX threshold registers: pthresh=0 hthresh=0  wthresh=0
      TX offloads=0x8000 - TX RS bit threshold=0
  port 1: RX queue number: 2 Tx queue number: 2
    Rx offloads=0x80000 Tx offloads=0x0
    RX queue: 0
      RX desc=0 - RX free threshold=0
      RX threshold registers: pthresh=0 hthresh=0  wthresh=0
      RX Offloads=0x80000
    TX queue: 0
      TX desc=0 - TX free threshold=0
      TX threshold registers: pthresh=0 hthresh=0  wthresh=0
      TX offloads=0x8000 - TX RS bit threshold=0

3) Send a continuous stream of packet of large size, nearing MTU limit
(size 2020):
p = Ether()/IP(src='10.100.0.1', dst='10.200.0.1')/UDP(sport=11111,
dport=22222)/Raw(load='A'*2020)
sendp(p, iface='ntfp1', count=5000, inter=0.001)

*Stop sending packets*

4) Stop packet forwarding:
stop
Telling cores to stop...
Waiting for lcores to finish...

  ------- Forward Stats for RX Port= 0/Queue= 1 -> TX Port= 1/Queue= 1
-------
  RX-packets: 1251           TX-packets: 1251           TX-dropped: 0


  ---------------------- Forward statistics for port 0
 ----------------------
  RX-packets: 1251           RX-dropped: 0             RX-total: 1251
  TX-packets: 0              TX-dropped: 0             TX-total: 0

----------------------------------------------------------------------------

  ---------------------- Forward statistics for port 1
 ----------------------
  RX-packets: 0              RX-dropped: 0             RX-total: 0
  TX-packets: 1251           TX-dropped: 0             TX-total: 1251

----------------------------------------------------------------------------

  +++++++++++++++ Accumulated forward statistics for all
ports+++++++++++++++
  RX-packets: 1251           RX-dropped: 0             RX-total: 1251
  TX-packets: 1251           TX-dropped: 0             TX-total: 1251

++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

Done.

5) Stop port:
port stop 0
Stopping ports...
[qede_dev_set_link_state:1842(17:00.0:dpdk-port-0)]setting link state 0
[qede_link_update:1483(17:00.0:dpdk-port-0)]Link - Speed 0 Mode 1 AN 1
Status 0
[ecore_int_attentions:1239(17:00.0:dpdk-port-0-0)]MFW indication via
attention
[qede_link_update:1483(17:00.0:dpdk-port-0)]Link - Speed 0 Mode 1 AN 1
Status 0
[qede_activate_vport:536(17:00.0:dpdk-port-0)]vport is deactivated
[qede_tx_queue_reset:509(17:00.0:dpdk-port-0)]Reset TX queue 0
[qede_tx_queue_stop:991(17:00.0:dpdk-port-0)]TX queue 0 stopped
[qede_tx_queue_reset:509(17:00.0:dpdk-port-0)]Reset TX queue 1
[qede_tx_queue_stop:991(17:00.0:dpdk-port-0)]TX queue 1 stopped
[qede_rx_queue_reset:293(17:00.0:dpdk-port-0)]Reset RX queue 0
[qede_rx_queue_stop:371(17:00.0:dpdk-port-0)]RX queue 0 stopped
EAL: PANIC in rte_mbuf_sanity_check():
bad pkt_len
0: dpdk-testpmd (rte_dump_stack+0x42) [643a372c5ac2]
1: dpdk-testpmd (__rte_panic+0xcc) [643a36c81963]
2: dpdk-testpmd (643a36ab0000+0x1d0b99) [643a36c80b99]
3: dpdk-testpmd (643a36ab0000+0x11b66be) [643a37c666be]
4: dpdk-testpmd (qede_stop_queues+0x162) [643a37c67ea2]
5: dpdk-testpmd (643a36ab0000+0x3c33fa) [643a36e733fa]
6: dpdk-testpmd (rte_eth_dev_stop+0x86) [643a3725a4c6]
7: dpdk-testpmd (643a36ab0000+0x4a2b28) [643a36f52b28]
8: dpdk-testpmd (643a36ab0000+0x799696) [643a37249696]
9: dpdk-testpmd (643a36ab0000+0x798604) [643a37248604]
10: dpdk-testpmd (rdline_char_in+0x38b) [643a3724bcdb]
11: dpdk-testpmd (cmdline_in+0x71) [643a372486d1]
12: dpdk-testpmd (cmdline_interact+0x40) [643a37248800]
13: dpdk-testpmd (prompt+0x2f) [643a36f01cef]
14: dpdk-testpmd (main+0x7e8) [643a36eddeb8]
15: /lib/x86_64-linux-gnu/libc.so.6 (718852800000+0x29d90) [718852829d90]
16: /lib/x86_64-linux-gnu/libc.so.6 (__libc_start_main+0x80) [718852829e40]
17: dpdk-testpmd (_start+0x25) [643a36ef7145]
Aborted (core dumped)    <=======

========= Wrong offload flags set for tunnel packets ===========

Finally, there is still another problem with offload flags for RX
outer/inner IP and L4 checksum.
Flags raised outside the tunnel part of qede_recv_pkts() and
qede_recv_pkts_regular() should be OUTER flags. Instead, they are the same
as the inner part.
This can lead to a problem where both GOOD and BAD L4 flags are set in
inner offloads. I will submit a patch for this.

--000000000000e6326406335fcaa7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello, <br><br>I have several issues to report concerning =
the qede pmd=20
as well as potential solutions for them. Most of them have to do with=20
configuring the MTU.<br><div><br></div><div>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =
Abort on mtu change =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br></div><div><br></d=
iv>First,
 the qede_assign_rxtx_handlers() seems to be working wrong since an API=20
change in the rte_eth lib. The commit linked bellow changes the way=20
packet receive and transmit functions are handled:<br><a href=3D"https://gi=
t.dpdk.org/dpdk/commit/?id=3Dc87d435a4d79739c0cec2ed280b94b41cb908af7" targ=
et=3D"_blank">https://git.dpdk.org/dpdk/commit/?id=3Dc87d435a4d79739c0cec2e=
d280b94b41cb908af7</a><br><br><div>Originally,
 the Rx/Tx handlers were located in rte_eth_dev struct. This is=20
currently no longer the case and the polling of incoming packets is done
 with functions registered in rte_eth_fp_ops instead. The rte lib change
 is supposed to be transparent for the individual pmds, but the polling=20
functions in rte_eth_dev are only synchronized with the ones in=20
rte_eth_fp_ops at the device start. This leads to an issue when trying=20
to configure the MTU while there is ongoing traffic:=C2=A0</div><div style=
=3D"margin-left:40px">-&gt; Trying to change the MTU triggers a port restar=
t.</div><div style=3D"margin-left:40px">-&gt;
 qede_assign_rxtx_handlers() assign dummy polling functions in=20
dev-&gt;rx_pkt_burst and dev-&gt;tx_pkt_burst while the port is down.=C2=A0=
</div><div style=3D"margin-left:40px">-&gt; However, rte_eth_rx_burst() pol=
ls in &amp;rte_eth_fp_ops[port_id].rx_pkt_burst which still points to qede_=
recv_pkts_regular()</div><div style=3D"margin-left:40px">-&gt; The applicat=
ion keep polling packets in the receive function and triggers an assert(rx_=
mb !=3D NULL) which caused an abort.=C2=A0</div><div style=3D"margin-left:4=
0px"><br></div><div>Since
 rte_eth_fp_ops is reset in rte_eth_dev_stop(), it may be better to call
 this function instead of qede_dev_stop(). However the dummy functions=20
defined in lib/ethdev/ethdev_private.c log an error and dump stack when=20
called so they might not be intended to be used this way.</div><div>The=20
way I fixed this issue in our applications is by forcing a complete stop of=
 the port before=20
configuring the MTU. I have no DPDK patch to suggest for this<br></div><div=
><br></div><div>-------------- Reproduction ------------------<br></div><di=
v><br></div><div>=C2=A0=C2=A0=C2=A0 1) Start testpmd:<br></div><div>dpdk-te=
stpmd --log-level=3Dpmd.net.qede.driver:7 -a 0000:17:00.0 -a=20
0000:17:00.1 -- -i --rxq=3D2 --txq=3D2 --coremask=3D0x0c=20
--total-num-mbufs=3D250000<br></div><div><br></div><div>=C2=A0=C2=A0=C2=A0 =
2) Start packet forwarding:<br></div><div>start<br>io packet forwarding - p=
orts=3D2 - cores=3D2 - streams=3D4 - NUMA support enabled, MP allocation mo=
de: native<br>Logical Core 2 (socket 0) forwards packets on 2 streams:<br>=
=C2=A0 RX P=3D0/Q=3D0 (socket 0) -&gt; TX P=3D1/Q=3D0 (socket 0) peer=3D02:=
00:00:00:00:01<br>=C2=A0 RX P=3D1/Q=3D0 (socket 0) -&gt; TX P=3D0/Q=3D0 (so=
cket 0) peer=3D02:00:00:00:00:00<br>Logical Core 3 (socket 1) forwards pack=
ets on 2 streams:<br>=C2=A0 RX P=3D0/Q=3D1 (socket 0) -&gt; TX P=3D1/Q=3D1 =
(socket 0) peer=3D02:00:00:00:00:01<br>=C2=A0 RX P=3D1/Q=3D1 (socket 0) -&g=
t; TX P=3D0/Q=3D1 (socket 0) peer=3D02:00:00:00:00:00<br><br>=C2=A0 io pack=
et forwarding packets/burst=3D32<br>=C2=A0 nb forwarding cores=3D2 - nb for=
warding ports=3D2<br>=C2=A0 port 0: RX queue number: 2 Tx queue number: 2<b=
r>=C2=A0 =C2=A0 Rx offloads=3D0x80000 Tx offloads=3D0x0<br>=C2=A0 =C2=A0 RX=
 queue: 0<br>=C2=A0 =C2=A0 =C2=A0 RX desc=3D0 - RX free threshold=3D0<br>=
=C2=A0 =C2=A0 =C2=A0 RX threshold registers: pthresh=3D0 hthresh=3D0 =C2=A0=
wthresh=3D0<br>=C2=A0 =C2=A0 =C2=A0 RX Offloads=3D0x80000<br>=C2=A0 =C2=A0 =
TX queue: 0<br>=C2=A0 =C2=A0 =C2=A0 TX desc=3D0 - TX free threshold=3D0<br>=
=C2=A0 =C2=A0 =C2=A0 TX threshold registers: pthresh=3D0 hthresh=3D0 =C2=A0=
wthresh=3D0<br>=C2=A0 =C2=A0 =C2=A0 TX offloads=3D0x8000 - TX RS bit thresh=
old=3D0<br>=C2=A0 port 1: RX queue number: 2 Tx queue number: 2<br>=C2=A0 =
=C2=A0 Rx offloads=3D0x80000 Tx offloads=3D0x0<br>=C2=A0 =C2=A0 RX queue: 0=
<br>=C2=A0 =C2=A0 =C2=A0 RX desc=3D0 - RX free threshold=3D0<br>=C2=A0 =C2=
=A0 =C2=A0 RX threshold registers: pthresh=3D0 hthresh=3D0 =C2=A0wthresh=3D=
0<br>=C2=A0 =C2=A0 =C2=A0 RX Offloads=3D0x80000<br>=C2=A0 =C2=A0 TX queue: =
0<br>=C2=A0 =C2=A0 =C2=A0 TX desc=3D0 - TX free threshold=3D0<br>=C2=A0 =C2=
=A0 =C2=A0 TX threshold registers: pthresh=3D0 hthresh=3D0 =C2=A0wthresh=3D=
0<br>=C2=A0 =C2=A0 =C2=A0 TX offloads=3D0x8000 - TX RS bit threshold=3D0<br=
><br>=C2=A0=C2=A0=C2=A0 3) Send a continuous stream of packets and change t=
he mtu while they are being forwarded:<br><br>p =3D Ether()/IP(src=3D&#39;1=
0.100.0.1&#39;, dst=3D&#39;10.200.0.1&#39;)/UDP(sport=3D11111, dport=3D2222=
2)/Raw(load=3D&#39;A&#39;*100)<br>sendp(p, iface=3D&#39;ntfp1&#39;, count=
=3D5000000, inter=3D0.001)<br><br>port config mtu 0 1500<br>[qede_dev_set_l=
ink_state:1842(17:00.0:dpdk-port-0)]setting link state 0<br>[qede_link_upda=
te:1483(17:00.0:dpdk-port-0)]Link - Speed 0 Mode 1 AN 1 Status 0<br>[ecore_=
int_attentions:1239(17:00.0:dpdk-port-0-0)]MFW indication via attention<br>=
[qede_link_update:1483(17:00.0:dpdk-port-0)]Link - Speed 0 Mode 1 AN 1 Stat=
us 0<br>[qede_activate_vport:536(17:00.0:dpdk-port-0)]vport is deactivated<=
br>[qede_tx_queue_reset:509(17:00.0:dpdk-port-0)]Reset TX queue 0<br>[qede_=
tx_queue_stop:991(17:00.0:dpdk-port-0)]TX queue 0 stopped<br>[qede_tx_queue=
_reset:509(17:00.0:dpdk-port-0)]Reset TX queue 1<br>[qede_tx_queue_stop:991=
(17:00.0:dpdk-port-0)]TX queue 1 stopped<br>[qede_rx_queue_reset:293(17:00.=
0:dpdk-port-0)]Reset RX queue 0<br>[qede_rx_queue_stop:371(17:00.0:dpdk-por=
t-0)]RX queue 0 stopped<br>[qede_rx_queue_reset:293(17:00.0:dpdk-port-0)]Re=
set RX queue 1<br>[qede_rx_queue_stop:371(17:00.0:dpdk-port-0)]RX queue 1 s=
topped<br>dpdk-testpmd:
 ../../../source/dpdk-24.11/drivers/net/qede/qede_rxtx.c:1600:=20
qede_recv_pkts_regular: Assertion `rx_mb !=3D NULL&#39; failed.<br>Aborted =
(core dumped)=C2=A0 &lt;=3D=3D=3D=3D=3D=3D=3D</div><div><br></div><div>As y=
ou can see, the application is aborted.<br></div><div><br></div><div><br></=
div><div>=3D=3D=3D=3D=3D=3D=3D=3D=3D Bad Rx buffer size for mbufs =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D<br></div><div><br></div><div>Another
 issue I had when trying to set the MTU was that I got bad sanity checks
 on mbufs when sending large packets, causing aborts. These checks are=20
only done when compiling in debug mode with RTE_LIBRTE_MBUF_DEBUG set,=20
so they may be easy to miss. Even without using this debugging config,=20
there are problems when transmitting those packets. This problem occurs=20
when calculating the size of the rx buffer, which was reworked in this=20
patch:<br><a href=3D"https://git.dpdk.org/dpdk/commit/drivers/net/qede?id=
=3D318d7da3122bac04772418c5eda9f50fcd175d18" target=3D"_blank">https://git.=
dpdk.org/dpdk/commit/drivers/net/qede?id=3D318d7da3122bac04772418c5eda9f50f=
cd175d18</a><br><br><div style=3D"margin-left:40px">-&gt;
 First, the max Rx buffer size is configured at two different places in=20
the code, and the calculation is not consistant between them. In=20
qede_rx_queue_setup(), RTE_ETHER_CRC_LEN is added to max_rx_pktlen but=20
not in qede_set_mtu(). The commit above mentions that HW does not=20
include CRC in received frame when passed to host, meaning the CRC=20
should not be added. Also, QEDE_ETH_OVERHEAD is added twice, once when=20
frame_size is initialized with QEDE_MAX_ETHER_HDR_LEN and another time=20
in qede_calc_rx_buf_size.</div><div style=3D"margin-left:40px"><br></div><d=
iv style=3D"margin-left:40px">-&gt;
 Furthermore, the commit mentions applying a flooring on rx_buf_size to=20
align its value. This will cause an issue when receiving large packets=20
nearing MTU size limit, as the rx_buffer will not be large enough for=20
some MTU values. What I observed when debugging the pmd is that the nic=20
would do Rx scatter to compensate for the insufficient buffer size,=20
although the pmd was not configured to handle this. I=C2=A0 saw mbufs with=
=20
m-&gt;nb_segs =3D 2 and m-&gt;next =3D NULL being received, which was=20
unsurprising, given the wrong receive function was used as Rx scatter=20
was not enabled: qede_recv_pkts_regular() instead of qede_recv_pkts(). I
 would suggest restoring the use of QEDE_CEIL_TO_CACHE_LINE_SIZE and=20
force-enabling Rx scatter in case this value would exceed mbuf size.=20
This would ensure the buffer is large enough to receive MTU-sized=20
packets without fragmentation.</div><div style=3D"margin-left:40px"><br></d=
iv>I will submit patches to improve the calculation of the rx buffer size.<=
br></div><div><br></div><div>-------------- Reproduction ------------------=
</div><div><br></div><div>Sadly,
 I did not manage to reproduce this issue with=20
testpmd because Rx scatter gets forcefully enabled by qede when started.
 This happens because mtu is set at maximum possible value by=20
default.</div><div>With a sufficient log level, this is visible at start:</=
div><div><br></div><div>Configuring Port 0 (socket 0)<br>[qede_check_fdir_s=
upport:149(17:00.0:dpdk-port-0)]flowdir is disabled<br>[qed_sb_init:500(17:=
00.0:dpdk-port-0)]hwfn [0] &lt;--[init]-- SB 0000 [0x0000 upper]<br>[qede_a=
lloc_fp_resc:656(17:00.0:dpdk-port-0)]sb_info idx 0x1 initialized<br>[qed_s=
b_init:500(17:00.0:dpdk-port-0)]hwfn [0] &lt;--[init]-- SB 0001 [0x0001 upp=
er]<br>[qede_alloc_fp_resc:656(17:00.0:dpdk-port-0)]sb_info idx 0x2 initial=
ized<br>[qede_start_vport:498(17:00.0:dpdk-port-0)]VPORT started with MTU =
=3D 2154<br>[qede_vlan_stripping:906(17:00.0:dpdk-port-0)]VLAN stripping di=
sabled<br>[qede_vlan_filter_set:970(17:00.0:dpdk-port-0)]No VLAN filters co=
nfigured yet<br>[qede_vlan_offload_set:1035(17:00.0:dpdk-port-0)]VLAN offlo=
ad mask 3<br>[qede_dev_configure:1329(17:00.0:dpdk-port-0)]Device configure=
d with RSS=3D2 TSS=3D2<br>[qede_alloc_tx_queue_mem:446(17:00.0:dpdk-port-0)=
]txq 0 num_desc 512 tx_free_thresh 480 socket 0<br>[qede_alloc_tx_queue_mem=
:446(17:00.0:dpdk-port-0)]txq 1 num_desc 512 tx_free_thresh 480 socket 0<br=
>[qede_rx_queue_setup:247(17:00.0:dpdk-port-0)]Forcing scatter-gather mode =
&lt;=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D<br>[qede_alloc_rx_queue_mem:155(17:00.0:dpdk-port-0)]mtu 2154 mbufsz=
 2048 bd_max_bytes 2048 scatter_mode 1<br>[qede_rx_queue_setup:283(17:00.0:=
dpdk-port-0)]rxq 0 num_desc 512 rx_buf_size=3D2048 socket 0<br>[qede_alloc_=
rx_queue_mem:155(17:00.0:dpdk-port-0)]mtu 2154 mbufsz 2048 bd_max_bytes 204=
8 scatter_mode 1<br>[qede_rx_queue_setup:283(17:00.0:dpdk-port-0)]rxq 1 num=
_desc 512 rx_buf_size=3D2048 socket 0<br>[qede_rx_queue_start:778(17:00.0:d=
pdk-port-0)]rxq 0 igu_sb_id 0x1<br>[qede_rx_queue_start:805(17:00.0:dpdk-po=
rt-0)]RX queue 0 started<br>[qede_rx_queue_start:778(17:00.0:dpdk-port-0)]r=
xq 1 igu_sb_id 0x2<br>[qede_rx_queue_start:805(17:00.0:dpdk-port-0)]RX queu=
e 1 started<br>[qede_tx_queue_start:837(17:00.0:dpdk-port-0)]txq 0 igu_sb_i=
d 0x1<br>[qede_tx_queue_start:870(17:00.0:dpdk-port-0)]TX queue 0 started<b=
r>[qede_tx_queue_start:837(17:00.0:dpdk-port-0)]txq 1 igu_sb_id 0x2<br>[qed=
e_tx_queue_start:870(17:00.0:dpdk-port-0)]TX queue 1 started<br>[qede_confi=
g_rss:1059(17:00.0:dpdk-port-0)]Applying driver default key<br>[qede_rss_ha=
sh_update:2121(17:00.0:dpdk-port-0)]RSS hf =3D 0x104 len =3D 40 key =3D 0x7=
ffc5980db90<br>[qede_rss_hash_update:2126(17:00.0:dpdk-port-0)]Enabling rss=
<br>[qede_rss_hash_update:2140(17:00.0:dpdk-port-0)]Applying user supplied =
hash key<br>[qede_rss_hash_update:2187(17:00.0:dpdk-port-0)]Storing RSS key=
<br>[qede_activate_vport:536(17:00.0:dpdk-port-0)]vport is activated<br>[qe=
de_dev_set_link_state:1842(17:00.0:dpdk-port-0)]setting link state 1<br>[qe=
de_link_update:1483(17:00.0:dpdk-port-0)]Link - Speed 0 Mode 1 AN 1 Status =
0<br>[qede_link_update:1483(17:00.0:dpdk-port-0)]Link - Speed 0 Mode 1 AN 1=
 Status 0<br>[qede_assign_rxtx_handlers:338(17:00.0:dpdk-port-0)]Assigning =
qede_recv_pkts<br>[qede_assign_rxtx_handlers:354(17:00.0:dpdk-port-0)]Assig=
ning qede_xmit_pkts_regular<br>[qede_dev_start:1155(17:00.0:dpdk-port-0)]De=
vice started<br>[qede_ucast_filter:682(17:00.0:dpdk-port-0)]Unicast MAC is =
not found<br>Port 0: F4:E9:D4:7A:A1:E6</div><div><br></div><div><br></div><=
div>=3D=3D=3D=3D=3D=3D=3D=3D=3D Bad sanity check on port stop =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D<br></div><div><br></div><div>There
 is another sanity check which break the program on port stop when=20
releasing mbufs: If large traffic has been sent, it&#39;s possible to see=
=20
packets with m-&gt;pkt_len =3D 0 but non-zero m-&gt;data_len. It is=20
probably because mbufs are not reset when allocated in=20
qede_alloc_rx_buffer() and their value is only set at the end of=20
qede_recv_pkts(). Calling rte_pktmbuf_reset() before freeing the mbufs=20
is enough to avoid this issue. I will submit a patch doing this.<br></div><=
div><br></div><div>-------------- Reproduction ------------------</div><div=
><br></div><div style=3D"margin-left:40px">1) Start testpmd:</div><div>dpdk=
-testpmd --log-level=3Dpmd.net.qede.driver:7 -a 0000:17:00.0 -a=20
0000:17:00.1 -- -i --rxq=3D2 --txq=3D2 --coremask=3D0x0c=20
--total-num-mbufs=3D250000 --max-pkt-len 2172<br></div><div><br></div><div>=
show port info 0<br><br>********************* Infos for port 0 =C2=A0******=
***************<br>MAC address: F4:E9:D4:7A:A1:E6<br>Device name: 0000:17:0=
0.0<br>Driver name: net_qede<br>Firmware-version: 8.40.33.0 MFW: 8.24.21.0<=
br>Devargs: <br>Connect to socket: 0<br>memory allocation on the socket: 0<=
br>Link status: up<br>Link speed: 10 Gbps<br>Link duplex: full-duplex<br>Au=
toneg status: On<br>MTU: 2154<br>Promiscuous mode: enabled<br>Allmulticast =
mode: disabled<br>Maximum number of MAC addresses: 256<br>Maximum number of=
 MAC addresses of hash filtering: 0<br>VLAN offload: <br>=C2=A0 strip off, =
filter off, extend off, qinq strip off<br>Hash key size in bytes: 40<br>Red=
irection table size: 128<br>Supported RSS offload flow types:<br>=C2=A0 ipv=
4 =C2=A0ipv4-tcp =C2=A0ipv4-udp =C2=A0ipv6 =C2=A0ipv6-tcp =C2=A0ipv6-udp =
=C2=A0vxlan<br>=C2=A0 geneve<br>Minimum size of RX buffer: 1024<br>Maximum =
configurable length of RX packet: 9672<br>Maximum configurable size of LRO =
aggregated packet: 0<br>Current number of RX queues: 2<br>Max possible RX q=
ueues: 32<br>Max possible number of RXDs per queue: 32768<br>Min possible n=
umber of RXDs per queue: 128<br>RXDs number alignment: 128<br>Current numbe=
r of TX queues: 2<br>Max possible TX queues: 32<br>Max possible number of T=
XDs per queue: 32768<br>Min possible number of TXDs per queue: 256<br>TXDs =
number alignment: 256<br>Max segment number per packet: 255<br>Max segment =
number per MTU/TSO: 18<br>Device capabilities: 0x0( )<br>Device error handl=
ing mode: none<br>Device private info:<br>=C2=A0 none<br></div><div><br></d=
iv><div><div style=3D"margin-left:40px">2) Start packet forwarding:</div>st=
art<br>io packet forwarding - ports=3D2 - cores=3D2 - streams=3D4 - NUMA su=
pport enabled, MP allocation mode: native<br>Logical Core 2 (socket 0) forw=
ards packets on 2 streams:<br>=C2=A0 RX P=3D0/Q=3D0 (socket 0) -&gt; TX P=
=3D1/Q=3D0 (socket 0) peer=3D02:00:00:00:00:01<br>=C2=A0 RX P=3D1/Q=3D0 (so=
cket 0) -&gt; TX P=3D0/Q=3D0 (socket 0) peer=3D02:00:00:00:00:00<br>Logical=
 Core 3 (socket 1) forwards packets on 2 streams:<br>=C2=A0 RX P=3D0/Q=3D1 =
(socket 0) -&gt; TX P=3D1/Q=3D1 (socket 0) peer=3D02:00:00:00:00:01<br>=C2=
=A0 RX P=3D1/Q=3D1 (socket 0) -&gt; TX P=3D0/Q=3D1 (socket 0) peer=3D02:00:=
00:00:00:00<br><br>=C2=A0 io packet forwarding packets/burst=3D32<br>=C2=A0=
 nb forwarding cores=3D2 - nb forwarding ports=3D2<br>=C2=A0 port 0: RX que=
ue number: 2 Tx queue number: 2<br>=C2=A0 =C2=A0 Rx offloads=3D0x80000 Tx o=
ffloads=3D0x0<br>=C2=A0 =C2=A0 RX queue: 0<br>=C2=A0 =C2=A0 =C2=A0 RX desc=
=3D0 - RX free threshold=3D0<br>=C2=A0 =C2=A0 =C2=A0 RX threshold registers=
: pthresh=3D0 hthresh=3D0 =C2=A0wthresh=3D0<br>=C2=A0 =C2=A0 =C2=A0 RX Offl=
oads=3D0x80000<br>=C2=A0 =C2=A0 TX queue: 0<br>=C2=A0 =C2=A0 =C2=A0 TX desc=
=3D0 - TX free threshold=3D0<br>=C2=A0 =C2=A0 =C2=A0 TX threshold registers=
: pthresh=3D0 hthresh=3D0 =C2=A0wthresh=3D0<br>=C2=A0 =C2=A0 =C2=A0 TX offl=
oads=3D0x8000 - TX RS bit threshold=3D0<br>=C2=A0 port 1: RX queue number: =
2 Tx queue number: 2<br>=C2=A0 =C2=A0 Rx offloads=3D0x80000 Tx offloads=3D0=
x0<br>=C2=A0 =C2=A0 RX queue: 0<br>=C2=A0 =C2=A0 =C2=A0 RX desc=3D0 - RX fr=
ee threshold=3D0<br>=C2=A0 =C2=A0 =C2=A0 RX threshold registers: pthresh=3D=
0 hthresh=3D0 =C2=A0wthresh=3D0<br>=C2=A0 =C2=A0 =C2=A0 RX Offloads=3D0x800=
00<br>=C2=A0 =C2=A0 TX queue: 0<br>=C2=A0 =C2=A0 =C2=A0 TX desc=3D0 - TX fr=
ee threshold=3D0<br>=C2=A0 =C2=A0 =C2=A0 TX threshold registers: pthresh=3D=
0 hthresh=3D0 =C2=A0wthresh=3D0<br>=C2=A0 =C2=A0 =C2=A0 TX offloads=3D0x800=
0 - TX RS bit threshold=3D0<br><br><div style=3D"margin-left:40px">3) Send =
a continuous stream of packet of large size, nearing MTU limit (size 2020):=
<br></div>p =3D Ether()/IP(src=3D&#39;10.100.0.1&#39;, dst=3D&#39;10.200.0.=
1&#39;)/UDP(sport=3D11111, dport=3D22222)/Raw(load=3D&#39;A&#39;*2020)<br>s=
endp(p, iface=3D&#39;ntfp1&#39;, count=3D5000, inter=3D0.001)<br><br>*Stop =
sending packets*<br></div><div><br></div><div><div style=3D"margin-left:40p=
x">4) Stop packet forwarding:<br></div>stop<br>Telling cores to stop...<br>=
Waiting for lcores to finish...<br><br>=C2=A0 ------- Forward Stats for RX =
Port=3D 0/Queue=3D 1 -&gt; TX Port=3D 1/Queue=3D 1 -------<br>=C2=A0 RX-pac=
kets: 1251 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TX-packets: 1251 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 TX-dropped: 0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 <br><br>=C2=A0 ---------------------- Forward statistics for port 0 =
=C2=A0----------------------<br>=C2=A0 RX-packets: 1251 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 RX-dropped: 0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 R=
X-total: 1251<br>=C2=A0 TX-packets: 0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0TX-dropped: 0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TX-tot=
al: 0<br>=C2=A0 -----------------------------------------------------------=
-----------------<br><br>=C2=A0 ---------------------- Forward statistics f=
or port 1 =C2=A0----------------------<br>=C2=A0 RX-packets: 0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RX-dropped: 0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 RX-total: 0<br>=C2=A0 TX-packets: 1251 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 TX-dropped: 0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 TX-total: 1251<br>=C2=A0 ----------------------------------------------=
------------------------------<br><br>=C2=A0 +++++++++++++++ Accumulated fo=
rward statistics for all ports+++++++++++++++<br>=C2=A0 RX-packets: 1251 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RX-dropped: 0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 RX-total: 1251<br>=C2=A0 TX-packets: 1251 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 TX-dropped: 0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 TX-total: 1251<br>=C2=A0 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++++++++++++++++++++++<br><br>Done.<br></div><div><br></div><div><d=
iv style=3D"margin-left:40px">5) Stop port:<br></div>port stop 0<br>Stoppin=
g ports...<br>[qede_dev_set_link_state:1842(17:00.0:dpdk-port-0)]setting li=
nk state 0<br>[qede_link_update:1483(17:00.0:dpdk-port-0)]Link - Speed 0 Mo=
de 1 AN 1 Status 0<br>[ecore_int_attentions:1239(17:00.0:dpdk-port-0-0)]MFW=
 indication via attention<br>[qede_link_update:1483(17:00.0:dpdk-port-0)]Li=
nk - Speed 0 Mode 1 AN 1 Status 0<br>[qede_activate_vport:536(17:00.0:dpdk-=
port-0)]vport is deactivated<br>[qede_tx_queue_reset:509(17:00.0:dpdk-port-=
0)]Reset TX queue 0<br>[qede_tx_queue_stop:991(17:00.0:dpdk-port-0)]TX queu=
e 0 stopped<br>[qede_tx_queue_reset:509(17:00.0:dpdk-port-0)]Reset TX queue=
 1<br>[qede_tx_queue_stop:991(17:00.0:dpdk-port-0)]TX queue 1 stopped<br>[q=
ede_rx_queue_reset:293(17:00.0:dpdk-port-0)]Reset RX queue 0<br>[qede_rx_qu=
eue_stop:371(17:00.0:dpdk-port-0)]RX queue 0 stopped<br>EAL: PANIC in rte_m=
buf_sanity_check():<br>bad pkt_len<br>0: dpdk-testpmd (rte_dump_stack+0x42)=
 [643a372c5ac2]<br>1: dpdk-testpmd (__rte_panic+0xcc) [643a36c81963]<br>2: =
dpdk-testpmd (643a36ab0000+0x1d0b99) [643a36c80b99]<br>3: dpdk-testpmd (643=
a36ab0000+0x11b66be) [643a37c666be]<br>4: dpdk-testpmd (qede_stop_queues+0x=
162) [643a37c67ea2]<br>5: dpdk-testpmd (643a36ab0000+0x3c33fa) [643a36e733f=
a]<br>6: dpdk-testpmd (rte_eth_dev_stop+0x86) [643a3725a4c6]<br>7: dpdk-tes=
tpmd (643a36ab0000+0x4a2b28) [643a36f52b28]<br>8: dpdk-testpmd (643a36ab000=
0+0x799696) [643a37249696]<br>9: dpdk-testpmd (643a36ab0000+0x798604) [643a=
37248604]<br>10: dpdk-testpmd (rdline_char_in+0x38b) [643a3724bcdb]<br>11: =
dpdk-testpmd (cmdline_in+0x71) [643a372486d1]<br>12: dpdk-testpmd (cmdline_=
interact+0x40) [643a37248800]<br>13: dpdk-testpmd (prompt+0x2f) [643a36f01c=
ef]<br>14: dpdk-testpmd (main+0x7e8) [643a36eddeb8]<br>15: /lib/x86_64-linu=
x-gnu/libc.so.6 (718852800000+0x29d90) [718852829d90]<br>16: /lib/x86_64-li=
nux-gnu/libc.so.6 (__libc_start_main+0x80) [718852829e40]<br>17: dpdk-testp=
md (_start+0x25) [643a36ef7145]<br>Aborted (core dumped)=C2=A0=C2=A0=C2=A0 =
&lt;=3D=3D=3D=3D=3D=3D=3D<br></div><div><br></div><div>=3D=3D=3D=3D=3D=3D=
=3D=3D=3D Wrong offload flags set for tunnel packets =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D</div><div><br></div><div>Finally, there is still another probl=
em with offload flags for RX outer/inner IP and L4 checksum.<br>Flags
 raised outside the tunnel part of qede_recv_pkts() and=20
qede_recv_pkts_regular() should be OUTER flags. Instead, they are the=20
same as the inner part.</div><div>This can lead to a problem where both GOO=
D and BAD L4 flags are set in inner offloads. I will submit a patch for thi=
s.</div></div>

--000000000000e6326406335fcaa7--
