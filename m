Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB93E606A7B1
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=RwzFXPva
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8016C43067;
	Tue,  3 Nov 2026 16:23:48 +0100 (CET)
Received: from mta0.migadu.com (out-67.mta0.migadu.com [91.218.175.67])
 by mails.dpdk.org (Postfix) with ESMTPS id DB83642FC1
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:23:47 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=zQZrnXsbZlMDo6CyN7s19IKYOAidPhNiJFGBV1ej5/c=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793719427; v=1; x=1794324227;
 b=RwzFXPva7aVtDUbM3hRBuYnN+pBnBcpgh32bjvFkiM0fJP2AoAnxtmWm9XvDPL9xu8hjtrrX
 /hjWn8c/ESyMCjJHYR3quvtESNvfLt620brcd7FLT2l06PyByWHwkd0EPe899gBSDgfRhx1Rzls
 SaF/s1pggGTH6O/ywYrleZvo=
X-Envelope-To: dev@dpdk.org
Received: by mta12.migadu.com with ESMTPS id 597f203c7a6b588a;
 Tue, 03 Nov 2026 15:23:47 +0000
X-Mizu-Trace-ID: 597f203c7a6b588a
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 195/227] examples/ipv4_multicast: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:52:33 +0800
Message-ID: <20261103145306.487255-196-chengwen.feng@linux.dev>
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
 examples/ipv4_multicast/main.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/examples/ipv4_multicast/main.c b/examples/ipv4_multicast/main.c
index 1cb621cb8b..4f31cd9d77 100644
--- a/examples/ipv4_multicast/main.c
+++ b/examples/ipv4_multicast/main.c
@@ -124,7 +124,7 @@ static struct rte_fbk_hash_params mcast_hash_params = {
 	.name = "MCAST_HASH",
 	.entries = 1024,
 	.entries_per_bucket = 4,
-	.socket_id = 0,
+	.numa_id = 0,
 	.hash_func = NULL,
 	.init_val = 0,
 };
@@ -560,7 +560,7 @@ init_mcast_hash(void)
 {
 	uint32_t i;
 
-	mcast_hash_params.socket_id = rte_socket_id();
+	mcast_hash_params.numa_id = rte_numa_id();
 	mcast_hash = rte_fbk_hash_create(&mcast_hash_params);
 	if (mcast_hash == NULL){
 		return -1;
@@ -665,19 +665,19 @@ main(int argc, char **argv)
 
 	/* Create the mbuf pools. 8< */
 	packet_pool = rte_pktmbuf_pool_create("packet_pool", NB_PKT_MBUF, 32,
-		0, PKT_MBUF_DATA_SIZE, rte_socket_id());
+		0, PKT_MBUF_DATA_SIZE, rte_numa_id());
 
 	if (packet_pool == NULL)
 		rte_exit(EXIT_FAILURE, "Cannot init packet mbuf pool\n");
 
 	header_pool = rte_pktmbuf_pool_create("header_pool", NB_HDR_MBUF, 32,
-		0, HDR_MBUF_DATA_SIZE, rte_socket_id());
+		0, HDR_MBUF_DATA_SIZE, rte_numa_id());
 
 	if (header_pool == NULL)
 		rte_exit(EXIT_FAILURE, "Cannot init header mbuf pool\n");
 
 	clone_pool = rte_pktmbuf_pool_create("clone_pool", NB_CLONE_MBUF, 32,
-		0, 0, rte_socket_id());
+		0, 0, rte_numa_id());
 
 	if (clone_pool == NULL)
 		rte_exit(EXIT_FAILURE, "Cannot init clone mbuf pool\n");
@@ -764,7 +764,7 @@ main(int argc, char **argv)
 		rxq_conf = dev_info.default_rxconf;
 		rxq_conf.offloads = local_port_conf.rxmode.offloads;
 		ret = rte_eth_rx_queue_setup(portid, queueid, nb_rxd,
-					     rte_eth_dev_socket_id(portid),
+					     rte_eth_dev_numa_id(portid),
 					     &rxq_conf,
 					     packet_pool);
 		if (ret < 0)
@@ -783,7 +783,7 @@ main(int argc, char **argv)
 			txconf = &dev_info.default_txconf;
 			txconf->offloads = local_port_conf.txmode.offloads;
 			ret = rte_eth_tx_queue_setup(portid, queueid, nb_txd,
-						     rte_lcore_to_socket_id(lcore_id), txconf);
+						     rte_lcore_to_numa_id(lcore_id), txconf);
 			if (ret < 0)
 				rte_exit(EXIT_FAILURE, "rte_eth_tx_queue_setup: err=%d, "
 					  "port=%d\n", ret, portid);
-- 
2.55.0

