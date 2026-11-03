Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D1F606A327
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=JmNtsvaF
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C2BF9432EC;
	Tue,  3 Nov 2026 16:26:51 +0100 (CET)
Received: from mta0.migadu.com (out-145.mta0.migadu.com [91.218.175.145])
 by mails.dpdk.org (Postfix) with ESMTPS id AFEEF432EC
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:26:50 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=n+lgpa+UOH/kh/Fxp1IZwnIsx57csp/T9c4HW4xTcA4=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793719610; v=1; x=1794324410;
 b=JmNtsvaF8ZKvqilP5JzuxNHl30Ubta7cdZFuJa7BM8+a/SzBN6nTmFWEChi8S0+sEXVnNbCr
 NYF08vtqqa2fR3620v8TqMmZmTsAUpE0ZV1QrRL9tp2PvWWAeCBDhr/9iUX9zPtEX/WWxD2E2kY
 t9FtyzGreaqZqUTRFJBxgLKA=
X-Envelope-To: dev@dpdk.org
Received: by mta10.migadu.com with ESMTPS id 0b2a94dbf85f33c5;
 Tue, 03 Nov 2026 15:26:50 +0000
X-Mizu-Trace-ID: 0b2a94dbf85f33c5
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 214/227] examples/qos_sched: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:52:52 +0800
Message-ID: <20261103145306.487255-215-chengwen.feng@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261103145306.487255-1-chengwen.feng@linux.dev>
References: <20261103145306.487255-1-chengwen.feng@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Chengwen Feng <fengchengwen@huawei.com>

Rename socket_id parameters, local variables and comments to the
NUMA node terminology, and switch calls to the NUMA-named APIs.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 examples/qos_sched/args.c | 4 ++--
 examples/qos_sched/init.c | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/examples/qos_sched/args.c b/examples/qos_sched/args.c
index 04e2a0e03c..739cc5dab9 100644
--- a/examples/qos_sched/args.c
+++ b/examples/qos_sched/args.c
@@ -394,8 +394,8 @@ app_parse_args(int argc, char **argv)
 					qos_conf[i].wt_core);
 			return -1;
 		}
-		uint32_t rx_sock = rte_lcore_to_socket_id(qos_conf[i].rx_core);
-		uint32_t wt_sock = rte_lcore_to_socket_id(qos_conf[i].wt_core);
+		uint32_t rx_sock = rte_lcore_to_numa_id(qos_conf[i].rx_core);
+		uint32_t wt_sock = rte_lcore_to_numa_id(qos_conf[i].wt_core);
 		if (rx_sock != wt_sock) {
 			RTE_LOG(ERR, APP, "pfc %u: RX and WT must be on the same socket\n", i + 1);
 			return -1;
diff --git a/examples/qos_sched/init.c b/examples/qos_sched/init.c
index 9f4b2e0082..40dece4146 100644
--- a/examples/qos_sched/init.c
+++ b/examples/qos_sched/init.c
@@ -127,7 +127,7 @@ app_init_port(uint16_t portid, struct rte_mempool *mp)
 	fflush(stdout);
 	rx_conf.offloads = local_port_conf.rxmode.offloads;
 	ret = rte_eth_rx_queue_setup(portid, 0, (uint16_t)ring_conf.rx_size,
-		rte_eth_dev_socket_id(portid), &rx_conf, mp);
+		rte_eth_dev_numa_id(portid), &rx_conf, mp);
 	if (ret < 0)
 		rte_exit(EXIT_FAILURE,
 			 "rte_eth_tx_queue_setup: err=%d, port=%u\n",
@@ -137,7 +137,7 @@ app_init_port(uint16_t portid, struct rte_mempool *mp)
 	fflush(stdout);
 	tx_conf.offloads = local_port_conf.txmode.offloads;
 	ret = rte_eth_tx_queue_setup(portid, 0,
-		(uint16_t)ring_conf.tx_size, rte_eth_dev_socket_id(portid), &tx_conf);
+		(uint16_t)ring_conf.tx_size, rte_eth_dev_numa_id(portid), &tx_conf);
 	if (ret < 0)
 		rte_exit(EXIT_FAILURE,
 			 "rte_eth_tx_queue_setup: err=%d, port=%u queue=%d\n",
@@ -333,7 +333,7 @@ int app_init(void)
 
 	/* Initialize each active flow */
 	for(i = 0; i < nb_pfc; i++) {
-		uint32_t socket = rte_lcore_to_socket_id(qos_conf[i].rx_core);
+		uint32_t socket = rte_lcore_to_numa_id(qos_conf[i].rx_core);
 		struct rte_ring *ring;
 		struct rte_eth_link link;
 		int retry_count = 100, retry_delay = 100; /* try every 100ms for 10 sec */
@@ -360,7 +360,7 @@ int app_init(void)
 		qos_conf[i].mbuf_pool = rte_pktmbuf_pool_create(pool_name,
 			mp_size, burst_conf.rx_burst * 4, 0,
 			RTE_MBUF_DEFAULT_BUF_SIZE,
-			rte_eth_dev_socket_id(qos_conf[i].rx_port));
+			rte_eth_dev_numa_id(qos_conf[i].rx_port));
 		if (qos_conf[i].mbuf_pool == NULL)
 			rte_exit(EXIT_FAILURE, "Cannot init mbuf pool for socket %u\n", i);
 
-- 
2.55.0

