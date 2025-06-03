Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632A6C5AD49
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Jun 2025 11:52:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 116DF40DD6;
	Tue,  3 Jun 2025 13:51:08 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 6672B40DCA
 for <dev@dpdk.org>; Tue,  3 Jun 2025 13:51:05 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 553AHutS017714
 for <dev@dpdk.org>; Tue, 3 Jun 2025 04:51:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=D
 zvj5EyBtgu8mStuVWh4DgwFykUdm+psWM9AeEsPndI=; b=F+IbscscwGfg3E4FT
 Zx50m3D7VbSTepHrPowobGFdY6t94uS+R5jSdra+J/BFLXFyfE07pxvD1E+ngdmc
 h6tP7KJoh04fv1KpUijnQXV3IlI2C4fRQug5iDIsce5TZzhnGrQv12z5M1MLy/bs
 xW26x7XI1FXQJcuDsBOhRwEFiAXhqNcmtdLPW5h7880N07G4IwPf8C2hf/iffxQr
 GWWxls3yRq/ciIwPeHIMysM5dQONOQArE8xAC4IBhPT82Q4NXVTjehDCVh54/1Jd
 9cbCgU0VWVGvTPX2j3HXFM56YIaUcO5ymVyBbOeVqlWMJ6mXb3KnSN+miHtvWV+s
 lZFFw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 471y6304dq-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 03 Jun 2025 04:51:04 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 3 Jun 2025 04:51:03 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 3 Jun 2025 04:51:03 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id C0D365B6921;
 Tue,  3 Jun 2025 04:51:01 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Anoob Joseph <anoobj@marvell.com>, Vidya Sagar Velumuri
 <vvelumuri@marvell.com>, <dev@dpdk.org>
Subject: [PATCH v2 15/25] crypto/cnxk: add Rx inject in security lookaside
Date: Tue, 3 Jun 2025 17:20:16 +0530
Message-ID: <20250603115026.2664706-16-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250603115026.2664706-1-ktejasree@marvell.com>
References: <20250603115026.2664706-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAzMDEwNCBTYWx0ZWRfXzNpo3JDjRJvo
 Sv5325to4F/yRHGa7w/hBCQ8rfKm8e4UwONRWn8X6Zy/UDht4zouaa/nA+hZEf3fBf6FczJfmGy
 wl1it3dARD6pdTEQTil6Pyv52hZ1BZYKhQwAM2QWfBkLTzMdfginbMzYQJ++WF6NkCBF1dti9O8
 Esj1uauqQotvFHqTjMtY/6GS7ttnFllLCqLjMNSA+Yes93tdW+Y9lAqbwJiXUjnt9R03J7G+fGq
 77ynUcLv+gN10RTyo4rRIuoXraVAgrKde6uGeXRPz7oh7nF+93hAy+zxuazo9BEQHXF/nOdPFxR
 owpXAN0bgHEzuAGorWPtc9PjgWTAAnTduEameLnyRnt5KEXacngp/3fkVf3ynrNuikHcdN5XYby
 4ezGuyPtXtVk/Jhc7BY9K6beND3JjRVgbNVHuv7A6+zNew50jLpJf63WsMGeTQNthWX5+1Cm
X-Proofpoint-GUID: hr8SJvBwPyPa810ko4hQEaFD1LROYp1U
X-Authority-Analysis: v=2.4 cv=QaJmvtbv c=1 sm=1 tr=0 ts=683ee1a8 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=dE99wGDcKYuoAeO9Ty8A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: hr8SJvBwPyPa810ko4hQEaFD1LROYp1U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-03_01,2025-06-02_01,2025-03-28_01
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
Signed-off-by: Tejasree Kondoj <ktejasree@marvell.com>
---
 drivers/crypto/cnxk/cn20k_cryptodev_ops.c | 165 ++++++++++++++++++++--
 1 file changed, 156 insertions(+), 9 deletions(-)

diff --git a/drivers/crypto/cnxk/cn20k_cryptodev_ops.c b/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
index 328679bd07..e61a5e50c8 100644
--- a/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
+++ b/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
@@ -4,8 +4,10 @@
 
 #include <cryptodev_pmd.h>
 #include <eal_export.h>
+#include <ethdev_driver.h>
 #include <rte_cryptodev.h>
 #include <rte_hexdump.h>
+#include <rte_vect.h>
 
 #include "roc_cpt.h"
 #include "roc_idev.h"
@@ -516,12 +518,143 @@ uint16_t __rte_hot
 cn20k_cryptodev_sec_inb_rx_inject(void *dev, struct rte_mbuf **pkts,
 				  struct rte_security_session **sess, uint16_t nb_pkts)
 {
-	RTE_SET_USED(dev);
-	RTE_SET_USED(pkts);
-	RTE_SET_USED(sess);
-	RTE_SET_USED(nb_pkts);
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
 
-	return 0;
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
 }
 #else
 RTE_EXPORT_INTERNAL_SYMBOL(cn20k_cryptodev_sec_inb_rx_inject)
@@ -541,11 +674,25 @@ RTE_EXPORT_INTERNAL_SYMBOL(cn20k_cryptodev_sec_rx_inject_configure)
 int
 cn20k_cryptodev_sec_rx_inject_configure(void *device, uint16_t port_id, bool enable)
 {
-	RTE_SET_USED(device);
-	RTE_SET_USED(port_id);
-	RTE_SET_USED(enable);
+	struct rte_cryptodev *crypto_dev = device;
+	struct rte_eth_dev *eth_dev;
+	int ret;
+
+	if (!rte_eth_dev_is_valid_port(port_id))
+		return -EINVAL;
 
-	return -ENOTSUP;
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
 }
 
 struct rte_cryptodev_ops cn20k_cpt_ops = {
-- 
2.25.1

