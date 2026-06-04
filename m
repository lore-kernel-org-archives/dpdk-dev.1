Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26789CD6E4A
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Jun 2026 03:17:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 240F440430;
	Thu,  4 Jun 2026 05:17:08 +0200 (CEST)
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com
 [209.85.214.226])
 by mails.dpdk.org (Postfix) with ESMTP id E2077402E1
 for <dev@dpdk.org>; Thu,  4 Jun 2026 05:17:06 +0200 (CEST)
Received: by mail-pl1-f226.google.com with SMTP id
 d9443c01a7336-2c0b9328c4aso1693075ad.0
 for <dev@dpdk.org>; Wed, 03 Jun 2026 20:17:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780543026; x=1781147826;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+xU1NbvTIZ7ISQhG/jmYGb94izECIGl5VJJaI+SQZ08=;
 b=LDEos1zRYrGZs+QxJ3EGzNTRVLGiXrkySyF+nvsbZkvBIGyfImWTGVPFa/aoue8e1H
 YdfVS6Vr1sH2SiblWhAprJ24nDko0A2hHLGfwZHWoO9FKl87YG1gUvNbQ+eWJU7WLL7c
 Ra0PHsq2Aku2qMsfYNnE2BImNptBrtHyhxHTyPlUfUW5fVWEoGthdCAVw7mqdEsLkp8O
 eetap6yQgtA54WeUWTaxFKhCC8qv8D1vuDVniZ9CTrBPDBwOw7LT12F75gR+vMmdvw4H
 KnwttKzNjPMRxRsmuzHDw98uyoKr5nbFlOi1tXYabXeHB2W9q8nelWPXRcwe25M0ZBUn
 /qaQ==
X-Gm-Message-State: AOJu0YzdtKKaKhK4EvpWgL4w37oEdTx8yrkp89+stBTbYp5JGaBC4gnJ
 vxXQUlhInBJ1cTl+nAsxJmYDBDqfNnGLK2kenx6aTFkiUGstvyRJnmie7DaBa5axp9RQsuFD9lO
 32W8TQdY7iYwHwnIbnqRvm3TulKhuTgyb5K1rBnGNVp1J/t1zIdwkmtsy3TzO8vP7ldpYARDc6w
 HDcTwpWTnSagwhOTQ3xu4Y/pZkb9ox8FHkkO0jJyKxc8RT19yqTS4X7MVq5qTJc+V76gv4hsIjH
 HLpMSvcQxpl
X-Gm-Gg: Acq92OHNwM+plBKuia3qr3QRM961/Xk81xmuifYv4avE/Msof2bSkMkEfxFUC1aOzLM
 MVmkWDqILc24Fvad/AlczYn5hds6YQwQ9ImFOvSpCBeOCOR6Ez5ggiJ284Yhq6SwHpA+o6spLYy
 YHiaecGZa6ek3Tp9PerI66KONRFoNByVvPuKTk2wBntGOZ7xgz5JOy5gnyeSOkDvkngzOUhw6pq
 bGJzgcqbxq186m4sUpFxT2i4O6/sZYkCsvSGcKI0beyuW2HNacWesseTAMf2QOcYO9ZBe4TQDsD
 87M5T0CenqWSTbuBiMR9/w9iKMiHed9+s5AdiI6+Y1PHJMDbnTCDXxISw0tEYJSwHxR2R6T23x6
 77b/acBTHLppwdRjWKWrO4B8gVVmE0A/PPWr7bb3QHZu7qqdsiY/oed7UFYXUhg+37StWtdwoda
 xZBznS/p5FY7La2XtexpSDae0FrQCQ0w==
X-Received: by 2002:a17:903:1a4e:b0:2ba:25ca:b49f with SMTP id
 d9443c01a7336-2c163c60285mr63917325ad.17.1780543025932; 
 Wed, 03 Jun 2026 20:17:05 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 ([144.49.247.127]) by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-2c166394c3fsm4183965ad.44.2026.06.03.20.17.05
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 03 Jun 2026 20:17:05 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-91572601753so54674585a.1
 for <dev@dpdk.org>; Wed, 03 Jun 2026 20:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1780543025; x=1781147825; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+xU1NbvTIZ7ISQhG/jmYGb94izECIGl5VJJaI+SQZ08=;
 b=H4ffc9hbL68ZKEqS1FeyXAHPjZuSCKKnUMkrCnMjss1fz7REyMQyLRJj5UL0afkHpa
 O9rwNvEUxA7bliND+2Ynq/PJbnxsiRxVeP4TGgAEkvDlJwPJk0kudUG5vK5r2zVFAgq4
 CpPOKrtX+8oGzIN8ed6VuOCql/NoR7TjTxJOA=
X-Received: by 2002:a05:620a:280e:b0:915:6a2b:626c with SMTP id
 af79cd13be357-9158a825084mr1004963785a.51.1780543024342; 
 Wed, 03 Jun 2026 20:17:04 -0700 (PDT)
X-Received: by 2002:a05:620a:280e:b0:915:6a2b:626c with SMTP id
 af79cd13be357-9158a825084mr1004958485a.51.1780543023560; 
 Wed, 03 Jun 2026 20:17:03 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9158a009fe7sm446421685a.8.2026.06.03.20.17.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 20:17:03 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, stable@dpdk.org,
 Keegan Freyhof <keegan.freyhof@broadcom.com>,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH 01/10] net/bnxt: vector mode implementation for V3 packets
Date: Wed,  3 Jun 2026 21:18:42 -0600
Message-ID: <20260604031851.2267548-2-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260604031851.2267548-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260604031851.2267548-1-Mohammad-Shuab.Siddique@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

From: Keegan Freyhof <keegan.freyhof@broadcom.com>

Added support for AVX2 vector mode reporting of the
VLAN TCI for Thor 2.

Signed-off-by: Keegan Freyhof <keegan.freyhof@broadcom.com>
Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
 drivers/net/bnxt/bnxt_ethdev.c          |   7 +-
 drivers/net/bnxt/bnxt_rxr.h             |   2 +
 drivers/net/bnxt/bnxt_rxtx_vec_avx2.c   | 402 ++++++++++++++++++++++++
 drivers/net/bnxt/bnxt_rxtx_vec_common.h |  36 +++
 4 files changed, 446 insertions(+), 1 deletion(-)

diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/bnxt/bnxt_ethdev.c
index c45afdb20a..5bd51de3cd 100644
--- a/drivers/net/bnxt/bnxt_ethdev.c
+++ b/drivers/net/bnxt/bnxt_ethdev.c
@@ -1493,7 +1493,12 @@ bnxt_receive_function(struct rte_eth_dev *eth_dev)
 		bp->flags |= BNXT_FLAG_RX_VECTOR_PKT_MODE;
 		if (bnxt_compressed_rx_cqe_mode_enabled(bp))
 			return bnxt_crx_pkts_vec_avx2;
-		return bnxt_recv_pkts_vec_avx2;
+		if (BNXT_TRUFLOW_EN(bp) && bnxt_ulp_explicit_mark_enabled(bp))
+			goto use_scalar_rx;
+		if (BNXT_CHIP_P7(bp))
+			return bnxt_recv_pkts_vec_avx2_v3;
+		else
+			return bnxt_recv_pkts_vec_avx2;
 	}
 #endif
 	if (rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_128) {
diff --git a/drivers/net/bnxt/bnxt_rxr.h b/drivers/net/bnxt/bnxt_rxr.h
index 2a28fa2073..352d509210 100644
--- a/drivers/net/bnxt/bnxt_rxr.h
+++ b/drivers/net/bnxt/bnxt_rxr.h
@@ -165,6 +165,8 @@ int bnxt_rxq_vec_setup(struct bnxt_rx_queue *rxq);
 #if defined(RTE_ARCH_X86)
 uint16_t bnxt_recv_pkts_vec_avx2(void *rx_queue, struct rte_mbuf **rx_pkts,
 				 uint16_t nb_pkts);
+uint16_t bnxt_recv_pkts_vec_avx2_v3(void *rx_queue, struct rte_mbuf **rx_pkts,
+				    uint16_t nb_pkts);
 uint16_t bnxt_crx_pkts_vec_avx2(void *rx_queue, struct rte_mbuf **rx_pkts,
 				uint16_t nb_pkts);
 #endif
diff --git a/drivers/net/bnxt/bnxt_rxtx_vec_avx2.c b/drivers/net/bnxt/bnxt_rxtx_vec_avx2.c
index 35550534de..46b51b20e4 100644
--- a/drivers/net/bnxt/bnxt_rxtx_vec_avx2.c
+++ b/drivers/net/bnxt/bnxt_rxtx_vec_avx2.c
@@ -903,3 +903,405 @@ bnxt_xmit_pkts_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
 
 	return nb_sent;
 }
+
+
+/*
+ * V3 (Thor2) RX burst processing - AVX2 vectorized implementation
+ *
+ * V3 completions have a different layout for checksum and VLAN handling
+ * compared to the standard and compressed completion formats.
+ */
+static uint16_t
+recv_burst_vec_avx2_v3(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
+{
+	struct bnxt_rx_queue *rxq = rx_queue;
+	struct bnxt_vnic_info *vnic = rxq->vnic;
+	const __m256i mbuf_init =
+		_mm256_set_epi64x(0, 0, 0, rxq->mbuf_initializer);
+	struct bnxt_cp_ring_info *cpr = rxq->cp_ring;
+	struct bnxt_rx_ring_info *rxr = rxq->rx_ring;
+	uint16_t cp_ring_size = cpr->cp_ring_struct->ring_size;
+	uint16_t rx_ring_size = rxr->rx_ring_struct->ring_size;
+	struct cmpl_base *cp_desc_ring = cpr->cp_desc_ring;
+	uint64_t valid, desc_valid_mask = ~0ULL;
+	const __m256i info3_v_mask = _mm256_set1_epi32(CMPL_BASE_V);
+	uint32_t raw_cons = cpr->cp_raw_cons;
+	uint32_t cons, mbcons;
+	int nb_rx_pkts = 0;
+	int i;
+	const __m256i valid_target =
+		_mm256_set1_epi32(!!(raw_cons & cp_ring_size));
+
+	/*
+	 * Shuffle mask for V3 descriptors to rearrange fields into mbuf layout.
+	 */
+	const __m256i shuf_msk =
+		_mm256_set_epi8(15, 14, 13, 12,          /* rss */
+				0xFF, 0xFF,              /* vlan_tci (filled separately) */
+				3, 2,                    /* data_len */
+				0xFF, 0xFF, 3, 2,        /* pkt_len */
+				0xFF, 0xFF, 0xFF, 0xFF,  /* pkt_type (zeroes) */
+				15, 14, 13, 12,          /* rss */
+				0xFF, 0xFF,              /* vlan_tci (filled separately) */
+				3, 2,                    /* data_len */
+				0xFF, 0xFF, 3, 2,        /* pkt_len */
+				0xFF, 0xFF, 0xFF, 0xFF); /* pkt_type (zeroes) */
+
+	/* Shuffle mask for high completion to extract metadata0 and errors */
+	const __m256i dsc_shuf_msk =
+		_mm256_set_epi8(0xff, 0xff, 0xff, 0xff,  /* Zeroes */
+				11, 10,                  /* metadata0 (vlan_tci) */
+				9, 8,                    /* errors_v2 */
+				5, 4,                    /* metadata1 (payload_offset) */
+				1, 0,                    /* flags2 low */
+				0xff, 0xff, 0xff, 0xff,  /* Zeroes */
+				0xff, 0xff, 0xff, 0xff,  /* Zeroes */
+				11, 10,                  /* metadata0 (vlan_tci) */
+				9, 8,                    /* errors_v2 */
+				5, 4,                    /* metadata1 (payload_offset) */
+				1, 0,                    /* flags2 low */
+				0xff, 0xff, 0xff, 0xff); /* Zeroes */
+
+	const __m256i flags_type_mask =
+		_mm256_set1_epi32(RX_PKT_V3_CMPL_FLAGS_ITYPE_MASK);
+	const __m256i flags2_ip_type_mask =
+		_mm256_set1_epi32(RX_PKT_V3_CMPL_HI_FLAGS2_IP_TYPE);
+	const __m256i rss_mask =
+		_mm256_set1_epi32(RX_PKT_V3_CMPL_FLAGS_RSS_VALID);
+	const __m256i metadata1_valid_mask =
+		_mm256_set1_epi32(RX_PKT_V3_CMPL_METADATA1_VALID);
+	const __m256i vlan_tci_mask =
+		_mm256_set1_epi32(RX_PKT_V3_CMPL_HI_METADATA0_VID_MASK |
+				  RX_PKT_V3_CMPL_HI_METADATA0_DE |
+				  RX_PKT_V3_CMPL_HI_METADATA0_PRI_MASK);
+	const __m256i cs_err_mask =
+		_mm256_set1_epi32(RX_PKT_CMPL_ERRORS_T_L4_CS_ERROR |
+				  RX_PKT_CMPL_ERRORS_T_IP_CS_ERROR |
+				  RX_PKT_CMPL_ERRORS_L4_CS_ERROR |
+				  RX_PKT_CMPL_ERRORS_IP_CS_ERROR);
+	const __m256i cs_calc_mask =
+		_mm256_set1_epi32(RX_PKT_CMPL_CALC);
+
+	__m256i t0, t1, flags_type, flags2, errors, metadata1;
+	__m256i ptype_idx, ptypes, vlan_tci, vlan_flags;
+	__m256i mbuf01, mbuf23, mbuf45, mbuf67;
+	__m256i rearm0, rearm1, rearm2, rearm3, rearm4, rearm5, rearm6, rearm7;
+	__m256i ol_flags, ol_flags_hi;
+	__m256i rss_flags;
+
+	/* Validate ptype table indexing at build time. */
+	bnxt_check_ptype_constants();
+
+	if (unlikely(!rxq->rx_started))
+		return 0;
+
+	if (rxq->rxrearm_nb >= rxq->rx_free_thresh)
+		bnxt_rxq_rearm(rxq, rxr);
+
+	nb_pkts = RTE_ALIGN_FLOOR(nb_pkts, BNXT_RX_DESCS_PER_LOOP_VEC256);
+
+	cons = raw_cons & (cp_ring_size - 1);
+	mbcons = (raw_cons / 2) & (rx_ring_size - 1);
+
+	if (!bnxt_cpr_cmp_valid(&cp_desc_ring[cons], raw_cons, cp_ring_size))
+		return 0;
+
+	nb_pkts = RTE_MIN(nb_pkts, RTE_MIN(rx_ring_size - mbcons,
+					   (cp_ring_size - cons) / 2));
+	/*
+	 * If we are at the end of the ring, ensure that descriptors after the
+	 * last valid entry are not treated as valid.
+	 */
+	if (nb_pkts < BNXT_RX_DESCS_PER_LOOP_VEC256) {
+		desc_valid_mask >>=
+			CHAR_BIT * (BNXT_RX_DESCS_PER_LOOP_VEC256 - nb_pkts);
+	} else {
+		nb_pkts =
+			RTE_ALIGN_FLOOR(nb_pkts, BNXT_RX_DESCS_PER_LOOP_VEC256);
+	}
+
+	for (i = 0; i < nb_pkts; i += BNXT_RX_DESCS_PER_LOOP_VEC256,
+				  cons += BNXT_RX_DESCS_PER_LOOP_VEC256 * 2,
+				  mbcons += BNXT_RX_DESCS_PER_LOOP_VEC256) {
+		__m256i desc0, desc1, desc2, desc3, desc4, desc5, desc6, desc7;
+		__m256i rxcmp0_1, rxcmp2_3, rxcmp4_5, rxcmp6_7, info3_v;
+		__m256i errors_v2, meta0_err, cs_calc, cs_valid;
+		uint32_t num_valid;
+
+		t0 = _mm256_loadu_si256((void *)&rxr->rx_buf_ring[mbcons]);
+		_mm256_storeu_si256((void *)&rx_pkts[i], t0);
+#ifdef RTE_ARCH_X86_64
+		t0 = _mm256_loadu_si256((void *)&rxr->rx_buf_ring[mbcons + 4]);
+		_mm256_storeu_si256((void *)&rx_pkts[i + 4], t0);
+#endif
+
+		/*
+		 * Load eight receive completion descriptors into 256-bit
+		 * registers. Loads are issued in reverse order for consistent state.
+		 */
+		desc7 = _mm256_load_si256((void *)&cp_desc_ring[cons + 14]);
+		rte_compiler_barrier();
+		desc6 = _mm256_load_si256((void *)&cp_desc_ring[cons + 12]);
+		rte_compiler_barrier();
+		desc5 = _mm256_load_si256((void *)&cp_desc_ring[cons + 10]);
+		rte_compiler_barrier();
+		desc4 = _mm256_load_si256((void *)&cp_desc_ring[cons + 8]);
+		rte_compiler_barrier();
+		desc3 = _mm256_load_si256((void *)&cp_desc_ring[cons + 6]);
+		rte_compiler_barrier();
+		desc2 = _mm256_load_si256((void *)&cp_desc_ring[cons + 4]);
+		rte_compiler_barrier();
+		desc1 = _mm256_load_si256((void *)&cp_desc_ring[cons + 2]);
+		rte_compiler_barrier();
+		desc0 = _mm256_load_si256((void *)&cp_desc_ring[cons + 0]);
+
+		/*
+		 * Pack needed fields from each descriptor pair.
+		 * For V3: extract rxcmp (low) for flags_type, len, rss
+		 * and rxcmp1 (hi) for flags2, metadata0, metadata1, errors_v2
+		 */
+		t0 = _mm256_permute2f128_si256(desc6, desc7, 0x20);
+		t1 = _mm256_permute2f128_si256(desc6, desc7, 0x31);
+		t1 = _mm256_shuffle_epi8(t1, dsc_shuf_msk);
+		rxcmp6_7 = _mm256_blend_epi32(t0, t1, 0x66);
+
+		t0 = _mm256_permute2f128_si256(desc4, desc5, 0x20);
+		t1 = _mm256_permute2f128_si256(desc4, desc5, 0x31);
+		t1 = _mm256_shuffle_epi8(t1, dsc_shuf_msk);
+		rxcmp4_5 = _mm256_blend_epi32(t0, t1, 0x66);
+
+		t0 = _mm256_permute2f128_si256(desc2, desc3, 0x20);
+		t1 = _mm256_permute2f128_si256(desc2, desc3, 0x31);
+		t1 = _mm256_shuffle_epi8(t1, dsc_shuf_msk);
+		rxcmp2_3 = _mm256_blend_epi32(t0, t1, 0x66);
+
+		t0 = _mm256_permute2f128_si256(desc0, desc1, 0x20);
+		t1 = _mm256_permute2f128_si256(desc0, desc1, 0x31);
+		t1 = _mm256_shuffle_epi8(t1, dsc_shuf_msk);
+		rxcmp0_1 = _mm256_blend_epi32(t0, t1, 0x66);
+
+		/* Extract flags_type from low completion for eight packets */
+		t0 = _mm256_unpacklo_epi32(rxcmp0_1, rxcmp2_3);
+		t1 = _mm256_unpacklo_epi32(rxcmp4_5, rxcmp6_7);
+		flags_type = _mm256_unpacklo_epi64(t0, t1);
+
+		/* Compute ptype_idx from flags_type itype field */
+		ptype_idx = _mm256_and_si256(flags_type, flags_type_mask);
+		ptype_idx = _mm256_srli_epi32(ptype_idx,
+					      RX_PKT_V3_CMPL_FLAGS_ITYPE_SFT -
+					      BNXT_PTYPE_TBL_TYPE_SFT);
+
+		/* Extract flags2 from high completion */
+		t0 = _mm256_unpacklo_epi32(rxcmp0_1, rxcmp2_3);
+		t1 = _mm256_unpacklo_epi32(rxcmp4_5, rxcmp6_7);
+		flags2 = _mm256_unpackhi_epi64(t0, t1);
+
+		t0 = _mm256_srli_epi32(_mm256_and_si256(flags2, flags2_ip_type_mask),
+				       RX_PKT_V3_CMPL_FLAGS2_IP_TYPE_SFT -
+				       BNXT_PTYPE_TBL_IP_VER_SFT);
+		ptype_idx = _mm256_or_si256(ptype_idx, t0);
+
+		/*
+		 * Extract metadata1 (contains VLAN valid bit) from LOW completion.
+		 * metadata1_payload_offset is at word 2 of rxcmp (low 128 bits of desc).
+		 */
+		{
+			__m128i m01, m23, hi;
+			hi =
+		_mm_unpacklo_epi64(_mm_unpackhi_epi32(_mm256_castsi256_si128(desc4),
+						    _mm256_castsi256_si128(desc5)),
+				 _mm_unpackhi_epi32(_mm256_castsi256_si128(desc6),
+						    _mm256_castsi256_si128(desc7)));
+			m01 = _mm_unpackhi_epi32(_mm256_castsi256_si128(desc0),
+						 _mm256_castsi256_si128(desc1));
+			m23 = _mm_unpackhi_epi32(_mm256_castsi256_si128(desc2),
+						 _mm256_castsi256_si128(desc3));
+			metadata1 =
+			_mm256_inserti128_si256(_mm256_castsi128_si256(_mm_unpacklo_epi64(m01,
+								       m23)), hi, 1);
+		}
+		metadata1 = _mm256_srli_epi32(metadata1, 16);
+
+		t0 = _mm256_srli_epi32(_mm256_and_si256(metadata1, metadata1_valid_mask),
+				       RX_PKT_V3_CMPL_METADATA1_VALID_SFT -
+				       BNXT_PTYPE_TBL_VLAN_SFT);
+		ptype_idx = _mm256_or_si256(ptype_idx, t0);
+
+		/*
+		 * Load ptypes for eight packets using gather.
+		 */
+		ptypes = _mm256_i32gather_epi32((int *)bnxt_ptype_table,
+						ptype_idx, sizeof(uint32_t));
+
+		/* Extract RSS valid flags for eight packets */
+		rss_flags = _mm256_and_si256(flags_type, rss_mask);
+		rss_flags = _mm256_srli_epi32(rss_flags, 9);
+
+		/* Extract metadata0 (contains vlan_tci) and errors from high completion */
+		t0 = _mm256_unpackhi_epi32(rxcmp0_1, rxcmp2_3);
+		t1 = _mm256_unpackhi_epi32(rxcmp4_5, rxcmp6_7);
+		meta0_err = _mm256_unpacklo_epi64(t0, t1);
+
+		/* Extract vlan_tci from high 16 bits of meta0_err (metadata0) */
+		vlan_tci = _mm256_and_si256(_mm256_srli_epi32(meta0_err, 16), vlan_tci_mask);
+
+		vlan_flags = _mm256_and_si256(metadata1, metadata1_valid_mask);
+		vlan_flags = _mm256_min_epu32(vlan_flags, _mm256_set1_epi32(1));
+
+		if (vnic->vlan_strip) {
+			vlan_flags = _mm256_or_si256(vlan_flags,
+				_mm256_slli_epi32(vlan_flags, 6));
+		}
+
+		errors_v2 = meta0_err;
+
+		errors = _mm256_srli_epi32(_mm256_and_si256(meta0_err, cs_err_mask), 4);
+
+		cs_calc = _mm256_and_si256(flags2, cs_calc_mask);
+		cs_valid = _mm256_cmpeq_epi32(cs_calc, _mm256_setzero_si256());
+		errors = _mm256_andnot_si256(cs_valid, errors);
+		ol_flags = _mm256_i32gather_epi32((const int *)errors_to_olflags_v3,
+						  errors, sizeof(uint32_t));
+		__m256i unknown_flags = _mm256_and_si256(cs_valid,
+				_mm256_set1_epi32(RTE_MBUF_F_RX_IP_CKSUM_UNKNOWN));
+		ol_flags = _mm256_or_si256(ol_flags, unknown_flags);
+
+		const __m256i perm_msk =
+				_mm256_set_epi32(7, 3, 6, 2, 5, 1, 4, 0);
+		info3_v = _mm256_permutevar8x32_epi32(errors_v2, perm_msk);
+		info3_v = _mm256_and_si256(errors_v2, info3_v_mask);
+		info3_v = _mm256_xor_si256(info3_v, valid_target);
+
+		info3_v = _mm256_packs_epi32(info3_v, _mm256_setzero_si256());
+		valid = _mm_cvtsi128_si64(_mm256_extracti128_si256(info3_v, 1));
+		valid = (valid << CHAR_BIT) |
+			_mm_cvtsi128_si64(_mm256_castsi256_si128(info3_v));
+		num_valid = rte_popcount64(valid & desc_valid_mask);
+
+		if (num_valid == 0)
+			break;
+
+		mbuf01 = _mm256_shuffle_epi8(rxcmp0_1, shuf_msk);
+		mbuf23 = _mm256_shuffle_epi8(rxcmp2_3, shuf_msk);
+		mbuf45 = _mm256_shuffle_epi8(rxcmp4_5, shuf_msk);
+		mbuf67 = _mm256_shuffle_epi8(rxcmp6_7, shuf_msk);
+
+		mbuf01 = _mm256_blend_epi32(mbuf01, ptypes, 0x11);
+		mbuf23 = _mm256_blend_epi32(mbuf23,
+					_mm256_srli_si256(ptypes, 4), 0x11);
+		mbuf45 = _mm256_blend_epi32(mbuf45,
+					_mm256_srli_si256(ptypes, 8), 0x11);
+		mbuf67 = _mm256_blend_epi32(mbuf67,
+					_mm256_srli_si256(ptypes, 12), 0x11);
+
+		const __m256i tci_perm_01 = _mm256_set_epi32(1, 1, 1, 1, 0, 0, 0, 0);
+		const __m256i tci_perm_23 = _mm256_set_epi32(3, 3, 3, 3, 2, 2, 2, 2);
+		const __m256i tci_perm_45 = _mm256_set_epi32(5, 5, 5, 5, 4, 4, 4, 4);
+		const __m256i tci_perm_67 = _mm256_set_epi32(7, 7, 7, 7, 6, 6, 6, 6);
+
+		mbuf01 = _mm256_blend_epi16(mbuf01,
+			_mm256_slli_si256(_mm256_permutevar8x32_epi32(vlan_tci,
+						tci_perm_01), 10), 0x20);
+		mbuf23 = _mm256_blend_epi16(mbuf23,
+			_mm256_slli_si256(_mm256_permutevar8x32_epi32(vlan_tci,
+						tci_perm_23), 10), 0x20);
+		mbuf45 = _mm256_blend_epi16(mbuf45,
+			_mm256_slli_si256(_mm256_permutevar8x32_epi32(vlan_tci,
+						tci_perm_45), 10), 0x20);
+		mbuf67 = _mm256_blend_epi16(mbuf67,
+			_mm256_slli_si256(_mm256_permutevar8x32_epi32(vlan_tci,
+						tci_perm_67), 10), 0x20);
+
+		rearm0 = _mm256_permute2f128_si256(mbuf_init, mbuf01, 0x20);
+		rearm1 = _mm256_blend_epi32(mbuf_init, mbuf01, 0xF0);
+		rearm2 = _mm256_permute2f128_si256(mbuf_init, mbuf23, 0x20);
+		rearm3 = _mm256_blend_epi32(mbuf_init, mbuf23, 0xF0);
+
+		ol_flags = _mm256_or_si256(ol_flags, rss_flags);
+		ol_flags = _mm256_or_si256(ol_flags, vlan_flags);
+		ol_flags_hi = _mm256_permute2f128_si256(ol_flags,
+							ol_flags, 0x11);
+
+		rearm0 = _mm256_blend_epi32(rearm0,
+					    _mm256_slli_si256(ol_flags, 8),
+					    0x04);
+		rearm1 = _mm256_blend_epi32(rearm1,
+					    _mm256_slli_si256(ol_flags_hi, 8),
+					    0x04);
+		rearm2 = _mm256_blend_epi32(rearm2,
+					    _mm256_slli_si256(ol_flags, 4),
+					    0x04);
+		rearm3 = _mm256_blend_epi32(rearm3,
+					    _mm256_slli_si256(ol_flags_hi, 4),
+					    0x04);
+
+		_mm256_storeu_si256((void *)&rx_pkts[i + 0]->rearm_data,
+				    rearm0);
+		_mm256_storeu_si256((void *)&rx_pkts[i + 1]->rearm_data,
+				    rearm1);
+		_mm256_storeu_si256((void *)&rx_pkts[i + 2]->rearm_data,
+				    rearm2);
+		_mm256_storeu_si256((void *)&rx_pkts[i + 3]->rearm_data,
+				    rearm3);
+
+		rearm4 = _mm256_permute2f128_si256(mbuf_init, mbuf45, 0x20);
+		rearm5 = _mm256_blend_epi32(mbuf_init, mbuf45, 0xF0);
+		rearm6 = _mm256_permute2f128_si256(mbuf_init, mbuf67, 0x20);
+		rearm7 = _mm256_blend_epi32(mbuf_init, mbuf67, 0xF0);
+
+		rearm4 = _mm256_blend_epi32(rearm4, ol_flags, 0x04);
+		rearm5 = _mm256_blend_epi32(rearm5, ol_flags_hi, 0x04);
+		rearm6 = _mm256_blend_epi32(rearm6,
+					    _mm256_srli_si256(ol_flags, 4),
+					    0x04);
+		rearm7 = _mm256_blend_epi32(rearm7,
+					    _mm256_srli_si256(ol_flags_hi, 4),
+					    0x04);
+
+		_mm256_storeu_si256((void *)&rx_pkts[i + 4]->rearm_data,
+				    rearm4);
+		_mm256_storeu_si256((void *)&rx_pkts[i + 5]->rearm_data,
+				    rearm5);
+		_mm256_storeu_si256((void *)&rx_pkts[i + 6]->rearm_data,
+				    rearm6);
+		_mm256_storeu_si256((void *)&rx_pkts[i + 7]->rearm_data,
+				    rearm7);
+
+		nb_rx_pkts += num_valid;
+		if (num_valid < BNXT_RX_DESCS_PER_LOOP_VEC256)
+			break;
+	}
+
+	if (nb_rx_pkts) {
+		rxr->rx_raw_prod = RING_ADV(rxr->rx_raw_prod, nb_rx_pkts);
+
+		rxq->rxrearm_nb += nb_rx_pkts;
+		cpr->cp_raw_cons += 2 * nb_rx_pkts;
+		bnxt_db_cq(cpr);
+	}
+
+	return nb_rx_pkts;
+}
+
+uint16_t
+bnxt_recv_pkts_vec_avx2_v3(void *rx_queue, struct rte_mbuf **rx_pkts,
+			   uint16_t nb_pkts)
+{
+	struct bnxt_rx_queue *rxq = rx_queue;
+	uint32_t expected_burst = rxq->rx_free_thresh;
+	uint16_t cnt = 0;
+
+	while (nb_pkts > expected_burst) {
+		uint16_t burst;
+
+		burst = recv_burst_vec_avx2_v3(rx_queue, rx_pkts + cnt, expected_burst);
+
+		cnt += burst;
+		nb_pkts -= burst;
+
+		if (burst < expected_burst)
+			return cnt;
+	}
+	return cnt + recv_burst_vec_avx2_v3(rx_queue, rx_pkts + cnt, nb_pkts);
+}
+
diff --git a/drivers/net/bnxt/bnxt_rxtx_vec_common.h b/drivers/net/bnxt/bnxt_rxtx_vec_common.h
index e185005293..e8da010dc3 100644
--- a/drivers/net/bnxt/bnxt_rxtx_vec_common.h
+++ b/drivers/net/bnxt/bnxt_rxtx_vec_common.h
@@ -177,4 +177,40 @@ bnxt_tx_cmp_vec(struct bnxt_tx_queue *txq, uint32_t nr_pkts)
 	}
 	txr->tx_raw_cons = raw_cons;
 }
+
+static const uint64_t errors_to_olflags_v3[16] = {
+	RTE_MBUF_F_RX_OUTER_L4_CKSUM_GOOD | RTE_MBUF_F_RX_L4_CKSUM_GOOD |
+	RTE_MBUF_F_RX_IP_CKSUM_GOOD,
+	RTE_MBUF_F_RX_OUTER_L4_CKSUM_GOOD | RTE_MBUF_F_RX_L4_CKSUM_GOOD |
+	RTE_MBUF_F_RX_IP_CKSUM_BAD,
+	RTE_MBUF_F_RX_OUTER_L4_CKSUM_GOOD | RTE_MBUF_F_RX_L4_CKSUM_BAD |
+	RTE_MBUF_F_RX_IP_CKSUM_GOOD,
+	RTE_MBUF_F_RX_OUTER_L4_CKSUM_GOOD | RTE_MBUF_F_RX_L4_CKSUM_BAD |
+	RTE_MBUF_F_RX_IP_CKSUM_BAD,
+	RTE_MBUF_F_RX_OUTER_L4_CKSUM_GOOD | RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD |
+	RTE_MBUF_F_RX_L4_CKSUM_GOOD,
+	RTE_MBUF_F_RX_OUTER_L4_CKSUM_GOOD | RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD |
+	RTE_MBUF_F_RX_L4_CKSUM_GOOD | RTE_MBUF_F_RX_IP_CKSUM_BAD,
+	RTE_MBUF_F_RX_OUTER_L4_CKSUM_GOOD | RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD |
+	RTE_MBUF_F_RX_L4_CKSUM_BAD,
+	RTE_MBUF_F_RX_OUTER_L4_CKSUM_GOOD | RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD |
+	RTE_MBUF_F_RX_L4_CKSUM_BAD | RTE_MBUF_F_RX_IP_CKSUM_BAD,
+	RTE_MBUF_F_RX_OUTER_L4_CKSUM_BAD | RTE_MBUF_F_RX_L4_CKSUM_GOOD |
+	RTE_MBUF_F_RX_IP_CKSUM_GOOD,
+	RTE_MBUF_F_RX_OUTER_L4_CKSUM_BAD | RTE_MBUF_F_RX_L4_CKSUM_GOOD |
+	RTE_MBUF_F_RX_IP_CKSUM_BAD,
+	RTE_MBUF_F_RX_OUTER_L4_CKSUM_BAD | RTE_MBUF_F_RX_L4_CKSUM_BAD |
+	RTE_MBUF_F_RX_IP_CKSUM_GOOD,
+	RTE_MBUF_F_RX_OUTER_L4_CKSUM_BAD | RTE_MBUF_F_RX_L4_CKSUM_BAD |
+	RTE_MBUF_F_RX_IP_CKSUM_BAD,
+	RTE_MBUF_F_RX_OUTER_L4_CKSUM_BAD | RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD |
+	RTE_MBUF_F_RX_L4_CKSUM_GOOD,
+	RTE_MBUF_F_RX_OUTER_L4_CKSUM_BAD | RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD |
+	RTE_MBUF_F_RX_L4_CKSUM_GOOD | RTE_MBUF_F_RX_IP_CKSUM_BAD,
+	RTE_MBUF_F_RX_OUTER_L4_CKSUM_BAD | RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD |
+	RTE_MBUF_F_RX_L4_CKSUM_BAD,
+	RTE_MBUF_F_RX_OUTER_L4_CKSUM_BAD | RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD |
+	RTE_MBUF_F_RX_L4_CKSUM_BAD | RTE_MBUF_F_RX_IP_CKSUM_BAD
+};
+
 #endif /* _BNXT_RXTX_VEC_COMMON_H_ */
-- 
2.47.3

