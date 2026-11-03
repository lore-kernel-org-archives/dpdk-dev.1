Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61F3606BA1B
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=olgFr4t+
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8BE4642DD1;
	Tue,  3 Nov 2026 16:09:53 +0100 (CET)
Received: from mta1.migadu.com (out-34.mta1.migadu.com [95.215.58.34])
 by mails.dpdk.org (Postfix) with ESMTPS id 3749840616
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:09:52 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=RGZCMFcP8sJfYzfP/VzwZxRzwRmwu6HNw3NUE/DJnmE=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718592; v=1; x=1794323392;
 b=olgFr4t+HYa8jNWHchLsMNw9kUX3CC7tuK4k/32OKq0p8hSHndiGwQmUEBB6s586NpAAiOm/
 iU9uP0ij+r1PaJ0QzLa9hBDnr1ohvOMOcJ5SJ10EUQDigDH6pgLugkgXDMdHL6a/mEdei5FHjL1
 A0JvphdGJufJqKLFOxHPSmfA=
X-Envelope-To: dev@dpdk.org
Received: by mta11.migadu.com with ESMTPS id ae80aaac13eeffed;
 Tue, 03 Nov 2026 15:09:51 +0000
X-Mizu-Trace-ID: ae80aaac13eeffed
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 101/227] ml/cnxk: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:50:59 +0800
Message-ID: <20261103145306.487255-102-chengwen.feng@linux.dev>
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
 drivers/ml/cnxk/cnxk_ml_ops.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/ml/cnxk/cnxk_ml_ops.c b/drivers/ml/cnxk/cnxk_ml_ops.c
index dc05764306..c47c58e4d0 100644
--- a/drivers/ml/cnxk/cnxk_ml_ops.c
+++ b/drivers/ml/cnxk/cnxk_ml_ops.c
@@ -73,7 +73,7 @@ cnxk_ml_dev_queue_pair_release(struct rte_ml_dev *dev, uint16_t queue_pair_id)
 }
 
 static struct cnxk_ml_qp *
-cnxk_ml_qp_create(const struct rte_ml_dev *dev, uint16_t qp_id, uint32_t nb_desc, int socket_id)
+cnxk_ml_qp_create(const struct rte_ml_dev *dev, uint16_t qp_id, uint32_t nb_desc, int numa_id)
 {
 	const struct rte_memzone *qp_mem;
 	char name[RTE_MEMZONE_NAMESIZE];
@@ -85,8 +85,8 @@ cnxk_ml_qp_create(const struct rte_ml_dev *dev, uint16_t qp_id, uint32_t nb_desc
 	cnxk_mldev = dev->data->dev_private;
 
 	/* Allocate queue pair */
-	qp = rte_zmalloc_socket("cnxk_ml_pmd_queue_pair", sizeof(struct cnxk_ml_qp), ROC_ALIGN,
-				socket_id);
+	qp = rte_zmalloc_numa("cnxk_ml_pmd_queue_pair", sizeof(struct cnxk_ml_qp), ROC_ALIGN,
+				numa_id);
 	if (qp == NULL) {
 		plt_err("Could not allocate queue pair");
 		return NULL;
@@ -96,7 +96,7 @@ cnxk_ml_qp_create(const struct rte_ml_dev *dev, uint16_t qp_id, uint32_t nb_desc
 	len = nb_desc * sizeof(struct cnxk_ml_req);
 	qp_memzone_name_get(name, RTE_MEMZONE_NAMESIZE, dev->data->dev_id, qp_id);
 	qp_mem = rte_memzone_reserve_aligned(
-		name, len, socket_id, RTE_MEMZONE_SIZE_HINT_ONLY | RTE_MEMZONE_256MB, ROC_ALIGN);
+		name, len, numa_id, RTE_MEMZONE_SIZE_HINT_ONLY | RTE_MEMZONE_256MB, ROC_ALIGN);
 	if (qp_mem == NULL) {
 		plt_err("Could not reserve memzone: %s", name);
 		goto qp_free;
@@ -837,7 +837,7 @@ cnxk_ml_dev_selftest(struct rte_ml_dev *dev)
 
 static int
 cnxk_ml_dev_queue_pair_setup(struct rte_ml_dev *dev, uint16_t queue_pair_id,
-			     const struct rte_ml_dev_qp_conf *qp_conf, int socket_id)
+			     const struct rte_ml_dev_qp_conf *qp_conf, int numa_id)
 {
 	struct rte_ml_dev_info dev_info;
 	struct cnxk_ml_qp *qp;
@@ -870,7 +870,7 @@ cnxk_ml_dev_queue_pair_setup(struct rte_ml_dev *dev, uint16_t queue_pair_id,
 	 */
 	nb_desc =
 		(qp_conf->nb_desc == dev_info.max_desc) ? dev_info.max_desc : qp_conf->nb_desc + 1;
-	qp = cnxk_ml_qp_create(dev, queue_pair_id, nb_desc, socket_id);
+	qp = cnxk_ml_qp_create(dev, queue_pair_id, nb_desc, numa_id);
 	if (qp == NULL) {
 		plt_err("Could not create queue pair %u", queue_pair_id);
 		return -ENOMEM;
-- 
2.55.0

