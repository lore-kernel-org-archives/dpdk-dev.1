Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D23606A789
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 14:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=C077f2i2
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B43C1427A2;
	Tue,  3 Nov 2026 15:57:46 +0100 (CET)
Received: from mta0.migadu.com (out-39.mta0.migadu.com [91.218.175.39])
 by mails.dpdk.org (Postfix) with ESMTPS id 70A904279D
 for <dev@dpdk.org>; Tue,  3 Nov 2026 15:57:45 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=wzh5lCqvmscDYiZAXYJIQValWg1BwuqHIrE7PhHFnko=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793717865; v=1; x=1794322665;
 b=C077f2i2NF4zIPONea1tgINRoeg4DQSwPKBXyI2Tag3Veh8r/RzrnG/YkkDaS7YmZBa4eWCb
 KquJzB1BoBj8MCQPM5UsxkYkCo+XMivdfdH7aT77Bhfa5i6zmdW4j+YkUTmQW82OpggYILPaChX
 LsrplrWY/DVrRsoZexnNlPdc=
X-Envelope-To: dev@dpdk.org
Received: by mta10.migadu.com with ESMTPS id b76e013bc9335084;
 Tue, 03 Nov 2026 14:57:45 +0000
X-Mizu-Trace-ID: b76e013bc9335084
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 030/227] table: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:49:48 +0800
Message-ID: <20261103145306.487255-31-chengwen.feng@linux.dev>
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
 lib/table/rte_swx_table_em.c       | 2 +-
 lib/table/rte_swx_table_learner.c  | 2 +-
 lib/table/rte_swx_table_selector.c | 2 +-
 lib/table/rte_swx_table_wm.c       | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/table/rte_swx_table_em.c b/lib/table/rte_swx_table_em.c
index c408ea6fc3..a0587c831a 100644
--- a/lib/table/rte_swx_table_em.c
+++ b/lib/table/rte_swx_table_em.c
@@ -31,7 +31,7 @@ do {                                                                           \
 static void *
 env_malloc(size_t size, size_t alignment, int numa_node)
 {
-	return rte_zmalloc_socket(NULL, size, alignment, numa_node);
+	return rte_zmalloc_numa(NULL, size, alignment, numa_node);
 }
 
 static void
diff --git a/lib/table/rte_swx_table_learner.c b/lib/table/rte_swx_table_learner.c
index 3680bf26c1..120e38e012 100644
--- a/lib/table/rte_swx_table_learner.c
+++ b/lib/table/rte_swx_table_learner.c
@@ -26,7 +26,7 @@
 static void *
 env_calloc(size_t size, size_t alignment, int numa_node)
 {
-	return rte_zmalloc_socket(NULL, size, alignment, numa_node);
+	return rte_zmalloc_numa(NULL, size, alignment, numa_node);
 }
 
 static void
diff --git a/lib/table/rte_swx_table_selector.c b/lib/table/rte_swx_table_selector.c
index d42f67f157..23aa982dc3 100644
--- a/lib/table/rte_swx_table_selector.c
+++ b/lib/table/rte_swx_table_selector.c
@@ -18,7 +18,7 @@
 static void *
 env_calloc(size_t size, size_t alignment, int numa_node)
 {
-	return rte_zmalloc_socket(NULL, size, alignment, numa_node);
+	return rte_zmalloc_numa(NULL, size, alignment, numa_node);
 }
 
 static void
diff --git a/lib/table/rte_swx_table_wm.c b/lib/table/rte_swx_table_wm.c
index c57738dda3..4293e2fa6f 100644
--- a/lib/table/rte_swx_table_wm.c
+++ b/lib/table/rte_swx_table_wm.c
@@ -23,7 +23,7 @@
 static void *
 env_malloc(size_t size, size_t alignment, int numa_node)
 {
-	return rte_zmalloc_socket(NULL, size, alignment, numa_node);
+	return rte_zmalloc_numa(NULL, size, alignment, numa_node);
 }
 
 static void
-- 
2.55.0

