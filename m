Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77EEAC44529
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Jul 2026 14:59:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C32924064A;
	Tue, 21 Jul 2026 16:59:21 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 76C3E40687
 for <dev@dpdk.org>; Tue, 21 Jul 2026 16:59:15 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=sAZE9gaenHMQOOPI0spVBHPUxynYtWLI5DWzxXWdjj4=;
 b=zWVU/HSMuahkJdzJNRh18wnNvs4VlLo7WIHdcY2q91brLlkc/DBj7aSuGYdb7VMsKMYCDkVb2
 UAVGLO3tzWKcaUY5G3chsbfT4PkhKJNOCQB9DFSjHMQAfZmcgIYPr7ffQ1wYpcDF6VUhbrfFkFk
 NcQddjtN4ZpOfeOSsV2oQeU=
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4h4LB51zsYzJ46cS;
 Tue, 21 Jul 2026 22:58:53 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id A1F404058B;
 Tue, 21 Jul 2026 22:59:13 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 21 Jul 2026 16:59:13 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: 
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <bruce.richardson@intel.com>
Subject: [PATCH v4 7/7] doc: add missing headers to doxy-api-index.md
Date: Tue, 21 Jul 2026 15:58:40 +0100
Message-ID: <20260721145841.7424-8-marat.khalili@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721145841.7424-1-marat.khalili@huawei.com>
References: <20260707085048.15295-1-marat.khalili@huawei.com>
 <20260721145841.7424-1-marat.khalili@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.220.239.45]
X-ClientProxiedBy: frapema100002.china.huawei.com (7.182.19.63) To
 frapema500003.china.huawei.com (7.182.19.114)
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

Make sure all public headers are listed in `doxy-api-index.md` to be
reachable in HTML version. Presumably each of them should contain at
least a general file description, though this is not checked now.

The only header still omitted is rte_pmd_bphy.h since it needs writing
multiple new doxygen descriptions which could not be done on the spot,
so it is excluded from the build (tracked by bug 1962 in bugzilla).

Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
---
 doc/api/doxy-api-index.md | 110 +++++++++++++++++++++++++++++++++-----
 1 file changed, 96 insertions(+), 14 deletions(-)

diff --git a/doc/api/doxy-api-index.md b/doc/api/doxy-api-index.md
index 929604211946..fc7351d8d45a 100644
--- a/doc/api/doxy-api-index.md
+++ b/doc/api/doxy-api-index.md
@@ -9,14 +9,21 @@ API
 The public API headers are grouped by topics:
 
 - **device**:
+  [bus](@ref rte_bus.h),
   [dev](@ref rte_dev.h),
   [ethdev](@ref rte_ethdev.h),
+  [cman](@ref rte_cman.h),
+  [dev info](@ref rte_dev_info.h),
   [ethctrl](@ref rte_eth_ctrl.h),
   [rte_flow](@ref rte_flow.h),
   [rte_tm](@ref rte_tm.h),
   [rte_mtr](@ref rte_mtr.h),
   [bbdev](@ref rte_bbdev.h),
+  [bbdev op](@ref rte_bbdev_op.h),
   [cryptodev](@ref rte_cryptodev.h),
+  [crypto](@ref rte_crypto.h),
+  [crypto sym](@ref rte_crypto_sym.h),
+  [crypto asym](@ref rte_crypto_asym.h),
   [security](@ref rte_security.h),
   [compressdev](@ref rte_compressdev.h),
   [compress](@ref rte_comp.h),
@@ -25,6 +32,7 @@ The public API headers are grouped by topics:
   [dmadev](@ref rte_dmadev.h),
   [gpudev](@ref rte_gpudev.h),
   [eventdev](@ref rte_eventdev.h),
+  [event ring](@ref rte_event_ring.h),
   [event_eth_rx_adapter](@ref rte_event_eth_rx_adapter.h),
   [event_eth_tx_adapter](@ref rte_event_eth_tx_adapter.h),
   [event_timer_adapter](@ref rte_event_timer_adapter.h),
@@ -33,17 +41,27 @@ The public API headers are grouped by topics:
   [event_vector_adapter](@ref rte_event_vector_adapter.h),
   [rawdev](@ref rte_rawdev.h),
   [metrics](@ref rte_metrics.h),
+  [metrics telemetry](@ref rte_metrics_telemetry.h),
   [bitrate](@ref rte_bitrate.h),
   [latency](@ref rte_latencystats.h),
   [devargs](@ref rte_devargs.h),
   [PCI](@ref rte_pci.h),
+  [PCI dev feature defs](@ref rte_pci_dev_feature_defs.h),
+  [PCI dev features](@ref rte_pci_dev_features.h),
+  [bus PCI](@ref rte_bus_pci.h),
   [vdev](@ref rte_bus_vdev.h),
+  [vmbus](@ref rte_bus_vmbus.h),
+  [vmbus reg](@ref rte_vmbus_reg.h),
   [vfio](@ref rte_vfio.h)
 
 - **device specific**:
   [softnic](@ref rte_eth_softnic.h),
   [bond](@ref rte_eth_bond.h),
+  [bond 8023ad](@ref rte_eth_bond_8023ad.h),
   [vhost](@ref rte_vhost.h),
+  [vhost async](@ref rte_vhost_async.h),
+  [vhost crypto](@ref rte_vhost_crypto.h),
+  [eth vhost](@ref rte_eth_vhost.h),
   [vdpa](@ref rte_vdpa.h),
   [ixgbe](@ref rte_pmd_ixgbe.h),
   [i40e](@ref rte_pmd_i40e.h),
@@ -53,6 +71,7 @@ The public API headers are grouped by topics:
   [cnxk_crypto](@ref rte_pmd_cnxk_crypto.h),
   [cnxk_eventdev](@ref rte_pmd_cnxk_eventdev.h),
   [cnxk_mempool](@ref rte_pmd_cnxk_mempool.h),
+  [cnxk gpio](@ref rte_pmd_cnxk_gpio.h),
   [dpaa](@ref rte_pmd_dpaa.h),
   [dpaa2](@ref rte_pmd_dpaa2.h),
   [mlx5](@ref rte_pmd_mlx5.h),
@@ -60,12 +79,23 @@ The public API headers are grouped by topics:
   [dpaa2_cmdif](@ref rte_pmd_dpaa2_cmdif.h),
   [dpaax_qdma](@ref rte_pmd_dpaax_qdma.h),
   [crypto_scheduler](@ref rte_cryptodev_scheduler.h),
+  [crypto scheduler operations](@ref rte_cryptodev_scheduler_operations.h),
   [dlb2](@ref rte_pmd_dlb2.h),
-  [ifpga](@ref rte_pmd_ifpga.h)
+  [ifpga](@ref rte_pmd_ifpga.h),
+  [avp common](@ref rte_avp_common.h),
+  [avp fifo](@ref rte_avp_fifo.h),
+  [ntnic](@ref rte_pmd_ntnic.h),
+  [ring](@ref rte_eth_ring.h),
+  [txgbe](@ref rte_pmd_txgbe.h),
+  [ntb](@ref rte_pmd_ntb.h),
+  [acc cfg](@ref rte_acc_cfg.h),
+  [acc common cfg](@ref rte_acc_common_cfg.h),
+  [fpga 5gnr fec](@ref rte_pmd_fpga_5gnr_fec.h)
 
 - **memory**:
   [per-lcore](@ref rte_per_lcore.h),
   [lcore variables](@ref rte_lcore_var.h),
+  [EAL memconfig](@ref rte_eal_memconfig.h),
   [memseg](@ref rte_memory.h),
   [memzone](@ref rte_memzone.h),
   [mempool](@ref rte_mempool.h),
@@ -74,11 +104,14 @@ The public API headers are grouped by topics:
 
 - **timers**:
   [cycles](@ref rte_cycles.h),
+  [time](@ref rte_time.h),
   [timer](@ref rte_timer.h),
   [alarm](@ref rte_alarm.h)
 
 - **locks**:
   [atomic](@ref rte_atomic.h),
+  [stdatomic](@ref rte_stdatomic.h),
+  [lock annotations](@ref rte_lock_annotations.h),
   [mcslock](@ref rte_mcslock.h),
   [pflock](@ref rte_pflock.h),
   [rwlock](@ref rte_rwlock.h),
@@ -103,13 +136,18 @@ The public API headers are grouped by topics:
   [launch](@ref rte_launch.h),
   [lcore](@ref rte_lcore.h),
   [service cores](@ref rte_service.h),
+  [service component](@ref rte_service_component.h),
   [keepalive](@ref rte_keepalive.h),
   [power/freq](@ref rte_power_cpufreq.h),
   [power/uncore](@ref rte_power_uncore.h),
-  [PMD power](@ref rte_power_pmd_mgmt.h)
+  [PMD power](@ref rte_power_pmd_mgmt.h),
+  [power guest channel](@ref rte_power_guest_channel.h),
+  [power qos](@ref rte_power_qos.h)
 
 - **layers**:
   [ethernet](@ref rte_ether.h),
+  [net](@ref rte_net.h),
+  [net CRC](@ref rte_net_crc.h),
   [MACsec](@ref rte_macsec.h),
   [ARP](@ref rte_arp.h),
   [HIGIG](@ref rte_higig.h),
@@ -119,6 +157,7 @@ The public API headers are grouped by topics:
   [IPsec group](@ref rte_ipsec_group.h),
   [IPsec SA](@ref rte_ipsec_sa.h),
   [IPsec SAD](@ref rte_ipsec_sad.h),
+  [IP](@ref rte_ip.h),
   [IPv4](@ref rte_ip4.h),
   [IPv6](@ref rte_ip6.h),
   [frag/reass](@ref rte_ip_frag.h),
@@ -139,12 +178,15 @@ The public API headers are grouped by topics:
   [PDCP](@ref rte_pdcp.h),
   [L2TPv2](@ref rte_l2tpv2.h),
   [PPP](@ref rte_ppp.h),
-  [IB](@ref rte_ib.h)
+  [IB](@ref rte_ib.h),
+  [PTP](@ref rte_ptp.h)
 
 - **QoS**:
   [metering](@ref rte_meter.h),
   [scheduler](@ref rte_sched.h),
-  [RED congestion](@ref rte_red.h)
+  [sched common](@ref rte_sched_common.h),
+  [RED congestion](@ref rte_red.h),
+  [PIE](@ref rte_pie.h)
 
 - **routing**:
   [LPM IPv4 route](@ref rte_lpm.h),
@@ -168,18 +210,28 @@ The public API headers are grouped by topics:
   [distributor](@ref rte_distributor.h),
   [EFD](@ref rte_efd.h),
   [ACL](@ref rte_acl.h),
-  [member](@ref rte_member.h),
-  [BPF](@ref rte_bpf.h)
+  [ACL osdep](@ref rte_acl_osdep.h),
+  [member](@ref rte_member.h)
+  * BPF:
+    [load and execute](@ref rte_bpf.h),
+    [machine code](@ref bpf_def.h),
+    [port filters](@ref rte_bpf_ethdev.h),
+    [validate debug](@ref rte_bpf_validate_debug.h)
 
 - **containers**:
   [mbuf](@ref rte_mbuf.h),
+  [mbuf core](@ref rte_mbuf_core.h),
+  [mbuf ptype](@ref rte_mbuf_ptype.h),
+  [mbuf dyn](@ref rte_mbuf_dyn.h),
+  [mbuf history](@ref rte_mbuf_history.h),
   [mbuf pool ops](@ref rte_mbuf_pool_ops.h),
   [ring](@ref rte_ring.h),
   [soring](@ref rte_soring.h),
   [stack](@ref rte_stack.h),
   [tailq](@ref rte_tailq.h),
   [bitset](@ref rte_bitset.h),
-  [bitmap](@ref rte_bitmap.h)
+  [bitmap](@ref rte_bitmap.h),
+  [fbarray](@ref rte_fbarray.h)
 
 - **packet framework**:
   * [port](@ref rte_port.h):
@@ -188,21 +240,28 @@ The public API headers are grouped by topics:
     [frag](@ref rte_port_frag.h),
     [reass](@ref rte_port_ras.h),
     [sched](@ref rte_port_sched.h),
-    [src/sink](@ref rte_port_source_sink.h)
+    [src/sink](@ref rte_port_source_sink.h),
+    [fd](@ref rte_port_fd.h),
+    [sym crypto](@ref rte_port_sym_crypto.h),
+    [eventdev](@ref rte_port_eventdev.h)
   * [table](@ref rte_table.h):
     [lpm IPv4](@ref rte_table_lpm.h),
     [lpm IPv6](@ref rte_table_lpm_ipv6.h),
     [ACL](@ref rte_table_acl.h),
     [hash](@ref rte_table_hash.h),
     [array](@ref rte_table_array.h),
-    [stub](@ref rte_table_stub.h)
+    [stub](@ref rte_table_stub.h),
+    [LRU](@ref rte_lru.h),
+    [hash cuckoo](@ref rte_table_hash_cuckoo.h),
+    [hash func](@ref rte_table_hash_func.h)
   * [pipeline](@ref rte_pipeline.h)
     [port_in_action](@ref rte_port_in_action.h)
     [table_action](@ref rte_table_action.h)
   * SWX pipeline:
     [control](@ref rte_swx_ctl.h),
     [extern](@ref rte_swx_extern.h),
-    [pipeline](@ref rte_swx_pipeline.h)
+    [pipeline](@ref rte_swx_pipeline.h),
+    [IPsec](@ref rte_swx_ipsec.h)
   * SWX port:
     [port](@ref rte_swx_port.h),
     [ethdev](@ref rte_swx_port_ethdev.h),
@@ -211,8 +270,11 @@ The public API headers are grouped by topics:
     [src/sink](@ref rte_swx_port_source_sink.h)
   * SWX table:
     [table](@ref rte_swx_table.h),
-    [table_em](@ref rte_swx_table_em.h)
-    [table_wm](@ref rte_swx_table_wm.h)
+    [table_em](@ref rte_swx_table_em.h),
+    [table_wm](@ref rte_swx_table_wm.h),
+    [hash func](@ref rte_swx_hash_func.h),
+    [table learner](@ref rte_swx_table_learner.h),
+    [table selector](@ref rte_swx_table_selector.h)
   * [graph](@ref rte_graph.h):
     [graph_worker](@ref rte_graph_worker.h),
     [graph_feature_arc](@ref rte_graph_feature_arc.h),
@@ -222,7 +284,22 @@ The public API headers are grouped by topics:
     [ip4_node](@ref rte_node_ip4_api.h),
     [ip6_node](@ref rte_node_ip6_api.h),
     [udp4_input_node](@ref rte_node_udp4_input_api.h),
-    [mbuf_dynfield](@ref rte_node_mbuf_dynfield.h)
+    [mbuf_dynfield](@ref rte_node_mbuf_dynfield.h),
+    [pkt cls api](@ref rte_node_pkt_cls_api.h)
+
+- **cmdline**:
+  [cmdline](@ref cmdline.h),
+  [parse](@ref cmdline_parse.h),
+  [parse num](@ref cmdline_parse_num.h),
+  [parse bool](@ref cmdline_parse_bool.h),
+  [parse ipaddr](@ref cmdline_parse_ipaddr.h),
+  [parse etheraddr](@ref cmdline_parse_etheraddr.h),
+  [parse string](@ref cmdline_parse_string.h),
+  [parse portlist](@ref cmdline_parse_portlist.h),
+  [rdline](@ref cmdline_rdline.h),
+  [vt100](@ref cmdline_vt100.h),
+  [socket](@ref cmdline_socket.h),
+  [cirbuf](@ref cmdline_cirbuf.h)
 
 - **basic**:
   [bitops](@ref rte_bitops.h),
@@ -234,7 +311,9 @@ The public API headers are grouped by topics:
   [argument parsing](@ref rte_argparse.h),
   [ptr_compress](@ref rte_ptr_compress.h),
   [string](@ref rte_string_fns.h),
-  [thread](@ref rte_thread.h)
+  [thread](@ref rte_thread.h),
+  [reciprocal](@ref rte_reciprocal.h),
+  [UUID](@ref rte_uuid.h)
 
 - **debug**:
   [jobstats](@ref rte_jobstats.h),
@@ -251,7 +330,10 @@ The public API headers are grouped by topics:
 
 - **misc**:
   [EAL config](@ref rte_eal.h),
+  [class](@ref rte_class.h),
   [common](@ref rte_common.h),
+  [epoll](@ref rte_epoll.h),
+  [hypervisor](@ref rte_hypervisor.h),
   [experimental APIs](@ref rte_compat.h),
   [version](@ref rte_version.h)
 
-- 
2.43.0

