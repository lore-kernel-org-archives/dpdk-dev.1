Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEAD606B261
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=cL9qs0gm
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A08B6427DB;
	Tue,  3 Nov 2026 16:09:07 +0100 (CET)
Received: from mta1.migadu.com (out-247.mta1.migadu.com [95.215.58.247])
 by mails.dpdk.org (Postfix) with ESMTPS id A0D004279D
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:09:06 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=rkmfeZIV1QWKvwUuhyKIbFYDR72itsbIy0/2KCtkSMs=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718546; v=1; x=1794323346;
 b=cL9qs0gmo8u7JXs5tlaO/cnxl1xZvzEBUagvr76Elwj9BkNZNQb9JheP5KcIjBjz4p2x9Nsv
 VDaCzdOcLe527khWadK3HWk+Q1cR9xGty97HwYXZyPU2kmDJ8hViJo6sTxEvO5b1guDRrwjYqwR
 I7XKkR3CTtL74bw1ZtmkhzDw=
X-Envelope-To: dev@dpdk.org
Received: by mta11.migadu.com with ESMTPS id ce0389705380a205;
 Tue, 03 Nov 2026 15:09:06 +0000
X-Mizu-Trace-ID: ce0389705380a205
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 099/227] mempool/bucket: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:50:57 +0800
Message-ID: <20261103145306.487255-100-chengwen.feng@linux.dev>
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
 drivers/mempool/bucket/rte_mempool_bucket.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mempool/bucket/rte_mempool_bucket.c b/drivers/mempool/bucket/rte_mempool_bucket.c
index d3f626e064..a94e76bc13 100644
--- a/drivers/mempool/bucket/rte_mempool_bucket.c
+++ b/drivers/mempool/bucket/rte_mempool_bucket.c
@@ -63,7 +63,7 @@ bucket_stack_create(const struct rte_mempool *mp, unsigned int n_elts)
 {
 	struct bucket_stack *stack;
 
-	stack = rte_zmalloc_socket("bucket_stack",
+	stack = rte_zmalloc_numa("bucket_stack",
 				   sizeof(struct bucket_stack) +
 				   n_elts * sizeof(void *),
 				   RTE_CACHE_LINE_SIZE,
@@ -465,7 +465,7 @@ bucket_alloc(struct rte_mempool *mp)
 	if (rc < 0)
 		return rc;
 
-	bd = rte_zmalloc_socket("bucket_pool", sizeof(*bd),
+	bd = rte_zmalloc_numa("bucket_pool", sizeof(*bd),
 				RTE_CACHE_LINE_SIZE, mp->numa_id);
 	if (bd == NULL) {
 		rc = -ENOMEM;
-- 
2.55.0

