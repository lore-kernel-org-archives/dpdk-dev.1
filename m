Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA29C982CD
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 07:15:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 86B18427DF;
	Thu, 17 Sep 2026 09:14:50 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 47BD4427DE
 for <dev@dpdk.org>; Thu, 17 Sep 2026 09:14:49 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68H61XXm4005235 for <dev@dpdk.org>; Thu, 17 Sep 2026 00:14:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=D
 7bCKArelmnrv5JDZMouJcFbn24ZuX5W8thGbuJcxyM=; b=CJwlsTsqRFpN0PLIw
 PFGYi9o+YcssquV1q+W6guhmRo4Wl9n/nGV1SjDnPtRI1xxK7MxOcSuhfR63daHt
 pmAeV3rslyi3c4A3zPkKrsbF6CwLv/BPrkwISqX1nZ5Ly250sk6G9qVtDbCwYNhH
 oIcqml9QtJyKSuyEI2i3crt2OIGdmNoe0qfM8LTyxNu7volHCScMwHXTk0sRDYwJ
 3w8B9jfxyRHuQASbRU4rHuf+det3wOP5uUVPNBttvC2J+2rT2jWUUMCCQBf/5aC9
 yswQ3+umKbVN4vCmdc1TVF8TzKx9KWbNVQyc95ethtkma/TZNEm7zJ6xYSjAfyW2
 x1TSg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4gr7tvs2qe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 17 Sep 2026 00:14:48 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 17 Sep 2026 00:14:47 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 17 Sep 2026 00:14:47 -0700
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id 1C6705C68E1;
 Thu, 17 Sep 2026 00:14:43 -0700 (PDT)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Rakesh Kudurumalla <rkudurumalla@marvell.com>
Subject: [PATCH 10/14] net/cnxk: add MSNS inb SA and CN20K CPT result struct
Date: Thu, 17 Sep 2026 12:40:12 +0530
Message-ID: <20260917071016.2366467-10-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260917071016.2366467-1-rbhansali@marvell.com>
References: <20260917071016.2366467-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDA5NiBTYWx0ZWRfX2cSR9S1sm0an
 S5Gi7SxuKlCamG707qLwrk5kFbj7ASKatHusLCrIaObrmqmxDUbpPwNdlX844mZ1/rBqsu82yVJ
 2w3AdFIQP+Fs9s4uamUMCBiybeQgR/JpztLVonEFVZ9OgKNFeByrmYmqlQRcHChnbMIGQn9ujR0
 eLYZBHnARpVrpTukgUbLWXIVFbDQffHDvXSkrdcFwHyXk8grPOrs8ueBoPnfTTO0d/MHX+IEzti
 ApsjR4divbdzYFHBHrgPVMCQ4Yy1vcknIWrOUkWutxfi3aUTG228cduE5vzX0gBMuX0WHivL6GK
 Aubdo+fk6Hp3Cy0VZ6Qu1gg0bI/cnp9+/6ZULEpqHXxLBFG0AvZ9J4PDOfRcn3C10hHaijGPzBe
 PjXw20u5CIiQWbT8pn0l7BmpVZPtiS5TEmkLcD/JtAxyGCHMxgHDehBk4XMd/wwumY23SpWXQ4R
 46GnjW4HPS+D7pZ2C5w==
X-Authority-Analysis: v=2.4 cv=M5fYuCws c=1 sm=1 tr=0 ts=6aab9368 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=zrjj2Im-atA_QXTUIpIA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: aZq0e_I6gBWCtZ-L7AOfk9Gsf4HNAL6Z
X-Proofpoint-GUID: aZq0e_I6gBWCtZ-L7AOfk9Gsf4HNAL6Z
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDA5NiBTYWx0ZWRfX/CSTXSVPvTPa
 CclHhAnxxn0Rn+kCX5jg3dcsDyDXwncbtRkW8w/7WSQ/4JrM2jzcz2IV8To/66018z51tvc9bcL
 RWaVu0cc8WNE1yyBzPSGWGZVj0oq6gA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_01,2026-09-16_02,2025-10-01_01
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

Define the 1KB inbound MSNS SA layout with four packed anti-replay
sub-spaces, the MSNS context update region, and compile-time size
checks. Extend the HW SA union and add the CN20K CPT result format
for inline IPsec custom profile support.

Signed-off-by: Rakesh Kudurumalla <rkudurumalla@marvell.com>
---
 drivers/net/cnxk/cnxk_ethdev_sec.c |   9 +-
 drivers/net/cnxk/rte_pmd_cnxk.h    | 232 +++++++++++++++++++++++++++--
 2 files changed, 230 insertions(+), 11 deletions(-)

diff --git a/drivers/net/cnxk/cnxk_ethdev_sec.c b/drivers/net/cnxk/cnxk_ethdev_sec.c
index 61eb55ba43..d208569168 100644
--- a/drivers/net/cnxk/cnxk_ethdev_sec.c
+++ b/drivers/net/cnxk/cnxk_ethdev_sec.c
@@ -362,7 +362,14 @@ rte_pmd_cnxk_inl_inb_prof_sa_base_get(uint16_t portid, uint16_t profile_id)
 	eth_dev = &rte_eth_devices[portid];
 	dev = cnxk_eth_pmd_priv(eth_dev);
 
-	sa_base = roc_nix_inl_inb_prof_sa_base_get(&dev->nix, !dev->inb.no_inl_dev, profile_id);
+	/* Return IPsec sa base if profile_id is UINT16_MAX, else return the sa base
+	 * for the given profile_id.
+	 */
+	if (profile_id == UINT16_MAX)
+		sa_base = roc_nix_inl_inb_sa_base_get(&dev->nix, dev->inb.inl_dev);
+	else
+		sa_base = roc_nix_inl_inb_prof_sa_base_get(&dev->nix, !dev->inb.no_inl_dev,
+							   profile_id);
 
 	if (!sa_base)
 		return NULL;
diff --git a/drivers/net/cnxk/rte_pmd_cnxk.h b/drivers/net/cnxk/rte_pmd_cnxk.h
index 1960288cef..3ffd608f16 100644
--- a/drivers/net/cnxk/rte_pmd_cnxk.h
+++ b/drivers/net/cnxk/rte_pmd_cnxk.h
@@ -337,6 +337,209 @@ struct rte_pmd_cnxk_ipsec_inb_sa {
 	struct rte_pmd_cnxk_ipsec_inb_ctx_update_reg ctx;
 };
 
+/** Number of MSNS spaces per inbound SA CTX entry */
+#define RTE_PMD_CNXK_IPSEC_INB_MSNS_SPACES 4
+
+/** Anti-replay window size per MSNS space (bits) */
+#define RTE_PMD_CNXK_IPSEC_INB_MSNS_AR_WIN_BITS 1024
+
+/** Anti-replay window size per MSNS space (bytes) */
+#define RTE_PMD_CNXK_IPSEC_INB_MSNS_AR_WIN_BYTES (RTE_PMD_CNXK_IPSEC_INB_MSNS_AR_WIN_BITS / 8)
+
+/** u64 array size to fit MSNS anti-replay window bits per space */
+#define RTE_PMD_CNXK_IPSEC_INB_MSNS_AR_WIN_U64                                                     \
+	(RTE_PMD_CNXK_IPSEC_INB_MSNS_AR_WIN_BYTES / sizeof(uint64_t))
+
+/** Per MSNS space anti-replay base/valid pair (packed contiguously) */
+struct rte_pmd_cnxk_ipsec_msns_ar {
+	/** IPSEC Anti-Replay base */
+	uint64_t ar_base;
+	/** IPSEC Anti-Replay valid */
+	uint64_t ar_valid;
+};
+
+/**
+ * Inbound IPsec MSNS packed context update region (4 spaces).
+ *
+ * Layout: ar_base[0], ar_valid[0], ar_base[1], ar_valid[1], ...
+ */
+struct __rte_aligned(32) rte_pmd_cnxk_ipsec_inb_ctx_msns_reg {
+	/** IPSEC Anti-Replay base/valid per MSNS space */
+	struct rte_pmd_cnxk_ipsec_msns_ar ar[RTE_PMD_CNXK_IPSEC_INB_MSNS_SPACES];
+	/** Hard lifetime */
+	uint64_t hard_life;
+	/** Soft lifetime */
+	uint64_t soft_life;
+	/** MIB byte statistics */
+	uint64_t mib_octs;
+	/** MIB packet statistics */
+	uint64_t mib_pkts;
+	/** IPSEC Anti-Replay window per MSNS space (128B each) */
+	uint64_t ar_winbits[RTE_PMD_CNXK_IPSEC_INB_MSNS_SPACES]
+			   [RTE_PMD_CNXK_IPSEC_INB_MSNS_AR_WIN_U64];
+};
+
+/** Inbound IPsec MSNS SA slot size (1KB) */
+#define RTE_PMD_CNXK_IPSEC_INB_SA_MSNS_SZ 1024
+
+/** Byte offset of MSNS HW ctx region (32-byte aligned, Word32) */
+#define RTE_PMD_CNXK_IPSEC_INB_MSNS_CTX_OFF                                                        \
+	RTE_ALIGN_CEIL(offsetof(struct rte_pmd_cnxk_ipsec_inb_sa, ctx), 32)
+
+/** Pad bytes before MSNS HW ctx to reach RTE_PMD_CNXK_IPSEC_INB_MSNS_CTX_OFF */
+#define RTE_PMD_CNXK_IPSEC_INB_MSNS_CTX_ALIGN_PAD                                                  \
+	(RTE_PMD_CNXK_IPSEC_INB_MSNS_CTX_OFF - offsetof(struct rte_pmd_cnxk_ipsec_inb_sa, ctx))
+
+/** MSNS inbound ctx_push_size: push ends at HW ctx (not hw_ctx_off + 1) */
+#define RTE_PMD_CNXK_IPSEC_INB_MSNS_CTX_PUSH_SZ(hw_ctx_off_words) (hw_ctx_off_words)
+
+/**
+ * Inbound IPsec SA for MSNS with 4 spaces packed in one CTX cache entry.
+ *
+ * Word0 - Word30 match struct rte_pmd_cnxk_ipsec_inb_sa.
+ * Word32+ is the 32-byte aligned MSNS HW context update region.
+ */
+struct rte_pmd_cnxk_ipsec_inb_msns_sa {
+	/** Word0 */
+	union {
+		struct {
+			uint64_t ar_win : 3;
+			uint64_t hard_life_dec : 1;
+			uint64_t soft_life_dec : 1;
+			uint64_t count_glb_octets : 1;
+			uint64_t count_glb_pkts : 1;
+			uint64_t count_mib_bytes : 1;
+			uint64_t count_mib_pkts : 1;
+			uint64_t hw_ctx_off : 7;
+			uint64_t ctx_id : 16;
+			uint64_t orig_pkt_fabs : 1;
+			uint64_t orig_pkt_free : 1;
+			uint64_t pkind : 6;
+			uint64_t rsvd0 : 1;
+			uint64_t et_ovrwr : 1;
+			uint64_t pkt_output : 2;
+			uint64_t pkt_format : 1;
+			uint64_t defrag_opt : 2;
+			uint64_t x2p_dst : 1;
+			uint64_t ctx_push_size : 7;
+			uint64_t rsvd1 : 1;
+			uint64_t ctx_hdr_size : 2;
+			uint64_t aop_valid : 1;
+			uint64_t rsvd2 : 1;
+			uint64_t ctx_size : 4;
+		} s;
+		uint64_t u64;
+	} w0;
+
+	/** Word1 */
+	union {
+		struct {
+			uint64_t orig_pkt_aura : 20;
+			uint64_t rsvd3 : 4;
+			uint64_t orig_pkt_foff : 8;
+			uint64_t cookie : 32;
+		} s;
+		uint64_t u64;
+	} w1;
+
+	/** Word2 */
+	union {
+		struct {
+			uint64_t valid : 1;
+			uint64_t dir : 1;
+			uint64_t rsvd11 : 1;
+			uint64_t rsvd4 : 1;
+			uint64_t ipsec_mode : 1;
+			uint64_t ipsec_protocol : 1;
+			uint64_t aes_key_len : 2;
+			uint64_t enc_type : 3;
+			uint64_t life_unit : 1;
+			uint64_t auth_type : 4;
+			uint64_t encap_type : 2;
+			uint64_t et_ovrwr_ddr_en : 1;
+			uint64_t esn_en : 1;
+			uint64_t tport_l4_incr_csum : 1;
+			uint64_t ip_hdr_verify : 2;
+			uint64_t udp_ports_verify : 1;
+			uint64_t l3hdr_on_err : 1;
+			uint64_t rsvd6 : 6;
+			uint64_t rsvd12 : 1;
+			uint64_t spi : 32;
+		} s;
+		uint64_t u64;
+	} w2;
+
+	/** Word3 */
+	uint64_t rsvd7;
+
+	/** Word4 - Word7 */
+	uint8_t cipher_key[RTE_PMD_CNXK_CTX_MAX_CKEY_LEN];
+
+	/** Word8 - Word9 */
+	union {
+		struct {
+			uint32_t rsvd8;
+			uint8_t salt[4];
+		} s;
+		uint64_t u64;
+	} w8;
+	uint64_t rsvd9;
+
+	/** Word10 */
+	union {
+		struct {
+			uint64_t rsvd10 : 32;
+			uint64_t udp_src_port : 16;
+			uint64_t udp_dst_port : 16;
+		} s;
+		uint64_t u64;
+	} w10;
+
+	/** Word11 - Word14 */
+	union rte_pmd_cnxk_ipsec_outer_ip_hdr outer_hdr;
+
+	/** Word15 - Word30 */
+	uint8_t hmac_opad_ipad[RTE_PMD_CNXK_CTX_MAX_OPAD_IPAD_LEN];
+
+	/** Pad Word31 so MSNS HW ctx region is 32-byte aligned */
+	uint8_t ctx_align_pad[RTE_PMD_CNXK_IPSEC_INB_MSNS_CTX_ALIGN_PAD];
+
+	/** Word32+ MSNS HW context update region (32-byte aligned) */
+	struct rte_pmd_cnxk_ipsec_inb_ctx_msns_reg ctx;
+
+	/** Reserved to pad SA to 1KB */
+	uint8_t rsvd[RTE_PMD_CNXK_IPSEC_INB_SA_MSNS_SZ - RTE_PMD_CNXK_IPSEC_INB_MSNS_CTX_OFF -
+		     sizeof(struct rte_pmd_cnxk_ipsec_inb_ctx_msns_reg)];
+};
+
+static_assert(sizeof(struct rte_pmd_cnxk_ipsec_inb_msns_sa) == RTE_PMD_CNXK_IPSEC_INB_SA_MSNS_SZ,
+	      "rte_pmd_cnxk_ipsec_inb_msns_sa must be 1KB");
+static_assert(RTE_PMD_CNXK_IPSEC_INB_MSNS_CTX_ALIGN_PAD == 8, "msns_sa ctx align pad must be 8B");
+static_assert((offsetof(struct rte_pmd_cnxk_ipsec_inb_msns_sa, ctx) % 32) == 0,
+	      "msns_sa ctx must be 32-byte aligned");
+static_assert(offsetof(struct rte_pmd_cnxk_ipsec_inb_msns_sa, ctx) ==
+		      RTE_PMD_CNXK_IPSEC_INB_MSNS_CTX_OFF,
+	      "msns_sa ctx must start at Word32");
+static_assert((offsetof(struct rte_pmd_cnxk_ipsec_inb_msns_sa, ctx) / 8) <= 32,
+	      "msns_sa hw_ctx_off must be <= 32 without CTX caching");
+static_assert((offsetof(struct rte_pmd_cnxk_ipsec_inb_msns_sa, ctx.ar_winbits) % 32) == 0,
+	      "msns_sa ar_winbits must be 32-byte aligned");
+static_assert(offsetof(struct rte_pmd_cnxk_ipsec_inb_msns_sa, w1) ==
+		      offsetof(struct rte_pmd_cnxk_ipsec_inb_sa, w1),
+	      "msns_sa w1 offset must match inb_sa");
+static_assert(offsetof(struct rte_pmd_cnxk_ipsec_inb_msns_sa, w2) ==
+		      offsetof(struct rte_pmd_cnxk_ipsec_inb_sa, w2),
+	      "msns_sa w2 offset must match inb_sa");
+
+/** @deprecated use struct rte_pmd_cnxk_ipsec_inb_msns_sa */
+typedef struct rte_pmd_cnxk_ipsec_inb_msns_sa rte_pmd_cnxk_ipsec_inb_sa_msns;
+
+/** 1KB-aligned inbound MSNS SA slot size */
+#define RTE_PMD_CNXK_IPSEC_INB_SA_MSNS_SZ_ALIGN RTE_PMD_CNXK_IPSEC_INB_SA_MSNS_SZ
+
+/** HW write size for inbound MSNS SA (push + MSNS ctx, excludes sw priv tail) */
+#define RTE_PMD_CNXK_IPSEC_INB_SA_MSNS_WR_SZ offsetof(struct rte_pmd_cnxk_ipsec_inb_msns_sa, rsvd)
+
 /**
  * Outbound IPsec SA
  */
@@ -485,6 +688,8 @@ union rte_pmd_cnxk_ipsec_hw_sa {
 	struct rte_pmd_cnxk_ipsec_inb_sa inb;
 	/** Outbound SA */
 	struct rte_pmd_cnxk_ipsec_outb_sa outb;
+	/** Inbound MSNS SA (1KB, 4 packed AR spaces) */
+	struct rte_pmd_cnxk_ipsec_inb_msns_sa inb_msns;
 };
 
 /** CPT HW result format */
@@ -506,6 +711,23 @@ union rte_pmd_cnxk_cpt_res_s {
 		uint64_t esn;
 	} cn10k;
 
+	/** CN20K CPT result */
+	struct rte_pmd_cpt_cn20k_res_s {
+		/** Completion code */
+		uint64_t compcode : 7;
+		/** Done interrupt */
+		uint64_t doneint : 1;
+		/** Microcode completion code */
+		uint64_t uc_compcode : 8;
+		/** Result length */
+		uint64_t rlen : 16;
+		/** SPI */
+		uint64_t spi : 32;
+
+		/** Extended sequence number */
+		uint64_t esn;
+	} cn20k;
+
 	/** CN9K CPT result */
 	struct rte_pmd_cpt_cn9k_res_s {
 		/** Completion code */
@@ -745,16 +967,6 @@ struct rte_pmd_cnxk_rx_def_inl_cfg {
  * This structure represents the NIX_AF_RX_INLINE_GEN_CFG(0..7) register fields.
  */
 struct rte_pmd_cnxk_rx_gen_inl_cfg {
-	/** Layer type mask (bits 3:0) */
-	uint64_t ltype_mask;
-	/** Layer type match value (bits 7:4) */
-	uint64_t ltype_match;
-	/** Layer ID (bits 10:8) */
-	uint64_t lid;
-	/** Nibble Offset (bit 11) - 0: IPv4, 1: IPv6 */
-	uint64_t noffset;
-	/** Offset (bits 17:12) - Offset to DSCP field */
-	uint64_t offset;
 	/** PARAM2 (bits 15:0) - CPT_INST_S[PARAM2] */
 	uint64_t param2;
 	/** PARAM1 (bits 31:16) - CPT_INST_S[PARAM1] */
-- 
2.34.1

