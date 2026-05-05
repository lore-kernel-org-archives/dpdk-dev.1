Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E6AFF885A
	for <dpdk-dev@archiver.kernel.org>; Tue,  5 May 2026 08:50:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ACE904065B;
	Tue,  5 May 2026 10:50:50 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 727A340272
 for <dev@dpdk.org>; Tue,  5 May 2026 10:50:49 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6458dvHR813449 for <dev@dpdk.org>; Tue, 5 May 2026 01:50:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=w
 6BevfBeqyh071Ko25VwHxB+YG4DpmSksqOLdMlb5LY=; b=GibijtMawIpYZlC2e
 a+5ZJUtQRlY/d+MCWIpEABbOP7U15UuJBe8vTLtEkM8wJTbdbHmivGW7ck6pwH17
 TCRwNLly5s7reRRXOf66n5ytk9DKjh6WmA6iazFQn+W4rSIlltX6OdlUe5gCeS+P
 m2Py8TZ/4gTzqGZTMsD3N91Nl8a1ld5Flc8ucRjOjLDPTEMBn6P6d4amY8tvfr5J
 E81d38SB5yFvK8JiWoL/iDEtF/Kike13junuFPWhE4nk19DvLNjncNlyTBNgxzY/
 gWR/uurPSHd3Omrd4oNqTCqTyS3JeXnUWP4N4LI10gA6cUTIfFhHLEd9cmkjjMvG
 H1cZw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4dwgsj79jd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 05 May 2026 01:50:48 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 5 May 2026 01:50:47 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 5 May 2026 01:50:47 -0700
Received: from localhost.localdomain (unknown [10.28.36.154])
 by maili.marvell.com (Postfix) with ESMTP id 019D73F704B;
 Tue,  5 May 2026 01:50:43 -0700 (PDT)
From: rkudurumalla <rkudurumalla@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <dev@dpdk.org>, <jerinj@marvell.com>, Rakesh Kudurumalla
 <rkudurumalla@marvell.com>
Subject: [PATCH 2/2] net/cnxk: add PMD API to support custom profile setup
Date: Tue, 5 May 2026 14:20:37 +0530
Message-ID: <20260505085037.3961519-2-rkudurumalla@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260505085037.3961519-1-rkudurumalla@marvell.com>
References: <20260505085037.3961519-1-rkudurumalla@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDA4MiBTYWx0ZWRfXz1vW7tfaRfAX
 wH6IqUqh6vMm15wIonrkQw+8xdx3K2OQIlaT1QSkfgO0SJJjtU+8QZOu/0syfSXdbTqKlNqjb7I
 AfVlLSGyY9qa/fbw8tMJQzxTW+UzrJN7b2EaOV3m1sIYaDecOP4ckpIwYxCjZKgqx0CU3y5ZpB+
 iinjFZz3aZorL5LKeZuWm+GJapuholpmYUSZH3QmrtznosTakXRZ+3uMX4TSknXskPNARMYhdh2
 4FqkzIJ10d2P/cl63Ir++0KlzAFr23OXiCKl0MpLQtyaTz3Deh8uCEFchjwjUd6hoYGkhasAQJd
 Kv+HNmUKxgJIjb1SWs9JABPZrSVnuKtvrevvm8OhOwS8jmRXRXcrIAy+hzEsxYDS4A+I0N2jaCo
 XTKrqQzYP71o+FJVGfAejK+zHipJkiwnUrwTwUbWyTUN7vGaXnrWSJcErAqjKUQJ3b2qqtstvCM
 GmOA8iW+WzmFKAlKBng==
X-Proofpoint-ORIG-GUID: JVzr3GXEp400qzEq8X2XBbjSFwM-023G
X-Proofpoint-GUID: JVzr3GXEp400qzEq8X2XBbjSFwM-023G
X-Authority-Analysis: v=2.4 cv=G+As1dk5 c=1 sm=1 tr=0 ts=69f9af68 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=VdMmYqvrre1EFKHHD4QA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
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

Added new PMD APIS to create custom profile and API to update
SA table created during profile setup based on profile ID

Signed-off-by: Rakesh Kudurumalla <rkudurumalla@marvell.com>
---
 drivers/net/cnxk/cnxk_ethdev.h     |   4 +
 drivers/net/cnxk/cnxk_ethdev_sec.c | 175 +++++++++++++++++++++++
 drivers/net/cnxk/rte_pmd_cnxk.h    | 216 +++++++++++++++++++++++++++++
 3 files changed, 395 insertions(+)

diff --git a/drivers/net/cnxk/cnxk_ethdev.h b/drivers/net/cnxk/cnxk_ethdev.h
index 8691acc642..ea6a2be30e 100644
--- a/drivers/net/cnxk/cnxk_ethdev.h
+++ b/drivers/net/cnxk/cnxk_ethdev.h
@@ -26,6 +26,10 @@
 
 #define CNXK_ETH_DEV_PMD_VERSION "1.0"
 
+/* Macros for packing configuration fields */
+#define CNXK_FIELD_MASK(width)	((1ULL << (width)) - 1)
+#define PACK(val, shift, width) (((uint64_t)((val) & CNXK_FIELD_MASK(width))) << (shift))
+
 /* Used for struct cnxk_eth_dev::flags */
 #define CNXK_LINK_CFG_IN_PROGRESS_F BIT_ULL(0)
 
diff --git a/drivers/net/cnxk/cnxk_ethdev_sec.c b/drivers/net/cnxk/cnxk_ethdev_sec.c
index abb50d32de..fa7eacfbe4 100644
--- a/drivers/net/cnxk/cnxk_ethdev_sec.c
+++ b/drivers/net/cnxk/cnxk_ethdev_sec.c
@@ -348,6 +348,181 @@ rte_pmd_cnxk_hw_session_base_get(uint16_t portid, bool inb)
 	return (union rte_pmd_cnxk_ipsec_hw_sa *)sa_base;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_cnxk_inl_inb_prof_sa_base_get, 25.11)
+union rte_pmd_cnxk_ipsec_hw_sa *
+rte_pmd_cnxk_inl_inb_prof_sa_base_get(uint16_t portid, uint16_t profile_id)
+{
+	struct rte_eth_dev *eth_dev;
+	struct cnxk_eth_dev *dev;
+	uintptr_t sa_base;
+
+	if (!rte_eth_dev_is_valid_port(portid))
+		return NULL;
+
+	eth_dev = &rte_eth_devices[portid];
+	dev = cnxk_eth_pmd_priv(eth_dev);
+
+	sa_base = roc_nix_inl_inb_prof_sa_base_get(&dev->nix, !dev->inb.no_inl_dev, profile_id);
+
+	if (!sa_base)
+		return NULL;
+
+	return (union rte_pmd_cnxk_ipsec_hw_sa *)sa_base;
+}
+
+static uint64_t
+cnxk_rx_def_inl_cfg_pack(const struct rte_pmd_cnxk_rx_def_inl_cfg *cfg)
+{
+	uint64_t val = 0;
+
+	val |= PACK(cfg->ltype_mask, NIX_LTYPE_MASK_SHIFT, 4);
+	val |= PACK(cfg->ltype_match, NIX_LTYPE_MATCH_SHIFT, 4);
+	val |= PACK(cfg->lid, NIX_LID_SHIFT, 3);
+	val |= PACK(cfg->gen_offset_ng, NIX_GEN_OFFSET_NG_SHIFT, 1);
+	val |= PACK(cfg->gen_offset, NIX_GEN_OFFSET_SHIFT, 4);
+	val |= PACK(cfg->gen_nz, NIX_GEN_NZ_SHIFT, 1);
+	val |= PACK(cfg->cpt_l3_lid, NIX_CPT_L3_LID_SHIFT, 3);
+	val |= PACK(cfg->flags_mask, NIX_FLAGS_MASK_SHIFT, 4);
+	val |= PACK(cfg->flags_match, NIX_FLAGS_MATCH_SHIFT, 4);
+	val |= PACK(cfg->match_oipv4, NIX_MATCH_OIPV4_SHIFT, 1);
+	val |= PACK(cfg->match_oipv6, NIX_MATCH_OIPV6_SHIFT, 1);
+	val |= PACK(cfg->oiplen_ena, NIX_OIPLEN_ENA_SHIFT, 1);
+	val |= PACK(cfg->inline_shift, NIX_INLINE_SHIFT_SHIFT, 2);
+
+	return val;
+}
+
+static uint64_t
+cnxk_rx_gen_inl_cfg_pack(const struct rte_pmd_cnxk_rx_gen_inl_cfg *cfg)
+{
+	uint64_t val = 0;
+
+	/* CPT instruction fields */
+	val |= PACK(cfg->param2, NIX_PARAM2_SHIFT, 16);
+	val |= PACK(cfg->param1, NIX_PARAM1_SHIFT, 16);
+	val |= PACK(cfg->opcode, NIX_OPCODE_SHIFT, 16);
+	val |= PACK(cfg->egrp, NIX_EGRP_SHIFT, 3);
+	val |= PACK(cfg->ctx_val, NIX_CTX_VAL_SHIFT, 1);
+
+	return val;
+}
+
+static uint64_t
+cnxk_rx_extract_inl_cfg_pack(const struct rte_pmd_cnxk_rx_extract_inl_cfg *cfg)
+{
+	uint64_t val = 0;
+
+	val |= PACK(cfg->len_l, NIX_LEN_L_SHIFT, 6);
+	val |= PACK(cfg->bitpos_l, NIX_BITPOS_L_SHIFT, 6);
+	val |= PACK(cfg->len_m, NIX_LEN_M_SHIFT, 6);
+	val |= PACK(cfg->bitpos_m, NIX_BITPOS_M_SHIFT, 6);
+	val |= PACK(cfg->len_h, NIX_LEN_H_SHIFT, 6);
+	val |= PACK(cfg->bitpos_h, NIX_BITPOS_H_SHIFT, 6);
+
+	return val;
+}
+
+static uint64_t
+cnxk_rx_prot_field_inline_cfg_pack(const struct rte_pmd_cnxk_rx_prot_field_inl_cfg *cfg)
+{
+	uint64_t val = 0;
+
+	val |= PACK(cfg->valid, NIX_VALID_SHIFT, 1);
+	val |= PACK(cfg->offset, NIX_OFFSET_SHIFT, 6);
+	val |= PACK(cfg->sizem1, NIX_SIZEM1_SHIFT, 4);
+	val |= PACK(cfg->logmult, NIX_LOGMULT_SHIFT, 2);
+
+	return val;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_cnxk_nix_inl_custom_profile_setup, 25.11)
+int
+rte_pmd_cnxk_nix_inl_custom_profile_setup(uint16_t portid,
+					  const struct rte_pmd_cnxk_profile_cfg_params *cfg,
+					  uint16_t *profile_id)
+{
+	uint64_t prot_field_cfg_val[RTE_PMD_CNXK_MAX_PROT_FIELDS] = {0};
+	struct rte_eth_dev *eth_dev;
+	struct cnxk_eth_dev *dev;
+	uint64_t extract_cfg_val = 0;
+	uint64_t def_cfg_val = 0;
+	uint64_t gen_cfg_val = 0;
+	uint32_t sa_size = 0;
+	uint32_t max_sa = 0;
+	uint16_t prof_id = 0;
+	int rc = 0;
+	int i;
+
+	if (!roc_feature_nix_has_inl_profile())
+		return -ENOTSUP;
+
+	if (!rte_eth_dev_is_valid_port(portid))
+		return -EINVAL;
+
+	if (!cfg || !profile_id)
+		return -EINVAL;
+
+	eth_dev = &rte_eth_devices[portid];
+	dev = cnxk_eth_pmd_priv(eth_dev);
+
+	/* Pack default inline configuration */
+	def_cfg_val = cnxk_rx_def_inl_cfg_pack(&cfg->def_cfg);
+
+	/* Pack generic inline configuration */
+	gen_cfg_val = cnxk_rx_gen_inl_cfg_pack(&cfg->gen_cfg);
+
+	/* Pack extract inline configuration */
+	extract_cfg_val = cnxk_rx_extract_inl_cfg_pack(&cfg->extract_cfg);
+
+	/* Pack protocol field inline configurations */
+	for (i = 0; i < RTE_PMD_CNXK_MAX_PROT_FIELDS; i++)
+		prot_field_cfg_val[i] = cnxk_rx_prot_field_inline_cfg_pack(&cfg->prot_field_cfg[i]);
+
+	/* Get SA size and max SA count */
+	sa_size = cfg->sa_size;
+	max_sa = cfg->max_sa;
+
+	/* Call ROC API to configure the custom profile */
+	rc = roc_nix_inl_custom_profile_setup(&dev->nix, def_cfg_val, gen_cfg_val, extract_cfg_val,
+					      prot_field_cfg_val, sa_size, max_sa,
+					      !dev->inb.no_inl_dev, &prof_id);
+	if (rc) {
+		plt_err("Failed to setup custom profile: rc=%d", rc);
+		return rc;
+	}
+
+	*profile_id = prof_id;
+
+	plt_nix_dbg("Custom profile setup: port=%u, sa_size=%u, max_sa=%u, profile_id=%u", portid,
+		    sa_size, max_sa, *profile_id);
+
+	return 0;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_cnxk_nix_inl_custom_profile_release, 25.11)
+int
+rte_pmd_cnxk_nix_inl_custom_profile_release(uint16_t portid, uint16_t profile_id)
+{
+	struct rte_eth_dev *eth_dev;
+	struct cnxk_eth_dev *dev;
+	int rc;
+
+	if (!rte_eth_dev_is_valid_port(portid))
+		return -EINVAL;
+
+	eth_dev = &rte_eth_devices[portid];
+	dev = cnxk_eth_pmd_priv(eth_dev);
+
+	/* Call ROC API to release the custom profile */
+	rc = roc_nix_inl_custom_profile_release(&dev->nix, profile_id, !dev->inb.no_inl_dev);
+	if (rc) {
+		plt_err("Failed to release custom profile %u: rc=%d", profile_id, rc);
+		return rc;
+	}
+
+	return 0;
+}
+
 RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_cnxk_sa_flush, 23.11)
 int
 rte_pmd_cnxk_sa_flush(uint16_t portid, union rte_pmd_cnxk_ipsec_hw_sa *sess, bool inb)
diff --git a/drivers/net/cnxk/rte_pmd_cnxk.h b/drivers/net/cnxk/rte_pmd_cnxk.h
index d344137dd5..1960288cef 100644
--- a/drivers/net/cnxk/rte_pmd_cnxk.h
+++ b/drivers/net/cnxk/rte_pmd_cnxk.h
@@ -83,6 +83,15 @@ struct rte_pmd_cnxk_sec_action {
 	 */
 	enum rte_pmd_cnxk_sec_action_alg alg;
 	bool is_non_inp;
+	/** Inline profile ID (0-7) for custom profiles.
+	 * Only used when use_custom_profile is true.
+	 * Use profile_id returned by rte_pmd_cnxk_nix_inl_custom_profile_setup().
+	 */
+	uint16_t profile_id;
+	/** When true, use custom inline profile specified by profile_id.
+	 * When false, use default IPsec profile (backward compatible).
+	 */
+	bool use_custom_profile;
 };
 
 #define RTE_PMD_CNXK_CTX_MAX_CKEY_LEN	   32
@@ -607,6 +616,21 @@ union rte_pmd_cnxk_cpt_res_s *rte_pmd_cnxk_inl_ipsec_res(struct rte_mbuf *mbuf);
 __rte_experimental
 union rte_pmd_cnxk_ipsec_hw_sa *rte_pmd_cnxk_hw_session_base_get(uint16_t portid, bool inb);
 
+/**
+ * Get pointer to the Inline Inbound SA table base for a specific custom profile.
+ *
+ * @param portid
+ *   Port identifier of Ethernet device.
+ * @param profile_id
+ *   Custom profile ID to get the SA base for.
+ *
+ * @return
+ *   Pointer to Inbound SA base for the specified profile, or NULL on error.
+ */
+__rte_experimental
+union rte_pmd_cnxk_ipsec_hw_sa *rte_pmd_cnxk_inl_inb_prof_sa_base_get(uint16_t portid,
+								       uint16_t profile_id);
+
 /**
  * Executes a CPT flush on the specified session.
  *
@@ -682,6 +706,198 @@ int rte_pmd_cnxk_cpt_q_stats_get(uint16_t portid, enum rte_pmd_cnxk_cpt_q_stats_
 __rte_experimental
 void rte_pmd_cnxk_hw_inline_inb_cfg_set(uint16_t portid, struct rte_pmd_cnxk_ipsec_inb_cfg *cfg);
 
+/**
+ * RX Default Inline Configuration structure
+ * This structure represents the NIX_AF_RX_DEF_INLINE register fields
+ * used for configuring inline IPsec processing.
+ */
+struct rte_pmd_cnxk_rx_def_inl_cfg {
+	/** Layer type mask (bits 3:0) */
+	uint64_t ltype_mask;
+	/** Layer type match value (bits 7:4) */
+	uint64_t ltype_match;
+	/** Layer ID (bits 10:8) - Enumerated by NPC_LID_E */
+	uint64_t lid;
+	/** Generic offset negative (bit 11) */
+	uint64_t gen_offset_ng;
+	/** Generic offset in bytes (bits 15:12) */
+	uint64_t gen_offset;
+	/** Generic field non-zero (bit 16) */
+	uint64_t gen_nz;
+	/** CPT L3 Layer ID (bits 19:17) */
+	uint64_t cpt_l3_lid;
+	/** Layer type mask (bits 23:20) */
+	uint64_t flags_mask;
+	/** Layer type match value (bits 27:24) */
+	uint64_t flags_match;
+	/** Match on IPv4 (bit 28) */
+	uint64_t match_oipv4;
+	/** Match on IPv6 (bit 29) */
+	uint64_t match_oipv6;
+	/** OIP Length Enable (bit 30) */
+	uint64_t oiplen_ena;
+	/** Inline shift (bits 33:32) - Valid values: 0, 1, 2 */
+	uint64_t inline_shift;
+};
+
+/**
+ * RX Generic Inline Configuration structure
+ * This structure represents the NIX_AF_RX_INLINE_GEN_CFG(0..7) register fields.
+ */
+struct rte_pmd_cnxk_rx_gen_inl_cfg {
+	/** Layer type mask (bits 3:0) */
+	uint64_t ltype_mask;
+	/** Layer type match value (bits 7:4) */
+	uint64_t ltype_match;
+	/** Layer ID (bits 10:8) */
+	uint64_t lid;
+	/** Nibble Offset (bit 11) - 0: IPv4, 1: IPv6 */
+	uint64_t noffset;
+	/** Offset (bits 17:12) - Offset to DSCP field */
+	uint64_t offset;
+	/** PARAM2 (bits 15:0) - CPT_INST_S[PARAM2] */
+	uint64_t param2;
+	/** PARAM1 (bits 31:16) - CPT_INST_S[PARAM1] */
+	uint64_t param1;
+	/** OPCODE (bits 47:32) - CPT_INST_S[OPCODE] */
+	uint64_t opcode;
+	/** Engine Group (bits 50:48) - CPT_INST_S[EGRP] */
+	uint64_t egrp;
+	/** Context Valid (bit 51) - CPT_INST_S[CTX_VAL] */
+	uint64_t ctx_val;
+};
+
+/**
+ * RX Extract Inline Configuration structure
+ * This structure represents the NIX_AF_RX_EXTRACT_INLINE(0..7) register fields.
+ */
+struct rte_pmd_cnxk_rx_extract_inl_cfg {
+	/** LEN_L (bits 5:0) - Bit length from BITPOS_L (0-32) */
+	uint64_t len_l;
+	/** BITPOS_L (bits 13:8) - Bit pos to start extraction */
+	uint64_t bitpos_l;
+	/** LEN_M (bits 21:16) - Bit length from BITPOS_M (0-32) */
+	uint64_t len_m;
+	/** BITPOS_M (bits 29:24) - Bit pos to start extraction */
+	uint64_t bitpos_m;
+	/** LEN_H (bits 37:32) - Bit length from BITPOS_H (0-32) */
+	uint64_t len_h;
+	/** BITPOS_H (bits 45:40) - Bit pos to start extraction */
+	uint64_t bitpos_h;
+};
+
+/**
+ * Protocol field types for inline IPsec configuration
+ */
+enum rte_pmd_cnxk_nix_rx_prot_e {
+	RTE_PMD_CNXK_RX_PROT_OPCODE = 0,     /**< Opcode (max 2 bytes) */
+	RTE_PMD_CNXK_RX_PROT_PARAM1 = 1,     /**< Parameter 1 (max 2 bytes) */
+	RTE_PMD_CNXK_RX_PROT_PARAM2 = 2,     /**< Parameter 2 (max 2 bytes) */
+	RTE_PMD_CNXK_RX_PROT_SA_INDEX = 3,   /**< SA index (max 4 bytes) */
+	RTE_PMD_CNXK_RX_PROT_RPTR_H = 4,     /**< RPTR high bits (max 4 bytes) */
+	RTE_PMD_CNXK_RX_PROT_IP_OFFSET = 5,  /**< IP offset (max 1 byte) */
+	RTE_PMD_CNXK_RX_PROT_INL_OFFSET = 6, /**< Inline offset (max 4 bytes) */
+	RTE_PMD_CNXK_RX_PROT_ALG = 7,	     /**< ALG override (max 1 nibble) */
+	RTE_PMD_CNXK_RX_PROT_SUB_INDEX = 8,  /**< Sub index (max 1 nibble) */
+};
+
+/** Maximum number of inline profiles supported */
+#define RTE_PMD_CNXK_MAX_PROT_FIELDS 9
+
+/**
+ * RX Protocol Field Inline Configuration structure
+ * This structure represents the NIX_AF_RX_PROT_FIELD(0..8)_INLINE(0..7) registers.
+ */
+struct rte_pmd_cnxk_rx_prot_field_inl_cfg {
+	/** LOGMULT (bits 13:12) - Multiply: 0=1, 1=2, 2=4, 3=8 */
+	uint64_t logmult;
+	/** SIZEM1 (bits 11:8) - Size of field in nibbles */
+	uint64_t sizem1;
+	/** OFFSET (bits 7:2) - Offset from header start in nibbles */
+	uint64_t offset;
+	/** VALID (bit 0) - Valid flag */
+	uint64_t valid;
+};
+
+/**
+ * Combined profile configuration parameters structure
+ * This structure combines all configuration parameters needed for
+ * setting up a custom inline IPsec profile.
+ */
+struct rte_pmd_cnxk_profile_cfg_params {
+	/** Default inline configuration (NIX_AF_RX_DEF_INLINE) */
+	struct rte_pmd_cnxk_rx_def_inl_cfg def_cfg;
+
+	/** Generic inline configuration (NIX_AF_RX_INLINE_GEN_CFG) */
+	struct rte_pmd_cnxk_rx_gen_inl_cfg gen_cfg;
+
+	/** Extract inline configuration (NIX_AF_RX_EXTRACT_INLINE) */
+	struct rte_pmd_cnxk_rx_extract_inl_cfg extract_cfg;
+
+	/** Protocol field inline configuration
+	 * Array of configs for NIX_AF_RX_PROT_FIELD(prot_field)_INLINE(0..7)
+	 */
+	struct rte_pmd_cnxk_rx_prot_field_inl_cfg prot_field_cfg[RTE_PMD_CNXK_MAX_PROT_FIELDS];
+
+	/** SA size in bytes.
+	 * Size of each SA entry for this profile.
+	 * Must be a power of 2 and >= 128 bytes.
+	 * If 0, default SA size is used.
+	 */
+	uint32_t sa_size;
+
+	/** Maximum number of SAs for this profile.
+	 * Number of SA entries to allocate for this profile.
+	 * If 0, default max_sa is used.
+	 */
+	uint32_t max_sa;
+};
+
+/**
+ * Setup custom inline IPsec profile
+ *
+ * This function configures a custom inline IPsec profile for the specified port.
+ * The profile includes default inline configuration, generic inline configuration,
+ * extract inline configuration, protocol field inline configuration, and
+ * optional custom SA size and max SA count.
+ *
+ * @param portid
+ *   Port identifier of the Ethernet device.
+ * @param cfg
+ *   Pointer to the combined profile configuration structure.
+ * @param[out] profile_id
+ *   Pointer to store the returned profile ID (0-7).
+ *   This ID can be used in rte_pmd_cnxk_sec_action.profile_id.
+ *
+ * @return
+ *   0 on success, a negative errno value otherwise.
+ *   - -EINVAL: Invalid parameters
+ *   - -ENOTSUP: Function not supported on this device
+ *   - -ENOSPC: No free profile available
+ *   - -ENOMEM: Memory allocation failed for SA table
+ */
+__rte_experimental
+int rte_pmd_cnxk_nix_inl_custom_profile_setup(uint16_t portid,
+		const struct rte_pmd_cnxk_profile_cfg_params *cfg, uint16_t *profile_id);
+
+/**
+ * Release a custom inline profile.
+ *
+ * This function releases resources associated with a custom inline profile
+ * that was previously created using rte_pmd_cnxk_nix_inl_custom_profile_setup().
+ *
+ * @param portid
+ *   Port identifier of the Ethernet device.
+ * @param profile_id
+ *   Custom profile ID to release.
+ *
+ * @return
+ *   0 on success, a negative errno value otherwise.
+ */
+__rte_experimental
+int rte_pmd_cnxk_nix_inl_custom_profile_release(uint16_t portid,
+						uint16_t profile_id);
+
 /**
  * Retrieves model name on which it is running as a string.
  *
-- 
2.25.1

