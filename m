Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E45606A78D
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=QSND2Hyh
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AD81842E5E;
	Tue,  3 Nov 2026 16:11:48 +0100 (CET)
Received: from mta0.migadu.com (out-230.mta0.migadu.com [91.218.175.230])
 by mails.dpdk.org (Postfix) with ESMTPS id C2E0942E72
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:11:46 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=e7dxzbXqPdFig4d22AuZ0bSPbEj826Ep6KrsutC4ml0=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718706; v=1; x=1794323506;
 b=QSND2Hyhq+y7tsFp6byJaiDRkgH568EfkJxw6OnEFNPO4t63bOozYr8ctjlYDocNf9YN9GWS
 i5ey4iQEnQ7u/jK4QslR4g3RcLmr8WEIFX5Px6ntqluihYD4aZjben7cKEGSvFHe2FrLLB+NbDO
 yKu2dStths4iBHRCZgLIWAD4=
X-Envelope-To: dev@dpdk.org
Received: by mta11.migadu.com with ESMTPS id 900cdf0e8d77d07f;
 Tue, 03 Nov 2026 15:11:46 +0000
X-Mizu-Trace-ID: 900cdf0e8d77d07f
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 116/227] net/enetc: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:51:14 +0800
Message-ID: <20261103145306.487255-117-chengwen.feng@linux.dev>
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
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Chengwen Feng <fengchengwen@huawei.com>

Rename socket_id parameters, internal structure fields, variables
and comments to the NUMA node terminology, and switch calls to
the NUMA-named APIs.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/net/enetc/enetc.h         | 4 ++--
 drivers/net/enetc/enetc4_ethdev.c | 4 ++--
 drivers/net/enetc/enetc_ethdev.c  | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/enetc/enetc.h b/drivers/net/enetc/enetc.h
index 925ba22af6..cec38d3dea 100644
--- a/drivers/net/enetc/enetc.h
+++ b/drivers/net/enetc/enetc.h
@@ -382,14 +382,14 @@ int enetc4_dev_close(struct rte_eth_dev *dev);
 int enetc4_dev_infos_get(struct rte_eth_dev *dev,
 			 struct rte_eth_dev_info *dev_info);
 int enetc4_rx_queue_setup(struct rte_eth_dev *dev, uint16_t rx_queue_id,
-			  uint16_t nb_rx_desc, unsigned int socket_id __rte_unused,
+			  uint16_t nb_rx_desc, unsigned int numa_id __rte_unused,
 			  const struct rte_eth_rxconf *rx_conf,
 			  struct rte_mempool *mb_pool);
 int enetc4_rx_queue_start(struct rte_eth_dev *dev, uint16_t qidx);
 int enetc4_rx_queue_stop(struct rte_eth_dev *dev, uint16_t qidx);
 void enetc4_rx_queue_release(struct rte_eth_dev *dev, uint16_t qid);
 int enetc4_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
-			  uint16_t nb_desc, unsigned int socket_id __rte_unused,
+			  uint16_t nb_desc, unsigned int numa_id __rte_unused,
 			  const struct rte_eth_txconf *tx_conf);
 int enetc4_tx_queue_start(struct rte_eth_dev *dev, uint16_t qidx);
 int enetc4_tx_queue_stop(struct rte_eth_dev *dev, uint16_t qidx);
diff --git a/drivers/net/enetc/enetc4_ethdev.c b/drivers/net/enetc/enetc4_ethdev.c
index 199cd45ee5..aeda977ab4 100644
--- a/drivers/net/enetc/enetc4_ethdev.c
+++ b/drivers/net/enetc/enetc4_ethdev.c
@@ -483,7 +483,7 @@ int
 enetc4_tx_queue_setup(struct rte_eth_dev *dev,
 		     uint16_t queue_idx,
 		     uint16_t nb_desc,
-		     unsigned int socket_id __rte_unused,
+		     unsigned int numa_id __rte_unused,
 		     const struct rte_eth_txconf *tx_conf)
 {
 	int err;
@@ -704,7 +704,7 @@ int
 enetc4_rx_queue_setup(struct rte_eth_dev *dev,
 		     uint16_t rx_queue_id,
 		     uint16_t nb_rx_desc,
-		     unsigned int socket_id __rte_unused,
+		     unsigned int numa_id __rte_unused,
 		     const struct rte_eth_rxconf *rx_conf,
 		     struct rte_mempool *mb_pool)
 {
diff --git a/drivers/net/enetc/enetc_ethdev.c b/drivers/net/enetc/enetc_ethdev.c
index 55b0e0b881..1f6528df8e 100644
--- a/drivers/net/enetc/enetc_ethdev.c
+++ b/drivers/net/enetc/enetc_ethdev.c
@@ -302,7 +302,7 @@ static int
 enetc_tx_queue_setup(struct rte_eth_dev *dev,
 		     uint16_t queue_idx,
 		     uint16_t nb_desc,
-		     unsigned int socket_id __rte_unused,
+		     unsigned int numa_id __rte_unused,
 		     const struct rte_eth_txconf *tx_conf)
 {
 	int err = 0;
@@ -447,7 +447,7 @@ static int
 enetc_rx_queue_setup(struct rte_eth_dev *dev,
 		     uint16_t rx_queue_id,
 		     uint16_t nb_rx_desc,
-		     unsigned int socket_id __rte_unused,
+		     unsigned int numa_id __rte_unused,
 		     const struct rte_eth_rxconf *rx_conf,
 		     struct rte_mempool *mb_pool)
 {
-- 
2.55.0

