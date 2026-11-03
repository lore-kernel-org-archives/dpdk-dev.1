Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D57606F628
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=PoZ2squv
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 122D1427C7;
	Tue,  3 Nov 2026 16:15:30 +0100 (CET)
Received: from mta0.migadu.com (out-95.mta0.migadu.com [91.218.175.95])
 by mails.dpdk.org (Postfix) with ESMTPS id 93CB84042C
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:15:28 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=I2qTdp9dsuTPJoEYjvFcj0fi7JjcCmclzrTDHIGfzv8=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718928; v=1; x=1794323728;
 b=PoZ2squvoKvUfDinZ9cpOHd51Wkt5JO0H/njYJUOZA5I9KUIH/VMIrORAnOde5OjkSZy7ocG
 w+u6D4cUHITJCpM6rfm3ziw+xjBxsWtCjH237KXlFCPjtUULxpCkg+EnyGXsijzcLWdeChFWT1V
 JiSGQEj06vPxU0XZ2f5gyLjg=
X-Envelope-To: dev@dpdk.org
Received: by mta10.migadu.com with ESMTPS id 67e8e6beb16ac5f3;
 Tue, 03 Nov 2026 15:15:27 +0000
X-Mizu-Trace-ID: 67e8e6beb16ac5f3
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 140/227] net/pcap: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:51:38 +0800
Message-ID: <20261103145306.487255-141-chengwen.feng@linux.dev>
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
 drivers/net/pcap/pcap_ethdev.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 1e114e0008..5307979da2 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -1150,7 +1150,7 @@ eth_dev_close(struct rte_eth_dev *dev)
 	struct pmd_internals *internals = dev->data->dev_private;
 
 	PMD_LOG(INFO, "Closing pcap ethdev on NUMA socket %d",
-			rte_socket_id());
+			rte_numa_id());
 
 	eth_dev_stop(dev);
 
@@ -1212,7 +1212,7 @@ static int
 eth_rx_queue_setup(struct rte_eth_dev *dev,
 		uint16_t rx_queue_id,
 		uint16_t nb_rx_desc __rte_unused,
-		unsigned int socket_id __rte_unused,
+		unsigned int numa_id __rte_unused,
 		const struct rte_eth_rxconf *rx_conf __rte_unused,
 		struct rte_mempool *mb_pool)
 {
@@ -1335,7 +1335,7 @@ static int
 eth_tx_queue_setup(struct rte_eth_dev *dev,
 		uint16_t tx_queue_id,
 		uint16_t nb_tx_desc __rte_unused,
-		unsigned int socket_id,
+		unsigned int numa_id,
 		const struct rte_eth_txconf *tx_conf __rte_unused)
 {
 	struct pmd_internals *internals = dev->data->dev_private;
@@ -1343,8 +1343,8 @@ eth_tx_queue_setup(struct rte_eth_dev *dev,
 
 	pcap_q->port_id = dev->data->port_id;
 	pcap_q->queue_id = tx_queue_id;
-	pcap_q->bounce_buf = rte_malloc_socket(NULL, internals->snapshot_len,
-					       RTE_CACHE_LINE_SIZE, socket_id);
+	pcap_q->bounce_buf = rte_malloc_numa(NULL, internals->snapshot_len,
+					       RTE_CACHE_LINE_SIZE, numa_id);
 	if (pcap_q->bounce_buf == NULL)
 		return -ENOMEM;
 
@@ -1641,7 +1641,7 @@ pmd_init_internals(struct rte_vdev_device *vdev,
 	PMD_LOG(INFO, "Creating pcap-backed ethdev on numa socket %u",
 		numa_node);
 
-	pp = rte_zmalloc_socket("pcap_private", sizeof(struct pmd_process_private),
+	pp = rte_zmalloc_numa("pcap_private", sizeof(struct pmd_process_private),
 		RTE_CACHE_LINE_SIZE, numa_node);
 	if (pp == NULL) {
 		PMD_LOG(ERR,
@@ -1709,7 +1709,7 @@ eth_pcap_update_mac(const char *if_name, struct rte_eth_dev *eth_dev,
 	if (osdep_iface_mac_get(if_name, &mac) < 0)
 		return -1;
 
-	mac_addrs = rte_zmalloc_socket("pcap_mac", RTE_ETHER_ADDR_LEN, 0, numa_node);
+	mac_addrs = rte_zmalloc_numa("pcap_mac", RTE_ETHER_ADDR_LEN, 0, numa_node);
 	if (mac_addrs == NULL)
 		return -1;
 
-- 
2.55.0

