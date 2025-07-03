Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2761DC83030
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Jul 2025 05:26:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4BE14402D4;
	Thu,  3 Jul 2025 07:26:10 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 72D3C402BD
 for <dev@dpdk.org>; Thu,  3 Jul 2025 07:26:03 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 4D4211A2A79;
 Thu,  3 Jul 2025 07:26:03 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id DEA521A2A96;
 Thu,  3 Jul 2025 07:26:02 +0200 (CEST)
Received: from lsv03379.swis.in-blr01.nxp.com (lsv03379.swis.in-blr01.nxp.com
 [92.120.147.188])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 59B941800241;
 Thu,  3 Jul 2025 13:26:02 +0800 (+08)
From: vanshika.shukla@nxp.com
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [v7 8/8] bus/dpaa: optimize qman enqueue check
Date: Thu,  3 Jul 2025 10:55:58 +0530
Message-Id: <20250703052558.3700573-9-vanshika.shukla@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250703052558.3700573-1-vanshika.shukla@nxp.com>
References: <20250702101026.3301762-1-vanshika.shukla@nxp.com>
 <20250703052558.3700573-1-vanshika.shukla@nxp.com>
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
 drivers/bus/dpaa/base/fman/fman.c   |  3 ++-
 drivers/bus/dpaa/base/qbman/bman.c  |  6 ++---
 drivers/bus/dpaa/base/qbman/qman.c  | 41 ++++++++++++++++-------------
 drivers/bus/dpaa/include/fsl_qman.h |  2 +-
 4 files changed, 28 insertions(+), 24 deletions(-)

diff --git a/drivers/bus/dpaa/base/fman/fman.c b/drivers/bus/dpaa/base/fman/fman.c
index 5cb2ae999d..fb30ab96b5 100644
--- a/drivers/bus/dpaa/base/fman/fman.c
+++ b/drivers/bus/dpaa/base/fman/fman.c
@@ -50,11 +50,12 @@ _fman_init(const struct device_node *fman_node, int fd)
 {
 	const struct device_node *ptp_node;
 	const uint32_t *fman_addr, *ptp_addr, *cell_idx;
-	uint64_t phys_addr, regs_size, lenp;
+	uint64_t phys_addr, regs_size;
 	void *vir_addr;
 	uint32_t ip_rev_1;
 	int _errno = 0;
 	struct __fman *fman;
+	size_t lenp;
 
 	fman = rte_zmalloc(NULL, sizeof(struct __fman), 0);
 	if (!fman) {
diff --git a/drivers/bus/dpaa/base/qbman/bman.c b/drivers/bus/dpaa/base/qbman/bman.c
index 037030ea19..6b8dbb8544 100644
--- a/drivers/bus/dpaa/base/qbman/bman.c
+++ b/drivers/bus/dpaa/base/qbman/bman.c
@@ -353,7 +353,7 @@ int bman_release(struct bman_pool *pool, const struct bm_buffer *bufs, u8 num,
 }
 
 static inline uint64_t
-bman_extract_addr(struct bm_buffer *buf)
+__rte_unused bman_extract_addr(struct bm_buffer *buf)
 {
 	buf->opaque = be64_to_cpu(buf->opaque);
 
@@ -394,8 +394,8 @@ bman_acquire_fast(struct bman_pool *pool, uint64_t *bufs, uint8_t num)
 	while (!(mcr = bm_mc_result(&p->p)))
 		;
 	rst = mcr->verb & BM_MCR_VERB_ACQUIRE_BUFCOUNT;
-	if (unlikely(!rst))
-		return 0;
+	if (unlikely(rst < 1 || rst > FSL_BM_BURST_MAX))
+		return -EINVAL;
 
 	rte_memcpy(bm_bufs, mcr->acquire.bufs,
 		sizeof(struct bm_buffer) * rst);
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

