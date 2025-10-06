Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F18A6CCA471
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Oct 2025 05:14:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 820A04065D;
	Mon,  6 Oct 2025 07:14:30 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 7ED8E40669
 for <dev@dpdk.org>; Mon,  6 Oct 2025 07:14:28 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5964rkai014942
 for <dev@dpdk.org>; Sun, 5 Oct 2025 22:14:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=h
 jCTs5D0JdqZlZOvMWzn3vem3Q/V6c5eqSn9wg9e51I=; b=doiwN5nXP1dUAcstR
 9xq2c3IoEdlry6lXnGeF1uimkZQC8kKTIbkm5tQqjnEgMpZbQWGhtjFbeGOJSo8O
 T4NZ5+dvnOiI7i8Tyd6Oi+0WhzhxJXB6zMl7G+IngL2DiS+NgwUTCDdSPapfDCtb
 TAA9EREA1aow+MwKj9lhwYSBU4bFJaZCZCJiQiNS50L7jSE6gphhDDMCkfJUMBRB
 bk2n81QfnMPZCtUlQR/ItKIN5SLk5wOHyXRCb4AruH3lthKFGCwm47Y0nJC5wKbn
 H04nf2hONtyjaGDJrUeLV6wK8A2El16HO8X35FGqSU9otquPNhsxyDBZK2RjKnWF
 fglSw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 49m74y80w9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Sun, 05 Oct 2025 22:14:27 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 5 Oct 2025 22:14:26 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 5 Oct 2025 22:14:26 -0700
Received: from localhost.localdomain (unknown [10.28.36.154])
 by maili.marvell.com (Postfix) with ESMTP id 896803F705A;
 Sun,  5 Oct 2025 22:14:23 -0700 (PDT)
From: Rakesh Kudurumalla <rkudurumalla@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <dev@dpdk.org>, <jerinj@marvell.com>, Rakesh Kudurumalla
 <rkudurumalla@marvell.com>
Subject: [PATCH 5/5] net/cnxk: enable CPT CQ for outbound traffic
Date: Mon, 6 Oct 2025 10:44:02 +0530
Message-ID: <20251006051402.1387576-5-rkudurumalla@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251006051402.1387576-1-rkudurumalla@marvell.com>
References: <20251006051402.1387576-1-rkudurumalla@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: m3-_Fm_UQhk9j5p32wGsW5LMc1iyl3JV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA2MDAzNiBTYWx0ZWRfX7MjnuDZT0UPF
 GXkCATzvxjhszOaJ/4inx8PzG8BGtP5/i5BmNnCxXGhO7rfdnIo8U4WP9qzdwg18erjOZfpqsZA
 cruXk7I86ZzSi7/YDKnes+IcMYbkJryO4/pOIAYUuuayMXhUkguUD/pTYRS/azDsEGTABrpSJNH
 kzEsSfXT8ax6qdBpNNlOevdkdbMhQdNzqTbsCxyXgrHps/oZoeRMgm94WY3kSJ5Fp9WfYdcjsCT
 WamYwRcmOLZuAf8gGyBfZR560wlFDkVJ35ZHS+h3STM0JXvQ8mJuPKXR/lUFtmsvtHIcrwJiVLC
 WkaKRIqsws6s7zbkUtPcewC51w9DNabEkcv4MJl9wdpW0/1OOQWUEKbuDTxcxT2NabHWpJWbBwv
 R8Su/CjA2tacHgd+rZj49q0Gz1p7Mw==
X-Authority-Analysis: v=2.4 cv=f6hFxeyM c=1 sm=1 tr=0 ts=68e35033 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=x6icFKpwvdMA:10 a=M5GUcnROAAAA:8 a=Am-SR8nSCvOn2axuWswA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: m3-_Fm_UQhk9j5p32wGsW5LMc1iyl3JV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_02,2025-10-02_03,2025-03-28_01
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

enable CPT CQ in cpt instruction to read outbound
error packets from CQ

Signed-off-by: Rakesh Kudurumalla <rkudurumalla@marvell.com>
---
 drivers/common/cnxk/roc_nix_inl.c              | 18 ++++++++++++++++++
 drivers/common/cnxk/roc_nix_inl.h              |  1 +
 .../common/cnxk/roc_platform_base_symbols.c    |  1 +
 drivers/net/cnxk/cn20k_ethdev_sec.c            | 10 ++++++----
 drivers/net/cnxk/cn20k_rxtx.h                  |  2 +-
 drivers/net/cnxk/cn20k_tx.h                    | 11 +++++++----
 6 files changed, 34 insertions(+), 9 deletions(-)

diff --git a/drivers/common/cnxk/roc_nix_inl.c b/drivers/common/cnxk/roc_nix_inl.c
index bc63f4ee62..70ab8001e1 100644
--- a/drivers/common/cnxk/roc_nix_inl.c
+++ b/drivers/common/cnxk/roc_nix_inl.c
@@ -2563,3 +2563,21 @@ roc_nix_inl_custom_meta_pool_cb_register(roc_nix_inl_custom_meta_pool_cb_t cb)
 {
 	custom_meta_pool_cb = cb;
 }
+
+uint8_t
+roc_nix_inl_is_cq_ena(struct roc_nix *roc_nix)
+{
+	struct idev_cfg *idev = idev_get_cfg();
+	struct nix_inl_dev *inl_dev;
+
+	PLT_SET_USED(roc_nix);
+	if (idev != NULL) {
+		inl_dev = idev->nix_inl_dev;
+		if (inl_dev)
+			return inl_dev->cpt_cq_ena;
+		else
+			return 0;
+	} else {
+		return 0;
+	}
+}
diff --git a/drivers/common/cnxk/roc_nix_inl.h b/drivers/common/cnxk/roc_nix_inl.h
index 4bae261848..7970ac2258 100644
--- a/drivers/common/cnxk/roc_nix_inl.h
+++ b/drivers/common/cnxk/roc_nix_inl.h
@@ -213,6 +213,7 @@ int __roc_api roc_nix_inl_ctx_write(struct roc_nix *roc_nix, void *sa_dptr,
 void __roc_api roc_nix_inl_outb_cpt_lfs_dump(struct roc_nix *roc_nix, FILE *file);
 uint64_t __roc_api roc_nix_inl_eng_caps_get(struct roc_nix *roc_nix);
 void *__roc_api roc_nix_inl_dev_qptr_get(uint8_t qid);
+uint8_t __roc_api roc_nix_inl_is_cq_ena(struct roc_nix *roc_nix);
 
 enum roc_nix_cpt_lf_stats_type {
 	ROC_NIX_CPT_LF_STATS_INL_DEV,
diff --git a/drivers/common/cnxk/roc_platform_base_symbols.c b/drivers/common/cnxk/roc_platform_base_symbols.c
index e6fa3b540b..16ab37655d 100644
--- a/drivers/common/cnxk/roc_platform_base_symbols.c
+++ b/drivers/common/cnxk/roc_platform_base_symbols.c
@@ -281,6 +281,7 @@ RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_eng_caps_get)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_custom_meta_pool_cb_register)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_dev_xaq_realloc)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_dev_qptr_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_is_cq_ena)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_dev_stats_get)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_dev_stats_reset)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_dev_init)
diff --git a/drivers/net/cnxk/cn20k_ethdev_sec.c b/drivers/net/cnxk/cn20k_ethdev_sec.c
index 5b0aa8a34f..fd83f64c5d 100644
--- a/drivers/net/cnxk/cn20k_ethdev_sec.c
+++ b/drivers/net/cnxk/cn20k_ethdev_sec.c
@@ -664,6 +664,9 @@ cn20k_eth_sec_outb_sa_misc_fill(struct roc_nix *roc_nix, struct roc_ow_ipsec_out
 {
 	uint64_t *ring_base, ring_addr;
 
+	if (roc_nix_inl_is_cq_ena(roc_nix))
+		goto done;
+
 	if (ipsec_xfrm->life.bytes_soft_limit | ipsec_xfrm->life.packets_soft_limit) {
 		ring_base = roc_nix_inl_outb_ring_base_get(roc_nix);
 		if (ring_base == NULL)
@@ -674,6 +677,7 @@ cn20k_eth_sec_outb_sa_misc_fill(struct roc_nix *roc_nix, struct roc_ow_ipsec_out
 		sa->ctx.err_ctl.s.address = ring_addr >> 3;
 		sa->w0.s.ctx_id = ((uintptr_t)sa_cptr >> 51) & 0x1ff;
 	}
+done:
 	return 0;
 }
 
@@ -909,8 +913,7 @@ cn20k_eth_sec_session_create(void *device, struct rte_security_session_conf *con
 		sess_priv.chksum =
 			(!ipsec->options.ip_csum_enable << 1 | !ipsec->options.l4_csum_enable);
 		sess_priv.dec_ttl = ipsec->options.dec_ttl;
-		if (roc_feature_nix_has_inl_ipsec_mseg() && dev->outb.cpt_eng_caps & BIT_ULL(35))
-			sess_priv.nixtx_off = 1;
+		sess_priv.cpt_cq_ena = roc_nix_inl_is_cq_ena(&dev->nix);
 
 		/* Pointer from eth_sec -> outb_sa */
 		eth_sec->sa = outb_sa;
@@ -1106,9 +1109,8 @@ cn20k_eth_sec_session_update(void *device, struct rte_security_session *sess,
 		sess_priv.chksum =
 			(!ipsec->options.ip_csum_enable << 1 | !ipsec->options.l4_csum_enable);
 		sess_priv.dec_ttl = ipsec->options.dec_ttl;
-		if (roc_feature_nix_has_inl_ipsec_mseg() && dev->outb.cpt_eng_caps & BIT_ULL(35))
-			sess_priv.nixtx_off = 1;
 
+		sess_priv.cpt_cq_ena = roc_nix_inl_is_cq_ena(&dev->nix);
 		rc = roc_nix_inl_ctx_write(&dev->nix, outb_sa_dptr, eth_sec->sa, eth_sec->inb,
 					   sizeof(struct roc_ow_ipsec_outb_sa));
 		if (rc)
diff --git a/drivers/net/cnxk/cn20k_rxtx.h b/drivers/net/cnxk/cn20k_rxtx.h
index 10da42680f..5fc4f8656d 100644
--- a/drivers/net/cnxk/cn20k_rxtx.h
+++ b/drivers/net/cnxk/cn20k_rxtx.h
@@ -106,7 +106,7 @@ struct __rte_packed_begin cn20k_sec_sess_priv {
 			uint16_t partial_len : 10;
 			uint16_t chksum : 2;
 			uint16_t dec_ttl : 1;
-			uint16_t nixtx_off : 1;
+			uint16_t cpt_cq_ena : 1;
 			uint16_t rsvd : 2;
 		};
 
diff --git a/drivers/net/cnxk/cn20k_tx.h b/drivers/net/cnxk/cn20k_tx.h
index 3fb2e1f4e1..9e48744831 100644
--- a/drivers/net/cnxk/cn20k_tx.h
+++ b/drivers/net/cnxk/cn20k_tx.h
@@ -444,14 +444,15 @@ cn20k_nix_prep_sec_vec(struct rte_mbuf *m, uint64x2_t *cmd0, uint64x2_t *cmd1,
 	uint32_t pkt_len, dlen_adj, rlen;
 	uint8_t l3l4type, chksum;
 	uint64x2_t cmd01, cmd23;
+	uint64_t sa, cpt_cq_ena;
 	uint8_t l2_len, l3_len;
 	uintptr_t dptr, nixtx;
 	uint64_t ucode_cmd[4];
 	uint64_t *laddr, w0;
 	uint16_t tag;
-	uint64_t sa;
 
 	sess_priv.u64 = *rte_security_dynfield(m);
+	cpt_cq_ena = sess_priv.cpt_cq_ena;
 
 	if (flags & NIX_TX_NEED_SEND_HDR_W1) {
 		/* Extract l3l4type either from il3il4type or ol3ol4type */
@@ -530,7 +531,7 @@ cn20k_nix_prep_sec_vec(struct rte_mbuf *m, uint64x2_t *cmd0, uint64x2_t *cmd1,
 	cmd01 = vdupq_n_u64(0);
 	cmd01 = vsetq_lane_u64(w0, cmd01, 0);
 	/* CPT_RES_S is 16B above NIXTX */
-	cmd01 = vsetq_lane_u64(nixtx - 16, cmd01, 1);
+	cmd01 = vsetq_lane_u64((nixtx - 16) | cpt_cq_ena << 63, cmd01, 1);
 
 	/* Return nixtx addr */
 	*nixtx_addr = nixtx;
@@ -577,15 +578,16 @@ cn20k_nix_prep_sec(struct rte_mbuf *m, uint64_t *cmd, uintptr_t *nixtx_addr, uin
 	uint8_t l3l4type, chksum;
 	uint64x2_t cmd01, cmd23;
 	union nix_send_sg_s *sg;
+	uint64_t sa, cpt_cq_ena;
 	uint8_t l2_len, l3_len;
 	uintptr_t dptr, nixtx;
 	uint64_t ucode_cmd[4];
 	uint64_t *laddr, w0;
 	uint16_t tag;
-	uint64_t sa;
 
 	/* Move to our line from base */
 	sess_priv.u64 = *rte_security_dynfield(m);
+	cpt_cq_ena = sess_priv.cpt_cq_ena;
 	send_hdr = (struct nix_send_hdr_s *)cmd;
 	if (flags & NIX_TX_NEED_EXT_HDR)
 		sg = (union nix_send_sg_s *)&cmd[4];
@@ -668,7 +670,8 @@ cn20k_nix_prep_sec(struct rte_mbuf *m, uint64_t *cmd, uintptr_t *nixtx_addr, uin
 	cmd01 = vdupq_n_u64(0);
 	cmd01 = vsetq_lane_u64(w0, cmd01, 0);
 	/* CPT_RES_S is 16B above NIXTX */
-	cmd01 = vsetq_lane_u64(nixtx - 16, cmd01, 1);
+	/* CQ_ENA for cpt */
+	cmd01 = vsetq_lane_u64((nixtx - 16) | cpt_cq_ena << 63, cmd01, 1);
 
 	/* Return nixtx addr */
 	*nixtx_addr = nixtx;
-- 
2.25.1

