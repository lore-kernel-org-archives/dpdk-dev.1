Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C00A3CD3430
	for <dpdk-dev@archiver.kernel.org>; Tue,  5 May 2026 08:50:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D70BA4060B;
	Tue,  5 May 2026 10:50:45 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id AB1A540272
 for <dev@dpdk.org>; Tue,  5 May 2026 10:50:44 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6455PRb4351382 for <dev@dpdk.org>; Tue, 5 May 2026 01:50:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=Qtx7Qhxqb4qKuGhPTUgREHT
 9Ms8fOd0ZnqCRzvzRXoc=; b=B0DvdSl44n7jFTP87B6wQ2nppLXYDfwJt1L8vqV
 7DXehUUa0apQ00av6/vLKMFvjEV6Sl2YajZQBiuYEkkYHsEVCVSmwscS4krwZTo0
 Btbv3lKjChNvWDaO23q1JlPy75h/DTCHdmg9OPXzvVdpBW99lIJNFGX+q4agr5UF
 aU3SZXSi3D7iNFssbaBu9iJTeFoOm7SEfNImBz0TcgCNKPA52ISJlIeFoysuoAHt
 xIA2mO3/lYRrKmdxFefb+V9nnpAyxuhI4v53zW3gvffzBMy5Qa/Uh2iPpROolwLu
 tKNlajgrVEOKR2NjCbFvQJhlolmi2JgI5WKsZPwuANA5aMw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4dx218x09n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 05 May 2026 01:50:43 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 5 May 2026 01:50:42 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 5 May 2026 01:50:42 -0700
Received: from localhost.localdomain (unknown [10.28.36.154])
 by maili.marvell.com (Postfix) with ESMTP id 7A5AD3F704B;
 Tue,  5 May 2026 01:50:39 -0700 (PDT)
From: rkudurumalla <rkudurumalla@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <dev@dpdk.org>, <jerinj@marvell.com>, Rakesh Kudurumalla
 <rkudurumalla@marvell.com>
Subject: [PATCH 1/2] common/cnxk: add ROC API to support custom profile
Date: Tue, 5 May 2026 14:20:36 +0530
Message-ID: <20260505085037.3961519-1-rkudurumalla@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDA4MiBTYWx0ZWRfX7O+8aRAtSQcR
 KD9PF19rj8pSuUD2lVLigynAsFplyxPd+ybsr9E+PnrqPNxN/BSaJX1pptxZ5Qs39lQQomLrLMb
 IJb5XHkc+TRpbNWXGGizFWiyASHewJ9SFnTsp9ibm4G7xD6xO+3W6b5h0byMfIh0mbdtgIcBT/w
 oyAlPlCDyArDMYYUrY0YBa9eRs3ovTYW6PPCC/kJxdd7m8Mlt+llq+mGvjdX+U+lTo6qLx1qOlW
 ZPRI2Dy5P+dedEXELh5kdiT4TEOEkeAAzFpB6mD/TZm+p4+aqjSMDW9b4uC5XU6JJQnrgnHAFin
 f8t1zqU5YfyJljJOPk23y6fascsNZDyF6rU+8q45HtCS2dvoUu8+RSkaGjWmUXq8Rz2yl6mo9Mo
 j9feACnsEvutrXq9XUf3mcKz/DcD4w/yNtwnTf0axKJJfwXy+8Ue4Nm00gdIwmfOTNg42tCKske
 kmR0/q8Uj1o42KqsK8g==
X-Proofpoint-ORIG-GUID: LwKEimnh7mNL653cDiHeFq0sHt1ko5c6
X-Authority-Analysis: v=2.4 cv=coqrVV4i c=1 sm=1 tr=0 ts=69f9af63 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=-HEf2dkWPfUWr8P7ZxMA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: LwKEimnh7mNL653cDiHeFq0sHt1ko5c6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
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

From: Rakesh Kudurumalla <rkudurumalla@marvell.com>

Added ROC api to support custom inline profile creation,
and create and configure sa_table for both inl_dev and nix
dev.

Signed-off-by: Rakesh Kudurumalla <rkudurumalla@marvell.com>
---
 drivers/common/cnxk/hw/nix.h                  |  44 +++
 drivers/common/cnxk/roc_nix_inl.c             | 294 ++++++++++++++++++
 drivers/common/cnxk/roc_nix_inl.h             |   9 +
 drivers/common/cnxk/roc_nix_inl_dev.c         |  28 +-
 drivers/common/cnxk/roc_nix_inl_priv.h        |   2 +
 drivers/common/cnxk/roc_npc.c                 |  23 +-
 drivers/common/cnxk/roc_npc.h                 |   6 +
 .../common/cnxk/roc_platform_base_symbols.c   |   3 +
 8 files changed, 392 insertions(+), 17 deletions(-)

diff --git a/drivers/common/cnxk/hw/nix.h b/drivers/common/cnxk/hw/nix.h
index a2a372a56a..6abb184d45 100644
--- a/drivers/common/cnxk/hw/nix.h
+++ b/drivers/common/cnxk/hw/nix.h
@@ -2794,4 +2794,48 @@ enum cgx_port_type {
 	CGX_PORT_OTHER = 0xff,
 };
 
+/* Shift values for NIX_AF_RX_DEF_INLINE register */
+enum {
+	NIX_LTYPE_MASK_SHIFT = 0,
+	NIX_LTYPE_MATCH_SHIFT = 4,
+	NIX_LID_SHIFT = 8,
+	NIX_GEN_OFFSET_NG_SHIFT = 11,
+	NIX_GEN_OFFSET_SHIFT = 12,
+	NIX_GEN_NZ_SHIFT = 16,
+	NIX_CPT_L3_LID_SHIFT = 17,
+	NIX_FLAGS_MASK_SHIFT = 20,
+	NIX_FLAGS_MATCH_SHIFT = 24,
+	NIX_MATCH_OIPV4_SHIFT = 28,
+	NIX_MATCH_OIPV6_SHIFT = 29,
+	NIX_OIPLEN_ENA_SHIFT = 30,
+	NIX_INLINE_SHIFT_SHIFT = 32,
+};
+
+/* Shift values for NIX_AF_RX_INLINE_GEN_CFG register */
+enum {
+	NIX_PARAM2_SHIFT = 0,
+	NIX_PARAM1_SHIFT = 16,
+	NIX_OPCODE_SHIFT = 32,
+	NIX_EGRP_SHIFT = 48,
+	NIX_CTX_VAL_SHIFT = 51,
+};
+
+/* Shift values for NIX_AF_RX_EXTRACT_INLINE register */
+enum {
+	NIX_LEN_L_SHIFT = 0,
+	NIX_BITPOS_L_SHIFT = 8,
+	NIX_LEN_M_SHIFT = 16,
+	NIX_BITPOS_M_SHIFT = 24,
+	NIX_LEN_H_SHIFT = 32,
+	NIX_BITPOS_H_SHIFT = 40,
+};
+
+/* Shift values for NIX_AF_RX_PROT_FIELD_INLINE register */
+enum {
+	NIX_VALID_SHIFT = 0,
+	NIX_OFFSET_SHIFT = 2,
+	NIX_SIZEM1_SHIFT = 8,
+	NIX_LOGMULT_SHIFT = 12,
+};
+
 #endif /* __NIX_HW_H__ */
diff --git a/drivers/common/cnxk/roc_nix_inl.c b/drivers/common/cnxk/roc_nix_inl.c
index ecf93ed03e..b515d52534 100644
--- a/drivers/common/cnxk/roc_nix_inl.c
+++ b/drivers/common/cnxk/roc_nix_inl.c
@@ -778,6 +778,43 @@ roc_nix_inl_inb_sa_base_get(struct roc_nix *roc_nix, bool inb_inl_dev)
 	return (uintptr_t)nix->inb_sa_base[nix->ipsec_prof_id];
 }
 
+uintptr_t
+roc_nix_inl_inb_prof_sa_base_get(struct roc_nix *roc_nix, bool inb_inl_dev, uint16_t profile_id)
+{
+	struct idev_cfg *idev = idev_get_cfg();
+	struct nix_inl_dev *inl_dev;
+	struct nix *nix = NULL;
+
+	/* Validate profile_id range */
+	if (profile_id >= ROC_NIX_INL_PROFILE_CNT) {
+		plt_err("Invalid profile_id %u, must be < %u", profile_id, ROC_NIX_INL_PROFILE_CNT);
+		return 0;
+	}
+
+	if (idev == NULL)
+		return 0;
+
+	if (!inb_inl_dev && roc_nix == NULL)
+		return 0;
+
+	if (roc_nix) {
+		nix = roc_nix_to_nix_priv(roc_nix);
+		if (!nix->inl_inb_ena)
+			return 0;
+	}
+
+	if (inb_inl_dev) {
+		inl_dev = idev->nix_inl_dev;
+		/* Return inline dev sa base for the specified profile */
+		if (inl_dev)
+			return (uintptr_t)inl_dev->inb_sa_base[profile_id];
+		return 0;
+	}
+
+	/* Return NIX sa base for the specified profile */
+	return (uintptr_t)nix->inb_sa_base[profile_id];
+}
+
 uint16_t
 roc_nix_inl_inb_ipsec_profile_id_get(struct roc_nix *roc_nix, bool inb_inl_dev)
 {
@@ -838,6 +875,263 @@ roc_nix_inl_inb_reass_profile_id_get(struct roc_nix *roc_nix, bool inb_inl_dev)
 	return nix->reass_prof_id;
 }
 
+static int
+nix_inl_custom_profile_sa_tbl_setup(struct roc_nix *roc_nix, uint32_t sa_size, uint32_t max_sa,
+				    uint16_t profile_id)
+{
+	struct nix *nix = roc_nix_to_nix_priv(roc_nix);
+	struct idev_cfg *idev = idev_get_cfg();
+	struct nix_inl_dev *inl_dev = NULL;
+	struct nix_rx_inl_lf_cfg_req *lf_cfg;
+	uint64_t res_addr_offset = 0;
+	uint64_t cpt_cq_ena = 0;
+	uint32_t inb_sa_sz;
+	uint32_t lenm1_max;
+	uint64_t def_cptq = 0;
+	struct mbox *mbox;
+	uint8_t sa_pow2_sz;
+	uint8_t sa_w;
+	int rc = 0;
+
+	/* Validate profile_id range */
+	if (profile_id >= ROC_NIX_INL_PROFILE_CNT) {
+		plt_err("Invalid profile_id %u, must be < %u", profile_id, ROC_NIX_INL_PROFILE_CNT);
+		return -EINVAL;
+	}
+
+	/* Use sa_size parameter if provided, otherwise use default */
+	if (sa_size > 0)
+		inb_sa_sz = sa_size;
+	else
+		inb_sa_sz = ROC_NIX_INL_OW_IPSEC_INB_SA_SZ;
+
+	/* Validate max_sa is provided */
+	if (max_sa == 0) {
+		plt_err("max_sa must be greater than 0 for profile %u", profile_id);
+		return -EINVAL;
+	}
+
+	/* Update max_sa */
+	nix->inb_sa_max[profile_id] = max_sa;
+
+	nix->inb_sa_sz[profile_id] = inb_sa_sz;
+	nix->inb_sa_base[profile_id] = plt_zmalloc(inb_sa_sz * max_sa, ROC_NIX_INL_SA_BASE_ALIGN);
+	if (!nix->inb_sa_base[profile_id]) {
+		plt_err("Failed to allocate memory for Inbound SA for profile %u", profile_id);
+		rc = -ENOMEM;
+		goto exit;
+	}
+
+	mbox = mbox_get(nix->dev.mbox);
+	lf_cfg = mbox_alloc_msg_nix_rx_inl_lf_cfg(mbox);
+	if (lf_cfg == NULL) {
+		rc = -ENOSPC;
+		goto free_mem;
+	}
+
+	lenm1_max = NIX_RPM_MAX_HW_FRS - 1;
+	sa_w = plt_log2_u32(max_sa);
+	sa_pow2_sz = plt_log2_u32(inb_sa_sz);
+
+	/* Get default CPT queue from inline device if available */
+	if (idev && idev->nix_inl_dev) {
+		inl_dev = idev->nix_inl_dev;
+		if (!inl_dev->nb_inb_cptlfs)
+			def_cptq = 0;
+		else
+			def_cptq = inl_dev->nix_inb_qids[inl_dev->inb_cpt_lf_id];
+
+		res_addr_offset = (uint64_t)(inl_dev->res_addr_offset & 0xFF) << 48;
+		if (res_addr_offset)
+			res_addr_offset |= (1UL << 56);
+
+		cpt_cq_ena = (uint64_t)inl_dev->cpt_cq_ena << 63;
+	}
+
+	lf_cfg->enable = 1;
+	lf_cfg->profile_id = profile_id;
+	lf_cfg->rx_inline_sa_base = (uintptr_t)nix->inb_sa_base[profile_id] | cpt_cq_ena;
+	lf_cfg->rx_inline_cfg0 = ((uint64_t)def_cptq << 57) | res_addr_offset |
+				 ((uint64_t)SSO_TT_ORDERED << 44) | (sa_pow2_sz << 16) | lenm1_max;
+	lf_cfg->rx_inline_cfg1 = (max_sa - 1) | ((uint64_t)sa_w << 32);
+
+	rc = mbox_process(mbox);
+	if (rc) {
+		plt_err("Failed to setup NIX Inbound SA conf of profile=%u, rc=%d", profile_id, rc);
+		goto free_mem;
+	}
+
+	mbox_put(mbox);
+	return rc;
+
+free_mem:
+	mbox_put(mbox);
+	plt_free(nix->inb_sa_base[profile_id]);
+	nix->inb_sa_base[profile_id] = NULL;
+exit:
+	return rc;
+}
+
+int
+roc_nix_inl_custom_profile_setup(struct roc_nix *roc_nix, uint64_t def_cfg, uint64_t gen_cfg,
+				 uint64_t extract_cfg, const uint64_t *prot_field_cfg,
+				 uint32_t sa_size, uint32_t max_sa, bool is_inline,
+				 uint16_t *profile_id)
+{
+	struct nix_rx_inl_profile_cfg_req *req;
+	struct nix_rx_inl_profile_cfg_rsp *rsp;
+	struct nix *nix = roc_nix_to_nix_priv(roc_nix);
+	struct idev_cfg *idev = idev_get_cfg();
+	struct nix_inl_dev *inl_dev = NULL;
+	struct mbox *mbox;
+	int rc = 0;
+	int i;
+
+	if (roc_nix == NULL || profile_id == NULL)
+		return -EINVAL;
+
+	if (!nix->inl_inb_ena)
+		return -ENOTSUP;
+
+	/* Get inline device - required for custom profiles */
+	if (!idev || !idev->nix_inl_dev) {
+		plt_err("nix_inl_dev not available for custom profile setup");
+		return -ENODEV;
+	}
+
+	inl_dev = idev->nix_inl_dev;
+
+	/* Use inline device mbox if is_inline is true, otherwise use nix mbox */
+	if (is_inline)
+		mbox = mbox_get(inl_dev->dev.mbox);
+	else
+		mbox = mbox_get(nix->dev.mbox);
+
+	req = mbox_alloc_msg_nix_rx_inl_profile_cfg(mbox);
+	if (req == NULL) {
+		rc = -ENOSPC;
+		plt_err("Failed to alloc %s profile cfg mbox msg",
+			is_inline ? "inline device" : "nix device");
+		mbox_put(mbox);
+		goto exit;
+	}
+
+	req->def_cfg = def_cfg;
+	req->gen_cfg = gen_cfg;
+	req->extract_cfg = extract_cfg;
+	for (i = 0; i < NIX_RX_INL_PROFILE_PROTO_CNT; i++)
+		req->prot_field_cfg[i] = prot_field_cfg[i];
+
+	rc = mbox_process_msg(mbox, (void **)&rsp);
+	if (rc) {
+		plt_err("Failed to setup %s custom profile, rc=%d",
+			is_inline ? "inline device" : "nix device", rc);
+		mbox_put(mbox);
+		goto exit;
+	}
+
+	*profile_id = rsp->profile_id;
+
+	/* Validate returned profile_id */
+	if (*profile_id >= ROC_NIX_INL_PROFILE_CNT) {
+		plt_err("Hardware returned invalid profile_id %u", *profile_id);
+		mbox_put(mbox);
+		rc = -EINVAL;
+		goto exit;
+	}
+
+	plt_info("%s custom profile %u created", is_inline ? "Inline device" : "NIX device",
+		 *profile_id);
+	mbox_put(mbox);
+
+	if (is_inline)
+		rc = nix_inl_dev_profile_config(inl_dev, sa_size, max_sa, *profile_id);
+	else
+		rc = nix_inl_custom_profile_sa_tbl_setup(roc_nix, sa_size, max_sa, *profile_id);
+
+	if (rc) {
+		plt_err("Failed to configure custom profile %u, rc=%d", *profile_id, rc);
+		/* Release the allocated profile on failure */
+		roc_nix_inl_custom_profile_release(roc_nix, *profile_id, is_inline);
+	}
+
+exit:
+	return rc;
+}
+
+int
+roc_nix_inl_custom_profile_release(struct roc_nix *roc_nix, uint16_t profile_id, bool is_inline)
+{
+	struct nix *nix = roc_nix_to_nix_priv(roc_nix);
+	struct idev_cfg *idev = idev_get_cfg();
+	struct nix_inl_dev *inl_dev = NULL;
+	struct nix_rx_inl_lf_cfg_req *lf_cfg;
+	struct mbox *mbox;
+	int rc = 0;
+
+	if (roc_nix == NULL)
+		return -EINVAL;
+
+	if (!nix->inl_inb_ena)
+		return -ENOTSUP;
+
+	/* Validate profile_id range */
+	if (profile_id >= ROC_NIX_INL_PROFILE_CNT) {
+		plt_err("Invalid profile_id %u, must be < %u", profile_id, ROC_NIX_INL_PROFILE_CNT);
+		return -EINVAL;
+	}
+
+	if (is_inline) {
+		/* Get inline device for inline mode */
+		if (!idev || !idev->nix_inl_dev) {
+			plt_err("nix_inl_dev not available for custom profile release");
+			return -ENODEV;
+		}
+		inl_dev = idev->nix_inl_dev;
+		mbox = mbox_get(inl_dev->dev.mbox);
+	} else {
+		/* Use NIX device mbox for non-inline mode */
+		mbox = mbox_get(nix->dev.mbox);
+	}
+
+	lf_cfg = mbox_alloc_msg_nix_rx_inl_lf_cfg(mbox);
+	if (lf_cfg == NULL) {
+		rc = -ENOSPC;
+		plt_err("Failed to alloc profile release mbox msg");
+		mbox_put(mbox);
+		goto exit;
+	}
+
+	lf_cfg->enable = 0;
+	lf_cfg->profile_id = profile_id;
+	rc = mbox_process(mbox);
+	if (rc) {
+		plt_err("Failed to cleanup NIX Inbound profile=%u SA conf, rc=%d", profile_id, rc);
+		mbox_put(mbox);
+		goto exit;
+	}
+
+	/* Free SA base memory */
+	if (is_inline) {
+		if (inl_dev->inb_sa_base[profile_id]) {
+			plt_free(inl_dev->inb_sa_base[profile_id]);
+			inl_dev->inb_sa_base[profile_id] = NULL;
+		}
+	} else {
+		if (nix->inb_sa_base[profile_id]) {
+			plt_free(nix->inb_sa_base[profile_id]);
+			nix->inb_sa_base[profile_id] = NULL;
+		}
+	}
+
+	mbox_put(mbox);
+	plt_info("%s custom profile %u released", is_inline ? "Inline device" : "NIX device",
+		 profile_id);
+
+exit:
+	return rc;
+}
+
 bool
 roc_nix_inl_inb_rx_inject_enable(struct roc_nix *roc_nix, bool inb_inl_dev)
 {
diff --git a/drivers/common/cnxk/roc_nix_inl.h b/drivers/common/cnxk/roc_nix_inl.h
index 82dae4b1ba..2832ed7961 100644
--- a/drivers/common/cnxk/roc_nix_inl.h
+++ b/drivers/common/cnxk/roc_nix_inl.h
@@ -162,8 +162,17 @@ int __roc_api roc_nix_inl_inb_fini(struct roc_nix *roc_nix);
 bool __roc_api roc_nix_inl_inb_is_enabled(struct roc_nix *roc_nix);
 uintptr_t __roc_api roc_nix_inl_inb_sa_base_get(struct roc_nix *roc_nix,
 						bool inl_dev_sa);
+uintptr_t __roc_api roc_nix_inl_inb_prof_sa_base_get(struct roc_nix *roc_nix, bool inb_inl_dev,
+						     uint16_t profile_id);
 uint16_t roc_nix_inl_inb_ipsec_profile_id_get(struct roc_nix *roc_nix, bool inb_inl_dev);
 uint16_t __roc_api roc_nix_inl_inb_reass_profile_id_get(struct roc_nix *roc_nix, bool inb_inl_dev);
+int __roc_api roc_nix_inl_custom_profile_setup(struct roc_nix *roc_nix, uint64_t def_cfg,
+					       uint64_t gen_cfg, uint64_t extract_cfg,
+					       const uint64_t *prot_field_cfg,
+					       uint32_t sa_size, uint32_t max_sa,
+					       bool is_inline, uint16_t *profile_id);
+int __roc_api roc_nix_inl_custom_profile_release(struct roc_nix *roc_nix, uint16_t profile_id,
+						 bool is_inline);
 bool __roc_api roc_nix_inl_inb_rx_inject_enable(struct roc_nix *roc_nix, bool inl_dev_sa);
 uint32_t __roc_api roc_nix_inl_inb_spi_range(struct roc_nix *roc_nix,
 					     bool inl_dev_sa, uint32_t *min,
diff --git a/drivers/common/cnxk/roc_nix_inl_dev.c b/drivers/common/cnxk/roc_nix_inl_dev.c
index 246dd4612f..667209b8a0 100644
--- a/drivers/common/cnxk/roc_nix_inl_dev.c
+++ b/drivers/common/cnxk/roc_nix_inl_dev.c
@@ -641,11 +641,12 @@ nix_inl_sso_release(struct nix_inl_dev *inl_dev)
 	return 0;
 }
 
-static int
-nix_inl_nix_profile_config(struct nix_inl_dev *inl_dev, uint8_t profile_id)
+int
+nix_inl_dev_profile_config(struct nix_inl_dev *inl_dev, uint32_t sa_size, uint32_t max_sa,
+			   uint16_t profile_id)
 {
 	struct mbox *mbox = mbox_get((&inl_dev->dev)->mbox);
-	uint64_t max_sa, sa_w, sa_pow2_sz, lenm1_max;
+	uint64_t sa_w, sa_pow2_sz, lenm1_max;
 	struct nix_rx_inl_lf_cfg_req *lf_cfg;
 	uint64_t res_addr_offset;
 	uint64_t cpt_cq_ena;
@@ -653,10 +654,12 @@ nix_inl_nix_profile_config(struct nix_inl_dev *inl_dev, uint8_t profile_id)
 	size_t inb_sa_sz;
 	void *sa;
 	int rc;
+	uint32_t i;
 
-	/* Alloc contiguous memory for Inbound SA's */
-	inb_sa_sz = ROC_NIX_INL_OW_IPSEC_INB_SA_SZ;
-	max_sa = inl_dev->inb_sa_max[profile_id];
+	inb_sa_sz = sa_size;
+
+	/* Update max_sa in inl_dev */
+	inl_dev->inb_sa_max[profile_id] = max_sa;
 	inl_dev->inb_sa_sz[profile_id] = inb_sa_sz;
 	inl_dev->inb_sa_base[profile_id] =
 		plt_zmalloc(inb_sa_sz * max_sa, ROC_NIX_INL_SA_BASE_ALIGN);
@@ -666,8 +669,11 @@ nix_inl_nix_profile_config(struct nix_inl_dev *inl_dev, uint8_t profile_id)
 		goto exit;
 	}
 
-	sa = ((uint8_t *)inl_dev->inb_sa_base[profile_id]);
-	roc_ow_reass_inb_sa_init(sa);
+	/* Initialize all SAs */
+	for (i = 0; i < max_sa; i++) {
+		sa = ((uint8_t *)inl_dev->inb_sa_base[profile_id]) + (i * inb_sa_sz);
+		roc_ow_reass_inb_sa_init(sa);
+	}
 	lf_cfg = mbox_alloc_msg_nix_rx_inl_lf_cfg(mbox);
 	if (lf_cfg == NULL) {
 		rc = -ENOSPC;
@@ -694,7 +700,7 @@ nix_inl_nix_profile_config(struct nix_inl_dev *inl_dev, uint8_t profile_id)
 	lf_cfg->rx_inline_cfg0 =
 		((def_cptq << 57) | res_addr_offset | ((uint64_t)SSO_TT_ORDERED << 44) |
 		 (sa_pow2_sz << 16) | lenm1_max);
-	lf_cfg->rx_inline_cfg1 = (max_sa - 1) | (sa_w << 32);
+	lf_cfg->rx_inline_cfg1 = (max_sa - 1) | ((uint64_t)sa_w << 32);
 
 	rc = mbox_process(mbox);
 	if (rc) {
@@ -791,8 +797,8 @@ nix_inl_nix_reass_setup(struct nix_inl_dev *inl_dev)
 		return rc;
 	}
 
-	inl_dev->inb_sa_max[inl_dev->reass_prof_id] = 1;
-	return nix_inl_nix_profile_config(inl_dev, inl_dev->reass_prof_id);
+	return nix_inl_dev_profile_config(inl_dev, ROC_NIX_INL_OW_IPSEC_INB_SA_SZ, 1,
+					  inl_dev->reass_prof_id);
 }
 
 static int
diff --git a/drivers/common/cnxk/roc_nix_inl_priv.h b/drivers/common/cnxk/roc_nix_inl_priv.h
index 402b1514e7..f63b7787ac 100644
--- a/drivers/common/cnxk/roc_nix_inl_priv.h
+++ b/drivers/common/cnxk/roc_nix_inl_priv.h
@@ -148,5 +148,7 @@ uint16_t nix_inl_dev_pffunc_get(void);
 
 int nix_inl_setup_dflt_ipsec_profile(struct dev *dev, uint16_t *prof_id);
 int nix_inl_setup_reass_profile(struct dev *dev, uint8_t *prof_id);
+int nix_inl_dev_profile_config(struct nix_inl_dev *inl_dev, uint32_t sa_size, uint32_t max_sa,
+			       uint16_t profile_id);
 
 #endif /* _ROC_NIX_INL_PRIV_H_ */
diff --git a/drivers/common/cnxk/roc_npc.c b/drivers/common/cnxk/roc_npc.c
index acf0007e05..a906fe0413 100644
--- a/drivers/common/cnxk/roc_npc.c
+++ b/drivers/common/cnxk/roc_npc.c
@@ -547,9 +547,13 @@ npc_parse_spi_to_sa_action(struct roc_npc *roc_npc, const struct roc_npc_action
 		req->spi_index = plt_be_to_cpu_32(flow->spi_to_sa_info.spi);
 		req->match_id = flow->match_id;
 		req->valid = true;
-		if (roc_model_is_cn20k())
-			req->inline_profile_id =
-				roc_nix_inl_inb_ipsec_profile_id_get(roc_nix, true);
+		if (roc_model_is_cn20k()) {
+			if (sec_action->use_custom_profile)
+				req->inline_profile_id = sec_action->profile_id;
+			else
+				req->inline_profile_id =
+					roc_nix_inl_inb_ipsec_profile_id_get(roc_nix, true);
+		}
 		rc = mbox_process_msg(mbox, (void *)&rsp);
 		if (rc)
 			return rc;
@@ -937,11 +941,18 @@ npc_parse_actions(struct roc_npc *roc_npc, const struct roc_npc_attr *attr,
 		flow->npc_action = NIX_RX_ACTIONOP_UCAST;
 	} else if (req_act & ROC_NPC_ACTION_TYPE_SEC) {
 		if (roc_model_is_cn20k()) {
+			const struct roc_npc_sec_action *sa_action = NULL;
+			uint16_t profile_id;
+
 			flow->npc_action = NIX_RX_ACTIONOP_UCAST_CPT;
 			flow->npc_action |= (uint64_t)rq << 20;
-			flow->npc_action2 =
-				roc_nix_inl_inb_ipsec_profile_id_get(roc_nix, true) << 8;
-			flow->npc_action2 |= is_non_inp ? (1ULL << 15) : 0;
+			profile_id = roc_nix_inl_inb_ipsec_profile_id_get(roc_nix, true);
+			if (sec_action && sec_action->conf) {
+				sa_action = (const struct roc_npc_sec_action *)sec_action->conf;
+				if (sa_action->use_custom_profile)
+					profile_id = sa_action->profile_id;
+			}
+			flow->npc_action2 = (is_non_inp ? (1ULL << 15) : 0) | (profile_id << 8);
 		} else {
 			flow->npc_action = NIX_RX_ACTIONOP_UCAST_IPSEC;
 			flow->npc_action |= (uint64_t)rq << 20;
diff --git a/drivers/common/cnxk/roc_npc.h b/drivers/common/cnxk/roc_npc.h
index 62385e4481..130990bda7 100644
--- a/drivers/common/cnxk/roc_npc.h
+++ b/drivers/common/cnxk/roc_npc.h
@@ -285,6 +285,12 @@ struct roc_npc_sec_action {
 	 */
 	enum roc_npc_sec_action_alg alg;
 	bool is_non_inp;
+	uint16_t profile_id;
+	/* Enable custom inline profile.
+	 * When true, use custom IPsec profile specified by profile_id.
+	 * When false, use default IPsec profile (backward compatible).
+	 */
+	bool use_custom_profile;
 };
 
 struct roc_npc_attr {
diff --git a/drivers/common/cnxk/roc_platform_base_symbols.c b/drivers/common/cnxk/roc_platform_base_symbols.c
index cf080b1bdc..ed34d4b05b 100644
--- a/drivers/common/cnxk/roc_platform_base_symbols.c
+++ b/drivers/common/cnxk/roc_platform_base_symbols.c
@@ -249,6 +249,9 @@ RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_outb_lf_base_get)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_inb_inj_lf_get)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_outb_sa_base_get)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_inb_sa_base_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_inb_prof_sa_base_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_custom_profile_setup)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_custom_profile_release)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_inb_rx_inject_enable)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_inb_spi_range)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_inb_sa_sz)
-- 
2.25.1

