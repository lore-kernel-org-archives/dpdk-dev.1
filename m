Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FA1606A33D
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=qUEWt7Ou
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EE2A342E94;
	Tue,  3 Nov 2026 16:13:29 +0100 (CET)
Received: from mta1.migadu.com (out-20.mta1.migadu.com [95.215.58.20])
 by mails.dpdk.org (Postfix) with ESMTPS id 8424A42E91
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:13:28 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=Is+imwxp4KZlCmijuVw8rHaFHmhQM09xPVZSz6bAXS4=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718807; v=1; x=1794323607;
 b=qUEWt7OuIIqzmD3uafrLwkTdsuLYrYSVCpAmxfpk++CmbMgiUcL1d9ChzWIkNLVdruQxQjF8
 dEpxt6efOSp+HUljvX6TkDmGCcXBoZPLNEZcIetpLLvN0lTtyHTNrX7EKQyOAVvjwITd9uRC3L3
 e8MdwnaQkTZIccr9rq8eg70g=
X-Envelope-To: dev@dpdk.org
Received: by mta10.migadu.com with ESMTPS id e77a6a771e311673;
 Tue, 03 Nov 2026 15:13:27 +0000
X-Mizu-Trace-ID: e77a6a771e311673
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 127/227] net/memif: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:51:25 +0800
Message-ID: <20261103145306.487255-128-chengwen.feng@linux.dev>
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
 drivers/net/memif/rte_eth_memif.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/memif/rte_eth_memif.c b/drivers/net/memif/rte_eth_memif.c
index 0680dc3947..7df31141c2 100644
--- a/drivers/net/memif/rte_eth_memif.c
+++ b/drivers/net/memif/rte_eth_memif.c
@@ -1765,7 +1765,7 @@ static int
 memif_tx_queue_setup(struct rte_eth_dev *dev,
 		     uint16_t qid,
 		     uint16_t nb_tx_desc __rte_unused,
-		     unsigned int socket_id __rte_unused,
+		     unsigned int numa_id __rte_unused,
 		     const struct rte_eth_txconf *tx_conf __rte_unused)
 {
 	struct pmd_internals *pmd = dev->data->dev_private;
@@ -1802,7 +1802,7 @@ static int
 memif_rx_queue_setup(struct rte_eth_dev *dev,
 		     uint16_t qid,
 		     uint16_t nb_rx_desc __rte_unused,
-		     unsigned int socket_id __rte_unused,
+		     unsigned int numa_id __rte_unused,
 		     const struct rte_eth_rxconf *rx_conf __rte_unused,
 		     struct rte_mempool *mb_pool)
 {
-- 
2.55.0

