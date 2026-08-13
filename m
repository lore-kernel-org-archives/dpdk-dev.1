Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A02FEC5CFDB
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 10:44:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ACB47427DB;
	Thu, 13 Aug 2026 12:44:19 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id E8498410DF
 for <dev@dpdk.org>; Thu, 13 Aug 2026 12:44:16 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id CC90D1A0052;
 Thu, 13 Aug 2026 12:44:16 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9963E1A0032;
 Thu, 13 Aug 2026 12:44:16 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 6302718000B1;
 Thu, 13 Aug 2026 18:44:15 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	thomas@monjalon.net,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v10 05/25] drivers: shutdown DPAA FQ by fq descriptor
Date: Thu, 13 Aug 2026 16:13:45 +0530
Message-Id: <20260813104405.2313474-6-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260813104405.2313474-1-hemant.agrawal@nxp.com>
References: <20260812174609.1100111-1-hemant.agrawal@nxp.com>
 <20260813104405.2313474-1-hemant.agrawal@nxp.com>
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
 drivers/net/dpaa/dpaa_ethdev.c      |  2 +-
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/bus/dpaa/base/qbman/qman.c b/drivers/bus/dpaa/base/qbman/qman.c
index 931d487de4..2315b81065 100644
--- a/drivers/bus/dpaa/base/qbman/qman.c
+++ b/drivers/bus/dpaa/base/qbman/qman.c
@@ -2784,18 +2784,19 @@ qm_mc_result_timeout(struct qm_portal *portal,
 
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
diff --git a/drivers/net/dpaa/dpaa_ethdev.c b/drivers/net/dpaa/dpaa_ethdev.c
index e1245c862a..cd3cd828e4 100644
--- a/drivers/net/dpaa/dpaa_ethdev.c
+++ b/drivers/net/dpaa/dpaa_ethdev.c
@@ -1120,7 +1120,7 @@ int dpaa_eth_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 			queue_idx, rxq->fqid);
 
 	/* Shutdown FQ before configure */
-	qman_shutdown_fq(rxq->fqid);
+	qman_shutdown_fq_by_fqid(rxq->fqid);
 
 	if (!fif->num_profiles) {
 		if (dpaa_intf->bp_info && dpaa_intf->bp_info->bp &&
-- 
2.25.1

