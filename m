Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BCF606A7A4
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=VwIFrsnJ
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DD35942F7A;
	Tue,  3 Nov 2026 16:20:43 +0100 (CET)
Received: from mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
 by mails.dpdk.org (Postfix) with ESMTPS id 602CF42F7A
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:20:42 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=f2sbZcy7zVm9PpTB8hHwURUOZt9UK2JcAqglatwBL34=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793719242; v=1; x=1794324042;
 b=VwIFrsnJQfUImCwJot14OU4CQtJePZZOAo6nsLt0PqcCeToReCF2AlSAz8B8p6FFRMUeohYj
 JIBGdYT6sLpM7VjintVx6glrjASUPDqckvhUI6G2Q/cCNrhvgVen0JdH8/SDsJ+oqys3aLGhHw6
 MYuR5JLs5fkst+Wbt36j+agQ=
X-Envelope-To: dev@dpdk.org
Received: by mta12.migadu.com with ESMTPS id a937055120b4f3e3;
 Tue, 03 Nov 2026 15:20:20 +0000
X-Mizu-Trace-ID: a937055120b4f3e3
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 174/227] app/pdump: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:52:12 +0800
Message-ID: <20261103145306.487255-175-chengwen.feng@linux.dev>
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
 app/pdump/main.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/app/pdump/main.c b/app/pdump/main.c
index 1e62c8adc1..b3458be969 100644
--- a/app/pdump/main.c
+++ b/app/pdump/main.c
@@ -595,7 +595,7 @@ configure_vdev(uint16_t port_id)
 
 	for (q = 0; q < txRings; q++) {
 		ret = rte_eth_tx_queue_setup(port_id, q, TX_DESC_PER_QUEUE,
-				rte_eth_dev_socket_id(port_id), NULL);
+				rte_eth_dev_numa_id(port_id), NULL);
 		if (ret < 0)
 			rte_exit(EXIT_FAILURE, "queue setup failed\n");
 	}
@@ -645,7 +645,7 @@ create_mp_ring_vdev(void)
 					pt->total_num_mbufs,
 					MBUF_POOL_CACHE_SIZE, 0,
 					pt->mbuf_data_size,
-					rte_socket_id(), "ring_mp_mc");
+					rte_numa_id(), "ring_mp_mc");
 			if (mbuf_pool == NULL) {
 				cleanup_rings();
 				rte_exit(EXIT_FAILURE,
@@ -660,7 +660,7 @@ create_mp_ring_vdev(void)
 			/* create rx_ring */
 			snprintf(ring_name, SIZE, RX_RING, i);
 			pt->rx_ring = rte_ring_create(ring_name, pt->ring_size,
-					rte_socket_id(), 0);
+					rte_numa_id(), 0);
 			if (pt->rx_ring == NULL) {
 				cleanup_rings();
 				rte_exit(EXIT_FAILURE, "%s:%s:%d\n",
@@ -671,7 +671,7 @@ create_mp_ring_vdev(void)
 			/* create tx_ring */
 			snprintf(ring_name, SIZE, TX_RING, i);
 			pt->tx_ring = rte_ring_create(ring_name, pt->ring_size,
-					rte_socket_id(), 0);
+					rte_numa_id(), 0);
 			if (pt->tx_ring == NULL) {
 				cleanup_rings();
 				rte_exit(EXIT_FAILURE, "%s:%s:%d\n",
@@ -743,7 +743,7 @@ create_mp_ring_vdev(void)
 			/* create rx_ring */
 			snprintf(ring_name, SIZE, RX_RING, i);
 			pt->rx_ring = rte_ring_create(ring_name, pt->ring_size,
-					rte_socket_id(), 0);
+					rte_numa_id(), 0);
 			if (pt->rx_ring == NULL) {
 				cleanup_rings();
 				rte_exit(EXIT_FAILURE, "%s\n",
@@ -780,7 +780,7 @@ create_mp_ring_vdev(void)
 			/* create tx_ring */
 			snprintf(ring_name, SIZE, TX_RING, i);
 			pt->tx_ring = rte_ring_create(ring_name, pt->ring_size,
-					rte_socket_id(), 0);
+					rte_numa_id(), 0);
 			if (pt->tx_ring == NULL) {
 				cleanup_rings();
 				rte_exit(EXIT_FAILURE, "%s\n",
-- 
2.55.0

