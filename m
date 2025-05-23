Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D8AC54F2E
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 May 2025 13:53:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F13D40DDE;
	Fri, 23 May 2025 15:52:29 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 22BCF40DC9
 for <dev@dpdk.org>; Fri, 23 May 2025 15:52:25 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54NB9TDo029869
 for <dev@dpdk.org>; Fri, 23 May 2025 06:52:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=o
 dfPq+FstIEU9h9ctQ+yhz9jr+YjH3u5kcqftX7WK6c=; b=Z+VzOjka/t2SVg1Px
 qG/hhvybHid559pUBKSxdAymzQfjQnDhm9lGEFVk95Dm3+ZA3IPXpsCcZLefLRBu
 ogGx+zAUqEO4wBSbtExVgHtf5Sh/XVWVRJyEHSlvmz+Fe7PIwYLrag+iCYvoJwzc
 d6Q1RWrTp/lRenMBDjjndii9ejpmYtmBs02hK+glM3USHX7Mx9JWg71r86vhdTF8
 uoSheBIj1CsvBS9ObeUtRWTsBhLRPjLcqZ3tFq87uqBs8w3Lgt3XmmHFSl1F64h+
 J3tCeqYqJ2jW56N70eVkRNjRYJkOM1tECJ8oDPYq/klfsO4qFU57Zm8yKy3akYrQ
 7c1bw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46tqw589fy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 23 May 2025 06:52:25 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 23 May 2025 06:52:24 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 23 May 2025 06:52:23 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 621D73F7041;
 Fri, 23 May 2025 06:52:20 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Anoob Joseph <anoobj@marvell.com>, Aakash Sasidharan
 <asasidharan@marvell.com>,
 Nithinsen Kaithakadan <nkaithakadan@marvell.com>,
 Rupesh Chiluka <rchiluka@marvell.com>, Vidya Sagar Velumuri
 <vvelumuri@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 21/40] crypto/cnxk: add Rx inject in security lookaside
Date: Fri, 23 May 2025 19:20:52 +0530
Message-ID: <20250523135111.2178408-22-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250523135111.2178408-1-ktejasree@marvell.com>
References: <20250523135111.2178408-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=F8xXdrhN c=1 sm=1 tr=0 ts=68307d99 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=Mh948lM4h2CRWd6TL9kA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDEyMyBTYWx0ZWRfX8wleGjQZSQPD
 HNjbEPnqHw28jgT6T/215WFe/n7u06ab/FUQM6r0AYJfii93HswGLLNmxRPxygtYiKFZ/6mHLr/
 Kh41jF8hf/P6/Ch5vUTtg7xM05SkwFUXA/KPLhH+kFnzJE2C72m6qqWFxhWMrpPuN/ne/3qXyUt
 6gqUPAjLyZ5wm0EGWrV30HyEOADByRHm0NEGMLL3uOt/gMktwLsWdESHUuRFQzmY3ywp1QPdD5P
 YRtR7EfTmwxC9hRrt6Pj+exAJByvX5T67cdlMjIUvlxbaWLPOAKHiyKdqQV+KV0+ukDQznuwgUW
 9kh/qJI8pahiPFT7enJeubLxRl+sknfU4AtFYeGmXvvNd4pRcQGjqpanA89C51+ePtdraDqWTbU
 Vkq0xeU5YgW1zvV2n2C47H6quup4gnCDkvqidSfFQZv4YBftIay3O5D+dtdAK4rSyBBhkHcc
X-Proofpoint-GUID: IcqipRYaytmfCnQD2YrYARTHLm8vsLay
X-Proofpoint-ORIG-GUID: IcqipRYaytmfCnQD2YrYARTHLm8vsLay
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_04,2025-05-22_01,2025-03-28_01
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

Add Rx inject fastpath API for cn20k

Signed-off-by: Vidya Sagar Velumuri <vvelumuri@marvell.com>
---
 drivers/crypto/cnxk/cn20k_cryptodev_ops.c | 186 ++++++++++++++++++++++
 drivers/crypto/cnxk/cn20k_cryptodev_ops.h |   8 +
 drivers/crypto/cnxk/cn20k_cryptodev_sec.c |  35 ----
 3 files changed, 194 insertions(+), 35 deletions(-)

diff --git a/drivers/crypto/cnxk/cn20k_cryptodev_ops.c b/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
index 28f88704b7..97dfa5865f 100644
--- a/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
+++ b/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
@@ -3,8 +3,11 @@
  */
 
 #include <cryptodev_pmd.h>
+#include <eal_export.h>
+#include <ethdev_driver.h>
 #include <rte_cryptodev.h>
 #include <rte_hexdump.h>
+#include <rte_vect.h>
 
 #include "roc_cpt.h"
 #include "roc_idev.h"
@@ -508,6 +511,189 @@ cn20k_sym_configure_raw_dp_ctx(struct rte_cryptodev *dev, uint16_t qp_id,
 	return 0;
 }
 
+#if defined(RTE_ARCH_ARM64)
+RTE_EXPORT_INTERNAL_SYMBOL(cn20k_cryptodev_sec_inb_rx_inject)
+uint16_t __rte_hot
+cn20k_cryptodev_sec_inb_rx_inject(void *dev, struct rte_mbuf **pkts,
+				  struct rte_security_session **sess, uint16_t nb_pkts)
+{
+	uint64_t lmt_base, io_addr, u64_0, u64_1, l2_len, pf_func;
+	uint64x2_t inst_01, inst_23, inst_45, inst_67;
+	struct cn20k_sec_session *sec_sess;
+	struct rte_cryptodev *cdev = dev;
+	union cpt_res_s *hw_res = NULL;
+	uint16_t lmt_id, count = 0;
+	struct cpt_inst_s *inst;
+	union cpt_fc_write_s fc;
+	struct cnxk_cpt_vf *vf;
+	struct rte_mbuf *m;
+	uint64_t u64_dptr;
+	uint64_t *fc_addr;
+	int i;
+
+	vf = cdev->data->dev_private;
+
+	lmt_base = vf->rx_inj_lmtline.lmt_base;
+	io_addr = vf->rx_inj_lmtline.io_addr;
+	fc_addr = vf->rx_inj_lmtline.fc_addr;
+
+	ROC_LMT_BASE_ID_GET(lmt_base, lmt_id);
+	pf_func = vf->rx_inj_sso_pf_func;
+
+	const uint32_t fc_thresh = vf->rx_inj_lmtline.fc_thresh;
+
+again:
+	fc.u64[0] =
+		rte_atomic_load_explicit((RTE_ATOMIC(uint64_t) *)fc_addr, rte_memory_order_relaxed);
+	inst = (struct cpt_inst_s *)lmt_base;
+
+	i = 0;
+
+	if (unlikely(fc.s.qsize > fc_thresh))
+		goto exit;
+
+	for (; i < RTE_MIN(CN20K_CPT_PKTS_PER_LOOP, nb_pkts); i++) {
+
+		m = pkts[i];
+		sec_sess = (struct cn20k_sec_session *)sess[i];
+
+		if (unlikely(rte_pktmbuf_headroom(m) < 32)) {
+			plt_dp_err("No space for CPT res_s");
+			break;
+		}
+
+		l2_len = m->l2_len;
+
+		*rte_security_dynfield(m) = (uint64_t)sec_sess->userdata;
+
+		hw_res = rte_pktmbuf_mtod(m, void *);
+		hw_res = RTE_PTR_SUB(hw_res, 32);
+		hw_res = RTE_PTR_ALIGN_CEIL(hw_res, 16);
+
+		/* Prepare CPT instruction */
+		if (m->nb_segs > 1) {
+			struct rte_mbuf *last = rte_pktmbuf_lastseg(m);
+			uintptr_t dptr, rxphdr, wqe_hdr;
+			uint16_t i;
+
+			if ((m->nb_segs > CNXK_CPT_MAX_SG_SEGS) ||
+			    (rte_pktmbuf_tailroom(m) < CNXK_CPT_MIN_TAILROOM_REQ))
+				goto exit;
+
+			wqe_hdr = rte_pktmbuf_mtod_offset(last, uintptr_t, last->data_len);
+			wqe_hdr += BIT_ULL(7);
+			wqe_hdr = (wqe_hdr - 1) & ~(BIT_ULL(7) - 1);
+
+			/* Pointer to WQE header */
+			*(uint64_t *)(m + 1) = wqe_hdr;
+
+			/* Reserve SG list after end of last mbuf data location. */
+			rxphdr = wqe_hdr + 8;
+			dptr = rxphdr + 7 * 8;
+
+			/* Prepare Multiseg SG list */
+			i = fill_sg2_comp_from_pkt((struct roc_sg2list_comp *)dptr, 0, m);
+			u64_dptr = dptr | ((uint64_t)(i) << 60);
+		} else {
+			struct roc_sg2list_comp *sg2;
+			uintptr_t dptr, wqe_hdr;
+
+			/* Reserve space for WQE, NIX_RX_PARSE_S and SG_S.
+			 * Populate SG_S with num segs and seg length
+			 */
+			wqe_hdr = (uintptr_t)(m + 1);
+			*(uint64_t *)(m + 1) = wqe_hdr;
+
+			sg2 = (struct roc_sg2list_comp *)(wqe_hdr + 8 * 8);
+			sg2->u.s.len[0] = rte_pktmbuf_pkt_len(m);
+			sg2->u.s.valid_segs = 1;
+
+			dptr = (uint64_t)rte_pktmbuf_iova(m);
+			u64_dptr = dptr;
+		}
+
+		/* Word 0 and 1 */
+		inst_01 = vdupq_n_u64(0);
+		u64_0 = pf_func << 48 | *(vf->rx_chan_base + m->port) << 4 | (l2_len - 2) << 24 |
+			l2_len << 16;
+		inst_01 = vsetq_lane_u64(u64_0, inst_01, 0);
+		inst_01 = vsetq_lane_u64((uint64_t)hw_res, inst_01, 1);
+		vst1q_u64(&inst->w0.u64, inst_01);
+
+		/* Word 2 and 3 */
+		inst_23 = vdupq_n_u64(0);
+		u64_1 = (((uint64_t)m + sizeof(struct rte_mbuf)) >> 3) << 3 | 1;
+		inst_23 = vsetq_lane_u64(u64_1, inst_23, 1);
+		vst1q_u64(&inst->w2.u64, inst_23);
+
+		/* Word 4 and 5 */
+		inst_45 = vdupq_n_u64(0);
+		u64_0 = sec_sess->inst.w4 | (rte_pktmbuf_pkt_len(m));
+		inst_45 = vsetq_lane_u64(u64_0, inst_45, 0);
+		inst_45 = vsetq_lane_u64(u64_dptr, inst_45, 1);
+		vst1q_u64(&inst->w4.u64, inst_45);
+
+		/* Word 6 and 7 */
+		inst_67 = vdupq_n_u64(0);
+		u64_1 = sec_sess->inst.w7;
+		inst_67 = vsetq_lane_u64(u64_1, inst_67, 1);
+		vst1q_u64(&inst->w6.u64, inst_67);
+
+		inst++;
+	}
+
+	cn20k_cpt_lmtst_dual_submit(&io_addr, lmt_id, &i);
+
+	if (nb_pkts - i > 0 && i == CN20K_CPT_PKTS_PER_LOOP) {
+		nb_pkts -= CN20K_CPT_PKTS_PER_LOOP;
+		pkts += CN20K_CPT_PKTS_PER_LOOP;
+		count += CN20K_CPT_PKTS_PER_LOOP;
+		sess += CN20K_CPT_PKTS_PER_LOOP;
+		goto again;
+	}
+
+exit:
+	return count + i;
+}
+#else
+RTE_EXPORT_INTERNAL_SYMBOL(cn20k_cryptodev_sec_inb_rx_inject)
+uint16_t __rte_hot
+cn20k_cryptodev_sec_inb_rx_inject(void *dev, struct rte_mbuf **pkts,
+				  struct rte_security_session **sess, uint16_t nb_pkts)
+{
+	RTE_SET_USED(dev);
+	RTE_SET_USED(pkts);
+	RTE_SET_USED(sess);
+	RTE_SET_USED(nb_pkts);
+	return 0;
+}
+#endif
+
+RTE_EXPORT_INTERNAL_SYMBOL(cn20k_cryptodev_sec_rx_inject_configure)
+int
+cn20k_cryptodev_sec_rx_inject_configure(void *device, uint16_t port_id, bool enable)
+{
+	struct rte_cryptodev *crypto_dev = device;
+	struct rte_eth_dev *eth_dev;
+	int ret;
+
+	if (!rte_eth_dev_is_valid_port(port_id))
+		return -EINVAL;
+
+	if (!(crypto_dev->feature_flags & RTE_CRYPTODEV_FF_SECURITY_RX_INJECT))
+		return -ENOTSUP;
+
+	eth_dev = &rte_eth_devices[port_id];
+
+	ret = strncmp(eth_dev->device->driver->name, "net_cn20k", 8);
+	if (ret)
+		return -ENOTSUP;
+
+	roc_idev_nix_rx_inject_set(port_id, enable);
+
+	return 0;
+}
+
 struct rte_cryptodev_ops cn20k_cpt_ops = {
 	/* Device control ops */
 	.dev_configure = cnxk_cpt_dev_config,
diff --git a/drivers/crypto/cnxk/cn20k_cryptodev_ops.h b/drivers/crypto/cnxk/cn20k_cryptodev_ops.h
index bdd6f71022..752ca588e0 100644
--- a/drivers/crypto/cnxk/cn20k_cryptodev_ops.h
+++ b/drivers/crypto/cnxk/cn20k_cryptodev_ops.h
@@ -25,6 +25,14 @@ extern struct rte_cryptodev_ops cn20k_cpt_ops;
 
 void cn20k_cpt_set_enqdeq_fns(struct rte_cryptodev *dev);
 
+__rte_internal
+uint16_t __rte_hot cn20k_cryptodev_sec_inb_rx_inject(void *dev, struct rte_mbuf **pkts,
+						     struct rte_security_session **sess,
+						     uint16_t nb_pkts);
+
+__rte_internal
+int cn20k_cryptodev_sec_rx_inject_configure(void *device, uint16_t port_id, bool enable);
+
 static __rte_always_inline void __rte_hot
 cn20k_cpt_lmtst_dual_submit(uint64_t *io_addr, const uint16_t lmt_id, int *i)
 {
diff --git a/drivers/crypto/cnxk/cn20k_cryptodev_sec.c b/drivers/crypto/cnxk/cn20k_cryptodev_sec.c
index ba7f1baf86..7374a83795 100644
--- a/drivers/crypto/cnxk/cn20k_cryptodev_sec.c
+++ b/drivers/crypto/cnxk/cn20k_cryptodev_sec.c
@@ -112,41 +112,6 @@ cn20k_sec_session_update(void *dev, struct rte_security_session *sec_sess,
 	return -ENOTSUP;
 }
 
-static int
-cn20k_cryptodev_sec_rx_inject_configure(void *device, uint16_t port_id, bool enable)
-{
-	RTE_SET_USED(device);
-	RTE_SET_USED(port_id);
-	RTE_SET_USED(enable);
-
-	return -ENOTSUP;
-}
-
-#if defined(RTE_ARCH_ARM64)
-static uint16_t
-cn20k_cryptodev_sec_inb_rx_inject(void *dev, struct rte_mbuf **pkts,
-				  struct rte_security_session **sess, uint16_t nb_pkts)
-{
-	RTE_SET_USED(dev);
-	RTE_SET_USED(pkts);
-	RTE_SET_USED(sess);
-	RTE_SET_USED(nb_pkts);
-
-	return 0;
-}
-#else
-uint16_t __rte_hot
-cn20k_cryptodev_sec_inb_rx_inject(void *dev, struct rte_mbuf **pkts,
-				  struct rte_security_session **sess, uint16_t nb_pkts)
-{
-	RTE_SET_USED(dev);
-	RTE_SET_USED(sess);
-	RTE_SET_USED(nb_pkts);
-
-	return 0;
-}
-#endif
-
 /* Update platform specific security ops */
 void
 cn20k_sec_ops_override(void)
-- 
2.25.1

