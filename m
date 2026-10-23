Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328BB606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 13:47:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D850C40A81;
	Fri, 23 Oct 2026 15:44:37 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 6B6FD40E3B
 for <dev@dpdk.org>; Fri, 23 Oct 2026 15:44:25 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 4CCAC1A0021;
 Fri, 23 Oct 2026 15:44:25 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 14F811A000A;
 Fri, 23 Oct 2026 15:44:25 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id A25D61800068;
 Fri, 23 Oct 2026 21:44:23 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v4-S3 30/65] bus/fslmc: add alloc/free DPIO API for non-affine
 portals
Date: Fri, 23 Oct 2026 19:13:10 +0530
Message-ID: <20261023134346.37727-31-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023134346.37727-1-prashant.gupta_3@nxp.com>
References: <20260915120208.4185877-1-prashant.gupta_3@nxp.com>
 <20261023134346.37727-1-prashant.gupta_3@nxp.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jun Yang <jun.yang@nxp.com>

Add rte_dpaa2_alloc_dpio_device() and rte_dpaa2_free_dpio_device() to
grab and release a DPIO software portal that is not tied to a specific
CPU affinity. The allocator reserves a free portal from the DPIO list,
sets up the DQRI interrupt when the event driver is built in, and the
release helper returns the portal via dpaa2_put_qbman_swp().

This lets consumers that manage their own threading (rather than the
per-lcore affine portals) obtain a dedicated portal handle.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.c | 40 ++++++++++++++++++++++++
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.h |  8 +++++
 2 files changed, 48 insertions(+)

diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
index 8af8600935..63e1660686 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
@@ -422,6 +422,46 @@ static void dpaa2_portal_finish(void *arg)
 	pthread_setspecific(dpaa2_portal_key, NULL);
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_dpaa2_alloc_dpio_device)
+struct dpaa2_dpio_dev *
+rte_dpaa2_alloc_dpio_device(void)
+{
+	struct dpaa2_dpio_dev *dpio_dev = NULL;
+	uint16_t expected = 0;
+
+	/* Get DPIO dev handle from list using index */
+	TAILQ_FOREACH(dpio_dev, &dpio_dev_list, next) {
+		if (dpio_dev &&
+			rte_atomic_compare_exchange_strong_explicit(&dpio_dev->ref_count,
+			&expected, 1, rte_memory_order_acquire, rte_memory_order_relaxed))
+			break;
+	}
+	if (!dpio_dev) {
+		DPAA2_BUS_ERR("No software portal resource left");
+		return NULL;
+	}
+
+	DPAA2_BUS_DEBUG("New Portal %p (%d) affined thread - %u",
+		dpio_dev, dpio_dev->index, rte_gettid());
+
+#ifdef RTE_EVENT_DPAA2
+	if (dpaa2_dpio_intr_init(dpio_dev, 1, 0, false)) {
+		DPAA2_BUS_ERR("Interrupt registration failed for dpio");
+		rte_atomic_store_explicit(&dpio_dev->ref_count, 0,
+			rte_memory_order_release);
+		return NULL;
+	}
+#endif
+
+	return dpio_dev;
+}
+
+RTE_EXPORT_INTERNAL_SYMBOL(rte_dpaa2_free_dpio_device)
+void rte_dpaa2_free_dpio_device(struct dpaa2_dpio_dev *dpio_dev)
+{
+	dpaa2_put_qbman_swp(dpio_dev);
+}
+
 static void
 dpaa2_close_dpio_device(int object_id)
 {
diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.h b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.h
index 0838254437..59a9d11955 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.h
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.h
@@ -70,4 +70,12 @@ __rte_internal
 uint32_t
 dpaa2_free_eq_descriptors(void);
 
+__rte_internal
+struct dpaa2_dpio_dev *
+rte_dpaa2_alloc_dpio_device(void);
+
+__rte_internal
+void
+rte_dpaa2_free_dpio_device(struct dpaa2_dpio_dev *dpio_dev);
+
 #endif /* _DPAA2_HW_DPIO_H_ */
-- 
2.43.0

