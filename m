Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FBC606F63E
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=cFi1pC2j
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8D70A42D3F;
	Tue,  3 Nov 2026 16:14:37 +0100 (CET)
Received: from mta0.migadu.com (out-73.mta0.migadu.com [91.218.175.73])
 by mails.dpdk.org (Postfix) with ESMTPS id 71ED44042C
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:14:36 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=7hWtnaDmcHEsktUROhG6gtHwQhj8TpGzCjRGWn3He0w=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718876; v=1; x=1794323676;
 b=cFi1pC2jaNOrUEavLZyvm+fZly6f3kxgyQVDhKVd0+4fjdf8BN28mc9vynWGuCNTLRpBQgQv
 VGajqW2/47D7OtT7IrNx9xSH5GsMioIpaWbbTfDkHxSrS7i/mlju4/SNnqtiAe4r2VdbBvblGAX
 AyApTNNSjQOJu5ZH/T3LhWxA=
X-Envelope-To: dev@dpdk.org
Received: by mta11.migadu.com with ESMTPS id 890fb4003a6610fd;
 Tue, 03 Nov 2026 15:14:36 +0000
X-Mizu-Trace-ID: 890fb4003a6610fd
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 137/227] net/null: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:51:35 +0800
Message-ID: <20261103145306.487255-138-chengwen.feng@linux.dev>
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

Rename socket_id parameters, internal structure fields, variables
and comments to the NUMA node terminology, and switch calls to
the NUMA-named APIs.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/net/null/rte_eth_null.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/null/rte_eth_null.c b/drivers/net/null/rte_eth_null.c
index a2f70fee79..dd90d51e9b 100644
--- a/drivers/net/null/rte_eth_null.c
+++ b/drivers/net/null/rte_eth_null.c
@@ -223,7 +223,7 @@ eth_dev_stop(struct rte_eth_dev *dev)
 static int
 eth_rx_queue_setup(struct rte_eth_dev *dev, uint16_t rx_queue_id,
 		uint16_t nb_rx_desc __rte_unused,
-		unsigned int socket_id __rte_unused,
+		unsigned int numa_id __rte_unused,
 		const struct rte_eth_rxconf *rx_conf __rte_unused,
 		struct rte_mempool *mb_pool)
 {
@@ -244,7 +244,7 @@ eth_rx_queue_setup(struct rte_eth_dev *dev, uint16_t rx_queue_id,
 	internals->rx_null_queues[rx_queue_id].mb_pool = mb_pool;
 	dev->data->rx_queues[rx_queue_id] =
 		&internals->rx_null_queues[rx_queue_id];
-	dummy_packet = rte_zmalloc_socket(NULL,
+	dummy_packet = rte_zmalloc_numa(NULL,
 			packet_size, 0, dev->data->numa_node);
 	if (dummy_packet == NULL)
 		return -ENOMEM;
@@ -258,7 +258,7 @@ eth_rx_queue_setup(struct rte_eth_dev *dev, uint16_t rx_queue_id,
 static int
 eth_tx_queue_setup(struct rte_eth_dev *dev, uint16_t tx_queue_id,
 		uint16_t nb_tx_desc __rte_unused,
-		unsigned int socket_id __rte_unused,
+		unsigned int numa_id __rte_unused,
 		const struct rte_eth_txconf *tx_conf __rte_unused)
 {
 	struct rte_mbuf *dummy_packet;
@@ -277,7 +277,7 @@ eth_tx_queue_setup(struct rte_eth_dev *dev, uint16_t tx_queue_id,
 
 	dev->data->tx_queues[tx_queue_id] =
 		&internals->tx_null_queues[tx_queue_id];
-	dummy_packet = rte_zmalloc_socket(NULL,
+	dummy_packet = rte_zmalloc_numa(NULL,
 			packet_size, 0, dev->data->numa_node);
 	if (dummy_packet == NULL)
 		return -ENOMEM;
@@ -500,7 +500,7 @@ static int
 eth_dev_close(struct rte_eth_dev *dev)
 {
 	PMD_LOG(INFO, "Closing null ethdev on NUMA socket %u",
-			rte_socket_id());
+			rte_numa_id());
 
 	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
 		return 0;
@@ -548,8 +548,8 @@ eth_dev_null_create(struct rte_vdev_device *dev, struct pmd_options *args)
 		0xBE, 0xAC, 0x01, 0xFA
 	};
 
-	if (dev->device.numa_node == SOCKET_ID_ANY)
-		dev->device.numa_node = rte_socket_id();
+	if (dev->device.numa_node == RTE_NUMA_ID_ANY)
+		dev->device.numa_node = rte_numa_id();
 
 	PMD_LOG(INFO, "Creating null ethdev on numa socket %u",
 		dev->device.numa_node);
-- 
2.55.0

