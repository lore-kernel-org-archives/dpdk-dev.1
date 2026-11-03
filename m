Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B519E606A796
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=bkOOQB6/
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7A9B042DCB;
	Tue,  3 Nov 2026 16:06:46 +0100 (CET)
Received: from mta1.migadu.com (out-91.mta1.migadu.com [95.215.58.91])
 by mails.dpdk.org (Postfix) with ESMTPS id 703C14113D
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:06:45 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=x0axmGJLWaIUUXHm4qR1etQ27KNcTsOkQHOL/Bk72yc=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718405; v=1; x=1794323205;
 b=bkOOQB6/bsDRFAxfQpDPyZvqGlbBYubpiErohROHv3ShgZFJCdzAVMV5jxYMDGveubeFLN+y
 5Fz5umOD+I2t6qa64cTRGmbG/KVjPpWGhJIJuPL1YPcBiYHpw83hg1SzVqcbmUArpQdBv6ql6rt
 IbfCanqESkMRkrGho23cSGjE=
X-Envelope-To: dev@dpdk.org
Received: by mta11.migadu.com with ESMTPS id 9e263f5b8ce45210;
 Tue, 03 Nov 2026 15:06:45 +0000
X-Mizu-Trace-ID: 9e263f5b8ce45210
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 080/227] crypto/zsda: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:50:38 +0800
Message-ID: <20261103145306.487255-81-chengwen.feng@linux.dev>
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
 drivers/crypto/zsda/zsda_crypto_pmd.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/crypto/zsda/zsda_crypto_pmd.c b/drivers/crypto/zsda/zsda_crypto_pmd.c
index d1cdfcce0b..d080a26891 100644
--- a/drivers/crypto/zsda/zsda_crypto_pmd.c
+++ b/drivers/crypto/zsda/zsda_crypto_pmd.c
@@ -115,7 +115,7 @@ zsda_crypto_stats_reset(struct rte_cryptodev *dev)
 static int
 zsda_qp_setup(struct rte_cryptodev *dev, uint16_t qp_id,
 		  const struct rte_cryptodev_qp_conf *qp_conf,
-		  int socket_id)
+		  int numa_id)
 {
 	int ret = ZSDA_SUCCESS;
 	struct zsda_qp *qp_new;
@@ -134,15 +134,15 @@ zsda_qp_setup(struct rte_cryptodev *dev, uint16_t qp_id,
 			return ret;
 	}
 
-	qp_new = rte_zmalloc_socket("zsda PMD qp metadata", sizeof(*qp_new),
-				    RTE_CACHE_LINE_SIZE, socket_id);
+	qp_new = rte_zmalloc_numa("zsda PMD qp metadata", sizeof(*qp_new),
+				    RTE_CACHE_LINE_SIZE, numa_id);
 	if (qp_new == NULL) {
 		ZSDA_LOG(ERR, "Failed to alloc mem for qp struct");
 		return -ENOMEM;
 	}
 
 	task_q_info.nb_des = nb_des;
-	task_q_info.socket_id = socket_id;
+	task_q_info.numa_id = numa_id;
 	task_q_info.qp_id = qp_id;
 	task_q_info.rx_cb = zsda_crypto_callback;
 
@@ -315,7 +315,7 @@ zsda_crypto_dev_create(struct zsda_pci_device *zsda_pci_dev)
 	crypto_dev_priv->capa_mz = rte_memzone_lookup(capa_memz_name);
 	if (crypto_dev_priv->capa_mz == NULL)
 		crypto_dev_priv->capa_mz = rte_memzone_reserve(
-			capa_memz_name, capa_size, rte_socket_id(), 0);
+			capa_memz_name, capa_size, rte_numa_id(), 0);
 
 	if (crypto_dev_priv->capa_mz == NULL) {
 		ZSDA_LOG(ERR, "Failed! crypto_dev_priv->capa_mz");
-- 
2.55.0

