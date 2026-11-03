Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8F1606EE80
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=f6Tjzr27
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 83C9242DB0;
	Tue,  3 Nov 2026 16:06:01 +0100 (CET)
Received: from mta0.migadu.com (out-24.mta0.migadu.com [91.218.175.24])
 by mails.dpdk.org (Postfix) with ESMTPS id ADA2C4113D
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:05:59 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=0+QuhIIWkhL0Lny1UUlGNt4X+/R5KyyR2U5dxDNzc78=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718359; v=1; x=1794323159;
 b=f6Tjzr27B2QyF5yuHdg51Q5sxyvc4VcXtpHF/ReAkBDiU5POxWlkMYA4Y3uqFHxZ92lGWEw2
 qR/MCpWcUWCYnl4fVdGLcNgoSSjRU3EjnSPhy+cUo6CT6CpCkEy5R3JVgZNEY0N9ZFyWGpEIjTH
 1Pp24wWGB8oyBbbif2HAangY=
X-Envelope-To: dev@dpdk.org
Received: by mta12.migadu.com with ESMTPS id 01417e4cf71175b6;
 Tue, 03 Nov 2026 15:05:59 +0000
X-Mizu-Trace-ID: 01417e4cf71175b6
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 078/227] crypto/uadk: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:50:36 +0800
Message-ID: <20261103145306.487255-79-chengwen.feng@linux.dev>
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
 drivers/crypto/uadk/uadk_crypto_pmd.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/crypto/uadk/uadk_crypto_pmd.c b/drivers/crypto/uadk/uadk_crypto_pmd.c
index 221ad546da..0758fb6e1b 100644
--- a/drivers/crypto/uadk/uadk_crypto_pmd.c
+++ b/drivers/crypto/uadk/uadk_crypto_pmd.c
@@ -485,7 +485,7 @@ uadk_pmd_qp_set_unique_name(struct rte_cryptodev *dev,
 /* Create a ring to place process packets on */
 static struct rte_ring *
 uadk_pmd_qp_create_processed_pkts_ring(struct uadk_qp *qp,
-				       unsigned int ring_size, int socket_id)
+				       unsigned int ring_size, int numa_id)
 {
 	struct rte_ring *r = qp->processed_pkts;
 
@@ -501,14 +501,14 @@ uadk_pmd_qp_create_processed_pkts_ring(struct uadk_qp *qp,
 		return NULL;
 	}
 
-	return rte_ring_create(qp->name, ring_size, socket_id,
+	return rte_ring_create(qp->name, ring_size, numa_id,
 			       RING_F_EXACT_SZ);
 }
 
 static int
 uadk_crypto_pmd_qp_setup(struct rte_cryptodev *dev, uint16_t qp_id,
 			 const struct rte_cryptodev_qp_conf *qp_conf,
-			 int socket_id)
+			 int numa_id)
 {
 	struct uadk_qp *qp;
 
@@ -517,8 +517,8 @@ uadk_crypto_pmd_qp_setup(struct rte_cryptodev *dev, uint16_t qp_id,
 		uadk_crypto_pmd_qp_release(dev, qp_id);
 
 	/* Allocate the queue pair data structure. */
-	qp = rte_zmalloc_socket("uadk PMD Queue Pair", sizeof(*qp),
-				RTE_CACHE_LINE_SIZE, socket_id);
+	qp = rte_zmalloc_numa("uadk PMD Queue Pair", sizeof(*qp),
+				RTE_CACHE_LINE_SIZE, numa_id);
 	if (qp == NULL)
 		return (-ENOMEM);
 
@@ -529,7 +529,7 @@ uadk_crypto_pmd_qp_setup(struct rte_cryptodev *dev, uint16_t qp_id,
 		goto qp_setup_cleanup;
 
 	qp->processed_pkts = uadk_pmd_qp_create_processed_pkts_ring(qp,
-				qp_conf->nb_descriptors, socket_id);
+				qp_conf->nb_descriptors, numa_id);
 	if (qp->processed_pkts == NULL)
 		goto qp_setup_cleanup;
 
-- 
2.55.0

