Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F40606A328
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Ze8THUyl
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 03CF242E63;
	Tue,  3 Nov 2026 16:11:26 +0100 (CET)
Received: from mta1.migadu.com (out-155.mta1.migadu.com [95.215.58.155])
 by mails.dpdk.org (Postfix) with ESMTPS id 8621E42E5E
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:11:24 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=ktTMip1TJbuRexTwAVK1vCNbGC0Q7wbTfG/dCaIg6jw=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718684; v=1; x=1794323484;
 b=Ze8THUyll8cmgQ35MPxzXTZsFWHkAhOCZxeNQFv5AhzcGrSsQweEMNekYms5m320JjAtNYAl
 WNrIwCTtCT/4sRSQORMl0D5gHOR7VyJzCAjq99i+jtrQkrr29KJ2oHmfuCV2bv/bzeRCMVsFMiw
 jQqAu5jioUmmqwe9eM4X4TJw=
X-Envelope-To: dev@dpdk.org
Received: by mta10.migadu.com with ESMTPS id 3d75a936c7c31b49;
 Tue, 03 Nov 2026 15:11:24 +0000
X-Mizu-Trace-ID: 3d75a936c7c31b49
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 113/227] net/dpaa: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:51:11 +0800
Message-ID: <20261103145306.487255-114-chengwen.feng@linux.dev>
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
 drivers/net/dpaa/dpaa_ethdev.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dpaa/dpaa_ethdev.c b/drivers/net/dpaa/dpaa_ethdev.c
index fe49c7b961..0e4679fd2b 100644
--- a/drivers/net/dpaa/dpaa_ethdev.c
+++ b/drivers/net/dpaa/dpaa_ethdev.c
@@ -1123,7 +1123,7 @@ static inline int dpaa_eth_rx_queue_bp_check(struct rte_eth_dev *dev,
 static
 int dpaa_eth_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 			    uint16_t nb_desc,
-			    unsigned int socket_id __rte_unused,
+			    unsigned int numa_id __rte_unused,
 			    const struct rte_eth_rxconf *rx_conf,
 			    struct rte_mempool *mp)
 {
@@ -1450,7 +1450,7 @@ dpaa_eth_eventq_detach(const struct rte_eth_dev *dev,
 static
 int dpaa_eth_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 			    uint16_t nb_desc __rte_unused,
-		unsigned int socket_id __rte_unused,
+		unsigned int numa_id __rte_unused,
 		const struct rte_eth_txconf *tx_conf)
 {
 	struct dpaa_if *dpaa_intf = dev->data->dev_private;
@@ -2652,7 +2652,7 @@ rte_dpaa_probe(struct rte_dpaa_driver *dpaa_drv,
 			DPAA_POOL_SIZE,
 			DPAA_POOL_CACHE_SIZE, 0,
 			DPAA_MAX_SGS * sizeof(struct qm_sg_entry),
-			rte_socket_id());
+			rte_numa_id());
 		if (dpaa_tx_sg_pool == NULL) {
 			DPAA_PMD_ERR("SG pool creation failed");
 			diag = -ENOMEM;
-- 
2.55.0

