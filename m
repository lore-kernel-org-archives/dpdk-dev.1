Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C076082BEB
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 14:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=XGfn1RbS
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4381642795;
	Tue,  3 Nov 2026 15:56:59 +0100 (CET)
Received: from mta0.migadu.com (out-13.mta0.migadu.com [91.218.175.13])
 by mails.dpdk.org (Postfix) with ESMTPS id E00DC41143
 for <dev@dpdk.org>; Tue,  3 Nov 2026 15:56:57 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=xWF3wIbWMEZjAyTKckBM+eyTs+VUuBHRy33/44ZHi+c=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793717817; v=1; x=1794322617;
 b=XGfn1RbS8fjof6Wd1E3CD6qcuHC8OUEJcaQWt1s3L0hmqHxM0+AHP62jEmtfPTcUcrsIUklv
 0qs6gNWVL/XgVbLhr6wyW0UjqNWn7g5/oubTgt/PDsXvdukpvvpCp6NysFadsxBDpk1LX++xxj/
 +NCIM5ZZe/yEbptfw2njK8GI=
X-Envelope-To: dev@dpdk.org
Received: by mta11.migadu.com with ESMTPS id fa9c68d0130a6d1f;
 Tue, 03 Nov 2026 14:56:57 +0000
X-Mizu-Trace-ID: fa9c68d0130a6d1f
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 023/227] distributor: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:49:41 +0800
Message-ID: <20261103145306.487255-24-chengwen.feng@linux.dev>
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
 lib/distributor/rte_distributor.c        | 6 +++---
 lib/distributor/rte_distributor.h        | 4 ++--
 lib/distributor/rte_distributor_single.c | 4 ++--
 lib/distributor/rte_distributor_single.h | 4 ++--
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/lib/distributor/rte_distributor.c b/lib/distributor/rte_distributor.c
index dde7ce2677..d34a7934fd 100644
--- a/lib/distributor/rte_distributor.c
+++ b/lib/distributor/rte_distributor.c
@@ -720,7 +720,7 @@ rte_distributor_clear_returns(struct rte_distributor *d)
 RTE_EXPORT_SYMBOL(rte_distributor_create)
 struct rte_distributor *
 rte_distributor_create(const char *name,
-		unsigned int socket_id,
+		unsigned int numa_id,
 		unsigned int num_workers,
 		unsigned int alg_type)
 {
@@ -749,7 +749,7 @@ rte_distributor_create(const char *name,
 			return NULL;
 		}
 		d->d_single = rte_distributor_create_single(name,
-				socket_id, num_workers);
+				numa_id, num_workers);
 		if (d->d_single == NULL) {
 			free(d);
 			/* rte_errno will have been set */
@@ -760,7 +760,7 @@ rte_distributor_create(const char *name,
 	}
 
 	snprintf(mz_name, sizeof(mz_name), RTE_DISTRIB_PREFIX"%s", name);
-	mz = rte_memzone_reserve(mz_name, sizeof(*d), socket_id, NO_FLAGS);
+	mz = rte_memzone_reserve(mz_name, sizeof(*d), numa_id, NO_FLAGS);
 	if (mz == NULL) {
 		rte_errno = ENOMEM;
 		return NULL;
diff --git a/lib/distributor/rte_distributor.h b/lib/distributor/rte_distributor.h
index a073e64612..0c72300252 100644
--- a/lib/distributor/rte_distributor.h
+++ b/lib/distributor/rte_distributor.h
@@ -35,7 +35,7 @@ struct rte_mbuf;
  *
  * @param name
  *   The name to be given to the distributor instance.
- * @param socket_id
+ * @param numa_id
  *   The NUMA node on which the memory is to be allocated
  * @param num_workers
  *   The maximum number of workers that will request packets from this
@@ -48,7 +48,7 @@ struct rte_mbuf;
  *   The newly created distributor instance
  */
 struct rte_distributor *
-rte_distributor_create(const char *name, unsigned int socket_id,
+rte_distributor_create(const char *name, unsigned int numa_id,
 		unsigned int num_workers,
 		unsigned int alg_type);
 
diff --git a/lib/distributor/rte_distributor_single.c b/lib/distributor/rte_distributor_single.c
index d4b3e12648..a018a04cea 100644
--- a/lib/distributor/rte_distributor_single.c
+++ b/lib/distributor/rte_distributor_single.c
@@ -375,7 +375,7 @@ rte_distributor_clear_returns_single(struct rte_distributor_single *d)
 /* creates a distributor instance */
 struct rte_distributor_single *
 rte_distributor_create_single(const char *name,
-		unsigned socket_id,
+		unsigned int numa_id,
 		unsigned num_workers)
 {
 	struct rte_distributor_single *d;
@@ -395,7 +395,7 @@ rte_distributor_create_single(const char *name,
 	}
 
 	snprintf(mz_name, sizeof(mz_name), RTE_DISTRIB_PREFIX"%s", name);
-	mz = rte_memzone_reserve(mz_name, sizeof(*d), socket_id, NO_FLAGS);
+	mz = rte_memzone_reserve(mz_name, sizeof(*d), numa_id, NO_FLAGS);
 	if (mz == NULL) {
 		rte_errno = ENOMEM;
 		return NULL;
diff --git a/lib/distributor/rte_distributor_single.h b/lib/distributor/rte_distributor_single.h
index 2f80aa43d1..289703601d 100644
--- a/lib/distributor/rte_distributor_single.h
+++ b/lib/distributor/rte_distributor_single.h
@@ -30,7 +30,7 @@ struct rte_mbuf;
  *
  * @param name
  *   The name to be given to the distributor instance.
- * @param socket_id
+ * @param numa_id
  *   The NUMA node on which the memory is to be allocated
  * @param num_workers
  *   The maximum number of workers that will request packets from this
@@ -39,7 +39,7 @@ struct rte_mbuf;
  *   The newly created distributor instance
  */
 struct rte_distributor_single *
-rte_distributor_create_single(const char *name, unsigned int socket_id,
+rte_distributor_create_single(const char *name, unsigned int numa_id,
 		unsigned int num_workers);
 
 /*  *** APIS to be called on the distributor lcore ***  */
-- 
2.55.0

