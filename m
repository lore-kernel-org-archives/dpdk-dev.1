Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE9CCD4855
	for <dpdk-dev@archiver.kernel.org>; Tue, 12 May 2026 09:23:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 35D304065A;
	Tue, 12 May 2026 11:23:15 +0200 (CEST)
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com
 [113.46.200.216])
 by mails.dpdk.org (Postfix) with ESMTP id 75AFB402C1
 for <dev@dpdk.org>; Tue, 12 May 2026 11:23:11 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=0UWZyf1Q/174RRdZSVcQeErKUiyKC+sgM92F2yCUYhI=;
 b=GKnskALSyCp+uz5OtbPiGSNncBpIylIN1T+ZjwJA/1ejIxMSH7mQ1aLADkfg4lOg5uh8zjxHg
 AbdMAMsAI+dKpqG2dnIlXZUQDf+E5mXMX7wJxyv8qK2pSRTwOIfp8synACQEmVEsDFEMX6L4qxQ
 OSAJV/Ps397dAS1w0UHDssM=
Received: from mail.maildlp.com (unknown [172.19.163.104])
 by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4gF9tB0NlXz1T4G7;
 Tue, 12 May 2026 17:15:30 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 0004A4056A;
 Tue, 12 May 2026 17:23:09 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 12 May 2026 17:23:09 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <thomas@monjalon.net>, <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <wathsala.vithanage@arm.com>, <liuyonglong@huawei.com>
Subject: [PATCH v2 4/4] app/testpmd: add TPH stash objects configuration
Date: Tue, 12 May 2026 17:23:02 +0800
Message-ID: <20260512092302.23735-5-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260512092302.23735-1-fengchengwen@huawei.com>
References: <20260508092855.51987-1-fengchengwen@huawei.com>
 <20260512092302.23735-1-fengchengwen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk500009.china.huawei.com (7.202.194.94)
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

Add --tph-stash-objects command line option to configure PCIe TPH cache
stash objects for Rx queues. Implement enable/disable logic during
packet forwarding start/stop with device capability checks.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 app/test-pmd/parameters.c | 20 ++++++++++
 app/test-pmd/testpmd.c    | 81 +++++++++++++++++++++++++++++++++++++++
 app/test-pmd/testpmd.h    |  1 +
 3 files changed, 102 insertions(+)

diff --git a/app/test-pmd/parameters.c b/app/test-pmd/parameters.c
index ecbd618f00..ae31d9ba4c 100644
--- a/app/test-pmd/parameters.c
+++ b/app/test-pmd/parameters.c
@@ -79,6 +79,8 @@ enum {
 	TESTPMD_OPT_NO_NUMA_NUM,
 #define TESTPMD_OPT_MP_ANON "mp-anon"
 	TESTPMD_OPT_MP_ANON_NUM,
+#define TESTPMD_OPT_TPH_STASH_OBJECTS "tph-stash-objects"
+	TESTPMD_OPT_TPH_STASH_OBJECTS_NUM,
 #define TESTPMD_OPT_PORT_NUMA_CONFIG "port-numa-config"
 	TESTPMD_OPT_PORT_NUMA_CONFIG_NUM,
 #define TESTPMD_OPT_RING_NUMA_CONFIG "ring-numa-config"
@@ -289,6 +291,7 @@ static const struct option long_options[] = {
 	NO_ARG(TESTPMD_OPT_NUMA),
 	NO_ARG(TESTPMD_OPT_NO_NUMA),
 	NO_ARG(TESTPMD_OPT_MP_ANON), /* deprecated */
+	REQUIRED_ARG(TESTPMD_OPT_TPH_STASH_OBJECTS),
 	REQUIRED_ARG(TESTPMD_OPT_PORT_NUMA_CONFIG),
 	REQUIRED_ARG(TESTPMD_OPT_RING_NUMA_CONFIG),
 	REQUIRED_ARG(TESTPMD_OPT_SOCKET_NUM),
@@ -1140,6 +1143,23 @@ launch_args_parse(int argc, char** argv)
 					"native, anon, xmem or xmemhuge\n",
 					optarg);
 			break;
+		case TESTPMD_OPT_TPH_STASH_OBJECTS_NUM:
+			if (!strcmp(optarg, "rxdesc"))
+				tph_stash_objects = RTE_ETH_CACHE_STASH_OBJ_RX_DESC;
+			else if (!strcmp(optarg, "rxheader"))
+				tph_stash_objects = RTE_ETH_CACHE_STASH_OBJ_RX_HEADER;
+			else if (!strcmp(optarg, "rxpayload"))
+				tph_stash_objects = RTE_ETH_CACHE_STASH_OBJ_RX_PAYLOAD;
+			else if (!strcmp(optarg, "rxdata"))
+				tph_stash_objects = RTE_ETH_CACHE_STASH_OBJ_RX_HEADER |
+						    RTE_ETH_CACHE_STASH_OBJ_RX_PAYLOAD;
+			else if (!strcmp(optarg, "rxall"))
+				tph_stash_objects = RTE_ETH_CACHE_STASH_OBJ_RX_DESC |
+						    RTE_ETH_CACHE_STASH_OBJ_RX_HEADER |
+						    RTE_ETH_CACHE_STASH_OBJ_RX_PAYLOAD;
+			else
+				rte_exit(EXIT_FAILURE, "unknown tph stash mode %s\n", optarg);
+			break;
 		case TESTPMD_OPT_PORT_NUMA_CONFIG_NUM:
 			if (parse_portnuma_config(optarg))
 				rte_exit(EXIT_FAILURE,
diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
index e2569d9e30..6f94dd3b76 100644
--- a/app/test-pmd/testpmd.c
+++ b/app/test-pmd/testpmd.c
@@ -136,6 +136,11 @@ uint8_t socket_num = UMA_NO_CONFIG;
  */
 uint8_t mp_alloc_type = MP_ALLOC_NATIVE;
 
+/*
+ * PCIE TPH stash objects.
+ */
+uint64_t tph_stash_objects;
+
 /*
  * Store specified sockets on which memory pool to be used by ports
  * is allocated.
@@ -2540,6 +2545,77 @@ update_queue_state(portid_t pid)
 	}
 }
 
+static void
+start_tph_stash(void)
+{
+	struct rte_eth_cache_stash_capability capa;
+	struct rte_eth_cache_stash_config config;
+	struct fwd_config *cfg = &cur_fwd_config;
+	struct fwd_stream *fs;
+	lcoreid_t  lc_id;
+	streamid_t sm_id;
+	portid_t pt_id;
+	int ret;
+	int i;
+
+	for (i = 0; i < cur_fwd_config.nb_fwd_ports; i++) {
+		pt_id = fwd_ports_ids[i];
+		ret = rte_eth_cache_stash_get(pt_id, &capa);
+		if (ret != 0 || (capa.supported_types & RTE_ETH_CACHE_STASH_TYPE_TPH) == 0) {
+			fprintf(stderr,	"%s: (port %u) don't support tph stash!\n",
+				__func__, pt_id);
+			return;
+		}
+		if ((capa.supported_objects & tph_stash_objects) != tph_stash_objects) {
+			fprintf(stderr, "%s: (port %u) don't support objects=0x%"PRIx64" 0x%"PRIx64"\n",
+				__func__, pt_id, tph_stash_objects, capa.supported_objects);
+			return;
+		}
+		memset(&config, 0, sizeof(config));
+		config.dev.type = RTE_ETH_CACHE_STASH_TYPE_TPH;
+		ret = rte_eth_cache_stash_set(pt_id, RTE_ETH_CACHE_STASH_OP_DEV_ENABLE, &config);
+		if (ret != 0) {
+			fprintf(stderr, "%s: (port %u) enable tph failed! ret=%d\n",
+				__func__, pt_id, ret);
+			return;
+		}
+	}
+
+	for (lc_id = 0; lc_id < cfg->nb_fwd_lcores; lc_id++) {
+		for (sm_id = 0; sm_id < fwd_lcores[lc_id]->stream_nb; sm_id++) {
+			fs = fwd_streams[fwd_lcores[lc_id]->stream_idx + sm_id];
+			memset(&config, 0, sizeof(config));
+			config.queue.lcore_id = fwd_lcores_cpuids[lc_id];
+			config.queue.queue_id = fs->rx_queue;
+			config.queue.objects = tph_stash_objects;
+			ret = rte_eth_cache_stash_set(fs->rx_port,
+				RTE_ETH_CACHE_STASH_OP_QUEUE_ENABLE, &config);
+			if (ret != 0)
+				fprintf(stderr, "%s: (port %u) enable rx-queue=%u cpu=%u stash ret=%d\n",
+					__func__, fs->rx_port, fs->rx_queue,
+					fwd_lcores_cpuids[lc_id], ret);
+		}
+	}
+}
+
+static void
+stop_tph_stash(void)
+{
+	struct rte_eth_cache_stash_config config;
+	portid_t pt_id;
+	int ret;
+	int i;
+
+	for (i = 0; i < cur_fwd_config.nb_fwd_ports; i++) {
+		pt_id = fwd_ports_ids[i];
+		memset(&config, 0, sizeof(config));
+		ret = rte_eth_cache_stash_set(pt_id, RTE_ETH_CACHE_STASH_OP_DEV_DISABLE, &config);
+		if (ret != 0)
+			fprintf(stderr, "%s: (port %u) disable tph stash ret=%d\n",
+				__func__, pt_id, ret);
+	}
+}
+
 /*
  * Launch packet forwarding configuration.
  */
@@ -2614,6 +2690,9 @@ start_packet_forwarding(int with_tx_first)
 	if(!no_flush_rx)
 		flush_fwd_rx_queues();
 
+	if (tph_stash_objects > 0)
+		start_tph_stash();
+
 	rxtx_config_display();
 
 	fwd_stats_reset();
@@ -2649,6 +2728,8 @@ stop_packet_forwarding(void)
 		fwd_lcores[lc_id]->stopped = 1;
 	printf("\nWaiting for lcores to finish...\n");
 	rte_eal_mp_wait_lcore();
+	if (tph_stash_objects > 0)
+		stop_tph_stash();
 	port_fwd_end = cur_fwd_config.fwd_eng->port_fwd_end;
 	if (port_fwd_end != NULL) {
 		for (i = 0; i < cur_fwd_config.nb_fwd_ports; i++) {
diff --git a/app/test-pmd/testpmd.h b/app/test-pmd/testpmd.h
index 9b60ebd7fc..4124d40fda 100644
--- a/app/test-pmd/testpmd.h
+++ b/app/test-pmd/testpmd.h
@@ -535,6 +535,7 @@ extern uint8_t flow_isolate_all; /**< set by "--flow-isolate-all */
 extern uint8_t no_flow_flush; /**< set by "--disable-flow-flush" parameter */
 extern uint8_t  mp_alloc_type;
 /**< set by "--mp-anon" or "--mp-alloc" parameter */
+extern uint64_t tph_stash_objects; /**< set by "--tph-stash-objects" parameter */
 extern uint32_t eth_link_speed;
 extern uint8_t no_link_check; /**<set by "--disable-link-check" parameter */
 extern uint8_t no_device_start; /**<set by "--disable-device-start" parameter */
-- 
2.17.1

