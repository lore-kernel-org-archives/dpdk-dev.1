Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CADBAC54FB3
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Jun 2025 13:16:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5432740695;
	Mon,  2 Jun 2025 15:15:42 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id D11AE4026F
 for <dev@dpdk.org>; Mon,  2 Jun 2025 15:15:32 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B3E5A1A09FA;
 Mon,  2 Jun 2025 15:15:32 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7BD991A1192;
 Mon,  2 Jun 2025 15:15:32 +0200 (CEST)
Received: from lsv03379.swis.in-blr01.nxp.com (lsv03379.swis.in-blr01.nxp.com
 [92.120.147.188])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id EEB991800073;
 Mon,  2 Jun 2025 21:15:31 +0800 (+08)
From: vanshika.shukla@nxp.com
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [v2 10/10] bus/dpaa: optimize qman enqueue check
Date: Mon,  2 Jun 2025 18:45:26 +0530
Message-Id: <20250602131526.3233959-11-vanshika.shukla@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250602131526.3233959-1-vanshika.shukla@nxp.com>
References: <20250528103934.1001747-1-vanshika.shukla@nxp.com>
 <20250602131526.3233959-1-vanshika.shukla@nxp.com>
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

From: Hemant Agrawal <hemant.agrawal@nxp.com>

This patch improves data access during qman enequeue ring check.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/bus/dpaa/base/qbman/qman.c  | 41 ++++++++++++++++-------------
 drivers/bus/dpaa/include/fsl_qman.h |  2 +-
 2 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/drivers/bus/dpaa/base/qbman/qman.c b/drivers/bus/dpaa/base/qbman/qman.c
index fbce0638b7..60087c55a1 100644
--- a/drivers/bus/dpaa/base/qbman/qman.c
+++ b/drivers/bus/dpaa/base/qbman/qman.c
@@ -1466,7 +1466,7 @@ int qman_create_fq(u32 fqid, u32 flags, struct qman_fq *fq)
 	}
 	spin_lock_init(&fq->fqlock);
 	fq->fqid = fqid;
-	fq->fqid_le = cpu_to_be32(fqid);
+	fq->fqid_be = cpu_to_be32(fqid);
 	fq->flags = flags;
 	fq->state = qman_fq_state_oos;
 	fq->cgr_groupid = 0;
@@ -2291,7 +2291,7 @@ int qman_enqueue_multi(struct qman_fq *fq,
 	struct qm_portal *portal = &p->p;
 
 	register struct qm_eqcr *eqcr = &portal->eqcr;
-	struct qm_eqcr_entry *eq = eqcr->cursor, *prev_eq;
+	struct qm_eqcr_entry *eq = eqcr->cursor;
 
 	u8 i = 0, diff, old_ci, sent = 0;
 
@@ -2307,7 +2307,7 @@ int qman_enqueue_multi(struct qman_fq *fq,
 
 	/* try to send as many frames as possible */
 	while (eqcr->available && frames_to_send--) {
-		eq->fqid = fq->fqid_le;
+		eq->fqid = fq->fqid_be;
 		eq->fd.opaque_addr = fd->opaque_addr;
 		eq->fd.addr = cpu_to_be40(fd->addr);
 		eq->fd.status = cpu_to_be32(fd->status);
@@ -2317,8 +2317,9 @@ int qman_enqueue_multi(struct qman_fq *fq,
 				((flags[i] >> 8) & QM_EQCR_DCA_IDXMASK);
 		}
 		i++;
-		eq = (void *)((unsigned long)(eq + 1) &
-			(~(unsigned long)(QM_EQCR_SIZE << 6)));
+		eq++;
+		if (unlikely(eq >= (eqcr->ring + QM_EQCR_SIZE)))
+			eq = eqcr->ring;
 		eqcr->available--;
 		sent++;
 		fd++;
@@ -2332,11 +2333,11 @@ int qman_enqueue_multi(struct qman_fq *fq,
 	for (i = 0; i < sent; i++) {
 		eq->__dont_write_directly__verb =
 			QM_EQCR_VERB_CMD_ENQUEUE | eqcr->vbit;
-		prev_eq = eq;
-		eq = (void *)((unsigned long)(eq + 1) &
-			(~(unsigned long)(QM_EQCR_SIZE << 6)));
-		if (unlikely((prev_eq + 1) != eq))
+		eq++;
+		if (unlikely(eq >= (eqcr->ring + QM_EQCR_SIZE))) {
 			eqcr->vbit ^= QM_EQCR_VERB_VBIT;
+			eq = eqcr->ring;
+		}
 	}
 
 	/* We need  to flush all the lines but without load/store operations
@@ -2361,7 +2362,7 @@ qman_enqueue_multi_fq(struct qman_fq *fq[], const struct qm_fd *fd,
 	struct qm_portal *portal = &p->p;
 
 	register struct qm_eqcr *eqcr = &portal->eqcr;
-	struct qm_eqcr_entry *eq = eqcr->cursor, *prev_eq;
+	struct qm_eqcr_entry *eq = eqcr->cursor;
 
 	u8 i = 0, diff, old_ci, sent = 0;
 
@@ -2377,7 +2378,7 @@ qman_enqueue_multi_fq(struct qman_fq *fq[], const struct qm_fd *fd,
 
 	/* try to send as many frames as possible */
 	while (eqcr->available && frames_to_send--) {
-		eq->fqid = fq[sent]->fqid_le;
+		eq->fqid = fq[sent]->fqid_be;
 		eq->fd.opaque_addr = fd->opaque_addr;
 		eq->fd.addr = cpu_to_be40(fd->addr);
 		eq->fd.status = cpu_to_be32(fd->status);
@@ -2388,8 +2389,9 @@ qman_enqueue_multi_fq(struct qman_fq *fq[], const struct qm_fd *fd,
 		}
 		i++;
 
-		eq = (void *)((unsigned long)(eq + 1) &
-			(~(unsigned long)(QM_EQCR_SIZE << 6)));
+		eq++;
+		if (unlikely(eq >= (eqcr->ring + QM_EQCR_SIZE)))
+			eq = eqcr->ring;
 		eqcr->available--;
 		sent++;
 		fd++;
@@ -2403,11 +2405,11 @@ qman_enqueue_multi_fq(struct qman_fq *fq[], const struct qm_fd *fd,
 	for (i = 0; i < sent; i++) {
 		eq->__dont_write_directly__verb =
 			QM_EQCR_VERB_CMD_ENQUEUE | eqcr->vbit;
-		prev_eq = eq;
-		eq = (void *)((unsigned long)(eq + 1) &
-			(~(unsigned long)(QM_EQCR_SIZE << 6)));
-		if (unlikely((prev_eq + 1) != eq))
+		eq++;
+		if (unlikely(eq >= (eqcr->ring + QM_EQCR_SIZE))) {
 			eqcr->vbit ^= QM_EQCR_VERB_VBIT;
+			eq = eqcr->ring;
+		}
 	}
 
 	/* We need  to flush all the lines but without load/store operations
@@ -2416,8 +2418,9 @@ qman_enqueue_multi_fq(struct qman_fq *fq[], const struct qm_fd *fd,
 	eq = eqcr->cursor;
 	for (i = 0; i < sent; i++) {
 		dcbf(eq);
-		eq = (void *)((unsigned long)(eq + 1) &
-			(~(unsigned long)(QM_EQCR_SIZE << 6)));
+		eq++;
+		if (unlikely(eq >= (eqcr->ring + QM_EQCR_SIZE)))
+			eq = eqcr->ring;
 	}
 	/* Update cursor for the next call */
 	eqcr->cursor = eq;
diff --git a/drivers/bus/dpaa/include/fsl_qman.h b/drivers/bus/dpaa/include/fsl_qman.h
index b949f2c893..71d5b16878 100644
--- a/drivers/bus/dpaa/include/fsl_qman.h
+++ b/drivers/bus/dpaa/include/fsl_qman.h
@@ -1225,7 +1225,7 @@ struct qman_fq {
 	/* Caller of qman_create_fq() provides these demux callbacks */
 	struct qman_fq_cb cb;
 
-	u32 fqid_le;
+	rte_be32_t fqid_be;
 	u32 fqid;
 
 	int q_fd;
-- 
2.25.1

