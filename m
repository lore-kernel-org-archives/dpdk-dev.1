Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08914606A7A0
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=H7pJXJwO
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D912343009;
	Tue,  3 Nov 2026 16:23:01 +0100 (CET)
Received: from mta0.migadu.com (out-41.mta0.migadu.com [91.218.175.41])
 by mails.dpdk.org (Postfix) with ESMTPS id 99D2343007
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:23:00 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=kNa6IF1TEqwKFyL+O2UerH23TWGn5+XXX8j9VPmGf2Q=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793719380; v=1; x=1794324180;
 b=H7pJXJwOJikhknmhVcEr8eR8S956muhuh9i7g/ZxMrgx/ou+F/fEUZGteh7Dsg49gKIpikB2
 FS8s5VU+HohWa+Zm9YkBxXw3oc3UGiJY4BtbdvpyO1H07T5ezLEVj1B7Kxl22dAlQ4q5qBYNUuH
 Gx0LKeX7zdYJvM1LO/dNZaLQ=
X-Envelope-To: dev@dpdk.org
Received: by mta11.migadu.com with ESMTPS id 246343ebb3842b8d;
 Tue, 03 Nov 2026 15:23:00 +0000
X-Mizu-Trace-ID: 246343ebb3842b8d
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 189/227] examples/eventdev_pipeline: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:52:27 +0800
Message-ID: <20261103145306.487255-190-chengwen.feng@linux.dev>
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
 examples/eventdev_pipeline/pipeline_worker_generic.c | 6 +++---
 examples/eventdev_pipeline/pipeline_worker_tx.c      | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/examples/eventdev_pipeline/pipeline_worker_generic.c b/examples/eventdev_pipeline/pipeline_worker_generic.c
index 77d9d91043..47669bf66c 100644
--- a/examples/eventdev_pipeline/pipeline_worker_generic.c
+++ b/examples/eventdev_pipeline/pipeline_worker_generic.c
@@ -357,7 +357,7 @@ port_init(uint8_t port, struct rte_mempool *mbuf_pool)
 	/* Allocate and set up 1 RX queue per Ethernet port. */
 	for (q = 0; q < rx_rings; q++) {
 		retval = rte_eth_rx_queue_setup(port, q, rx_ring_size,
-				rte_eth_dev_socket_id(port), &rx_conf,
+				rte_eth_dev_numa_id(port), &rx_conf,
 				mbuf_pool);
 		if (retval < 0)
 			return retval;
@@ -368,7 +368,7 @@ port_init(uint8_t port, struct rte_mempool *mbuf_pool)
 	/* Allocate and set up 1 TX queue per Ethernet port. */
 	for (q = 0; q < tx_rings; q++) {
 		retval = rte_eth_tx_queue_setup(port, q, tx_ring_size,
-				rte_eth_dev_socket_id(port), &txconf);
+				rte_eth_dev_numa_id(port), &txconf);
 		if (retval < 0)
 			return retval;
 	}
@@ -407,7 +407,7 @@ init_ports(uint16_t num_ports)
 			/* cache_size */ 512,
 			/* priv_size*/ 0,
 			/* data_room_size */ RTE_MBUF_DEFAULT_BUF_SIZE,
-			rte_socket_id());
+			rte_numa_id());
 
 	RTE_ETH_FOREACH_DEV(portid)
 		if (port_init(portid, mp) != 0)
diff --git a/examples/eventdev_pipeline/pipeline_worker_tx.c b/examples/eventdev_pipeline/pipeline_worker_tx.c
index 174976a1b5..fae9481f56 100644
--- a/examples/eventdev_pipeline/pipeline_worker_tx.c
+++ b/examples/eventdev_pipeline/pipeline_worker_tx.c
@@ -702,7 +702,7 @@ port_init(uint8_t port, struct rte_mempool *mbuf_pool)
 	/* Allocate and set up 1 RX queue per Ethernet port. */
 	for (q = 0; q < rx_rings; q++) {
 		retval = rte_eth_rx_queue_setup(port, q, rx_ring_size,
-				rte_eth_dev_socket_id(port), &rx_conf,
+				rte_eth_dev_numa_id(port), &rx_conf,
 				mbuf_pool);
 		if (retval < 0)
 			return retval;
@@ -713,7 +713,7 @@ port_init(uint8_t port, struct rte_mempool *mbuf_pool)
 	/* Allocate and set up 1 TX queue per Ethernet port. */
 	for (q = 0; q < tx_rings; q++) {
 		retval = rte_eth_tx_queue_setup(port, q, tx_ring_size,
-				rte_eth_dev_socket_id(port), &txconf);
+				rte_eth_dev_numa_id(port), &txconf);
 		if (retval < 0)
 			return retval;
 	}
@@ -752,7 +752,7 @@ init_ports(uint16_t num_ports)
 			/* cache_size */ 512,
 			/* priv_size*/ 0,
 			/* data_room_size */ RTE_MBUF_DEFAULT_BUF_SIZE,
-			rte_socket_id());
+			rte_numa_id());
 
 	RTE_ETH_FOREACH_DEV(portid)
 		if (port_init(portid, mp) != 0)
-- 
2.55.0

