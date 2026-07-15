Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD82EC44501
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Jul 2026 09:22:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A3321402D3;
	Wed, 15 Jul 2026 11:22:34 +0200 (CEST)
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com
 [113.46.200.225])
 by mails.dpdk.org (Postfix) with ESMTP id 8B25D4028B
 for <dev@dpdk.org>; Wed, 15 Jul 2026 11:22:32 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=3o+v60c8kIrSM6ST3tRAsfPx+BcOUdGXB9zsaOEFuMk=;
 b=tKEq2qUF2g1wfPDQjt/zrq2bixPD3KXRkfotFnxrdeK92qWMUQScgNB0IZ2iJljVK6MZt+iDm
 KcrhvVnT4cMhZ9DKtcU2j+iCBF5drlSHO1oUX0Drr30ZWPI/vbzKZ9eDFRH85kG94YbTPzX3FFI
 zLx7VkV3xFKTiLkv8wFChPs=
Received: from mail.maildlp.com (unknown [172.19.163.15])
 by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4h0Vp11G4Qz1K96g;
 Wed, 15 Jul 2026 17:13:13 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
 by mail.maildlp.com (Postfix) with ESMTPS id 49CB840578;
 Wed, 15 Jul 2026 17:22:30 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 15 Jul 2026 17:22:29 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <thomas@monjalon.net>, <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: [PATCH] examples/l3fwd: dynamic NUMA-aware alloc lcore_conf
Date: Wed, 15 Jul 2026 17:22:24 +0800
Message-ID: <20260715092224.52594-1-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260623032301.17570-1-fengchengwen@huawei.com>
References: <20260623032301.17570-1-fengchengwen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemo500009.china.huawei.com (7.202.194.199)
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

Currently lcore_conf is a global static array. When multiple
ports/lcores are distributed across different NUMA nodes, datapath
suffers from severe cross-NUMA memory access penalty.

On Kunpeng platform, sizeof(struct lcore_conf) reaches 133760 bytes.
Such a huge per-lcore structure significantly amplifies cross-NUMA
overhead in multi-port multi-NUMA deployment scenarios.

This commit refactors lcore_conf to pointer array and implements
per-lcore NUMA-aware hugepage allocation, allocating each lcore's
configuration on its local socket to eliminate remote memory access.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>

---
v3: Fix Thomas' comment: support no-numa parameter
v2: Fix AI review comment: add cleanup when init lcore-conf fail

---
 examples/l3fwd/l3fwd.h     |  2 +-
 examples/l3fwd/l3fwd_acl.c |  2 +-
 examples/l3fwd/l3fwd_em.c  |  8 +++---
 examples/l3fwd/l3fwd_fib.c |  6 ++---
 examples/l3fwd/l3fwd_lpm.c |  8 +++---
 examples/l3fwd/main.c      | 52 +++++++++++++++++++++++++++++++-------
 6 files changed, 56 insertions(+), 22 deletions(-)

diff --git a/examples/l3fwd/l3fwd.h b/examples/l3fwd/l3fwd.h
index 349fc37c79..20c457ee7f 100644
--- a/examples/l3fwd/l3fwd.h
+++ b/examples/l3fwd/l3fwd.h
@@ -104,7 +104,7 @@ extern uint32_t hash_entry_number;
 
 extern xmm_t val_eth[RTE_MAX_ETHPORTS];
 
-extern struct lcore_conf lcore_conf[RTE_MAX_LCORE];
+extern struct lcore_conf *lcore_conf[RTE_MAX_LCORE];
 
 extern struct parm_cfg parm_config;
 
diff --git a/examples/l3fwd/l3fwd_acl.c b/examples/l3fwd/l3fwd_acl.c
index 4ee3411d2a..0605f6feb9 100644
--- a/examples/l3fwd/l3fwd_acl.c
+++ b/examples/l3fwd/l3fwd_acl.c
@@ -1090,7 +1090,7 @@ acl_main_loop(__rte_unused void *dummy)
 
 	prev_tsc = 0;
 	lcore_id = rte_lcore_id();
-	qconf = &lcore_conf[lcore_id];
+	qconf = lcore_conf[lcore_id];
 	socketid = rte_lcore_to_socket_id(lcore_id);
 
 	if (qconf->n_rx_queue == 0) {
diff --git a/examples/l3fwd/l3fwd_em.c b/examples/l3fwd/l3fwd_em.c
index d8748a0edd..9aa23759d3 100644
--- a/examples/l3fwd/l3fwd_em.c
+++ b/examples/l3fwd/l3fwd_em.c
@@ -597,7 +597,7 @@ em_main_loop(__rte_unused void *dummy)
 		US_PER_S * BURST_TX_DRAIN_US;
 
 	lcore_id = rte_lcore_id();
-	qconf = &lcore_conf[lcore_id];
+	qconf = lcore_conf[lcore_id];
 
 	const uint16_t n_rx_q = qconf->n_rx_queue;
 	const uint16_t n_tx_p = qconf->n_tx_port;
@@ -685,7 +685,7 @@ em_event_loop_single(struct l3fwd_event_resources *evt_rsrc,
 		return;
 
 	lcore_id = rte_lcore_id();
-	lconf = &lcore_conf[lcore_id];
+	lconf = lcore_conf[lcore_id];
 
 	RTE_LOG(INFO, L3FWD, "entering %s on lcore %u\n", __func__, lcore_id);
 	while (!force_quit) {
@@ -747,7 +747,7 @@ em_event_loop_burst(struct l3fwd_event_resources *evt_rsrc,
 
 	lcore_id = rte_lcore_id();
 
-	lconf = &lcore_conf[lcore_id];
+	lconf = lcore_conf[lcore_id];
 
 	RTE_LOG(INFO, L3FWD, "entering %s on lcore %u\n", __func__, lcore_id);
 
@@ -877,7 +877,7 @@ em_event_loop_vector(struct l3fwd_event_resources *evt_rsrc,
 	if (dst_ports == NULL)
 		return;
 	lcore_id = rte_lcore_id();
-	lconf = &lcore_conf[lcore_id];
+	lconf = lcore_conf[lcore_id];
 
 	RTE_LOG(INFO, L3FWD, "entering %s on lcore %u\n", __func__, lcore_id);
 
diff --git a/examples/l3fwd/l3fwd_fib.c b/examples/l3fwd/l3fwd_fib.c
index 4fc6bf90d5..32c8847130 100644
--- a/examples/l3fwd/l3fwd_fib.c
+++ b/examples/l3fwd/l3fwd_fib.c
@@ -192,7 +192,7 @@ fib_main_loop(__rte_unused void *dummy)
 			US_PER_S * BURST_TX_DRAIN_US;
 
 	lcore_id = rte_lcore_id();
-	qconf = &lcore_conf[lcore_id];
+	qconf = lcore_conf[lcore_id];
 
 	const uint16_t n_rx_q = qconf->n_rx_queue;
 	const uint16_t n_tx_p = qconf->n_tx_port;
@@ -282,7 +282,7 @@ fib_event_loop(struct l3fwd_event_resources *evt_rsrc,
 
 	lcore_id = rte_lcore_id();
 
-	lconf = &lcore_conf[lcore_id];
+	lconf = lcore_conf[lcore_id];
 
 	RTE_LOG(INFO, L3FWD, "entering %s on lcore %u\n", __func__, lcore_id);
 
@@ -446,7 +446,7 @@ fib_process_event_vector(struct rte_event_vector *vec, uint8_t *type_arr,
 	uint16_t nh;
 	int i;
 
-	lconf = &lcore_conf[rte_lcore_id()];
+	lconf = lcore_conf[rte_lcore_id()];
 
 	/* Reset counters. */
 	ipv4_cnt = 0;
diff --git a/examples/l3fwd/l3fwd_lpm.c b/examples/l3fwd/l3fwd_lpm.c
index 2d2651e750..77701503f7 100644
--- a/examples/l3fwd/l3fwd_lpm.c
+++ b/examples/l3fwd/l3fwd_lpm.c
@@ -154,7 +154,7 @@ lpm_main_loop(__rte_unused void *dummy)
 		US_PER_S * BURST_TX_DRAIN_US;
 
 	lcore_id = rte_lcore_id();
-	qconf = &lcore_conf[lcore_id];
+	qconf = lcore_conf[lcore_id];
 
 	const uint16_t n_rx_q = qconf->n_rx_queue;
 	const uint16_t n_tx_p = qconf->n_tx_port;
@@ -270,7 +270,7 @@ lpm_event_loop_single(struct l3fwd_event_resources *evt_rsrc,
 		return;
 
 	lcore_id = rte_lcore_id();
-	lconf = &lcore_conf[lcore_id];
+	lconf = lcore_conf[lcore_id];
 
 	RTE_LOG(INFO, L3FWD, "entering %s on lcore %u\n", __func__, lcore_id);
 	while (!force_quit) {
@@ -324,7 +324,7 @@ lpm_event_loop_burst(struct l3fwd_event_resources *evt_rsrc,
 
 	lcore_id = rte_lcore_id();
 
-	lconf = &lcore_conf[lcore_id];
+	lconf = lcore_conf[lcore_id];
 
 	RTE_LOG(INFO, L3FWD, "entering %s on lcore %u\n", __func__, lcore_id);
 
@@ -468,7 +468,7 @@ lpm_event_loop_vector(struct l3fwd_event_resources *evt_rsrc,
 		return;
 
 	lcore_id = rte_lcore_id();
-	lconf = &lcore_conf[lcore_id];
+	lconf = lcore_conf[lcore_id];
 	dst_port_list =
 		rte_zmalloc("", sizeof(uint16_t) * evt_rsrc->vector_size,
 			    RTE_CACHE_LINE_SIZE);
diff --git a/examples/l3fwd/main.c b/examples/l3fwd/main.c
index 6866811526..b1ad0af8cb 100644
--- a/examples/l3fwd/main.c
+++ b/examples/l3fwd/main.c
@@ -95,7 +95,7 @@ uint32_t enabled_port_mask;
 /* Used only in exact match mode. */
 bool ipv6_enabled; /**< ipv6 is false by default. */
 
-struct lcore_conf lcore_conf[RTE_MAX_LCORE];
+struct lcore_conf *lcore_conf[RTE_MAX_LCORE];
 
 struct parm_cfg parm_config;
 
@@ -367,17 +367,17 @@ init_lcore_rx_queues(void)
 
 	for (i = 0; i < nb_lcore_params; ++i) {
 		lcore = lcore_params[i].lcore_id;
-		nb_rx_queue = lcore_conf[lcore].n_rx_queue;
+		nb_rx_queue = lcore_conf[lcore]->n_rx_queue;
 		if (nb_rx_queue >= MAX_RX_QUEUE_PER_LCORE) {
 			printf("error: too many queues (%u) for lcore: %u\n",
 				(unsigned int)nb_rx_queue + 1, lcore);
 			return -1;
 		} else {
-			lcore_conf[lcore].rx_queue_list[nb_rx_queue].port_id =
+			lcore_conf[lcore]->rx_queue_list[nb_rx_queue].port_id =
 				lcore_params[i].port_id;
-			lcore_conf[lcore].rx_queue_list[nb_rx_queue].queue_id =
+			lcore_conf[lcore]->rx_queue_list[nb_rx_queue].queue_id =
 				lcore_params[i].queue_id;
-			lcore_conf[lcore].n_rx_queue++;
+			lcore_conf[lcore]->n_rx_queue++;
 		}
 	}
 	return 0;
@@ -1117,6 +1117,36 @@ print_ethaddr(const char *name, const struct rte_ether_addr *eth_addr)
 	printf("%s%s", name, buf);
 }
 
+static int
+init_lcore_conf(void)
+{
+	unsigned int lcore_id;
+	int socketid;
+
+	for (lcore_id = 0; lcore_id < RTE_MAX_LCORE; lcore_id++) {
+		if (rte_lcore_is_enabled(lcore_id) == 0)
+			continue;
+
+		socketid = numa_on ? rte_lcore_to_socket_id(lcore_id) : 0;
+		lcore_conf[lcore_id] = rte_zmalloc_socket(NULL, sizeof(struct lcore_conf),
+							  RTE_CACHE_LINE_SIZE, socketid);
+		if (lcore_conf[lcore_id] == NULL)
+			goto cleanup;
+	}
+
+	return 0;
+
+cleanup:
+	for (lcore_id = 0; lcore_id < RTE_MAX_LCORE; lcore_id++) {
+		if (lcore_conf[lcore_id] != NULL) {
+			rte_free(lcore_conf[lcore_id]);
+			lcore_conf[lcore_id] = NULL;
+		}
+	}
+
+	return -ENOMEM;
+}
+
 int
 init_mem(uint16_t portid, unsigned int nb_mbuf)
 {
@@ -1188,7 +1218,7 @@ init_mem(uint16_t portid, unsigned int nb_mbuf)
 		}
 #endif
 
-		qconf = &lcore_conf[lcore_id];
+		qconf = lcore_conf[lcore_id];
 		qconf->ipv4_lookup_struct =
 			l3fwd_lkp.get_ipv4_lookup_struct(socketid);
 		qconf->ipv6_lookup_struct =
@@ -1489,7 +1519,7 @@ l3fwd_poll_resource_setup(void)
 					"rte_eth_tx_queue_setup: err=%d, "
 					"port=%d\n", ret, portid);
 
-			qconf = &lcore_conf[lcore_id];
+			qconf = lcore_conf[lcore_id];
 			qconf->tx_queue_id[portid] = queueid;
 			queueid++;
 
@@ -1502,7 +1532,7 @@ l3fwd_poll_resource_setup(void)
 	for (lcore_id = 0; lcore_id < RTE_MAX_LCORE; lcore_id++) {
 		if (rte_lcore_is_enabled(lcore_id) == 0)
 			continue;
-		qconf = &lcore_conf[lcore_id];
+		qconf = lcore_conf[lcore_id];
 		printf("\nInitializing rx queues on lcore %u ... ", lcore_id );
 		fflush(stdout);
 		/* init RX queues */
@@ -1683,6 +1713,10 @@ main(int argc, char **argv)
 	if (ret < 0)
 		rte_exit(EXIT_FAILURE, "Invalid L3FWD parameters\n");
 
+	ret = init_lcore_conf();
+	if (ret)
+		rte_exit(EXIT_FAILURE, "Init lcore conf failed!\n");
+
 	RTE_LOG(INFO, L3FWD, "Using Rx burst %u Tx burst %u\n", rx_burst_size, tx_burst_size);
 
 	/* Setup function pointers for lookup method. */
@@ -1746,7 +1780,7 @@ main(int argc, char **argv)
 	for (lcore_id = 0; lcore_id < RTE_MAX_LCORE; lcore_id++) {
 		if (rte_lcore_is_enabled(lcore_id) == 0)
 			continue;
-		qconf = &lcore_conf[lcore_id];
+		qconf = lcore_conf[lcore_id];
 		for (queue = 0; queue < qconf->n_rx_queue; ++queue) {
 			portid = qconf->rx_queue_list[queue].port_id;
 			queueid = qconf->rx_queue_list[queue].queue_id;
-- 
2.17.1

