Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC892606A33E
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=DQG+7Vsw
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ADFED42E47;
	Tue,  3 Nov 2026 16:07:27 +0100 (CET)
Received: from mta0.migadu.com (out-86.mta0.migadu.com [91.218.175.86])
 by mails.dpdk.org (Postfix) with ESMTPS id 6B5BF42E46
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:07:26 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=D9ChTs93+fKpvc4rSP6W2Y4sMKcdFoFu4FittDCnbpc=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718446; v=1; x=1794323246;
 b=DQG+7Vsw+oo434ZXIKcvNCQ2yzLn8i4CYfktp7cmjfm0B5oB1R2GuWm+j6rikLyzllo8GJY5
 UI2zQFbyI0xZRVcidDvHlbOcQkPzUGQe3o/sET+1qqbYrURsNR3V8dy2Z9aecfKdV1mtjA3QQbj
 i3rR7wwLfMXFv15xqsexKAFc=
X-Envelope-To: dev@dpdk.org
Received: by mta12.migadu.com with ESMTPS id 543e065a3005a5a9;
 Tue, 03 Nov 2026 15:07:26 +0000
X-Mizu-Trace-ID: 543e065a3005a5a9
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 086/227] dma/idxd: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:50:44 +0800
Message-ID: <20261103145306.487255-87-chengwen.feng@linux.dev>
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
 drivers/dma/idxd/idxd_bus.c    | 2 +-
 drivers/dma/idxd/idxd_common.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/idxd/idxd_bus.c b/drivers/dma/idxd/idxd_bus.c
index 2ec526ec09..197d14f9fe 100644
--- a/drivers/dma/idxd/idxd_bus.c
+++ b/drivers/dma/idxd/idxd_bus.c
@@ -286,7 +286,7 @@ dsa_scan(void)
 
 	while ((wq = readdir(dev_dir)) != NULL) {
 		struct rte_dsa_device *dev;
-		int numa_node = SOCKET_ID_ANY;
+		int numa_node = RTE_NUMA_ID_ANY;
 
 		if (strncmp(wq->d_name, "wq", 2) != 0)
 			continue;
diff --git a/drivers/dma/idxd/idxd_common.c b/drivers/dma/idxd/idxd_common.c
index dc2e8cd432..e70238794b 100644
--- a/drivers/dma/idxd/idxd_common.c
+++ b/drivers/dma/idxd/idxd_common.c
@@ -612,7 +612,7 @@ idxd_dmadev_create(const char *name, struct rte_device *dev,
 	 * The +1 is because we can never fully use
 	 * the ring, otherwise read == write means both full and empty.
 	 */
-	idxd->batch_comp_ring = rte_zmalloc_socket(NULL, (sizeof(idxd->batch_idx_ring[0]) +
+	idxd->batch_comp_ring = rte_zmalloc_numa(NULL, (sizeof(idxd->batch_idx_ring[0]) +
 			sizeof(idxd->batch_comp_ring[0]))	* (idxd->max_batches + 1),
 			sizeof(idxd->batch_comp_ring[0]), dev->numa_node);
 	if (idxd->batch_comp_ring == NULL) {
-- 
2.55.0

