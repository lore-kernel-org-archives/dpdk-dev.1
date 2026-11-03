Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474F2606A789
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 14:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=GPDK1ojD
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E59DA42790;
	Tue,  3 Nov 2026 15:57:15 +0100 (CET)
Received: from mta0.migadu.com (out-22.mta0.migadu.com [91.218.175.22])
 by mails.dpdk.org (Postfix) with ESMTPS id 9436D40430
 for <dev@dpdk.org>; Tue,  3 Nov 2026 15:57:14 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=FtJjyIDNA4AlUeKzzeOh24g0tXu1o/ki1j+Vq5d/YAg=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793717834; v=1; x=1794322634;
 b=GPDK1ojDe43eDOT5pyB22GOzNKAH3j1bO1BzuTz4K4X9KLUZDtYq82KpNI303szngCHtcVkm
 /O0Znq3si+siejcBo0hB4uNvLyA2L7o02Bz4ynl9lBeToIRcPh4YeBlW33TjucSvuTOMrVHT6mG
 dgPSsswAmy0etInT6ehUg6f8=
X-Envelope-To: dev@dpdk.org
Received: by mta10.migadu.com with ESMTPS id 601e6298d6b10278;
 Tue, 03 Nov 2026 14:57:14 +0000
X-Mizu-Trace-ID: 601e6298d6b10278
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 025/227] stack: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:49:43 +0800
Message-ID: <20261103145306.487255-26-chengwen.feng@linux.dev>
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
 lib/stack/rte_stack.c | 4 ++--
 lib/stack/rte_stack.h | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/stack/rte_stack.c b/lib/stack/rte_stack.c
index a4bbf8a4d7..51f70f0960 100644
--- a/lib/stack/rte_stack.c
+++ b/lib/stack/rte_stack.c
@@ -52,7 +52,7 @@ rte_stack_get_memsize(unsigned int count, uint32_t flags)
 
 RTE_EXPORT_SYMBOL(rte_stack_create)
 struct rte_stack *
-rte_stack_create(const char *name, unsigned int count, int socket_id,
+rte_stack_create(const char *name, unsigned int count, int numa_id,
 		 uint32_t flags)
 {
 	char mz_name[RTE_MEMZONE_NAMESIZE];
@@ -108,7 +108,7 @@ rte_stack_create(const char *name, unsigned int count, int socket_id,
 
 	rte_mcfg_tailq_write_lock();
 
-	mz = rte_memzone_reserve_aligned(mz_name, sz, socket_id,
+	mz = rte_memzone_reserve_aligned(mz_name, sz, numa_id,
 					 0, alignof(typeof(*s)));
 	if (mz == NULL) {
 		STACK_LOG_ERR("Cannot reserve stack memzone!");
diff --git a/lib/stack/rte_stack.h b/lib/stack/rte_stack.h
index 14983516bf..23a739912d 100644
--- a/lib/stack/rte_stack.h
+++ b/lib/stack/rte_stack.h
@@ -254,9 +254,9 @@ rte_stack_free_count(struct rte_stack *s)
  *   The name of the stack.
  * @param count
  *   The size of the stack.
- * @param socket_id
- *   The *socket_id* argument is the socket identifier in case of
- *   NUMA. The value can be *SOCKET_ID_ANY* if there is no NUMA
+ * @param numa_id
+ *   The *numa_id* argument is the NUMA node ID in case of
+ *   NUMA. The value can be *RTE_NUMA_ID_ANY* if there is no NUMA
  *   constraint for the reserved zone.
  * @param flags
  *   An OR of the following:
@@ -273,7 +273,7 @@ rte_stack_free_count(struct rte_stack *s)
  *    - ENOTSUP - platform does not support given flags combination.
  */
 struct rte_stack *
-rte_stack_create(const char *name, unsigned int count, int socket_id,
+rte_stack_create(const char *name, unsigned int count, int numa_id,
 		 uint32_t flags);
 
 /**
-- 
2.55.0

