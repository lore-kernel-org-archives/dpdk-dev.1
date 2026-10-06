Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7011FCA5FF0
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Oct 2026 09:28:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F100240EDF;
	Tue,  6 Oct 2026 11:27:19 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id E7A7E40E09
 for <dev@dpdk.org>; Tue,  6 Oct 2026 11:27:10 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id CA9192001AB;
 Tue,  6 Oct 2026 11:27:10 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 94D662001A8;
 Tue,  6 Oct 2026 11:27:10 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 18D9B1800230;
 Tue,  6 Oct 2026 17:27:10 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	thomas@monjalon.net,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v21 10/27] drivers: shutdown DPAA FQ by fq descriptor
Date: Tue,  6 Oct 2026 14:56:46 +0530
Message-Id: <20261006092703.2138929-11-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261006092703.2138929-1-hemant.agrawal@nxp.com>
References: <20261005085337.1069213-1-hemant.agrawal@nxp.com>
 <20261006092703.2138929-1-hemant.agrawal@nxp.com>
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

qman_shutdown_fq() took only an fqid and always drained the FQ through
get_affine_portal(), the portal of the calling thread. A frame queue
that belongs to a different portal cannot be drained that way.

Take the FQ descriptor instead and use fq->qp when the caller has one,
falling back to the affine portal otherwise, so a caller that owns the
queue can drain it on the portal the queue is bound to.

Add a qman_shutdown_fq_by_fqid() wrapper for the one caller that only
has an fqid: net/dpaa cleans up a frame queue left behind by a previous
run before the queue is initialized, so no descriptor exists yet.

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
index 049723cb19..cfc1685cc8 100644
--- a/drivers/net/dpaa/dpaa_ethdev.c
+++ b/drivers/net/dpaa/dpaa_ethdev.c
@@ -2359,7 +2359,7 @@ dpaa_dev_init(struct rte_eth_dev *eth_dev)
 		/* Clean up a frame queue left behind by a previous run
 		 * before it is initialized.
 		 */
-		qman_shutdown_fq(fqid);
+		qman_shutdown_fq_by_fqid(fqid);
 
 		if (dpaa_intf->cgr_rx)
 			dpaa_intf->cgr_rx[loop].cgrid = cgrid[loop];
-- 
2.25.1

