Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B00606BA00
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=j6jrGvuy
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C504842788;
	Tue,  3 Nov 2026 16:03:33 +0100 (CET)
Received: from mta0.migadu.com (out-198.mta0.migadu.com [91.218.175.198])
 by mails.dpdk.org (Postfix) with ESMTPS id 8151A4113D
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:03:32 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=GOW2cTsKR3/AX5X0gAKXbDUKqFV1DuF2vAgsvVXtVBc=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718212; v=1; x=1794323012;
 b=j6jrGvuyRarW++JzMUVOmUZFV3nA3sTZkmWuZ8pRm0EPhC8iIK2yceyl1di1luw+0dC/hITL
 Z7AAxNIwJ1TjwjC++VW0zWhryQWanarK19Q25+xiLh8OQfRS6amr9dXcErEtwp/vm9TunxLO3sT
 z5wDrmCnu4hE/OzIN1aSZT94=
X-Envelope-To: dev@dpdk.org
Received: by mta10.migadu.com with ESMTPS id 4d9e5e1ea7b1e855;
 Tue, 03 Nov 2026 15:03:32 +0000
X-Mizu-Trace-ID: 4d9e5e1ea7b1e855
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 061/227] compress/zsda: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:50:19 +0800
Message-ID: <20261103145306.487255-62-chengwen.feng@linux.dev>
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
 drivers/compress/zsda/zsda_comp_pmd.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/compress/zsda/zsda_comp_pmd.c b/drivers/compress/zsda/zsda_comp_pmd.c
index 6d857be2f0..057e7178e2 100644
--- a/drivers/compress/zsda/zsda_comp_pmd.c
+++ b/drivers/compress/zsda/zsda_comp_pmd.c
@@ -227,7 +227,7 @@ zsda_private_xform_free(struct rte_compressdev *dev __rte_unused,
 
 static int
 zsda_qp_setup(struct rte_compressdev *dev, uint16_t qp_id,
-		uint32_t max_inflight_ops, int socket_id)
+		uint32_t max_inflight_ops, int numa_id)
 {
 	int ret = ZSDA_SUCCESS;
 	struct zsda_qp *qp_new;
@@ -247,15 +247,15 @@ zsda_qp_setup(struct rte_compressdev *dev, uint16_t qp_id,
 			return ret;
 	}
 
-	qp_new = rte_zmalloc_socket("zsda PMD qp metadata", sizeof(*qp_new),
-				    RTE_CACHE_LINE_SIZE, socket_id);
+	qp_new = rte_zmalloc_numa("zsda PMD qp metadata", sizeof(*qp_new),
+				    RTE_CACHE_LINE_SIZE, numa_id);
 	if (qp_new == NULL) {
 		ZSDA_LOG(ERR, "Failed! qp_new is NULL");
 		return -ENOMEM;
 	}
 
 	task_q_info.nb_des = nb_des;
-	task_q_info.socket_id = socket_id;
+	task_q_info.numa_id = numa_id;
 	task_q_info.qp_id = qp_id;
 	task_q_info.rx_cb = zsda_comp_callback;
 
@@ -377,7 +377,7 @@ zsda_comp_dev_create(struct zsda_pci_device *zsda_pci_dev)
 	comp_dev->capa_mz = rte_memzone_lookup(capa_memz_name);
 	if (comp_dev->capa_mz == NULL)
 		comp_dev->capa_mz = rte_memzone_reserve(
-			capa_memz_name, capa_size, rte_socket_id(), 0);
+			capa_memz_name, capa_size, rte_numa_id(), 0);
 
 	if (comp_dev->capa_mz == NULL) {
 		ZSDA_LOG(DEBUG, "Failed! comp_dev->capa_mz is NULL");
-- 
2.55.0

