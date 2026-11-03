Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8859606B266
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 14:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=NzBy3CmY
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 93E4842790;
	Tue,  3 Nov 2026 15:56:48 +0100 (CET)
Received: from mta1.migadu.com (out-108.mta1.migadu.com [95.215.58.108])
 by mails.dpdk.org (Postfix) with ESMTPS id B2EDC4161A
 for <dev@dpdk.org>; Tue,  3 Nov 2026 15:56:47 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=JSUTEysUui/ObFKQqMKDJRQIu6trvyS8QabK+kURjvc=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793717807; v=1; x=1794322607;
 b=NzBy3CmYyyC+wlfgSdN7hwegdKFmQO1rjw5OkqUNjf+ODyPHz5AMFwcchxu0HrarJbzLnqBw
 +BFvxDFhsKz1+Zfui8hwc/STlfal6le8EJyZAos9sc6dDGPYU0/KO7sSxb5L1VfR3ywI0FqL0Eu
 mAA42cSDNy1yAaDALn4zhJTk=
X-Envelope-To: dev@dpdk.org
Received: by mta11.migadu.com with ESMTPS id e54e295099d6b85c;
 Tue, 03 Nov 2026 14:56:47 +0000
X-Mizu-Trace-ID: e54e295099d6b85c
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 021/227] ip_frag: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:49:39 +0800
Message-ID: <20261103145306.487255-22-chengwen.feng@linux.dev>
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
 lib/ip_frag/rte_ip_frag.h        |  8 ++++----
 lib/ip_frag/rte_ip_frag_common.c | 12 ++++++------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/lib/ip_frag/rte_ip_frag.h b/lib/ip_frag/rte_ip_frag.h
index 84fd717953..483930a2d6 100644
--- a/lib/ip_frag/rte_ip_frag.h
+++ b/lib/ip_frag/rte_ip_frag.h
@@ -54,15 +54,15 @@ struct rte_ip_frag_death_row {
  *   The value should be less or equal then bucket_num * bucket_entries.
  * @param max_cycles
  *   Maximum TTL in cycles for each fragmented packet.
- * @param socket_id
- *   The *socket_id* argument is the socket identifier in the case of
- *   NUMA. The value can be *SOCKET_ID_ANY* if there is no NUMA constraints.
+ * @param numa_id
+ *   The *numa_id* argument is the NUMA node ID in the case of
+ *   NUMA. The value can be *RTE_NUMA_ID_ANY* if there is no NUMA constraints.
  * @return
  *   The pointer to the new allocated fragmentation table, on success. NULL on error.
  */
 struct rte_ip_frag_tbl * rte_ip_frag_table_create(uint32_t bucket_num,
 		uint32_t bucket_entries,  uint32_t max_entries,
-		uint64_t max_cycles, int socket_id);
+		uint64_t max_cycles, int numa_id);
 
 /**
  * Free allocated IP fragmentation table.
diff --git a/lib/ip_frag/rte_ip_frag_common.c b/lib/ip_frag/rte_ip_frag_common.c
index 00bf9476de..d675de4338 100644
--- a/lib/ip_frag/rte_ip_frag_common.c
+++ b/lib/ip_frag/rte_ip_frag_common.c
@@ -43,7 +43,7 @@ rte_ip_frag_free_death_row(struct rte_ip_frag_death_row *dr,
 RTE_EXPORT_SYMBOL(rte_ip_frag_table_create)
 struct rte_ip_frag_tbl *
 rte_ip_frag_table_create(uint32_t bucket_num, uint32_t bucket_entries,
-	uint32_t max_entries, uint64_t max_cycles, int socket_id)
+	uint32_t max_entries, uint64_t max_cycles, int numa_id)
 {
 	struct rte_ip_frag_tbl *tbl;
 	size_t sz;
@@ -62,16 +62,16 @@ rte_ip_frag_table_create(uint32_t bucket_num, uint32_t bucket_entries,
 	}
 
 	sz = sizeof (*tbl) + nb_entries * sizeof (tbl->pkt[0]);
-	if ((tbl = rte_zmalloc_socket(__func__, sz, RTE_CACHE_LINE_SIZE,
-			socket_id)) == NULL) {
+	tbl = rte_zmalloc_numa(__func__, sz, RTE_CACHE_LINE_SIZE, numa_id);
+	if (tbl == NULL) {
 		IP_FRAG_LOG_LINE(ERR,
-			"%s: allocation of %zu bytes at socket %d failed do",
-			__func__, sz, socket_id);
+			"%s: allocation of %zu bytes at NUMA node %d failed do",
+			__func__, sz, numa_id);
 		return NULL;
 	}
 
 	IP_FRAG_LOG_LINE(INFO, "%s: allocated of %zu bytes at socket %d",
-		__func__, sz, socket_id);
+		__func__, sz, numa_id);
 
 	tbl->max_cycles = max_cycles;
 	tbl->max_entries = max_entries;
-- 
2.55.0

