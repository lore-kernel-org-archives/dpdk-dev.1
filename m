Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D24A606A324
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=WiecD0sl
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B67AF4330E;
	Tue,  3 Nov 2026 16:27:23 +0100 (CET)
Received: from mta0.migadu.com (out-161.mta0.migadu.com [91.218.175.161])
 by mails.dpdk.org (Postfix) with ESMTPS id DA64C432C8
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:27:22 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=mQ+Imw8+ptC6cGNpaz0FJqLKcufJ6W+V52rJbux8wVc=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793719642; v=1; x=1794324442;
 b=WiecD0slL3NR/lU18CvUVQCGIGuywvRtxBAuiwMe3ZXnSRLQLy4RSZ6/kD3oNXJw2JNBXeih
 33Yk0TYxcigwmaDtlvpNBdwNHf+GskjdoNovz+qCzmZT/X9yKreGNhTBJUPCTugDJKnBegqO8dL
 enjeVQ9f09kkkXGdKuNl5Rtc=
X-Envelope-To: dev@dpdk.org
Received: by mta12.migadu.com with ESMTPS id 3c02415c497fee8f;
 Tue, 03 Nov 2026 15:27:22 +0000
X-Mizu-Trace-ID: 3c02415c497fee8f
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 218/227] examples/vhost: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:52:56 +0800
Message-ID: <20261103145306.487255-219-chengwen.feng@linux.dev>
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
 examples/vhost/main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/examples/vhost/main.c b/examples/vhost/main.c
index e7434fd189..898625fd02 100644
--- a/examples/vhost/main.c
+++ b/examples/vhost/main.c
@@ -320,7 +320,7 @@ port_init(uint16_t port, struct rte_mempool *mbuf_pool)
 	rxconf->offloads = port_conf.rxmode.offloads;
 	for (q = 0; q < rx_rings; q ++) {
 		retval = rte_eth_rx_queue_setup(port, q, rx_ring_size,
-						rte_eth_dev_socket_id(port),
+						rte_eth_dev_numa_id(port),
 						rxconf,
 						mbuf_pool);
 		if (retval < 0) {
@@ -333,7 +333,7 @@ port_init(uint16_t port, struct rte_mempool *mbuf_pool)
 	txconf->offloads = port_conf.txmode.offloads;
 	for (q = 0; q < tx_rings; q ++) {
 		retval = rte_eth_tx_queue_setup(port, q, tx_ring_size,
-						rte_eth_dev_socket_id(port),
+						rte_eth_dev_numa_id(port),
 						txconf);
 		if (retval < 0) {
 			RTE_LOG(ERR, VHOST_PORT,
@@ -1559,7 +1559,7 @@ main(int argc, char *argv[])
 	 */
 	mbuf_pool = rte_pktmbuf_pool_create("MBUF_POOL", total_num_mbufs,
 					    MBUF_CACHE_SIZE, 0, MBUF_DATA_SIZE,
-					    rte_socket_id());
+					    rte_numa_id());
 	if (mbuf_pool == NULL)
 		rte_exit(EXIT_FAILURE, "Cannot create mbuf pool\n");
 
-- 
2.55.0

