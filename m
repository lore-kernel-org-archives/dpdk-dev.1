Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DEC606A31B
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 13:44:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 99C9140647;
	Fri, 23 Oct 2026 15:43:59 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 453EF40268
 for <dev@dpdk.org>; Fri, 23 Oct 2026 15:43:55 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2487D1A0021;
 Fri, 23 Oct 2026 15:43:55 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E17AC1A000A;
 Fri, 23 Oct 2026 15:43:54 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 8727F18000B1;
 Fri, 23 Oct 2026 21:43:53 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v4-S3 03/65] crypto/dpaa2_sec: use table-driven devargs parsing
Date: Fri, 23 Oct 2026 19:12:43 +0530
Message-ID: <20261023134346.37727-4-prashant.gupta_3@nxp.com>
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

Convert the dpaa2_sec devargs handling to the shared dpaax_devargs
table so each argument key is declared once and drives both the parse
table and the registered valid-args string.

Replace the custom check_devargs_handler()/dpaa2_sec_get_devargs()
pair with the generic dpaax_get_devargs() helper, and attach per-arg
callbacks (dpaa2_sec_devarg_dump_set, dpaa2_sec_devarg_order_set) for
the value-carrying arguments.

Move the dump level out of the global dpaa2_sec_dp_dump variable into
the per-device private data (priv->dump_level) so the dump setting is
scoped per device instead of being process-global, and move the
dpaa2_sec_dump_levels enum into dpaa2_sec_priv.h.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c | 133 ++++++++------------
 drivers/crypto/dpaa2_sec/dpaa2_sec_priv.h   |  10 +-
 2 files changed, 61 insertions(+), 82 deletions(-)

diff --git a/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c b/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
index 3d980d096f..6e759dd821 100644
--- a/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
+++ b/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  *
  *   Copyright (c) 2016 Freescale Semiconductor, Inc. All rights reserved.
- *   Copyright 2016-2025 NXP
+ *   Copyright 2016-2026 NXP
  *
  */
 
@@ -31,6 +31,7 @@
 #include <fsl_dpseci.h>
 #include <fsl_mc_sys.h>
 #include <rte_hexdump.h>
+#include <dpaax_devarg.h>
 
 #include "dpaa2_sec_priv.h"
 #include "dpaa2_sec_event.h"
@@ -55,18 +56,40 @@
 #define DPAA2_DEFAULT_NAT_T_PORT 4500
 #define NO_PREFETCH 0
 
-#define DRIVER_DUMP_MODE "drv_dump_mode"
-#define DRIVER_STRICT_ORDER "drv_strict_order"
+static void
+dpaa2_sec_devarg_order_set(void *vdev, const struct rte_kvargs_pair *pair)
+{
+	struct rte_cryptodev *dev = vdev;
+	struct dpaa2_sec_dev_private *priv = dev->data->dev_private;
+
+	priv->en_loose_ordered = atoi(pair->value) ? false : true;
+}
+
+static void
+dpaa2_sec_devarg_dump_set(void *vdev, const struct rte_kvargs_pair *pair)
+{
+	struct rte_cryptodev *dev = vdev;
+	struct dpaa2_sec_dev_private *priv = dev->data->dev_private;
+	enum dpaa2_sec_dump_levels val;
+
+	val = atoi(pair->value);
+	if (val > DPAA2_SEC_DP_FULL_DUMP) {
+		DPAA2_SEC_WARN("%s: val(%d) > full dump(%d), changing to full dump",
+			__func__, val, DPAA2_SEC_DP_FULL_DUMP);
+		val = DPAA2_SEC_DP_FULL_DUMP;
+	}
+	priv->dump_level = val;
+}
+
+#define DPAA2_DEVARGS(ENTRY) \
+	ENTRY("drv_dump_mode", dpaa2_sec_devarg_dump_set, 0) \
+	ENTRY("drv_strict_order", dpaa2_sec_devarg_order_set, 0)
 
-/* DPAA2_SEC_DP_DUMP levels */
-enum dpaa2_sec_dump_levels {
-	DPAA2_SEC_DP_NO_DUMP,
-	DPAA2_SEC_DP_ERR_DUMP,
-	DPAA2_SEC_DP_FULL_DUMP
+static const struct dpaax_devargs s_dpaa2_sec_devargs[] = {
+	DPAA2_DEVARGS(DPAAX_DEVARG_TABLE_ENTRY)
 };
 
 uint8_t cryptodev_driver_id;
-uint8_t dpaa2_sec_dp_dump = DPAA2_SEC_DP_ERR_DUMP;
 
 static int s_dpaa2_sec_cntx_pos = -1;
 
@@ -1701,10 +1724,9 @@ dpaa2_sec_fd_to_mbuf(const struct qbman_fd *fd,
 static void
 dpaa2_sec_dump(struct rte_crypto_op *op, FILE *f)
 {
-	int i;
 	dpaa2_sec_session *sess = NULL;
 	struct ctxt_priv *priv;
-	uint8_t bufsize;
+	uint8_t bufsize, i;
 	struct rte_crypto_sym_op *sym_op;
 
 	if (op->sess_type == RTE_CRYPTO_OP_WITH_SESSION)
@@ -1717,7 +1739,7 @@ dpaa2_sec_dump(struct rte_crypto_op *op, FILE *f)
 	if (sess == NULL)
 		goto mbuf_dump;
 
-	priv = (struct ctxt_priv *)sess->ctxt;
+	priv = sess->ctxt;
 	fprintf(f, "\n****************************************\n"
 		"session params:\n\tContext type:\t%d\n\tDirection:\t%s\n"
 		"\tCipher alg:\t%d\n\tAuth alg:\t%d\n\tAead alg:\t%d\n"
@@ -1746,7 +1768,7 @@ dpaa2_sec_dump(struct rte_crypto_op *op, FILE *f)
 		sess->pdcp.hfn_threshold);
 
 #endif
-	bufsize = (uint8_t)priv->flc_desc[0].flc.word1_sdl;
+	bufsize = priv->flc_desc[0].flc.word1_sdl;
 	fprintf(f, "Descriptor Dump:\n");
 	for (i = 0; i < bufsize; i++)
 		fprintf(f, "\tDESC[%d]:0x%x\n", i, priv->flc_desc[0].desc[i]);
@@ -1950,10 +1972,10 @@ dpaa2_sec_enqueue_burst_ordered(void *qp, struct rte_crypto_op **ops,
 
 static uint16_t
 dpaa2_sec_dequeue_burst(void *qp, struct rte_crypto_op **ops,
-			uint16_t nb_ops)
+	uint16_t nb_ops)
 {
 	/* Function is responsible to receive frames for a given device and VQ*/
-	struct dpaa2_sec_qp *dpaa2_qp = (struct dpaa2_sec_qp *)qp;
+	struct dpaa2_sec_qp *dpaa2_qp = qp;
 	struct qbman_result *dq_storage;
 	uint32_t fqid = dpaa2_qp->rx_vq.fqid;
 	int ret, num_rx = 0;
@@ -1961,12 +1983,12 @@ dpaa2_sec_dequeue_burst(void *qp, struct rte_crypto_op **ops,
 	struct qbman_swp *swp;
 	const struct qbman_fd *fd;
 	struct qbman_pull_desc pulldesc;
+	struct dpaa2_sec_dev_private *priv = dpaa2_qp->rx_vq.crypto_data->dev_private;
 
 	if (!DPAA2_PER_LCORE_DPIO) {
 		ret = dpaa2_affine_qbman_swp();
 		if (ret) {
-			DPAA2_SEC_ERR(
-				"Failed to allocate IO portal, tid: %d",
+			DPAA2_SEC_ERR("Failed to allocate IO portal, tid: %d",
 				rte_gettid());
 			return 0;
 		}
@@ -1976,18 +1998,15 @@ dpaa2_sec_dequeue_burst(void *qp, struct rte_crypto_op **ops,
 
 	qbman_pull_desc_clear(&pulldesc);
 	qbman_pull_desc_set_numframes(&pulldesc,
-				      (nb_ops > dpaa2_dqrr_size) ?
-				      dpaa2_dqrr_size : nb_ops);
+		(nb_ops > dpaa2_dqrr_size) ? dpaa2_dqrr_size : nb_ops);
 	qbman_pull_desc_set_fq(&pulldesc, fqid);
 	qbman_pull_desc_set_storage(&pulldesc, dq_storage,
-				    (dma_addr_t)DPAA2_VADDR_TO_IOVA(dq_storage),
-				    1);
+		(dma_addr_t)DPAA2_VADDR_TO_IOVA(dq_storage), 1);
 
 	/*Issue a volatile dequeue command. */
 	while (1) {
 		if (qbman_swp_pull(swp, &pulldesc)) {
-			DPAA2_SEC_WARN(
-				"SEC VDQ command is not issued : QBMAN busy");
+			DPAA2_SEC_WARN("SEC VDQ command is not issued : QBMAN busy");
 			/* Portal was busy, try again */
 			continue;
 		}
@@ -2017,8 +2036,7 @@ dpaa2_sec_dequeue_burst(void *qp, struct rte_crypto_op **ops,
 			is_last = 1;
 			/* Check for valid frame. */
 			status = (uint8_t)qbman_result_DQ_flags(dq_storage);
-			if (unlikely(
-				(status & QBMAN_DQ_STAT_VALIDFRAME) == 0)) {
+			if (unlikely(!(status & QBMAN_DQ_STAT_VALIDFRAME))) {
 				DPAA2_SEC_DP_DEBUG("No frame is delivered");
 				continue;
 			}
@@ -2029,10 +2047,9 @@ dpaa2_sec_dequeue_burst(void *qp, struct rte_crypto_op **ops,
 
 		if (unlikely(fd->simple.frc)) {
 			/* TODO Parse SEC errors */
-			if (dpaa2_sec_dp_dump > DPAA2_SEC_DP_NO_DUMP) {
-				DPAA2_SEC_DP_ERR("SEC returned Error - %x",
-						 fd->simple.frc);
-				if (dpaa2_sec_dp_dump > DPAA2_SEC_DP_ERR_DUMP)
+			if (priv->dump_level > DPAA2_SEC_DP_NO_DUMP) {
+				DPAA2_SEC_DP_ERR("SEC returned Error - %x", fd->simple.frc);
+				if (priv->dump_level > DPAA2_SEC_DP_ERR_DUMP)
 					dpaa2_sec_dump(ops[num_rx], stdout);
 			}
 
@@ -2049,7 +2066,7 @@ dpaa2_sec_dequeue_burst(void *qp, struct rte_crypto_op **ops,
 	dpaa2_qp->rx_vq.rx_pkts += num_rx;
 
 	DPAA2_SEC_DP_DEBUG("SEC RX pkts %d err pkts %" PRIu64, num_rx,
-				dpaa2_qp->rx_vq.err_pkts);
+		dpaa2_qp->rx_vq.err_pkts);
 	/*Return the total number of packets received to DPAA2 app*/
 	return num_rx;
 }
@@ -4332,53 +4349,6 @@ dpaa2_sec_uninit(const struct rte_cryptodev *dev)
 	return 0;
 }
 
-static int
-check_devargs_handler(const char *key, const char *value,
-		      void *opaque)
-{
-	struct rte_cryptodev *dev = (struct rte_cryptodev *)opaque;
-	struct dpaa2_sec_dev_private *priv = dev->data->dev_private;
-
-	if (!strcmp(key, "drv_strict_order")) {
-		priv->en_loose_ordered = false;
-	} else if (!strcmp(key, "drv_dump_mode")) {
-		dpaa2_sec_dp_dump = atoi(value);
-		if (dpaa2_sec_dp_dump > DPAA2_SEC_DP_FULL_DUMP) {
-			DPAA2_SEC_WARN("WARN: DPAA2_SEC_DP_DUMP_LEVEL is not "
-				      "supported, changing to FULL error"
-				      " prints");
-			dpaa2_sec_dp_dump = DPAA2_SEC_DP_FULL_DUMP;
-		}
-	} else
-		return -1;
-
-	return 0;
-}
-
-static void
-dpaa2_sec_get_devargs(struct rte_cryptodev *cryptodev, const char *key)
-{
-	struct rte_kvargs *kvlist;
-	struct rte_devargs *devargs;
-
-	devargs = cryptodev->device->devargs;
-	if (!devargs)
-		return;
-
-	kvlist = rte_kvargs_parse(devargs->args, NULL);
-	if (!kvlist)
-		return;
-
-	if (!rte_kvargs_count(kvlist, key)) {
-		rte_kvargs_free(kvlist);
-		return;
-	}
-
-	rte_kvargs_process(kvlist, key,
-			check_devargs_handler, (void *)cryptodev);
-	rte_kvargs_free(kvlist);
-}
-
 static int
 dpaa2_sec_dev_init(struct rte_cryptodev *cryptodev)
 {
@@ -4412,6 +4382,9 @@ dpaa2_sec_dev_init(struct rte_cryptodev *cryptodev)
 
 	internals = cryptodev->data->dev_private;
 
+	internals->dump_level = DPAA2_SEC_DP_ERR_DUMP;
+	dpaax_get_devargs(s_dpaa2_sec_devargs, cryptodev, NULL);
+
 	/*
 	 * For secondary processes, we don't initialise any further as primary
 	 * has already done this work. Only check we don't need a different
@@ -4462,8 +4435,6 @@ dpaa2_sec_dev_init(struct rte_cryptodev *cryptodev)
 	internals->token = token;
 	internals->en_loose_ordered = true;
 
-	dpaa2_sec_get_devargs(cryptodev, DRIVER_DUMP_MODE);
-	dpaa2_sec_get_devargs(cryptodev, DRIVER_STRICT_ORDER);
 	DPAA2_SEC_INFO("driver %s: created", cryptodev->data->name);
 	return 0;
 
@@ -4547,6 +4518,6 @@ RTE_PMD_REGISTER_DPAA2(CRYPTODEV_NAME_DPAA2_SEC_PMD, rte_dpaa2_sec_driver);
 RTE_PMD_REGISTER_CRYPTO_DRIVER(dpaa2_sec_crypto_drv,
 		rte_dpaa2_sec_driver.driver, cryptodev_driver_id);
 RTE_PMD_REGISTER_PARAM_STRING(CRYPTODEV_NAME_DPAA2_SEC_PMD,
-		DRIVER_STRICT_ORDER "=<int>"
-		DRIVER_DUMP_MODE "=<int>");
+		DPAA2_DEVARGS(DPAAX_DEVARG_STRING_ENTRY)
+);
 RTE_LOG_REGISTER(dpaa2_logtype_sec, pmd.crypto.dpaa2, NOTICE);
diff --git a/drivers/crypto/dpaa2_sec/dpaa2_sec_priv.h b/drivers/crypto/dpaa2_sec/dpaa2_sec_priv.h
index 755c8e9cc3..f29817f456 100644
--- a/drivers/crypto/dpaa2_sec/dpaa2_sec_priv.h
+++ b/drivers/crypto/dpaa2_sec/dpaa2_sec_priv.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  *
  *   Copyright (c) 2016 Freescale Semiconductor, Inc. All rights reserved.
- *   Copyright 2016,2020-2024 NXP
+ *   Copyright 2016,2020-2026 NXP
  *
  */
 
@@ -21,6 +21,13 @@ extern uint8_t cryptodev_driver_id;
 #define FLE_POOL_CACHE_SIZE	512
 #define FLE_SG_MEM_SIZE(num)	(FLE_POOL_BUF_SIZE + ((num) * 32))
 
+/* DPAA2_SEC_DP_DUMP levels */
+enum dpaa2_sec_dump_levels {
+	DPAA2_SEC_DP_NO_DUMP,
+	DPAA2_SEC_DP_ERR_DUMP,
+	DPAA2_SEC_DP_FULL_DUMP
+};
+
 #define MAX_QUEUES		64
 #define MAX_DESC_SIZE		64
 /** private data structure for each DPAA2_SEC device */
@@ -34,6 +41,7 @@ struct dpaa2_sec_dev_private {
 	/**< Max number of queue pairs supported by device */
 	uint8_t en_ordered;
 	uint8_t en_loose_ordered;
+	enum dpaa2_sec_dump_levels dump_level;
 };
 
 struct dpaa2_sec_qp {
-- 
2.43.0

