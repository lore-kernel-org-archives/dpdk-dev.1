Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D244C5B56A
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Aug 2026 11:58:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 65C4B410DF;
	Tue, 11 Aug 2026 13:57:52 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 4DCB042709
 for <dev@dpdk.org>; Tue, 11 Aug 2026 13:57:49 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 315CB1A020F;
 Tue, 11 Aug 2026 13:57:49 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 01AD21A0203;
 Tue, 11 Aug 2026 13:57:49 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 787811800088;
 Tue, 11 Aug 2026 19:57:47 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	thomas@monjalon.net,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v8 10/26] bus/dpaa: add DPAA cgrid cleanup support
Date: Tue, 11 Aug 2026 17:27:15 +0530
Message-Id: <20260811115731.3421032-11-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260811115731.3421032-1-hemant.agrawal@nxp.com>
References: <20260703124950.1895871-1-hemant.agrawal@nxp.com>
 <20260811115731.3421032-1-hemant.agrawal@nxp.com>
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

Add qman_find_fq_by_cgid() to find frame queues associated with
a given CGID. This allows the driver to verify that all FQs
using a CGR are shut down before releasing the CGR ID, preventing
use-after-free of CGR resources.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/bus/dpaa/base/qbman/qman.c       | 36 ++++++++++++++++++++++++
 drivers/bus/dpaa/dpaa_bus_base_symbols.c |  1 +
 drivers/bus/dpaa/include/fsl_qman.h      |  3 ++
 3 files changed, 40 insertions(+)

diff --git a/drivers/bus/dpaa/base/qbman/qman.c b/drivers/bus/dpaa/base/qbman/qman.c
index 56dc1cba45..bb936f8f9b 100644
--- a/drivers/bus/dpaa/base/qbman/qman.c
+++ b/drivers/bus/dpaa/base/qbman/qman.c
@@ -2972,3 +2972,39 @@ qman_shutdown_fq(struct qman_fq *fq)
 out:
 	return ret;
 }
+
+int qman_find_fq_by_cgrid(u32 cgrid, u32 *fqid)
+{
+	struct qman_fq fq = {
+		.fqid = 1
+	};
+	struct qm_mcr_queryfq_np np;
+	struct qm_fqd fqd;
+	int err;
+
+	do {
+		err = qman_query_fq_np(&fq, &np);
+		if (err == -ERANGE) {
+			DPAA_BUS_INFO("No FQ found with cgrid(0x%x)", cgrid);
+			return err;
+		} else if (err) {
+			DPAA_BUS_WARN("Failed(%d) to Query np FQ(fqid=0x%x)",
+				err, fq.fqid);
+			return err;
+		}
+		if ((np.state & QM_MCR_NP_STATE_MASK) != QM_MCR_NP_STATE_OOS) {
+			err = qman_query_fq(&fq, &fqd);
+			if (err) {
+				DPAA_BUS_WARN("Failed(%d) to Query FQ(fqid=0x%x)",
+					err, fq.fqid);
+			} else if ((fqd.fq_ctrl & QM_FQCTRL_CGE) &&
+				fqd.cgid == cgrid) {
+				if (fqid)
+					*fqid = fq.fqid;
+				return 0;
+			}
+		}
+		/* Move to the next FQID */
+		fq.fqid++;
+	} while (1);
+}
diff --git a/drivers/bus/dpaa/dpaa_bus_base_symbols.c b/drivers/bus/dpaa/dpaa_bus_base_symbols.c
index 4b63354e0e..1a4778e65b 100644
--- a/drivers/bus/dpaa/dpaa_bus_base_symbols.c
+++ b/drivers/bus/dpaa/dpaa_bus_base_symbols.c
@@ -57,6 +57,7 @@ RTE_EXPORT_INTERNAL_SYMBOL(qman_alloc_pool_range)
 RTE_EXPORT_INTERNAL_SYMBOL(qman_alloc_cgrid_range)
 RTE_EXPORT_INTERNAL_SYMBOL(qman_release_cgrid_range)
 RTE_EXPORT_INTERNAL_SYMBOL(dpaa_get_qm_channel_pool_num)
+RTE_EXPORT_INTERNAL_SYMBOL(qman_find_fq_by_cgrid)
 RTE_EXPORT_INTERNAL_SYMBOL(dpaa_intr_enable)
 RTE_EXPORT_INTERNAL_SYMBOL(dpaa_intr_disable)
 RTE_EXPORT_INTERNAL_SYMBOL(dpaa_get_ioctl_version_number)
diff --git a/drivers/bus/dpaa/include/fsl_qman.h b/drivers/bus/dpaa/include/fsl_qman.h
index 57b456cdfd..16fb4da98d 100644
--- a/drivers/bus/dpaa/include/fsl_qman.h
+++ b/drivers/bus/dpaa/include/fsl_qman.h
@@ -1908,6 +1908,9 @@ static inline int qman_shutdown_fq_by_fqid(u32 fqid)
 	return qman_shutdown_fq(&fq);
 }
 
+__rte_internal
+int qman_find_fq_by_cgrid(u32 cgrid, u32 *fqid);
+
 /**
  * qman_reserve_fqid_range - Reserve the specified range of frame queue IDs
  * @fqid: the base FQID of the range to deallocate
-- 
2.25.1

