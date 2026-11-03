Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60337606B255
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=OaspxPl4
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F412742FDB;
	Tue,  3 Nov 2026 16:22:17 +0100 (CET)
Received: from mta1.migadu.com (out-16.mta1.migadu.com [95.215.58.16])
 by mails.dpdk.org (Postfix) with ESMTPS id 00F3B42FA5
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:22:16 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=5tQwr/Hqmf4Kgb2gMS1/EN7TlnsYOBLFdMG1lX2L7Gw=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793719336; v=1; x=1794324136;
 b=OaspxPl4YRnjLgtgQ6+XRWnL/qJJ1XJy12IzSgmLNhkSfdjEGJXUfx+mhN7zwLIMG51pGBhg
 Xd99POBFDzuDPvHjTw0EwvknvP4E/lHZl29SexVEBqVFt6DE2kWodPAGMCTvhqdTUTTfXvn9rW9
 spT41Qbr7tdVJD5VVBAfDm+g=
X-Envelope-To: dev@dpdk.org
Received: by mta12.migadu.com with ESMTPS id d4222979a1e7a08f;
 Tue, 03 Nov 2026 15:22:16 +0000
X-Mizu-Trace-ID: d4222979a1e7a08f
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 184/227] examples/bbdev_app: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:52:22 +0800
Message-ID: <20261103145306.487255-185-chengwen.feng@linux.dev>
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
 examples/bbdev_app/main.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/examples/bbdev_app/main.c b/examples/bbdev_app/main.c
index 8c16d7c556..396ba9d1eb 100644
--- a/examples/bbdev_app/main.c
+++ b/examples/bbdev_app/main.c
@@ -467,7 +467,7 @@ initialize_ports(struct app_config_params *app_params,
 	for (q = 0; q < app_params->num_enc_cores; q++) {
 		ret = rte_eth_rx_queue_setup(port_id, q,
 			RX_DESC_DEFAULT,
-			rte_eth_dev_socket_id(port_id),
+			rte_eth_dev_numa_id(port_id),
 			NULL, ethdev_mbuf_mempool);
 		if (ret < 0) {
 			printf("rte_eth_rx_queue_setup: err=%d, queue=%u\n",
@@ -479,7 +479,7 @@ initialize_ports(struct app_config_params *app_params,
 	for (q = 0; q < app_params->num_dec_cores; q++) {
 		ret = rte_eth_tx_queue_setup(port_id, q,
 			TX_DESC_DEFAULT,
-			rte_eth_dev_socket_id(port_id), NULL);
+			rte_eth_dev_numa_id(port_id), NULL);
 		if (ret < 0) {
 			printf("rte_eth_tx_queue_setup: err=%d, queue=%u\n",
 				ret, q);
@@ -1079,10 +1079,10 @@ main(int argc, char **argv)
 	/*create bbdev op pools*/
 	bbdev_op_pools[RTE_BBDEV_OP_TURBO_DEC] =
 			rte_bbdev_op_pool_create("bbdev_op_pool_dec",
-			RTE_BBDEV_OP_TURBO_DEC, NB_MBUF, 128, rte_socket_id());
+			RTE_BBDEV_OP_TURBO_DEC, NB_MBUF, 128, rte_numa_id());
 	bbdev_op_pools[RTE_BBDEV_OP_TURBO_ENC] =
 			rte_bbdev_op_pool_create("bbdev_op_pool_enc",
-			RTE_BBDEV_OP_TURBO_ENC, NB_MBUF, 128, rte_socket_id());
+			RTE_BBDEV_OP_TURBO_ENC, NB_MBUF, 128, rte_numa_id());
 
 	if ((bbdev_op_pools[RTE_BBDEV_OP_TURBO_DEC] == NULL) ||
 			(bbdev_op_pools[RTE_BBDEV_OP_TURBO_ENC] == NULL))
@@ -1094,7 +1094,7 @@ main(int argc, char **argv)
 		flags |= RING_F_SC_DEQ;
 
 	enc_to_dec_ring = rte_ring_create("enc_to_dec_ring",
-		rte_align32pow2(NB_MBUF), rte_socket_id(), flags);
+		rte_align32pow2(NB_MBUF), rte_numa_id(), flags);
 
 	/* Get the number of available bbdev devices */
 	nb_bbdevs = rte_bbdev_count();
@@ -1112,14 +1112,14 @@ main(int argc, char **argv)
 	/* create the mbuf mempool for ethdev pkts */
 	ethdev_mbuf_mempool = rte_pktmbuf_pool_create("ethdev_mbuf_pool",
 			NB_MBUF, MEMPOOL_CACHE_SIZE, 0,
-			RTE_MBUF_DEFAULT_BUF_SIZE, rte_socket_id());
+			RTE_MBUF_DEFAULT_BUF_SIZE, rte_numa_id());
 	if (ethdev_mbuf_mempool == NULL)
 		rte_exit(EXIT_FAILURE, "Cannot create ethdev mbuf mempool\n");
 
 	/* create the mbuf mempool for encoder output */
 	bbdev_mbuf_mempool = rte_pktmbuf_pool_create("bbdev_mbuf_pool",
 			NB_MBUF, MEMPOOL_CACHE_SIZE, 0,
-			RTE_MBUF_DEFAULT_BUF_SIZE, rte_socket_id());
+			RTE_MBUF_DEFAULT_BUF_SIZE, rte_numa_id());
 	if (bbdev_mbuf_mempool == NULL)
 		rte_exit(EXIT_FAILURE, "Cannot create ethdev mbuf mempool\n");
 
-- 
2.55.0

