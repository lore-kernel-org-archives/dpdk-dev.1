Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC696606A327
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=IX3kt6bq
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AC19D42EBC;
	Tue,  3 Nov 2026 16:26:05 +0100 (CET)
Received: from mta0.migadu.com (out-126.mta0.migadu.com [91.218.175.126])
 by mails.dpdk.org (Postfix) with ESMTPS id 0A019432BA
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:26:04 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=Z6s3e4m+nNC3Ud9g/uIrggJYjM+96uwWELhOUOP++Ew=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793719563; v=1; x=1794324363;
 b=IX3kt6bqkghgyEn9Ju2ZcMh13gPIZZptIVs/V6iDL/JtJBYXAkIAYco0CuvQijetpf0K6h2b
 fBJInxmogNPSpX0T82iXhhHDYBIy1J1y1XjRTcYs6xvYfnO3XxgE2VbbLpDrh6/H8CwRZJ23qzd
 Rw4m/ydReDsI0vvZNIAeqnV8=
X-Envelope-To: dev@dpdk.org
Received: by mta11.migadu.com with ESMTPS id ddf2c54ceae9c403;
 Tue, 03 Nov 2026 15:26:03 +0000
X-Mizu-Trace-ID: ddf2c54ceae9c403
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 208/227] examples/ntb: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:52:46 +0800
Message-ID: <20261103145306.487255-209-chengwen.feng@linux.dev>
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
 examples/ntb/ntb_fwd.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/examples/ntb/ntb_fwd.c b/examples/ntb/ntb_fwd.c
index a53e8aae24..ac9cb2f71b 100644
--- a/examples/ntb/ntb_fwd.c
+++ b/examples/ntb/ntb_fwd.c
@@ -1098,7 +1098,7 @@ static struct rte_mempool *
 ntb_mbuf_pool_create(uint16_t mbuf_seg_size, uint32_t nb_mbuf,
 		     struct ntb_dev_info ntb_info,
 		     struct ntb_dev_config *ntb_conf,
-		     unsigned int socket_id)
+		     unsigned int numa_id)
 {
 	size_t mz_len, total_elt_sz, max_mz_len, left_sz;
 	struct rte_pktmbuf_pool_private mbp_priv;
@@ -1110,12 +1110,12 @@ ntb_mbuf_pool_create(uint16_t mbuf_seg_size, uint32_t nb_mbuf,
 	uint32_t mz_id;
 	int ret;
 
-	snprintf(pool_name, sizeof(pool_name), "ntb_mbuf_pool_%u", socket_id);
+	snprintf(pool_name, sizeof(pool_name), "ntb_mbuf_pool_%u", numa_id);
 	mp = rte_mempool_create_empty(pool_name, nb_mbuf,
 				      (mbuf_seg_size + sizeof(struct rte_mbuf)),
 				      MEMPOOL_CACHE_SIZE,
 				      sizeof(struct rte_pktmbuf_pool_private),
-				      socket_id, 0);
+				      numa_id, 0);
 	if (mp == NULL)
 		return NULL;
 
@@ -1161,7 +1161,7 @@ ntb_mbuf_pool_create(uint16_t mbuf_seg_size, uint32_t nb_mbuf,
 		 * for a memory window of this length.
 		 */
 		align = rte_pmd_ntb_get_mem_align(dev_id, mz_id, mz_len);
-		mz = rte_memzone_reserve_aligned(mz_name, mz_len, socket_id,
+		mz = rte_memzone_reserve_aligned(mz_name, mz_len, numa_id,
 					RTE_MEMZONE_IOVA_CONTIG, align);
 		if (mz == NULL) {
 			printf("Cannot allocate %" PRIu64 " aligned memzone"
@@ -1258,7 +1258,7 @@ main(int argc, char **argv)
 	nb_mbuf = nb_desc * num_queues * 2 * 2 + rte_lcore_count() *
 		  MEMPOOL_CACHE_SIZE;
 	mbuf_pool = ntb_mbuf_pool_create(ntb_buf_size, nb_mbuf, ntb_info,
-					 &ntb_conf, rte_socket_id());
+					 &ntb_conf, rte_numa_id());
 	if (mbuf_pool == NULL)
 		rte_exit(EXIT_FAILURE, "Cannot create mbuf pool.\n");
 
@@ -1327,13 +1327,13 @@ main(int argc, char **argv)
 		/* Setup ethdev queue if ethdev exists */
 		for (i = 0; i < num_queues; i++) {
 			ret = rte_eth_rx_queue_setup(eth_port_id, i, nb_desc,
-					rte_eth_dev_socket_id(eth_port_id),
+					rte_eth_dev_numa_id(eth_port_id),
 					&eth_rx_conf, mbuf_pool);
 			if (ret < 0)
 				rte_exit(EXIT_FAILURE,
 					"Failed to setup eth rxq %u.\n", i);
 			ret = rte_eth_tx_queue_setup(eth_port_id, i, nb_desc,
-					rte_eth_dev_socket_id(eth_port_id),
+					rte_eth_dev_numa_id(eth_port_id),
 					&eth_tx_conf);
 			if (ret < 0)
 				rte_exit(EXIT_FAILURE,
-- 
2.55.0

