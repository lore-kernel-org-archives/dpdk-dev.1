Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBAD0C9830B
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Sep 2026 18:44:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C0485402DB;
	Wed, 23 Sep 2026 20:44:06 +0200 (CEST)
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by mails.dpdk.org (Postfix) with ESMTP id 926544027C
 for <dev@dpdk.org>; Wed, 23 Sep 2026 20:44:04 +0200 (CEST)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-396ccb1a98dso850934a91.0
 for <dev@dpdk.org>; Wed, 23 Sep 2026 11:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790189043;
 x=1790793843; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=G90jG36z73UDTRqXetZVfvU0+ePHgXdpO4GjnLGmpLg=;
 b=r4BmdxMrqnaR6GEhmQ1lQbvIUurDp4PgIGX87s1p3yphQIJrYAJBw7oA+ahguMgL+X
 lCduvavQG62r4hwk/M5fjwsuQmDKRQhAi4QLC/7pZ1+LwxSotpvQhwYVEFJA6euIuGg1
 c8iGdD7Dq5viScJ/LBZFMuX6zB6j1pC5OVkZH2W3UuwwHk5sKCB1Co57V3e9DblZGBcX
 cgb4qK2pG/ZpeKAs0W6uThXomyXJjKeiSzaDsE93ptCq5eDWOioJR2xavv3B/h0GZnLG
 M9838SkRecGLQIKttwFj4mMlVZ/s18KeeX/KAkp4dItnjXGjt3ZwK7VbuZDfV7wSe11B
 IG+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790189043; x=1790793843;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=G90jG36z73UDTRqXetZVfvU0+ePHgXdpO4GjnLGmpLg=;
 b=FsQAIgWNYjKbzeBJvJ4mvxG40ibiiiWyt05ShyzkAKXDBVSWiUaQ/nKanFi7pxidjW
 HaZPgmieaADpScejDlPrHgq9gBHDaq7TmfIvCktbz0l3U8Y5DoMR9crDh4Asjxfqd12R
 DWOfrlDAMVBVShC8nmp9jZjlVf/Czl5KG1xjKSAzRNCDfD9Pp/k/Q7f90uvIGkRnLcAb
 +gd5FEw5AM6O1xFFo0Ci1fFRkLuyzmB5l64teS5Rlsekb9b5ZY2gdMzQsZ2NyOpVzfs5
 bt1pDaQxh6zbb+O5StUT/spTD9XHS+jAkCVeqptJ6mbcCtZLg5WHUE+lNLbkb3HQX/KQ
 Z66w==
X-Gm-Message-State: AFuF++lHMfP49GLnV16QW718vzkgJmTj7hkIenziom/OP2ZPPz5RyiZy
 5BZ5hy7/Ie6oIW+KSp2E5ZYmxoPGoQrDP/DPrgfP50zTlzEWTOWPZr+Tjte4XNYJwQX8UgWwnVm
 wTgN9
X-Gm-Gg: AYBFou3XKJMLfU6IpaC+HRxQR8vhiQhY0OuQm3gIQBfUhPrUDk4lV/TIQwi1J/fn/mQ
 JmB3qLye2GsJDTPzyx0kFzvdZLc8a2z2IZlgIwXft6MsRAcmKHJozHIRbCi8aV6d0k6sTjb3prk
 EWzCJIFb5SZ1kDnD2IWB6zoDk8ywi6R/fd78Q2FgY+9U8OMofvgPfENZf6mH6D1OcPHi86VnBB0
 qrAjV6Rb+VwS3Dz15RK630uBG++Ol+5Izim8XPgrioQ5X/0vgk9g0bRXoCMRrUIoT0mWI5qsYM1
 xU+r7arQtuDfJQxz0Rt8927BEd80ZvXh876zgdNzSa6K5Q/Qbb1JzNnUYuMPg+WJKhwCtUKODNS
 JlWkf958LnTAjMrXh6dSmLR3EijVjdXsOaJazjL+R8rmsbVF6McqWeLBhOxrvcWMWtYUCuXiw3e
 M9KdlGPDEZRjLr2Fd3poDizpRQZVLhosCdRoWbbjc8vKql55uoieAaNSurug0TRhoRp7wA+A6hm
 PJHvPcHPmZ57QaUkxUXUaZNJXA/z6+1lx0kq6BN
X-Received: by 2002:a17:90b:1644:b0:3a0:345a:3646 with SMTP id
 98e67ed59e1d1-3a098967e86mr53237a91.45.1790189043354; 
 Wed, 23 Sep 2026 11:44:03 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0972f2cddsm429023a91.1.2026.09.23.11.44.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 11:44:03 -0700 (PDT)
Date: Wed, 23 Sep 2026 11:44:00 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Aaron Conole <aconole@redhat.com>, Thomas Monjalon
 <thomas@monjalon.net>, Anatoly Burakov <anatoly.burakov@intel.com>
Subject: Re: [RFC] devtools: rewrite doc vs code check in Python
Message-ID: <20260923114400.120901fb@phoenix.local>
In-Reply-To: <20260923184207.626576-1-stephen@networkplumber.org>
References: <20260923184207.626576-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Wed, 23 Sep 2026 11:42:07 -0700
Stephen Hemminger <stephen@networkplumber.org> wrote:

> The existing check-doc-vs-code.sh only compares rte_flow items and
> actions, and only for drivers whose directory matches the ini name,
> so none of the drivers under net/intel are checked.
> 
> Replace it and parse-flow-support.sh with a Python script covering
> the whole NIC feature matrix:
>  - ini syntax: unknown rows, invalid values, duplicates, row order
>  - rte_flow items and actions, keeping the bnxt and dpaa2 exceptions
>  - feature rows against eth_dev_ops, fast-path ops, offload and
>    capability flags, including full (Y) vs partial (P) support
>  - ops that only return -ENOTSUP
>  - OS and architecture rows against meson.build and its dependencies
>  - incomplete operation sets, e.g. start without stop,
>    or Rx timestamp without read_clock
>  - rows requiring another row in the same ini
> 
> Drivers sharing a directory (PF/VF, e1000/igb/igc) are matched
> by their own eth_dev_ops instance or source files.
> 
> Given a git reference, only drivers changed since the reference
> are checked, and findings already present at the reference are
> not reported, so existing documentation gaps do not fail CI.
> 
> Documented but not implemented is an error. Implemented but not
> documented, and incomplete operation sets, are warnings.
> Option -v adds notes such as platforms meson allows but the ini
> does not list. Option -g prints ini rows derived from driver code.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---

This tool finds lots of incorrect/missing stuff:

bonding: warning: no features ini
null: warning: no features ini
ring: warning: no features ini
softnic: warning: no features ini
af_xdp: warning: no OS documented
afpacket: warning: line 9: "MTU update" not in default.ini order
afpacket: warning: "Scattered Rx" implemented, not documented
afpacket: warning: "VLAN offload" implemented, not documented
afpacket: warning: "Timestamp offload" implemented, not documented
afpacket: warning: Rx timestamp offload without read_clock, no way to read NIC clock
afpacket: warning: no OS documented
afpacket: warning: no architecture documented
ark: warning: "Link status" implemented, not documented
ark: warning: "Link status event" implemented, not documented
ark: warning: "MTU update" implemented, not documented
ark: error: "Scattered Rx" documented, no RTE_ETH_RX_OFFLOAD_SCATTER
ark: warning: "Unicast MAC filter" implemented, not documented
ark: warning: "Timestamp offload" implemented, not documented
ark: warning: Rx timestamp offload without read_clock, no way to read NIC clock
ark: warning: Rx timestamp offload without rte_mbuf_dyn_rx_timestamp_register()
atlantic: warning: line 23: "MACsec offload" not in default.ini order
atlantic: warning: "Rx interrupt" implemented, not documented
atlantic: warning: "TSO" implemented, not documented
atlantic: warning: "Multicast MAC filter" implemented, not documented
avp: error: "Scattered Rx" documented, no RTE_ETH_RX_OFFLOAD_SCATTER
avp: error: "Unicast MAC filter" documented, no mac_addr_add or mac_addr_remove
avp: warning: "QinQ offload" implemented, not documented (partial)
avp: warning: VLAN filter offload without vlan_filter_set
axgbe: warning: "MTU update" implemented, not documented
axgbe: warning: "Unicast MAC filter" implemented, not documented
axgbe: warning: "Multicast MAC filter" implemented, not documented
axgbe: warning: "Flow control" implemented, not documented
axgbe: warning: "VLAN offload" implemented, not documented
axgbe: warning: "QinQ offload" implemented, not documented
axgbe: warning: "Packet type parsing" implemented, not documented
axgbe: warning: "Timesync" implemented, not documented
axgbe: warning: "Rx descriptor status" implemented, not documented
axgbe: warning: "Tx descriptor status" implemented, not documented
axgbe: warning: "Extended stats" implemented, not documented
axgbe: warning: "Stats per queue" implemented, not documented
axgbe: warning: "Registers dump" implemented, not documented
bnx2x: warning: "Allmulticast mode" implemented, not documented
bnx2x: warning: stats_get without stats_reset
bnxt: warning: line 40: "VLAN offload" not in default.ini order
bnxt: warning: line 64: "ipv4", "ipv6" not in default.ini order
bnxt: warning: "Removal event" implemented, not documented
bnxt: warning: "Buffer split on Rx" implemented, not documented
bnxt: warning: "QinQ offload" implemented, not documented
bnxt: warning: "Timestamp offload" implemented, not documented
bnxt: warning: "Inner L4 checksum" documented Y, partial in code (missing RTE_ETH_TX_OFFLOAD_OUTER_UDP_CKSUM)
bnxt: warning: Rx timestamp offload without read_clock, no way to read NIC clock
cnxk: warning: line 10: "SR-IOV", "Multiprocess aware", "Link status", "Link status event", "Fast mbuf free", "Free Tx mbuf on demand", "Queue start/stop", "Flow control", "Scattered Rx", "Timestamp offload", "Extended stats" not in default.ini order
cnxk: warning: "LRO" implemented, not documented
cnxk: warning: "Rate limitation" implemented, not documented
cnxk: warning: "CRC offload" implemented, not documented
cnxk: warning: "VLAN offload" implemented, not documented
cnxk: warning: "QinQ offload" implemented, not documented
cnxk: warning: "IP reassembly" implemented, not documented (partial)
cnxk: warning: "MACsec offload" implemented, not documented
cnxk: warning: ip_reassembly_conf_get = cn10k_nix_reassembly_conf_get only returns an error, leave it NULL
cnxk: warning: Tx send on timestamp without rte_mbuf_dyn_tx_timestamp_register()
cnxk: warning: VLAN filter offload without vlan_filter_set
cnxk_vec: warning: line 10: "SR-IOV", "Multiprocess aware", "Link status", "Link status event", "Fast mbuf free", "Free Tx mbuf on demand", "Queue start/stop", "Flow control", "Extended stats" not in default.ini order
cnxk_vf: warning: line 10: "Multiprocess aware", "Link status", "Link status event", "Fast mbuf free", "Free Tx mbuf on demand", "Queue start/stop", "Scattered Rx", "Extended stats" not in default.ini order
cpfl: error: "Speed capabilities" documented, no speed_capa
cpfl: warning: "Fast mbuf free" implemented, not documented
cpfl: warning: "CRC offload" implemented, not documented
cpfl: warning: "VLAN offload" implemented, not documented
cpfl: warning: "QinQ offload" implemented, not documented
cpfl: warning: "Inner L3 checksum" implemented, not documented
cpfl: warning: "Timesync" implemented, not documented (partial)
cpfl: warning: "Extended stats" implemented, not documented
cpfl: warning: Rx timestamp offload without read_clock, no way to read NIC clock
cpfl: warning: Rx timestamp offload without rte_mbuf_dyn_rx_timestamp_register()
cpfl: warning: VLAN filter offload without vlan_filter_set
cxgbe: error: "CRC offload" documented, no RTE_ETH_RX_OFFLOAD_KEEP_CRC
cxgbe: warning: "Stats per queue" documented, no q_[io](packets|bytes)|RTE_ETH_DEV_AUTOFILL_QUEUE_XSTATS
cxgbevf: error: "CRC offload" documented, no RTE_ETH_RX_OFFLOAD_KEEP_CRC
cxgbevf: warning: "Stats per queue" documented, no q_[io](packets|bytes)|RTE_ETH_DEV_AUTOFILL_QUEUE_XSTATS
cxgbevf: warning: stats_get without stats_reset
dpaa: warning: line 23: "Timestamp offload" not in default.ini order
dpaa: warning: "Rx interrupt" implemented, not documented
dpaa: warning: "Lock-free Tx queue" implemented, not documented
dpaa: warning: "Fast mbuf free" implemented, not documented
dpaa: warning: "RSS key update" implemented, not documented
dpaa: error: "Timestamp offload" documented, no RTE_ETH_RX_OFFLOAD_TIMESTAMP
dpaa: warning: "Inner L3 checksum" implemented, not documented
dpaa: warning: no OS documented
dpaa2: warning: line 10: "Burst mode info", "MTU update", "Timestamp offload" not in default.ini order
dpaa2: warning: "Lock-free Tx queue" implemented, not documented
dpaa2: warning: "Fast mbuf free" implemented, not documented
dpaa2: error: "Queue start/stop" documented, no rx_queue_start or rx_queue_stop or tx_queue_start or tx_queue_stop
dpaa2: warning: "RSS key update" implemented, not documented
dpaa2: warning: "VLAN offload" documented Y, partial in code (missing RTE_ETH_RX_OFFLOAD_VLAN_STRIP|RTE_ETH_RX_OFFLOAD_VLAN)
dpaa2: warning: "Inner L3 checksum" implemented, not documented
dpaa2: warning: "Inner L4 checksum" implemented, not documented (partial)
dpaa2: warning: "Stats per queue" implemented, not documented
dpaa2: warning: Rx timestamp offload without read_clock, no way to read NIC clock
e1000: error: rte_flow item eth documented, not in code
e1000: error: rte_flow item ipv4 documented, not in code
e1000: error: rte_flow item ipv6 documented, not in code
e1000: error: rte_flow item raw documented, not in code
e1000: error: rte_flow item sctp documented, not in code
e1000: error: rte_flow item tcp documented, not in code
e1000: error: rte_flow item udp documented, not in code
e1000: error: rte_flow items documented without flow_ops_get
e1000: error: rte_flow action drop documented, not in code
e1000: error: rte_flow action queue documented, not in code
e1000: error: rte_flow action rss documented, not in code
e1000: error: rte_flow actions documented without flow_ops_get
e1000: error: "Free Tx mbuf on demand" documented, no tx_done_cleanup
e1000: warning: "Multicast MAC filter" implemented, not documented
e1000: error: "QinQ offload" documented, no RTE_ETH_RX_OFFLOAD_QINQ_STRIP|RTE_ETH_RX_OFFLOAD_VLAN_EXTEND or RTE_ETH_TX_OFFLOAD_QINQ_INSERT
e1000: warning: "LED" implemented, not documented
ena: warning: "Speed capabilities" implemented, not documented
ena: warning: "Timestamp offload" implemented, not documented
ena: warning: "Stats per queue" implemented, not documented
ena: warning: stats_get without stats_reset
ena: warning: Rx timestamp offload without read_clock, no way to read NIC clock
enetc: warning: line 7: "Packet type parsing", "Basic stats", "MTU update", "Queue start/stop" not in default.ini order
enetc4: warning: line 7: "Link status event", "RSS hash", "L3 checksum offload", "L4 checksum offload", "CRC offload", "Queue start/stop", "Scattered Rx" not in default.ini order
enetc4: error: "Speed capabilities" documented, no speed_capa
enetc4: error: "Link status event" documented, no RTE_ETH_DEV_INTR_LSC|RTE_PCI_DRV_INTR_LSC
enetc4: error: "Allmulticast mode" documented, no allmulticast_enable or allmulticast_disable
enetc4: error: "Unicast MAC filter" documented, no mac_addr_add or mac_addr_remove
enetc4: error: "VLAN filter" documented, no vlan_filter_set
enetc4_vf: warning: line 9: "Speed capabilities", "Link status", "RSS hash", "L3 checksum offload", "L4 checksum offload", "CRC offload", "Queue start/stop", "Scattered Rx" not in default.ini order
enetc4_vf: error: "Speed capabilities" documented, no speed_capa
enetc4_vf: warning: "MTU update" implemented, not documented
enetc4_vf: warning: "Unicast MAC filter" implemented, not documented (partial)
enetc4_vf: warning: mac_addr_add without mac_addr_remove
enetfec: warning: "Link status" implemented, not documented
enetfec: warning: "Promiscuous mode" documented Y, partial in code (missing promiscuous_disable)
enetfec: warning: "Allmulticast mode" implemented, not documented (partial)
enetfec: warning: "CRC offload" implemented, not documented
enetfec: warning: "VLAN offload" documented Y, partial in code (missing RTE_ETH_TX_OFFLOAD_VLAN_INSERT)
enetfec: warning: "L3 checksum offload" documented Y, partial in code (missing RTE_ETH_TX_OFFLOAD_IPV4_CKSUM)
enetfec: warning: "L4 checksum offload" documented Y, partial in code (missing RTE_ETH_TX_OFFLOAD_UDP_CKSUM, RTE_ETH_TX_OFFLOAD_TCP_CKSUM)
enetfec: warning: promiscuous_enable without promiscuous_disable
enetfec: warning: allmulticast_enable without allmulticast_disable
enetfec: warning: stats_get without stats_reset
enic: warning: line 72: "queue" not in default.ini order
enic: error: "CRC offload" documented, no RTE_ETH_RX_OFFLOAD_KEEP_CRC
enic: warning: "Inner L3 checksum" documented Y, partial in code (missing RTE_ETH_RX_OFFLOAD_OUTER_IPV4_CKSUM)
enic: warning: "Inner L4 checksum" documented, no RTE_ETH_RX_OFFLOAD_OUTER_UDP_CKSUM or RTE_ETH_TX_OFFLOAD_OUTER_UDP_CKSUM
failsafe: warning: "RSS key update" implemented, not documented (partial)
failsafe: warning: "Extended stats" implemented, not documented
failsafe: warning: rss_hash_update without rss_hash_conf_get
failsafe: warning: no OS documented
fm10k: error: "Multicast MAC filter" documented, no set_mc_addr_list
fm10k: error: "CRC offload" documented, no RTE_ETH_RX_OFFLOAD_KEEP_CRC
fm10k: warning: "QinQ offload" implemented, not documented (partial)
fm10k_vf: error: "CRC offload" documented, no RTE_ETH_RX_OFFLOAD_KEEP_CRC
gve: error: "Speed capabilities" documented, no speed_capa
gve: warning: "LRO" implemented, not documented
gve: warning: "L3 checksum offload" implemented, not documented
gve: warning: "Extended stats" implemented, not documented
hinic: warning: line 14: "LRO", "CRC offload", "Flow control", "ARMv8" not in default.ini order
hinic: error: "Queue start/stop" documented, no rx_queue_start or rx_queue_stop or tx_queue_start or tx_queue_stop
hinic: error: "Inner RSS" documented, no RTE_ETH_RSS_LEVEL_*|rss*.level
hinic: error: "CRC offload" documented, no RTE_ETH_RX_OFFLOAD_KEEP_CRC
hinic: warning: "Inner L3 checksum" documented Y, partial in code (missing RTE_ETH_RX_OFFLOAD_OUTER_IPV4_CKSUM)
hinic: warning: "Inner L4 checksum" documented, no RTE_ETH_RX_OFFLOAD_OUTER_UDP_CKSUM or RTE_ETH_TX_OFFLOAD_OUTER_UDP_CKSUM
hinic3: warning: line 17: "LRO", "ARMv8" not in default.ini order
hinic3: error: "Speed capabilities" documented, no speed_capa
hinic3: error: "Link speed configuration" documented, no link_speeds
hinic3: warning: "Link status event" implemented, not documented
hinic3: error: "Runtime Rx queue setup" documented, no RTE_ETH_DEV_CAPA_RUNTIME_RX_QUEUE_SETUP
hinic3: error: "Runtime Tx queue setup" documented, no RTE_ETH_DEV_CAPA_RUNTIME_TX_QUEUE_SETUP
hinic3: error: "CRC offload" documented, no RTE_ETH_RX_OFFLOAD_KEEP_CRC
hinic3: error: "QinQ offload" documented, no RTE_ETH_RX_OFFLOAD_QINQ_STRIP|RTE_ETH_RX_OFFLOAD_VLAN_EXTEND or RTE_ETH_TX_OFFLOAD_QINQ_INSERT
hinic3: warning: "Inner L4 checksum" documented, no RTE_ETH_RX_OFFLOAD_OUTER_UDP_CKSUM or RTE_ETH_TX_OFFLOAD_OUTER_UDP_CKSUM
hinic3: error: "Packet type parsing" documented, no dev_supported_ptypes_get
hns3: warning: line 16: "Fast mbuf free", "Free Tx mbuf on demand", "LRO", "Module EEPROM dump", "Timesync", "Timestamp offload" not in default.ini order
hns3: warning: "Power mgmt address monitor" implemented, not documented
hns3: warning: "QinQ offload" implemented, not documented
hns3: warning: "Stats per queue" documented, no q_[io](packets|bytes)|RTE_ETH_DEV_AUTOFILL_QUEUE_XSTATS
hns3: warning: Rx timestamp offload without read_clock, no way to read NIC clock
hns3_vf: warning: line 14: "Free Tx mbuf on demand", "LRO", "Rx descriptor status" not in default.ini order
hns3_vf: warning: "Power mgmt address monitor" implemented, not documented
hns3_vf: warning: "DCB" implemented, not documented
hns3_vf: warning: "Stats per queue" documented, no q_[io](packets|bytes)|RTE_ETH_DEV_AUTOFILL_QUEUE_XSTATS
hns3_vf: warning: "FW version" implemented, not documented
i40e: warning: line 54: "ARMv8", "Power8" not in default.ini order
i40e: warning: "Free Tx mbuf on demand" implemented, not documented
i40e: warning: "MTU update" implemented, not documented
i40e: warning: "EEPROM dump" implemented, not documented
i40e: warning: "Registers dump" implemented, not documented
i40e: warning: "LED" implemented, not documented
iavf: warning: "Link status event" implemented, not documented
iavf: warning: "Fast mbuf free" implemented, not documented
iavf: warning: "Timesync" implemented, not documented (partial)
iavf: warning: Rx timestamp offload without read_clock, no way to read NIC clock
ice: warning: line 14: "FEC", "DCB" not in default.ini order
ice: error: rte_flow item l2tpv2 not documented
ice: error: rte_flow item ppp not documented
ice: warning: "Inner L4 checksum" documented Y, partial in code (missing RTE_ETH_RX_OFFLOAD_OUTER_UDP_CKSUM)
ice: warning: "EEPROM dump" implemented, not documented
ice_dcf: warning: line 18: "RSS reta update", "RSS key update", "MTU update", "Promiscuous mode", "Allmulticast mode", "Unicast MAC filter", "VLAN filter", "Traffic manager", "VLAN offload", "Basic stats", "Power mgmt address monitor" not in default.ini order
ice_dcf: warning: "Link status" implemented, not documented
ice_dcf: warning: "Free Tx mbuf on demand" implemented, not documented
ice_dcf: warning: "Multicast MAC filter" implemented, not documented
ice_dcf: warning: "Packet type parsing" implemented, not documented
idpf: warning: line 23: "Packet type parsing" not in default.ini order
idpf: error: "Speed capabilities" documented, no speed_capa
idpf: warning: "Fast mbuf free" implemented, not documented
idpf: warning: "CRC offload" implemented, not documented
idpf: warning: "Inner L3 checksum" implemented, not documented (partial)
idpf: warning: "Extended stats" implemented, not documented
idpf: warning: Rx timestamp offload without read_clock, no way to read NIC clock
igb: error: rte_flow item eth not documented
igb: error: rte_flow item ipv4 not documented
igb: error: rte_flow item ipv6 not documented
igb: error: rte_flow item raw not documented
igb: error: rte_flow item sctp not documented
igb: error: rte_flow item tcp not documented
igb: error: rte_flow item udp not documented
igb: error: rte_flow action drop not documented
igb: error: rte_flow action queue not documented
igb: error: rte_flow action rss not documented
igb: warning: "Free Tx mbuf on demand" implemented, not documented
igb: warning: "Burst mode info" implemented, not documented
igb: error: "DCB" documented, no get_dcb_info
igb: warning: "QinQ offload" documented Y, partial in code (missing RTE_ETH_TX_OFFLOAD_QINQ_INSERT)
igb: warning: "LED" implemented, not documented
igb_vf: error: "Rx interrupt" documented, no rx_queue_intr_enable or rx_queue_intr_disable
igb_vf: warning: "Free Tx mbuf on demand" implemented, not documented
igb_vf: warning: "Burst mode info" implemented, not documented
igb_vf: error: "Unicast MAC filter" documented, no mac_addr_add or mac_addr_remove
igb_vf: warning: "Multicast MAC filter" implemented, not documented
igb_vf: warning: "QinQ offload" documented Y, partial in code (missing RTE_ETH_TX_OFFLOAD_QINQ_INSERT)
igc: warning: line 10: "FW version", "LED", "Packet type parsing", "Rx descriptor status", "Tx descriptor status", "Rx interrupt", "Flow control", "RSS key update", "RSS reta update", "VLAN filter", "VLAN offload" not in default.ini order
igc: warning: "Free Tx mbuf on demand" implemented, not documented
igc: warning: "QinQ offload" implemented, not documented (partial)
igc: warning: "Timestamp offload" implemented, not documented
igc: warning: Rx timestamp offload without rte_mbuf_dyn_rx_timestamp_register()
ionic: warning: line 25: "VLAN offload" not in default.ini order
ionic: error: "LRO" documented, no RTE_ETH_RX_OFFLOAD_TCP_LRO
ionic: error: "CRC offload" documented, no RTE_ETH_RX_OFFLOAD_KEEP_CRC
ionic: warning: "Inner L3 checksum" implemented, not documented (partial)
ionic: warning: "Inner L4 checksum" implemented, not documented (partial)
ipn3ke: error: "Link status event" documented, no RTE_ETH_DEV_INTR_LSC|RTE_PCI_DRV_INTR_LSC
ipn3ke: error: "Rx interrupt" documented, no rx_queue_intr_enable or rx_queue_intr_disable
ipn3ke: warning: "Fast mbuf free" implemented, not documented
ipn3ke: warning: "MTU update" implemented, not documented
ipn3ke: error: "Scattered Rx" documented, no RTE_ETH_RX_OFFLOAD_SCATTER
ipn3ke: error: "Unicast MAC filter" documented, no mac_addr_add or mac_addr_remove
ipn3ke: error: "Multicast MAC filter" documented, no set_mc_addr_list
ipn3ke: error: "RSS hash" documented, no RTE_ETH_RX_OFFLOAD_RSS_HASH|flow_type_rss_offloads
ipn3ke: error: "RSS key update" documented, no rss_hash_update or rss_hash_conf_get
ipn3ke: error: "RSS reta update" documented, no reta_update or reta_query
ipn3ke: error: "VMDq" documented, no RTE_ETH_MQ_RX_VMDQ_ONLY|vmdq_rx_conf
ipn3ke: error: "DCB" documented, no get_dcb_info
ipn3ke: error: "VLAN filter" documented, no vlan_filter_set
ipn3ke: error: "Flow control" documented, no flow_ctrl_get or flow_ctrl_set
ipn3ke: error: "CRC offload" documented, no RTE_ETH_RX_OFFLOAD_KEEP_CRC
ipn3ke: warning: "Inner L4 checksum" documented, no RTE_ETH_RX_OFFLOAD_OUTER_UDP_CKSUM or RTE_ETH_TX_OFFLOAD_OUTER_UDP_CKSUM
ipn3ke: error: "Packet type parsing" documented, no dev_supported_ptypes_get
ipn3ke: error: "Timesync" documented, no timesync_enable or timesync_disable or timesync_read_rx_timestamp or timesync_read_tx_timestamp or timesync_adjust_time or timesync_read_time or timesync_write_time
ipn3ke: error: "Rx descriptor status" documented, no rx_descriptor_status
ipn3ke: error: "Tx descriptor status" documented, no tx_descriptor_status
ipn3ke: error: "FW version" documented, no fw_version_get
ipn3ke: error: "Module EEPROM dump" documented, no get_module_info or get_module_eeprom
ipn3ke: warning: VLAN filter offload without vlan_filter_set
ixgbe: warning: "Fast mbuf free" implemented, not documented
ixgbe: warning: "Free Tx mbuf on demand" implemented, not documented
ixgbe: warning: "Burst mode info" implemented, not documented
ixgbe: warning: "Inner L4 checksum" documented, no RTE_ETH_RX_OFFLOAD_OUTER_UDP_CKSUM or RTE_ETH_TX_OFFLOAD_OUTER_UDP_CKSUM
ixgbe: warning: "LED" implemented, not documented
ixgbe_vf: warning: "Free Tx mbuf on demand" implemented, not documented
ixgbe_vf: warning: "Burst mode info" implemented, not documented
ixgbe_vf: warning: "Multicast MAC filter" implemented, not documented
ixgbe_vf: warning: "Inner L4 checksum" documented, no RTE_ETH_RX_OFFLOAD_OUTER_UDP_CKSUM or RTE_ETH_TX_OFFLOAD_OUTER_UDP_CKSUM
mana: warning: line 15: "MTU update" not in default.ini order
mana: warning: "RSS key update" implemented, not documented
mana: warning: "VLAN offload" implemented, not documented
mana: warning: "Packet type parsing" implemented, not documented
mana: warning: "Stats per queue" implemented, not documented
memif: warning: "Stats per queue" implemented, not documented
memif: warning: no OS documented
mlx4: error: "Queue start/stop" documented, no rx_queue_start or rx_queue_stop or tx_queue_start or tx_queue_stop
mlx4: warning: "Inner L3 checksum" documented Y, partial in code (missing RTE_ETH_RX_OFFLOAD_OUTER_IPV4_CKSUM)
mlx4: warning: "Inner L4 checksum" documented, no RTE_ETH_RX_OFFLOAD_OUTER_UDP_CKSUM or RTE_ETH_TX_OFFLOAD_OUTER_UDP_CKSUM
mlx5: warning: line 103: "represented_port" not in default.ini order
mlx5: warning: line 135: "queue" not in default.ini order
mlx5: error: "Flow control" documented, flow_ctrl_get, flow_ctrl_set only returns an error
mlx5: warning: "Inner L3 checksum" documented Y, partial in code (missing RTE_ETH_RX_OFFLOAD_OUTER_IPV4_CKSUM)
mlx5: warning: "Inner L4 checksum" documented, no RTE_ETH_RX_OFFLOAD_OUTER_UDP_CKSUM or RTE_ETH_TX_OFFLOAD_OUTER_UDP_CKSUM
mlx5: error: "Module EEPROM dump" documented, get_module_info, get_module_eeprom only returns an error
mlx5: warning: dev_set_link_down = mlx5_set_link_down only returns an error, leave it NULL
mlx5: warning: dev_set_link_up = mlx5_set_link_up only returns an error, leave it NULL
mlx5: warning: flow_ctrl_get = mlx5_dev_get_flow_ctrl only returns an error, leave it NULL
mlx5: warning: flow_ctrl_set = mlx5_dev_set_flow_ctrl only returns an error, leave it NULL
mlx5: warning: get_module_eeprom = mlx5_get_module_eeprom only returns an error, leave it NULL
mlx5: warning: get_module_info = mlx5_get_module_info only returns an error, leave it NULL
mlx5: warning: udp_tunnel_port_add without udp_tunnel_port_del
mvneta: error: "CRC offload" documented, no RTE_ETH_RX_OFFLOAD_KEEP_CRC
mvneta: warning: no OS documented
mvpp2: warning: "Queue start/stop" implemented, not documented (partial)
mvpp2: error: "Multicast MAC filter" documented, no set_mc_addr_list
mvpp2: warning: "RSS key update" implemented, not documented
mvpp2: error: "CRC offload" documented, no RTE_ETH_RX_OFFLOAD_KEEP_CRC
mvpp2: warning: "Stats per queue" implemented, not documented
mvpp2: warning: no OS documented
nbl: warning: "Link status" implemented, not documented
nbl: warning: "Link status event" implemented, not documented
nbl: error: "Unicast MAC filter" documented, no mac_addr_add or mac_addr_remove
nbl: warning: "RSS hash" implemented, not documented
netvsc: warning: line 15: "Extended stats", "MTU update" not in default.ini order
netvsc: warning: "Link status event" implemented, not documented
netvsc: warning: "Removal event" implemented, not documented
netvsc: error: "Scattered Rx" documented, no RTE_ETH_RX_OFFLOAD_SCATTER
netvsc: warning: "TSO" implemented, not documented
netvsc: warning: "Multicast MAC filter" implemented, not documented
netvsc: warning: "RSS hash" implemented, not documented
netvsc: warning: "RSS key update" implemented, not documented
netvsc: warning: "RSS reta update" implemented, not documented
netvsc: warning: "VLAN offload" implemented, not documented
netvsc: warning: "L3 checksum offload" implemented, not documented
netvsc: warning: "L4 checksum offload" implemented, not documented
netvsc: warning: "Packet type parsing" implemented, not documented
netvsc: warning: "Rx descriptor status" implemented, not documented
netvsc: warning: "Tx descriptor status" implemented, not documented
nfb: warning: "MTU update" implemented, not documented
nfb: warning: "FEC" implemented, not documented (partial)
nfb: error: "Extended stats" documented, no xstats_get or xstats_get_names
nfb: warning: fec_set without fec_get_capability
nfb: warning: Rx timestamp offload without read_clock, no way to read NIC clock
nfp: warning: line 15: "TSO", "Multiprocess aware" not in default.ini order
nfp: warning: line 68: "port_id" not in default.ini order
nfp: error: "Queue start/stop" documented, no rx_queue_start or rx_queue_stop or tx_queue_start or tx_queue_stop
nfp: warning: "Burst mode info" implemented, not documented
nfp: warning: "Inline crypto" implemented, not documented
nfp: warning: "Inline protocol" implemented, not documented
nfp: warning: "QinQ offload" documented Y, partial in code (missing RTE_ETH_TX_OFFLOAD_QINQ_INSERT)
nfp: warning: "Extended stats" implemented, not documented
nfp: warning: "FW version" implemented, not documented
ngbe: warning: "Inner L3 checksum" documented, no RTE_ETH_RX_OFFLOAD_OUTER_IPV4_CKSUM or RTE_ETH_TX_OFFLOAD_OUTER_IPV4_CKSUM
ngbe: warning: "Inner L4 checksum" documented, no RTE_ETH_RX_OFFLOAD_OUTER_UDP_CKSUM or RTE_ETH_TX_OFFLOAD_OUTER_UDP_CKSUM
ngbe_vf: warning: line 8: "Unicast MAC filter", "Multicast MAC filter", "Free Tx mbuf on demand" not in default.ini order
ngbe_vf: error: "LRO" documented, no RTE_ETH_RX_OFFLOAD_TCP_LRO
ngbe_vf: error: "Inline crypto" documented, no RTE_SECURITY_ACTION_TYPE_INLINE_CRYPTO
ngbe_vf: warning: "Inner L3 checksum" documented, no RTE_ETH_RX_OFFLOAD_OUTER_IPV4_CKSUM or RTE_ETH_TX_OFFLOAD_OUTER_IPV4_CKSUM
ngbe_vf: warning: "Inner L4 checksum" documented, no RTE_ETH_RX_OFFLOAD_OUTER_UDP_CKSUM or RTE_ETH_TX_OFFLOAD_OUTER_UDP_CKSUM
ntnic: warning: line 7: "FW version", "MTU update" not in default.ini order
ntnic: warning: "Promiscuous mode" implemented, not documented (partial)
ntnic: warning: "Unicast MAC filter" documented Y, partial in code (missing mac_addr_remove)
ntnic: warning: "Stats per queue" implemented, not documented
ntnic: warning: promiscuous_enable without promiscuous_disable
ntnic: warning: mac_addr_add without mac_addr_remove
octeon_ep: warning: line 11: "Basic stats", "Link status", "MTU update", "Multiprocess aware" not in default.ini order
octeon_ep: warning: "Scattered Rx" implemented, not documented
octeon_ep: warning: "Stats per queue" implemented, not documented
octeontx: warning: line 20: "CRC offload", "Flow control" not in default.ini order
octeontx: error: "Link status event" documented, no RTE_ETH_DEV_INTR_LSC|RTE_PCI_DRV_INTR_LSC
octeontx: warning: "Fast mbuf free" implemented, not documented
octeontx: error: "CRC offload" documented, no RTE_ETH_RX_OFFLOAD_KEEP_CRC
octeontx: error: "VLAN offload" documented, no RTE_ETH_RX_OFFLOAD_VLAN_STRIP|RTE_ETH_RX_OFFLOAD_VLAN or RTE_ETH_TX_OFFLOAD_VLAN_INSERT
octeontx: warning: "Inner L4 checksum" documented Y, partial in code (missing RTE_ETH_RX_OFFLOAD_OUTER_UDP_CKSUM)
pcap: warning: line 13: "VLAN offload" not in default.ini order
pcap: warning: "Scattered Rx" implemented, not documented
pfe: warning: line 12: "MTU update", "Promiscuous mode", "Allmulticast mode" not in default.ini order
pfe: warning: "Allmulticast mode" documented Y, partial in code (missing allmulticast_disable)
pfe: warning: allmulticast_enable without allmulticast_disable
pfe: warning: stats_get without stats_reset
qede: warning: line 33: "SR-IOV" not in default.ini order
qede: warning: "Link status event" implemented, not documented
qede: warning: "Inner L4 checksum" documented, no RTE_ETH_RX_OFFLOAD_OUTER_UDP_CKSUM or RTE_ETH_TX_OFFLOAD_OUTER_UDP_CKSUM
qede: warning: "Rx descriptor status" implemented, not documented
qede: warning: "FW version" implemented, not documented
qede_vf: warning: line 34: "LRO", "TSO" not in default.ini order
qede_vf: error: "Flow control" documented, no flow_ctrl_get or flow_ctrl_set
qede_vf: warning: "FW version" implemented, not documented
r8169: warning: "Free Tx mbuf on demand" implemented, not documented
r8169: error: "Flow control" documented, no flow_ctrl_get or flow_ctrl_set
r8169: warning: "VLAN offload" implemented, not documented
rnp: warning: line 10: "Packet type parsing", "L3 checksum offload", "L4 checksum offload", "Inner L3 checksum", "Inner L4 checksum", "Basic stats", "Stats per queue", "Extended stats", "MTU update", "VLAN filter", "VLAN offload", "QinQ offload", "Scattered Rx", "TSO" not in default.ini order
rnp: warning: "Fast mbuf free" implemented, not documented
rnp: warning: "Burst mode info" implemented, not documented
rnp: error: "Inner RSS" documented, no RTE_ETH_RSS_LEVEL_*|rss*.level
rnp: warning: "Inner L4 checksum" documented, no RTE_ETH_RX_OFFLOAD_OUTER_UDP_CKSUM or RTE_ETH_TX_OFFLOAD_OUTER_UDP_CKSUM
sfc: warning: line 79: "queue" not in default.ini order
sxe2: warning: line 17: "Queue start/stop", "MTU update", "TSO", "Promiscuous mode", "Allmulticast mode", "Unicast MAC filter", "RSS hash", "RSS key update", "RSS reta update", "VLAN filter", "Inline crypto", "Packet type parsing", "Timesync" not in default.ini order
sxe2: warning: line 79: "port_id" not in default.ini order
sxe2: error: "Link status event" documented, no RTE_ETH_DEV_INTR_LSC|RTE_PCI_DRV_INTR_LSC
sxe2: warning: "Removal event" implemented, not documented
sxe2: warning: "LRO" implemented, not documented
sxe2: warning: "Multicast MAC filter" implemented, not documented
sxe2: error: "Timesync" documented, no timesync_enable or timesync_disable or timesync_read_rx_timestamp or timesync_read_tx_timestamp or timesync_adjust_time or timesync_read_time or timesync_write_time
sxe2: warning: "Stats per queue" implemented, not documented
sxe2: warning: Rx timestamp offload without read_clock, no way to read NIC clock
tap: warning: "TSO" implemented, not documented
tap: warning: "RSS key update" implemented, not documented (partial)
tap: warning: "Stats per queue" implemented, not documented
tap: warning: rss_hash_update without rss_hash_conf_get
thunderx: warning: "Fast mbuf free" implemented, not documented
thunderx: warning: "Promiscuous mode" documented Y, partial in code (missing promiscuous_disable)
thunderx: error: "Allmulticast mode" documented, no allmulticast_enable or allmulticast_disable
thunderx: error: "CRC offload" documented, no RTE_ETH_RX_OFFLOAD_KEEP_CRC
thunderx: warning: "Inner L3 checksum" implemented, not documented (partial)
thunderx: warning: promiscuous_enable without promiscuous_disable
txgbe: warning: "Free Tx mbuf on demand" implemented, not documented
txgbe: warning: "FEC" implemented, not documented
txgbe: warning: "MACsec offload" implemented, not documented
txgbe: warning: "Inner L4 checksum" documented, no RTE_ETH_RX_OFFLOAD_OUTER_UDP_CKSUM or RTE_ETH_TX_OFFLOAD_OUTER_UDP_CKSUM
txgbe_vf: warning: line 8: "Unicast MAC filter", "Multicast MAC filter", "Free Tx mbuf on demand" not in default.ini order
txgbe_vf: warning: "Inner L4 checksum" documented, no RTE_ETH_RX_OFFLOAD_OUTER_UDP_CKSUM or RTE_ETH_TX_OFFLOAD_OUTER_UDP_CKSUM
vhost: warning: line 9: "Queue status event" not in default.ini order
vhost: warning: "Link status event" implemented, not documented
vhost: warning: "Rx interrupt" implemented, not documented
vhost: warning: "Power mgmt address monitor" implemented, not documented
vhost: warning: "VLAN offload" implemented, not documented
vhost: warning: "Stats per queue" implemented, not documented
vhost: warning: no OS documented
virtio: warning: line 22: "Extended stats", "MTU update" not in default.ini order
virtio: warning: "Burst mode info" implemented, not documented
virtio: warning: "Power mgmt address monitor" implemented, not documented
virtio: warning: "LRO" implemented, not documented
virtio: warning: "TSO" implemented, not documented
virtio: error: "Multicast MAC filter" documented, no set_mc_addr_list
virtio: warning: "VLAN offload" implemented, not documented
virtio: warning: "L4 checksum offload" implemented, not documented
vmxnet3: warning: "Rx interrupt" implemented, not documented
vmxnet3: warning: "Scattered Rx" implemented, not documented
vmxnet3: error: "Unicast MAC filter" documented, no mac_addr_add or mac_addr_remove
vmxnet3: warning: "RSS reta update" implemented, not documented
vmxnet3: warning: "L3 checksum offload" implemented, not documented (partial)
vmxnet3: warning: "FW version" implemented, not documented
xsc: warning: "Speed capabilities" implemented, not documented
xsc: error: "Link status event" documented, no RTE_ETH_DEV_INTR_LSC|RTE_PCI_DRV_INTR_LSC
xsc: error: "RSS reta update" documented, no reta_update or reta_query
xsc: warning: "FEC" documented Y, partial in code (missing fec_get_capability)
xsc: warning: "Timestamp offload" implemented, not documented
xsc: warning: "Inner L3 checksum" documented, no RTE_ETH_RX_OFFLOAD_OUTER_IPV4_CKSUM or RTE_ETH_TX_OFFLOAD_OUTER_IPV4_CKSUM
xsc: warning: "Inner L4 checksum" documented, no RTE_ETH_RX_OFFLOAD_OUTER_UDP_CKSUM or RTE_ETH_TX_OFFLOAD_OUTER_UDP_CKSUM
xsc: warning: fec_set without fec_get_capability
xsc: warning: Rx timestamp offload without read_clock, no way to read NIC clock
xsc: warning: Rx timestamp offload without rte_mbuf_dyn_rx_timestamp_register()
zxdh: warning: line 7: "Linux", "x86-64", "ARMv8", "SR-IOV", "Multiprocess aware", "Scattered Rx", "Promiscuous mode", "Allmulticast mode", "RSS hash", "RSS reta update", "Inner RSS", "Basic stats", "Stats per queue", "MTU update", "LRO", "TSO" not in default.ini order
zxdh: warning: line 50: "count" not in default.ini order
zxdh: warning: "Speed capabilities" implemented, not documented
zxdh: warning: "Rx interrupt" implemented, not documented
zxdh: error: "Multicast MAC filter" documented, no set_mc_addr_list
zxdh: warning: "RSS key update" implemented, not documented
zxdh: warning: "L4 checksum offload" implemented, not documented
zxdh: warning: "Inner L4 checksum" documented Y, partial in code (missing RTE_ETH_TX_OFFLOAD_OUTER_UDP_CKSUM)
zxdh: warning: "Packet type parsing" implemented, not documented
zxdh: warning: "Inner L4 checksum" documented without "L4 checksum offload"
