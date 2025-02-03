Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7590C0218A
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Feb 2025 04:07:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7413640B92;
	Mon,  3 Feb 2025 05:07:07 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id A129240695
 for <dev@dpdk.org>; Mon,  3 Feb 2025 05:06:48 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 51F062037186; Sun,  2 Feb 2025 20:06:47 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 51F062037186
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1738555607;
 bh=VrdBdvJUUltk+ZXtsDAj7IT45LyJQnArjkgdKInocWM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=CLpz/KVD6WIJH6cW1CAQtRnpeaffTH5oi9vWS5Y+fjhO7csTE2eqYNGfJn42klmHM
 esAc5xaGnNoFnkijCSacRL1bw4unhI7iS9J2pC6q2EPn8NBnfrN2qdm2QJ3D13a8ce
 5gHLbGtRh6Jds/BCDHkrUaZfNTX39VhtqSbI9CSQ=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: dev@dpdk.org
Cc: konstantin.ananyev@huawei.com, thomas@monjalon.net,
 david.marchand@redhat.com
Subject: [PATCH v19 07/27] rcu: remove use of VLAs for Windows built code
Date: Sun,  2 Feb 2025 20:06:10 -0800
Message-Id: <1738555590-12753-8-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1738555590-12753-1-git-send-email-andremue@linux.microsoft.com>
References: <1713397319-26135-1-git-send-email-roretzla@linux.microsoft.com>
 <1738555590-12753-1-git-send-email-andremue@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

From: Konstantin Ananyev <konstantin.ananyev@huawei.com>

1) ./lib/rcu/rte_rcu_qsbr.c:359:9
    : warning: ISO C90 forbids variable length array ‘data’ [-Wvla]
2) ./lib/rcu/rte_rcu_qsbr.c:422:9
    : warning: ISO C90 forbids variable length array ‘data’ [-Wvla]

In both cases we allocate VLA for one element from RCU deferred queue.
Right now, size of element in RCU queue is not limited by API.
The approach is to introduce some reasonable limitation on RCU DQ
element size.
Choose 128B for now.
With that in place we can replace both VLA occurencies with fixed size
array.

Note that such change need to be treated as API change.
So can be applied only at 24.11.

Signed-off-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
---
 lib/rcu/rte_rcu_qsbr.c | 7 ++++---
 lib/rcu/rte_rcu_qsbr.h | 5 +++++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/lib/rcu/rte_rcu_qsbr.c b/lib/rcu/rte_rcu_qsbr.c
index dbf31501a6..fe68d16326 100644
--- a/lib/rcu/rte_rcu_qsbr.c
+++ b/lib/rcu/rte_rcu_qsbr.c
@@ -245,7 +245,8 @@ rte_rcu_qsbr_dq_create(const struct rte_rcu_qsbr_dq_parameters *params)
 	if (params == NULL || params->free_fn == NULL ||
 		params->v == NULL || params->name == NULL ||
 		params->size == 0 || params->esize == 0 ||
-		(params->esize % 4 != 0)) {
+		(params->esize % 4 != 0) ||
+		params->esize > RTE_QSBR_ESIZE_MAX) {
 		RCU_LOG(ERR, "Invalid input parameter");
 		rte_errno = EINVAL;
 
@@ -323,7 +324,7 @@ int rte_rcu_qsbr_dq_enqueue(struct rte_rcu_qsbr_dq *dq, void *e)
 		return 1;
 	}
 
-	char data[dq->esize];
+	char data[RTE_QSBR_ESIZE_MAX + __RTE_QSBR_TOKEN_SIZE];
 	dq_elem = (__rte_rcu_qsbr_dq_elem_t *)data;
 	/* Start the grace period */
 	dq_elem->token = rte_rcu_qsbr_start(dq->v);
@@ -386,7 +387,7 @@ rte_rcu_qsbr_dq_reclaim(struct rte_rcu_qsbr_dq *dq, unsigned int n,
 
 	cnt = 0;
 
-	char data[dq->esize];
+	char data[RTE_QSBR_ESIZE_MAX + __RTE_QSBR_TOKEN_SIZE];
 	/* Check reader threads quiescent state and reclaim resources */
 	while (cnt < n &&
 		rte_ring_dequeue_bulk_elem_start(dq->r, &data,
diff --git a/lib/rcu/rte_rcu_qsbr.h b/lib/rcu/rte_rcu_qsbr.h
index 550fadf56a..abcbd78914 100644
--- a/lib/rcu/rte_rcu_qsbr.h
+++ b/lib/rcu/rte_rcu_qsbr.h
@@ -86,6 +86,11 @@ struct __rte_cache_aligned rte_rcu_qsbr_cnt {
 #define __RTE_QSBR_CNT_MAX ((uint64_t)~0)
 #define __RTE_QSBR_TOKEN_SIZE sizeof(uint64_t)
 
+/**
+ * Max allowable size (in bytes) of each element in the defer queue
+ */
+#define RTE_QSBR_ESIZE_MAX	(2 * RTE_CACHE_LINE_MIN_SIZE)
+
 /* RTE Quiescent State variable structure.
  * This structure has two elements that vary in size based on the
  * 'max_threads' parameter.
-- 
2.47.2.vfs.0.1

