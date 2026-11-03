Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26C96082BF1
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 14:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ZZuYFhKV
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B88374278E;
	Tue,  3 Nov 2026 15:57:30 +0100 (CET)
Received: from mta0.migadu.com (out-31.mta0.migadu.com [91.218.175.31])
 by mails.dpdk.org (Postfix) with ESMTPS id 6D89542708
 for <dev@dpdk.org>; Tue,  3 Nov 2026 15:57:29 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=OS/CVMRQI/A14SSD/GoTEVOF9ZlQgbVYnvW8DYDbxew=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793717849; v=1; x=1794322649;
 b=ZZuYFhKV6slDnUCSUHyb9QmqthTDdSV/FllnezCcz0hfZU4gZicn2dOhcIdVUXT87dWxm9oU
 tzR0Jy63QSZYPk5T5XBXvRx0YJv3PZfGYUTiLnlLtPwad+yqSXeEfv+bvxsGqOcdyQhecknpQ3k
 qaCGos5/O0WvSv4WroPweD30=
X-Envelope-To: dev@dpdk.org
Received: by mta10.migadu.com with ESMTPS id fb5da14aae59094b;
 Tue, 03 Nov 2026 14:57:29 +0000
X-Mizu-Trace-ID: fb5da14aae59094b
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 027/227] metrics: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:49:45 +0800
Message-ID: <20261103145306.487255-28-chengwen.feng@linux.dev>
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
 lib/metrics/rte_metrics.c           | 4 ++--
 lib/metrics/rte_metrics.h           | 4 ++--
 lib/metrics/rte_metrics_telemetry.c | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/metrics/rte_metrics.c b/lib/metrics/rte_metrics.c
index 4cd4623b7a..8896ea770f 100644
--- a/lib/metrics/rte_metrics.c
+++ b/lib/metrics/rte_metrics.c
@@ -58,7 +58,7 @@ struct rte_metrics_data_s {
 
 RTE_EXPORT_SYMBOL(rte_metrics_init)
 int
-rte_metrics_init(int socket_id)
+rte_metrics_init(int numa_id)
 {
 	struct rte_metrics_data_s *stats;
 	const struct rte_memzone *memzone;
@@ -72,7 +72,7 @@ rte_metrics_init(int socket_id)
 	if (memzone != NULL)
 		return -EEXIST;
 	memzone = rte_memzone_reserve(RTE_METRICS_MEMZONE_NAME,
-		sizeof(struct rte_metrics_data_s), socket_id, 0);
+		sizeof(struct rte_metrics_data_s), numa_id, 0);
 	if (memzone == NULL)
 		return -ENOMEM;
 	stats = memzone->addr;
diff --git a/lib/metrics/rte_metrics.h b/lib/metrics/rte_metrics.h
index 5e17873dd7..e8e10447c3 100644
--- a/lib/metrics/rte_metrics.h
+++ b/lib/metrics/rte_metrics.h
@@ -76,7 +76,7 @@ struct rte_metric_value {
  * Initializes metric module. This function must be called from
  * a primary process before metrics are used.
  *
- * @param socket_id
+ * @param numa_id
  *   Socket to use for shared memory allocation.
  * @return
  *   0 on success
@@ -85,7 +85,7 @@ struct rte_metric_value {
  *     -ENOMEM - cannot allocate metrics memzone
  *     -E_RTE_SECONDARY - function called from secondary process
  */
-int rte_metrics_init(int socket_id);
+int rte_metrics_init(int numa_id);
 
 /**
  * Deinitialize metric module. This function must be called from
diff --git a/lib/metrics/rte_metrics_telemetry.c b/lib/metrics/rte_metrics_telemetry.c
index 2350ef5041..d7acd956db 100644
--- a/lib/metrics/rte_metrics_telemetry.c
+++ b/lib/metrics/rte_metrics_telemetry.c
@@ -98,7 +98,7 @@ rte_metrics_tel_reg_all_ethdev(int *metrics_register_done, int *reg_index_list)
 	int ret, nb_drv_idx = 0;
 	uint16_t d;
 
-	rte_metrics_init(rte_socket_id());
+	rte_metrics_init(rte_numa_id());
 	RTE_ETH_FOREACH_DEV(d) {
 		int i;
 		/* Different device types have different numbers of stats, so
@@ -443,7 +443,7 @@ static int
 rte_metrics_tel_initial_metrics_setup(void)
 {
 	int ret;
-	rte_metrics_init(rte_socket_id());
+	rte_metrics_init(rte_numa_id());
 
 	if (!tel_met_data.metrics_register_done) {
 		ret = rte_metrics_tel_reg_all_ethdev(
-- 
2.55.0

