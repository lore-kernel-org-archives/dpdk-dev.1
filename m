Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7341C43458
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Jul 2026 12:50:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E294F40A73;
	Fri,  3 Jul 2026 14:50:04 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id E2258409FA
 for <dev@dpdk.org>; Fri,  3 Jul 2026 14:50:01 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C655E200006;
 Fri,  3 Jul 2026 14:50:01 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9C6F320001D;
 Fri,  3 Jul 2026 14:50:01 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 1F6C01800090;
 Fri,  3 Jul 2026 20:49:59 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	david.marchand@redhat.com,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v7 05/16] bus/dpaa: shutdown DPAA FQ by fq descriptor
Date: Fri,  3 Jul 2026 18:19:39 +0530
Message-Id: <20260703124950.1895871-6-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260703124950.1895871-1-hemant.agrawal@nxp.com>
References: <20260702053359.3243907-1-hemant.agrawal@nxp.com>
 <20260703124950.1895871-1-hemant.agrawal@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
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

From: Jun Yang <jun.yang@nxp.com>

Pass the full FQ descriptor to qman_shutdown_fq() instead of
just the fqid, so that channel-affine portals can be correctly
accessed when shutting down push-mode Rx queues.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/bus/dpaa/base/qbman/qman.c  |  9 +++++----
 drivers/bus/dpaa/include/fsl_qman.h | 11 ++++++++++-
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/bus/dpaa/base/qbman/qman.c b/drivers/bus/dpaa/base/qbman/qman.c
index c9a8ec34a5..dc8aeaa568 100644
--- a/drivers/bus/dpaa/base/qbman/qman.c
+++ b/drivers/bus/dpaa/base/qbman/qman.c
@@ -2781,18 +2781,19 @@ qm_mc_result_timeout(struct qm_portal *portal,
 
 RTE_EXPORT_INTERNAL_SYMBOL(qman_shutdown_fq)
 int
-qman_shutdown_fq(u32 fqid)
+qman_shutdown_fq(struct qman_fq *fq)
 {
-	struct qman_portal *p;
+	struct qman_portal *p = fq->qp;
 	struct qm_mc_command *mcc;
 	struct qm_mc_result *mcr;
 	int orl_empty, drain = 0, ret = 0;
-	u32 res;
+	u32 res, fqid = fq->fqid;
 	u8 state;
 	u32 channel, wq;
 
 	DPAA_BUS_DEBUG("In shutdown for queue = %x", fqid);
-	p = get_affine_portal();
+	if (!p)
+		p = get_affine_portal();
 	/* Determine the state of the FQID */
 	mcc = qm_mc_start(&p->p);
 	mcc->queryfq_np.fqid = cpu_to_be32(fqid);
diff --git a/drivers/bus/dpaa/include/fsl_qman.h b/drivers/bus/dpaa/include/fsl_qman.h
index 82269cdf99..673859ed2e 100644
--- a/drivers/bus/dpaa/include/fsl_qman.h
+++ b/drivers/bus/dpaa/include/fsl_qman.h
@@ -1896,7 +1896,16 @@ static inline void qman_release_fqid(u32 fqid)
 void qman_seed_fqid_range(u32 fqid, unsigned int count);
 
 __rte_internal
-int qman_shutdown_fq(u32 fqid);
+int qman_shutdown_fq(struct qman_fq *fq);
+
+static inline int qman_shutdown_fq_by_fqid(u32 fqid)
+{
+	struct qman_fq fq;
+
+	memset(&fq, 0, sizeof(struct qman_fq));
+	fq.fqid = fqid;
+	return qman_shutdown_fq(&fq);
+}
 
 /**
  * qman_reserve_fqid_range - Reserve the specified range of frame queue IDs
-- 
2.25.1

