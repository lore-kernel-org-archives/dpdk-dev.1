Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE8B606A326
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=n4Uvbitu
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E8B59432DA;
	Tue,  3 Nov 2026 16:26:46 +0100 (CET)
Received: from mta0.migadu.com (out-143.mta0.migadu.com [91.218.175.143])
 by mails.dpdk.org (Postfix) with ESMTPS id 5DAF1432DA
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:26:45 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=F7y2UDIKmPhDrPSxPsHzyJ5Eg4yEL0+niJIWdP2dRVU=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793719605; v=1; x=1794324405;
 b=n4UvbituwEEjixGEMArDsV4mG4JLPKXbRUi+S0swyfhNJVW4JOUu/WL9FA1dwuCGtjl8spjS
 IwDKcvlmvjyVOPo/txZeijjf3ZngoBjI1AvS1PLFx5mz74LWjM9x2XRPEd331VmQ27laXV+M7fj
 86PSx2dA9AIAZo/ua/kdj13g=
X-Envelope-To: dev@dpdk.org
Received: by mta11.migadu.com with ESMTPS id 523c83dcd300bb48;
 Tue, 03 Nov 2026 15:26:45 +0000
X-Mizu-Trace-ID: 523c83dcd300bb48
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 213/227] examples/qos_meter: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:52:51 +0800
Message-ID: <20261103145306.487255-214-chengwen.feng@linux.dev>
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
 examples/qos_meter/main.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/examples/qos_meter/main.c b/examples/qos_meter/main.c
index 59759355cd..efe6d3b63c 100644
--- a/examples/qos_meter/main.c
+++ b/examples/qos_meter/main.c
@@ -319,7 +319,7 @@ main(int argc, char **argv)
 
 	/* Buffer pool init */
 	pool = rte_pktmbuf_pool_create("pool", NB_MBUF, MEMPOOL_CACHE_SIZE,
-		0, RTE_MBUF_DEFAULT_BUF_SIZE, rte_socket_id());
+		0, RTE_MBUF_DEFAULT_BUF_SIZE, rte_numa_id());
 	if (pool == NULL)
 		rte_exit(EXIT_FAILURE, "Buffer pool creation error\n");
 
@@ -359,7 +359,7 @@ main(int argc, char **argv)
 	rxq_conf = dev_info.default_rxconf;
 	rxq_conf.offloads = conf.rxmode.offloads;
 	ret = rte_eth_rx_queue_setup(port_rx, NIC_RX_QUEUE, nb_rxd,
-				rte_eth_dev_socket_id(port_rx),
+				rte_eth_dev_numa_id(port_rx),
 				&rxq_conf, pool);
 	if (ret < 0)
 		rte_exit(EXIT_FAILURE, "Port %d RX queue setup error (%d)\n", port_rx, ret);
@@ -367,7 +367,7 @@ main(int argc, char **argv)
 	txq_conf = dev_info.default_txconf;
 	txq_conf.offloads = conf.txmode.offloads;
 	ret = rte_eth_tx_queue_setup(port_rx, NIC_TX_QUEUE, nb_txd,
-				rte_eth_dev_socket_id(port_rx),
+				rte_eth_dev_numa_id(port_rx),
 				&txq_conf);
 	if (ret < 0)
 	rte_exit(EXIT_FAILURE, "Port %d TX queue setup error (%d)\n", port_rx, ret);
@@ -409,7 +409,7 @@ main(int argc, char **argv)
 	rxq_conf = dev_info.default_rxconf;
 	rxq_conf.offloads = conf.rxmode.offloads;
 	ret = rte_eth_rx_queue_setup(port_tx, NIC_RX_QUEUE, nb_rxd,
-				rte_eth_dev_socket_id(port_tx),
+				rte_eth_dev_numa_id(port_tx),
 				NULL, pool);
 	if (ret < 0)
 		rte_exit(EXIT_FAILURE, "Port %d RX queue setup error (%d)\n", port_tx, ret);
@@ -417,14 +417,14 @@ main(int argc, char **argv)
 	txq_conf = dev_info.default_txconf;
 	txq_conf.offloads = conf.txmode.offloads;
 	ret = rte_eth_tx_queue_setup(port_tx, NIC_TX_QUEUE, nb_txd,
-				rte_eth_dev_socket_id(port_tx),
+				rte_eth_dev_numa_id(port_tx),
 				NULL);
 	if (ret < 0)
 		rte_exit(EXIT_FAILURE, "Port %d TX queue setup error (%d)\n", port_tx, ret);
 
-	tx_buffer = rte_zmalloc_socket("tx_buffer",
+	tx_buffer = rte_zmalloc_numa("tx_buffer",
 			RTE_ETH_TX_BUFFER_SIZE(RTE_MBUF_F_TX_BURST_MAX), 0,
-			rte_eth_dev_socket_id(port_tx));
+			rte_eth_dev_numa_id(port_tx));
 	if (tx_buffer == NULL)
 		rte_exit(EXIT_FAILURE, "Port %d TX buffer allocation error\n",
 				port_tx);
-- 
2.55.0

