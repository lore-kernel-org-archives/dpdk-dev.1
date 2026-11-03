Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D87E606B249
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=VdA+3MkK
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 751FA42E50;
	Tue,  3 Nov 2026 16:11:52 +0100 (CET)
Received: from mta0.migadu.com (out-233.mta0.migadu.com [91.218.175.233])
 by mails.dpdk.org (Postfix) with ESMTPS id 1AD5E42E6A
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:11:51 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=eWOjdPgLAdWDziWyxGZw9rta6nLmYO/CiWXTp22M8mc=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718710; v=1; x=1794323510;
 b=VdA+3MkKXZMeqBq3IwBdW+l2+pFFYUNpoR6L+70Xth1QuA+J7Sx6krZfkRhPbRQoeNaI06Zd
 6RnCqvIVHqqoXiDvC02OPUD1ilwfjRd18g7h0iIUnId1k4I2ygP7V4oSELDyvQzomF19JMjT0fy
 PUwi1/VK6BJXAWliJAFlFaiE=
X-Envelope-To: dev@dpdk.org
Received: by mta11.migadu.com with ESMTPS id 39a477a07481c2de;
 Tue, 03 Nov 2026 15:11:50 +0000
X-Mizu-Trace-ID: 39a477a07481c2de
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 117/227] net/enetfec: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:51:15 +0800
Message-ID: <20261103145306.487255-118-chengwen.feng@linux.dev>
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
 drivers/net/enetfec/enet_ethdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/enetfec/enet_ethdev.c b/drivers/net/enetfec/enet_ethdev.c
index c7ef097875..e84c4f7580 100644
--- a/drivers/net/enetfec/enet_ethdev.c
+++ b/drivers/net/enetfec/enet_ethdev.c
@@ -343,7 +343,7 @@ static int
 enetfec_tx_queue_setup(struct rte_eth_dev *dev,
 			uint16_t queue_idx,
 			uint16_t nb_desc,
-			unsigned int socket_id __rte_unused,
+			unsigned int numa_id __rte_unused,
 			const struct rte_eth_txconf *tx_conf __rte_unused)
 {
 	struct enetfec_private *fep = dev->data->dev_private;
@@ -424,7 +424,7 @@ static int
 enetfec_rx_queue_setup(struct rte_eth_dev *dev,
 			uint16_t queue_idx,
 			uint16_t nb_rx_desc,
-			unsigned int socket_id __rte_unused,
+			unsigned int numa_id __rte_unused,
 			const struct rte_eth_rxconf *rx_conf __rte_unused,
 			struct rte_mempool *mb_pool)
 {
-- 
2.55.0

