Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D898606A789
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 14:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=U90nkGEy
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 202CA41143;
	Tue,  3 Nov 2026 15:57:07 +0100 (CET)
Received: from mta0.migadu.com (out-16.mta0.migadu.com [91.218.175.16])
 by mails.dpdk.org (Postfix) with ESMTPS id C578541143
 for <dev@dpdk.org>; Tue,  3 Nov 2026 15:57:05 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=tD7BkZADIc5W+Xa3uP5pHtTxrOdoyEg1D6GsXKS2QpI=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793717825; v=1; x=1794322625;
 b=U90nkGEyXPgsEtPJhm8TjbGDvrgDXkc+7ynZr4xxGbQ6fac74vky0yxGR9b+0yU6zIzXmqg4
 wbT+aR4ZV+R+YAB9RlGKlvV2OJR20Gundw8Mh8urlNyer+npsCD6AgrO73P0Y/cyjcQRblYR0Wr
 +WaDfD4yzmo9TejvxMPW2deo=
X-Envelope-To: dev@dpdk.org
Received: by mta11.migadu.com with ESMTPS id e0931faf593311f5;
 Tue, 03 Nov 2026 14:57:05 +0000
X-Mizu-Trace-ID: e0931faf593311f5
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 024/227] reorder: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:49:42 +0800
Message-ID: <20261103145306.487255-25-chengwen.feng@linux.dev>
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

Rename socket_id parameters, internal variables and comments to
the NUMA node terminology, and switch internal calls to
rte_zmalloc_numa(), rte_numa_id() and RTE_NUMA_ID_ANY.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 lib/reorder/rte_reorder.c | 4 ++--
 lib/reorder/rte_reorder.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/reorder/rte_reorder.c b/lib/reorder/rte_reorder.c
index af5a6d9f01..daa871a39e 100644
--- a/lib/reorder/rte_reorder.c
+++ b/lib/reorder/rte_reorder.c
@@ -160,7 +160,7 @@ rte_reorder_entry_insert(struct rte_tailq_entry *new_te)
 
 RTE_EXPORT_SYMBOL(rte_reorder_create)
 struct rte_reorder_buffer*
-rte_reorder_create(const char *name, unsigned socket_id, unsigned int size)
+rte_reorder_create(const char *name, unsigned int numa_id, unsigned int size)
 {
 	struct rte_reorder_buffer *b = NULL;
 	struct rte_tailq_entry *te, *te_inserted;
@@ -190,7 +190,7 @@ rte_reorder_create(const char *name, unsigned socket_id, unsigned int size)
 	}
 
 	/* Allocate memory to store the reorder buffer structure. */
-	b = rte_zmalloc_socket("REORDER_BUFFER", bufsize, 0, socket_id);
+	b = rte_zmalloc_numa("REORDER_BUFFER", bufsize, 0, numa_id);
 	if (b == NULL) {
 		REORDER_LOG(ERR, "Memzone allocation failed");
 		rte_errno = ENOMEM;
diff --git a/lib/reorder/rte_reorder.h b/lib/reorder/rte_reorder.h
index 5bcb32b164..483a260e99 100644
--- a/lib/reorder/rte_reorder.h
+++ b/lib/reorder/rte_reorder.h
@@ -59,7 +59,7 @@ rte_reorder_free(struct rte_reorder_buffer *b);
  *
  * @param name
  *   The name to be given to the reorder buffer instance.
- * @param socket_id
+ * @param numa_id
  *   The NUMA node on which the memory for the reorder buffer
  *   instance is to be reserved.
  * @param size
@@ -71,7 +71,7 @@ rte_reorder_free(struct rte_reorder_buffer *b);
  *    - EINVAL - invalid parameters
  */
 struct rte_reorder_buffer *
-rte_reorder_create(const char *name, unsigned int socket_id, unsigned int size)
+rte_reorder_create(const char *name, unsigned int numa_id, unsigned int size)
 	__rte_malloc __rte_dealloc(rte_reorder_free, 1);
 
 /**
-- 
2.55.0

