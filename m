Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C4FC5CFEB
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 10:45:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 91AF542DBB;
	Thu, 13 Aug 2026 12:44:32 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 5CFA242D92
 for <dev@dpdk.org>; Thu, 13 Aug 2026 12:44:29 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 413491A0043;
 Thu, 13 Aug 2026 12:44:29 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 071251A0042;
 Thu, 13 Aug 2026 12:44:29 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id C4C9818000B5;
 Thu, 13 Aug 2026 18:44:27 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	thomas@monjalon.net,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v10 15/25] bus/dpaa: orp queue create and burst enqueue
Date: Thu, 13 Aug 2026 16:13:55 +0530
Message-Id: <20260813104405.2313474-16-hemant.agrawal@nxp.com>
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

Add burst orp queue create parameter and burst enqueue API.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/bus/dpaa/base/qbman/qman.c  | 76 +++++++++++++++++++++++++++++
 drivers/bus/dpaa/include/fsl_qman.h | 28 +++++++++++
 2 files changed, 104 insertions(+)

diff --git a/drivers/bus/dpaa/base/qbman/qman.c b/drivers/bus/dpaa/base/qbman/qman.c
index ff0433b6c1..fb0665c4fb 100644
--- a/drivers/bus/dpaa/base/qbman/qman.c
+++ b/drivers/bus/dpaa/base/qbman/qman.c
@@ -1514,6 +1514,7 @@ int qman_create_fq(u32 fqid, u32 flags, struct qman_fq *fq)
 	fq->flags = flags;
 	fq->state = qman_fq_state_oos;
 	fq->cgr_groupid = 0;
+	fq->force_ooo = false;
 #ifdef CONFIG_FSL_QMAN_FQ_LOOKUP
 	if (unlikely(find_empty_fq_table_entry(&fq->key, fq))) {
 		DPAA_BUS_ERR("Find empty table entry failed");
@@ -2401,6 +2402,78 @@ int qman_enqueue_multi(struct qman_fq *fq,
 	return sent;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(qman_enqueue_multi_orp)
+int
+qman_enqueue_multi_orp(struct qman_fq *fq,
+	const struct qm_fd *fd, struct qman_fq *orp,
+	uint32_t *flags, uint16_t *orp_seqnum,
+	int frames_to_send)
+{
+	struct qman_portal *p = get_affine_portal();
+	struct qm_portal *portal = &p->p;
+
+	register struct qm_eqcr *eqcr = &portal->eqcr;
+	struct qm_eqcr_entry *eq = eqcr->cursor;
+
+	uint8_t i = 0, diff, old_ci, sent = 0;
+	uint8_t eq_verbs;
+
+	if (unlikely(!orp || !orp_seqnum || fq->force_ooo))
+		return qman_enqueue_multi(fq, fd, flags, frames_to_send);
+
+	if (!eqcr->available) {
+		old_ci = eqcr->ci;
+		eqcr->ci = qm_cl_in(EQCR_CI) & (QM_EQCR_SIZE - 1);
+		diff = qm_cyc_diff(QM_EQCR_SIZE, old_ci, eqcr->ci);
+		eqcr->available += diff;
+		if (!diff)
+			return 0;
+	}
+
+	/* try to send as many frames as possible */
+	while (eqcr->available && frames_to_send--) {
+		eq->fqid = fq->fqid_be;
+		eq->fd.opaque_addr = fd->opaque_addr;
+		eq->fd.addr = cpu_to_be40(fd->addr);
+		eq->fd.status = cpu_to_be32(fd->status);
+		eq->fd.opaque = cpu_to_be32(fd->opaque);
+
+		eq->orp = cpu_to_be32(orp->fqid);
+		if (flags && flags[i] & QMAN_ENQUEUE_FLAG_NLIS) {
+			orp_seqnum[i] |= QM_EQCR_SEQNUM_NLIS;
+		} else if (flags) {
+			orp_seqnum[i] &= ~QM_EQCR_SEQNUM_NLIS;
+			if (flags[i] & QMAN_ENQUEUE_FLAG_NESN)
+				orp_seqnum[i] |= QM_EQCR_SEQNUM_NESN;
+			else
+				orp_seqnum[i] &= ~QM_EQCR_SEQNUM_NESN;
+		}
+		eq->seqnum = cpu_to_be16(orp_seqnum[i]);
+		eq_verbs = QM_EQCR_VERB_ORP | eqcr->vbit;
+		if (likely(!flags || !(flags[i] & (QMAN_ENQUEUE_FLAG_HOLE |
+			QMAN_ENQUEUE_FLAG_NESN))))
+			eq_verbs |= QM_EQCR_VERB_CMD_ENQUEUE;
+		eq_verbs |= flags ? (flags[i] & (QM_EQCR_VERB_COLOUR_MASK |
+			QM_EQCR_VERB_INTERRUPT)) : 0;
+
+		eq->__dont_write_directly__verb = eq_verbs;
+		dcbf(eq);
+		lwsync();
+		i++;
+		eq++;
+		if (unlikely(eq >= (eqcr->ring + QM_EQCR_SIZE))) {
+			eqcr->vbit ^= QM_EQCR_VERB_VBIT;
+			eq = eqcr->ring;
+		}
+		eqcr->available--;
+		sent++;
+		fd++;
+	}
+
+	eqcr->cursor = eq;
+	return sent;
+}
+
 int
 qman_enqueue_multi_fq(struct qman_fq *fq[], const struct qm_fd *fd,
 		      u32 *flags, int frames_to_send)
@@ -2480,6 +2553,9 @@ int qman_enqueue_orp(struct qman_fq *fq, const struct qm_fd *fd, u32 flags,
 	struct qman_portal *p  = get_affine_portal();
 	struct qm_eqcr_entry *eq;
 
+	if (unlikely(fq->force_ooo))
+		return qman_enqueue(fq, fd, flags);
+
 	eq = try_p_eq_start(p, fq, fd, flags);
 	if (!eq)
 		return -EBUSY;
diff --git a/drivers/bus/dpaa/include/fsl_qman.h b/drivers/bus/dpaa/include/fsl_qman.h
index 3c0f5dc492..a53f1654bc 100644
--- a/drivers/bus/dpaa/include/fsl_qman.h
+++ b/drivers/bus/dpaa/include/fsl_qman.h
@@ -584,6 +584,29 @@ static inline u32 qm_fqd_taildrop_get(const struct qm_fqd_taildrop *td)
 	return (u32)td->mant << td->exp;
 }
 
+/**Order restoration point (ORP) restoration window size*/
+enum {
+	ORP_RWS_WIN_32_FRMS = 0,
+	ORP_RWS_WIN_64_FRMS = 1,
+	ORP_RWS_WIN_128_FRMS = 2,
+	ORP_RWS_WIN_256_FRMS = 3,
+	ORP_RWS_WIN_512_FRMS = 4,
+	ORP_RWS_WIN_1024_FRMS = 5,
+	ORP_RWS_WIN_2048_FRMS = 6,
+	ORP_RWS_WIN_4096_FRMS = 7
+};
+
+enum {
+	ORP_AUTO_ADVANCE_DISABLE = 0,
+	ORP_AUTO_ADVANCE_ENABLE = 1
+};
+
+enum {
+	ORP_LATE_ARRIVE_REJECT = 0,
+	ORP_LATE_ARRIVE_WIN_32 = 1,
+	ORP_LATE_ARRIVE_WIN_RWS = 2,
+	ORP_LATE_ARRIVE_WIN_8192 = 3
+};
 
 /* See "Frame Queue Descriptor (FQD)" */
 /* Frame Queue Descriptor (FQD) field 'fq_ctrl' uses these constants */
@@ -1258,6 +1281,7 @@ struct qman_fq {
 	u16 nb_desc;
 	u16 resv;
 	u64 offloads;
+	bool force_ooo;
 };
 
 /*
@@ -1861,6 +1885,10 @@ typedef int (*qman_cb_precommit) (void *arg);
 int qman_enqueue_orp(struct qman_fq *fq, const struct qm_fd *fd, u32 flags,
 		     struct qman_fq *orp, u16 orp_seqnum);
 
+__rte_internal
+int qman_enqueue_multi_orp(struct qman_fq *fq, const struct qm_fd *fd,
+	struct qman_fq *orp, uint32_t *flags, uint16_t *orp_seqnum,
+	int frames_to_send);
 /**
  * qman_alloc_fqid_range - Allocate a contiguous range of FQIDs
  * @result: is set by the API to the base FQID of the allocated range
-- 
2.25.1

