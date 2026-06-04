Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A76DECD6E55
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Jun 2026 03:17:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B1BB740A67;
	Thu,  4 Jun 2026 05:17:19 +0200 (CEST)
Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com
 [209.85.216.99]) by mails.dpdk.org (Postfix) with ESMTP id A939D406B6
 for <dev@dpdk.org>; Thu,  4 Jun 2026 05:17:16 +0200 (CEST)
Received: by mail-pj1-f99.google.com with SMTP id
 98e67ed59e1d1-36d98c9b596so123803a91.3
 for <dev@dpdk.org>; Wed, 03 Jun 2026 20:17:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780543036; x=1781147836;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0+BczMbPg3ZtoOYrWLLP3fpvtCu1dFnZ2snPAKmjSlo=;
 b=CB+MBJ6wojXFCj5ll1LBUQqfxhdSTJkIYAnjR56EZ52ZWyvwkmPy9FMTmOjGbg0if1
 YoVVe7u/41bY3zuVhVGQSz//9EcijXCGGXj/fuzTY+u77+6g7shDyM5tesj//JcMJfqo
 MNUJLtbMGkgD5PHGAqmr7Y0X0FFl7gaEnjEv7rC7oouk7xkhK+N8XCbv2feKy1mqfYWA
 OzCUxK9e6ZH+a5O1/kf0X6Ngnt7qLJXGE6sSnSFuwgBEypyIIxu7WnOqiTuKrCnowEdC
 Tq0Nqa2RAvQITOuN8AovLXPj1Fc+cae1OxTEKuYfF2ltqVx5svw2USJRbJaRHdqTIig7
 sHEw==
X-Gm-Message-State: AOJu0YwDw+WMNQ2SHprrIf5R+tP5h2keHTIUSaVtpg3O/WCoaGM16cCy
 NQ25+UfsetjZjRigHZ5X0IVyGjsfYxemo6YZTup+zsapkut3DFa1c8aKJb8p2Ve/HTlE4EQ94rq
 TunHvufVOkrD80M9joKt+RzvOC7Fq/vscMZR/rBqNlMuMfEWOhkf7L1upvfvDOmKbtLBpH/rgrv
 h5REzilP9d8cWy4T74CIjY5ALga9pgxCCtxCsWpJIoQpxBkIaXO5RuDhlxaCzoXRM2Jo0HcpORt
 iCCaxLymtJA
X-Gm-Gg: Acq92OFes+3h0PB3SHtHcmq4lEsWiXhZCHbcF3nmXg17vTw8xaLS+PdsiQ/0BJzwgPH
 ODiUC7ERLKNBBnEmoDZSF3o9q+00Vtyc5ib4NxYiaE3NLe6WnTap46gB+kp+VWdzui7haSQ28zu
 sClcCbY1QnFCfRui+WiZmKFy/5ISWl3NgeoMlM+uDn7ed3a+PBEaF52ArhCDnGIgI39svdemraJ
 5vk7HlUg39a7IVzfdWwEzx4H4+DGSTfdKeFPkTL3uKG/H0TTvbkZvuOt0lVGaZcJVqDWFln7qkA
 EqEy9UHPubxmQVMQyHTUrdTZey0XdhmWt0tptmAbw6dR3g1BRQE1enHBKou+wiRowAiaPW85l/Z
 LNwRTyx9wQfKOtye0CeA1ASZfKMJ2lPUs2MqsikoTgJZieUARoE2ZytQJNpdCGSY//uMHsNqaOK
 FKeAOL3UMs4WvKnYe/+1i8Y4UsA61T/A94yFY1k3c0kCUZwm0cGQkcLIxVmuCF0MC+pC0ma57A5
 X4nCXM1bw==
X-Received: by 2002:a17:903:b8f:b0:2b2:67ca:5ff9 with SMTP id
 d9443c01a7336-2c16361add2mr57742655ad.0.1780543035753; 
 Wed, 03 Jun 2026 20:17:15 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-18.dlp.protect.broadcom.com. [144.49.247.18])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-2c164fa0735sm4278795ad.21.2026.06.03.20.17.15
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 03 Jun 2026 20:17:15 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-91574ad6871so57623185a.0
 for <dev@dpdk.org>; Wed, 03 Jun 2026 20:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1780543034; x=1781147834; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0+BczMbPg3ZtoOYrWLLP3fpvtCu1dFnZ2snPAKmjSlo=;
 b=g3BU3swCqg/cwcqoyPKpxue18UV5QaK9ocO1SkaUNdq4lfih5g8LLFpRdOVBMQG/Yf
 vMmfmmSrlSosLWiL3oQsV9wOJkaWOfM8Qz8Kdv+fhF7jVkpN5TByVNOA5QqLNtErmtkz
 QSWuOyNqjfjqiBtWzagM6lJpWwS4QZK+GrKOY=
X-Received: by 2002:a05:620a:4592:b0:915:9125:e649 with SMTP id
 af79cd13be357-9159125f39bmr775484785a.44.1780543034305; 
 Wed, 03 Jun 2026 20:17:14 -0700 (PDT)
X-Received: by 2002:a05:620a:4592:b0:915:9125:e649 with SMTP id
 af79cd13be357-9159125f39bmr775480585a.44.1780543033785; 
 Wed, 03 Jun 2026 20:17:13 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9158a009fe7sm446421685a.8.2026.06.03.20.17.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 20:17:12 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, stable@dpdk.org,
 Keegan Freyhof <keegan.freyhof@broadcom.com>,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH 07/10] net/bnxt: optimization of the AVX2 RX paths
Date: Wed,  3 Jun 2026 21:18:48 -0600
Message-ID: <20260604031851.2267548-8-Mohammad-Shuab.Siddique@broadcom.com>
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

Fixed some dead code and some variable names to make them more
descriptive. Also optimized the V3 path to stay under 16
registers.

Signed-off-by: Keegan Freyhof <keegan.freyhof@broadcom.com>
Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
 drivers/net/bnxt/bnxt_rxtx_vec_avx2.c   | 240 +++++++++++-------------
 drivers/net/bnxt/bnxt_rxtx_vec_common.h |   2 +-
 2 files changed, 114 insertions(+), 128 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_rxtx_vec_avx2.c b/drivers/net/bnxt/bnxt_rxtx_vec_avx2.c
index 46b51b20e4..5e22b4fc11 100644
--- a/drivers/net/bnxt/bnxt_rxtx_vec_avx2.c
+++ b/drivers/net/bnxt/bnxt_rxtx_vec_avx2.c
@@ -187,15 +187,12 @@ recv_burst_vec_avx2(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 		t0 = _mm256_unpacklo_epi32(rxcmp0_1, rxcmp2_3);
 		t1 = _mm256_unpacklo_epi32(rxcmp4_5, rxcmp6_7);
 		flags_type = _mm256_unpacklo_epi64(t0, t1);
+		flags2 = _mm256_unpackhi_epi64(t0, t1);
 		ptype_idx = _mm256_and_si256(flags_type, flags_type_mask);
 		ptype_idx = _mm256_srli_epi32(ptype_idx,
 					      RX_PKT_CMPL_FLAGS_ITYPE_SFT -
 					      BNXT_PTYPE_TBL_TYPE_SFT);
 
-		t0 = _mm256_unpacklo_epi32(rxcmp0_1, rxcmp2_3);
-		t1 = _mm256_unpacklo_epi32(rxcmp4_5, rxcmp6_7);
-		flags2 = _mm256_unpackhi_epi64(t0, t1);
-
 		t0 = _mm256_srli_epi32(_mm256_and_si256(flags2, flags2_mask1),
 				       RX_PKT_CMPL_FLAGS2_META_FORMAT_SFT -
 				       BNXT_PTYPE_TBL_VLAN_SFT);
@@ -251,9 +248,6 @@ recv_burst_vec_avx2(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 		 * bits and count the number of set bits in order to determine
 		 * the number of valid descriptors.
 		 */
-		const __m256i perm_msk =
-				_mm256_set_epi32(7, 3, 6, 2, 5, 1, 4, 0);
-		info3_v = _mm256_permutevar8x32_epi32(errors_v2, perm_msk);
 		info3_v = _mm256_and_si256(errors_v2, info3_v_mask);
 		info3_v = _mm256_xor_si256(info3_v, valid_target);
 
@@ -904,7 +898,6 @@ bnxt_xmit_pkts_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
 	return nb_sent;
 }
 
-
 /*
  * V3 (Thor2) RX burst processing - AVX2 vectorized implementation
  *
@@ -924,7 +917,6 @@ recv_burst_vec_avx2_v3(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pk
 	uint16_t rx_ring_size = rxr->rx_ring_struct->ring_size;
 	struct cmpl_base *cp_desc_ring = cpr->cp_desc_ring;
 	uint64_t valid, desc_valid_mask = ~0ULL;
-	const __m256i info3_v_mask = _mm256_set1_epi32(CMPL_BASE_V);
 	uint32_t raw_cons = cpr->cp_raw_cons;
 	uint32_t cons, mbcons;
 	int nb_rx_pkts = 0;
@@ -937,12 +929,12 @@ recv_burst_vec_avx2_v3(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pk
 	 */
 	const __m256i shuf_msk =
 		_mm256_set_epi8(15, 14, 13, 12,          /* rss */
-				0xFF, 0xFF,              /* vlan_tci (filled separately) */
+				11, 10,                  /* vlan_tci */
 				3, 2,                    /* data_len */
 				0xFF, 0xFF, 3, 2,        /* pkt_len */
 				0xFF, 0xFF, 0xFF, 0xFF,  /* pkt_type (zeroes) */
 				15, 14, 13, 12,          /* rss */
-				0xFF, 0xFF,              /* vlan_tci (filled separately) */
+				11, 10,                  /* vlan_tci */
 				3, 2,                    /* data_len */
 				0xFF, 0xFF, 3, 2,        /* pkt_len */
 				0xFF, 0xFF, 0xFF, 0xFF); /* pkt_type (zeroes) */
@@ -952,40 +944,24 @@ recv_burst_vec_avx2_v3(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pk
 		_mm256_set_epi8(0xff, 0xff, 0xff, 0xff,  /* Zeroes */
 				11, 10,                  /* metadata0 (vlan_tci) */
 				9, 8,                    /* errors_v2 */
-				5, 4,                    /* metadata1 (payload_offset) */
+				5, 4,                    /* metadata2 */
 				1, 0,                    /* flags2 low */
 				0xff, 0xff, 0xff, 0xff,  /* Zeroes */
 				0xff, 0xff, 0xff, 0xff,  /* Zeroes */
 				11, 10,                  /* metadata0 (vlan_tci) */
 				9, 8,                    /* errors_v2 */
-				5, 4,                    /* metadata1 (payload_offset) */
+				5, 4,                    /* metadata2 */
 				1, 0,                    /* flags2 low */
 				0xff, 0xff, 0xff, 0xff); /* Zeroes */
+	const __m256i mask_1s =
+		_mm256_set1_epi32(0x1);
+	const __m256i mask_fs =
+		_mm256_set1_epi32(0xf);
 
-	const __m256i flags_type_mask =
-		_mm256_set1_epi32(RX_PKT_V3_CMPL_FLAGS_ITYPE_MASK);
-	const __m256i flags2_ip_type_mask =
-		_mm256_set1_epi32(RX_PKT_V3_CMPL_HI_FLAGS2_IP_TYPE);
-	const __m256i rss_mask =
-		_mm256_set1_epi32(RX_PKT_V3_CMPL_FLAGS_RSS_VALID);
-	const __m256i metadata1_valid_mask =
-		_mm256_set1_epi32(RX_PKT_V3_CMPL_METADATA1_VALID);
-	const __m256i vlan_tci_mask =
-		_mm256_set1_epi32(RX_PKT_V3_CMPL_HI_METADATA0_VID_MASK |
-				  RX_PKT_V3_CMPL_HI_METADATA0_DE |
-				  RX_PKT_V3_CMPL_HI_METADATA0_PRI_MASK);
-	const __m256i cs_err_mask =
-		_mm256_set1_epi32(RX_PKT_CMPL_ERRORS_T_L4_CS_ERROR |
-				  RX_PKT_CMPL_ERRORS_T_IP_CS_ERROR |
-				  RX_PKT_CMPL_ERRORS_L4_CS_ERROR |
-				  RX_PKT_CMPL_ERRORS_IP_CS_ERROR);
-	const __m256i cs_calc_mask =
-		_mm256_set1_epi32(RX_PKT_CMPL_CALC);
-
-	__m256i t0, t1, flags_type, flags2, errors, metadata1;
-	__m256i ptype_idx, ptypes, vlan_tci, vlan_flags;
-	__m256i mbuf01, mbuf23, mbuf45, mbuf67;
 	__m256i rearm0, rearm1, rearm2, rearm3, rearm4, rearm5, rearm6, rearm7;
+	__m256i t0, t1, flags_type, flags2, errors_csum_idx, metadata1;
+	__m256i mbuf01, mbuf23, mbuf45, mbuf67;
+	__m256i ptype_idx, ptypes, vlan_flags;
 	__m256i ol_flags, ol_flags_hi;
 	__m256i rss_flags;
 
@@ -1025,7 +1001,8 @@ recv_burst_vec_avx2_v3(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pk
 				  mbcons += BNXT_RX_DESCS_PER_LOOP_VEC256) {
 		__m256i desc0, desc1, desc2, desc3, desc4, desc5, desc6, desc7;
 		__m256i rxcmp0_1, rxcmp2_3, rxcmp4_5, rxcmp6_7, info3_v;
-		__m256i errors_v2, meta0_err, cs_calc, cs_valid;
+		__m256i md1_0123, lo2_3, md1_4567, lo6_7;
+		__m256i errors_v2, cs_calc, cs_valid;
 		uint32_t num_valid;
 
 		t0 = _mm256_loadu_si256((void *)&rxr->rx_buf_ring[mbcons]);
@@ -1057,119 +1034,134 @@ recv_burst_vec_avx2_v3(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pk
 
 		/*
 		 * Pack needed fields from each descriptor pair.
-		 * For V3: extract rxcmp (low) for flags_type, len, rss
+		 * extract rxcmp (low) for flags_type, len, rss
 		 * and rxcmp1 (hi) for flags2, metadata0, metadata1, errors_v2
+		 * metadata1 is incrementally extracted to save on
+		 * register pressure
 		 */
 		t0 = _mm256_permute2f128_si256(desc6, desc7, 0x20);
 		t1 = _mm256_permute2f128_si256(desc6, desc7, 0x31);
 		t1 = _mm256_shuffle_epi8(t1, dsc_shuf_msk);
 		rxcmp6_7 = _mm256_blend_epi32(t0, t1, 0x66);
+		lo6_7 = t0;
 
 		t0 = _mm256_permute2f128_si256(desc4, desc5, 0x20);
 		t1 = _mm256_permute2f128_si256(desc4, desc5, 0x31);
 		t1 = _mm256_shuffle_epi8(t1, dsc_shuf_msk);
 		rxcmp4_5 = _mm256_blend_epi32(t0, t1, 0x66);
+		md1_4567 = _mm256_unpackhi_epi32(t0, lo6_7);
 
 		t0 = _mm256_permute2f128_si256(desc2, desc3, 0x20);
 		t1 = _mm256_permute2f128_si256(desc2, desc3, 0x31);
 		t1 = _mm256_shuffle_epi8(t1, dsc_shuf_msk);
 		rxcmp2_3 = _mm256_blend_epi32(t0, t1, 0x66);
+		lo2_3 = t0;
 
 		t0 = _mm256_permute2f128_si256(desc0, desc1, 0x20);
 		t1 = _mm256_permute2f128_si256(desc0, desc1, 0x31);
 		t1 = _mm256_shuffle_epi8(t1, dsc_shuf_msk);
 		rxcmp0_1 = _mm256_blend_epi32(t0, t1, 0x66);
+		md1_0123 = _mm256_unpackhi_epi32(t0, lo2_3);
+		metadata1 = _mm256_unpacklo_epi64(md1_0123, md1_4567);
 
-		/* Extract flags_type from low completion for eight packets */
-		t0 = _mm256_unpacklo_epi32(rxcmp0_1, rxcmp2_3);
-		t1 = _mm256_unpacklo_epi32(rxcmp4_5, rxcmp6_7);
-		flags_type = _mm256_unpacklo_epi64(t0, t1);
-
-		/* Compute ptype_idx from flags_type itype field */
-		ptype_idx = _mm256_and_si256(flags_type, flags_type_mask);
-		ptype_idx = _mm256_srli_epi32(ptype_idx,
-					      RX_PKT_V3_CMPL_FLAGS_ITYPE_SFT -
-					      BNXT_PTYPE_TBL_TYPE_SFT);
-
-		/* Extract flags2 from high completion */
+		/* Extract flags2 from high completion for eight packets */
 		t0 = _mm256_unpacklo_epi32(rxcmp0_1, rxcmp2_3);
 		t1 = _mm256_unpacklo_epi32(rxcmp4_5, rxcmp6_7);
 		flags2 = _mm256_unpackhi_epi64(t0, t1);
+		/* fs mask used for RX_PKT_CMPL_CALC */
+		cs_calc = _mm256_and_si256(flags2, mask_fs);
+		cs_valid = _mm256_cmpeq_epi32(cs_calc, _mm256_setzero_si256());
 
-		t0 = _mm256_srli_epi32(_mm256_and_si256(flags2, flags2_ip_type_mask),
-				       RX_PKT_V3_CMPL_FLAGS2_IP_TYPE_SFT -
-				       BNXT_PTYPE_TBL_IP_VER_SFT);
-		ptype_idx = _mm256_or_si256(ptype_idx, t0);
-
-		/*
-		 * Extract metadata1 (contains VLAN valid bit) from LOW completion.
-		 * metadata1_payload_offset is at word 2 of rxcmp (low 128 bits of desc).
+		/* Extract metadata0 and errors from high completion */
+		t0 = _mm256_unpackhi_epi32(rxcmp0_1, rxcmp2_3);
+		t1 = _mm256_unpackhi_epi32(rxcmp4_5, rxcmp6_7);
+		errors_v2 = _mm256_unpacklo_epi64(t0, t1);
+		/* mask_fs used in place of RX_PKT_CMPL_ERRORS_T_L4_CS_ERROR |
+		 * RX_PKT_CMPL_ERRORS_T_IP_CS_ERROR | RX_PKT_CMPL_ERRORS_L4_CS_ERROR |
+		 * RX_PKT_CMPL_ERRORS_IP_CS_ERROR
 		 */
-		{
-			__m128i m01, m23, hi;
-			hi =
-		_mm_unpacklo_epi64(_mm_unpackhi_epi32(_mm256_castsi256_si128(desc4),
-						    _mm256_castsi256_si128(desc5)),
-				 _mm_unpackhi_epi32(_mm256_castsi256_si128(desc6),
-						    _mm256_castsi256_si128(desc7)));
-			m01 = _mm_unpackhi_epi32(_mm256_castsi256_si128(desc0),
-						 _mm256_castsi256_si128(desc1));
-			m23 = _mm_unpackhi_epi32(_mm256_castsi256_si128(desc2),
-						 _mm256_castsi256_si128(desc3));
-			metadata1 =
-			_mm256_inserti128_si256(_mm256_castsi128_si256(_mm_unpacklo_epi64(m01,
-								       m23)), hi, 1);
-		}
-		metadata1 = _mm256_srli_epi32(metadata1, 16);
-
-		t0 = _mm256_srli_epi32(_mm256_and_si256(metadata1, metadata1_valid_mask),
-				       RX_PKT_V3_CMPL_METADATA1_VALID_SFT -
-				       BNXT_PTYPE_TBL_VLAN_SFT);
-		ptype_idx = _mm256_or_si256(ptype_idx, t0);
+		errors_csum_idx = _mm256_srli_epi32(_mm256_and_si256(errors_v2,
+						    _mm256_slli_epi32(mask_fs, 4)), 4);
+		errors_csum_idx = _mm256_andnot_si256(cs_valid, errors_csum_idx);
 
 		/*
-		 * Load ptypes for eight packets using gather.
+		 * Load ol_flags for eight packets using gather. Gather
+		 * operations have extremely high latency (~19 cycles),
+		 * execution and use of result should be separated as much
+		 * as possible.
 		 */
-		ptypes = _mm256_i32gather_epi32((int *)bnxt_ptype_table,
-						ptype_idx, sizeof(uint32_t));
-
-		/* Extract RSS valid flags for eight packets */
-		rss_flags = _mm256_and_si256(flags_type, rss_mask);
-		rss_flags = _mm256_srli_epi32(rss_flags, 9);
-
-		/* Extract metadata0 (contains vlan_tci) and errors from high completion */
-		t0 = _mm256_unpackhi_epi32(rxcmp0_1, rxcmp2_3);
-		t1 = _mm256_unpackhi_epi32(rxcmp4_5, rxcmp6_7);
-		meta0_err = _mm256_unpacklo_epi64(t0, t1);
+		ol_flags = _mm256_i32gather_epi32((const int *)errors_to_olflags_v3,
+						  errors_csum_idx, sizeof(uint32_t));
 
-		/* Extract vlan_tci from high 16 bits of meta0_err (metadata0) */
-		vlan_tci = _mm256_and_si256(_mm256_srli_epi32(meta0_err, 16), vlan_tci_mask);
+		/* Exctract if the packet is VLAN and the VLAN tci */
+		metadata1 = _mm256_srli_epi32(metadata1, 16);
+		/* mask_1s used in place of RX_PKT_V3_CMPL_METADATA1_VALID */
+		ptype_idx = _mm256_srli_epi32(_mm256_and_si256(metadata1,
+					      _mm256_slli_epi32(mask_1s, 15)),
+					      RX_PKT_V3_CMPL_METADATA1_VALID_SFT -
+					      BNXT_PTYPE_TBL_VLAN_SFT);
 
-		vlan_flags = _mm256_and_si256(metadata1, metadata1_valid_mask);
-		vlan_flags = _mm256_min_epu32(vlan_flags, _mm256_set1_epi32(1));
+		vlan_flags = _mm256_and_si256(metadata1, _mm256_slli_epi32(mask_1s, 15));
+		vlan_flags = _mm256_min_epu32(vlan_flags, mask_1s);
 
 		if (vnic->vlan_strip) {
 			vlan_flags = _mm256_or_si256(vlan_flags,
-				_mm256_slli_epi32(vlan_flags, 6));
+					_mm256_slli_epi32(vlan_flags, 6));
 		}
 
-		errors_v2 = meta0_err;
+		/* Extract flags_type from low completion for eight packets */
+		t0 = _mm256_unpacklo_epi32(rxcmp0_1, rxcmp2_3);
+		t1 = _mm256_unpacklo_epi32(rxcmp4_5, rxcmp6_7);
+		flags_type = _mm256_unpacklo_epi64(t0, t1);
 
-		errors = _mm256_srli_epi32(_mm256_and_si256(meta0_err, cs_err_mask), 4);
+		/* Compute ptype_idx from flags_type itype field
+		 * mask_fs is used in place of
+		 * RX_PKT_V3_CMPL_FLAGS_ITYPE_MASK
+		 */
+		t0 = _mm256_and_si256(flags_type,
+				      _mm256_slli_epi32(mask_fs, 12));
+		t0 = _mm256_srli_epi32(t0, RX_PKT_V3_CMPL_FLAGS_ITYPE_SFT -
+				       BNXT_PTYPE_TBL_TYPE_SFT);
+		ptype_idx = _mm256_or_si256(ptype_idx, t0);
 
-		cs_calc = _mm256_and_si256(flags2, cs_calc_mask);
+		/* Extract flags2 from low completion for eight packets
+		 * flags2 is re-extracted to save on registers
+		 */
+		t0 = _mm256_unpacklo_epi32(rxcmp0_1, rxcmp2_3);
+		t1 = _mm256_unpacklo_epi32(rxcmp4_5, rxcmp6_7);
+		flags2 = _mm256_unpackhi_epi64(t0, t1);
+
+		/* mask_fs is being used in place of
+		 * RX_PKT_CMPL_CALC
+		 */
+		cs_calc = _mm256_and_si256(flags2, mask_fs);
 		cs_valid = _mm256_cmpeq_epi32(cs_calc, _mm256_setzero_si256());
-		errors = _mm256_andnot_si256(cs_valid, errors);
-		ol_flags = _mm256_i32gather_epi32((const int *)errors_to_olflags_v3,
-						  errors, sizeof(uint32_t));
-		__m256i unknown_flags = _mm256_and_si256(cs_valid,
-				_mm256_set1_epi32(RTE_MBUF_F_RX_IP_CKSUM_UNKNOWN));
-		ol_flags = _mm256_or_si256(ol_flags, unknown_flags);
+		ol_flags = _mm256_andnot_si256(cs_valid, ol_flags);
 
-		const __m256i perm_msk =
-				_mm256_set_epi32(7, 3, 6, 2, 5, 1, 4, 0);
-		info3_v = _mm256_permutevar8x32_epi32(errors_v2, perm_msk);
-		info3_v = _mm256_and_si256(errors_v2, info3_v_mask);
+		/* mask_1s is being used in place of
+		 * RX_PKT_V3_CMPL_HI_FLAGS2_IP_TYPE
+		 */
+		t0 = _mm256_srli_epi32(_mm256_and_si256(flags2,
+				       _mm256_slli_epi32(mask_1s, 8)),
+				       RX_PKT_V3_CMPL_FLAGS2_IP_TYPE_SFT -
+				       BNXT_PTYPE_TBL_IP_VER_SFT);
+		ptype_idx = _mm256_or_si256(ptype_idx, t0);
+
+		/*
+		 * Load ptypes for eight packets using gather. Gather operations
+		 * have extremely high latency (~19 cycles), execution and use
+		 * of result should be separated as much as possible.
+		 */
+		ptypes = _mm256_i32gather_epi32((int *)bnxt_ptype_table,
+						ptype_idx, sizeof(uint32_t));
+
+		/*
+		 * Pack the 128-bit array of valid descriptor flags into 64
+		 * bits and count the number of set bits in order to determine
+		 * the number of valid descriptors.
+		 * mask_1s is used in place of CMPL_BASE_V
+		 */
+		info3_v = _mm256_and_si256(errors_v2, mask_1s);
 		info3_v = _mm256_xor_si256(info3_v, valid_target);
 
 		info3_v = _mm256_packs_epi32(info3_v, _mm256_setzero_si256());
@@ -1181,6 +1173,11 @@ recv_burst_vec_avx2_v3(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pk
 		if (num_valid == 0)
 			break;
 
+		/* Extract flags_type from low completion for eight packets*/
+		t0 = _mm256_unpacklo_epi32(rxcmp0_1, rxcmp2_3);
+		t1 = _mm256_unpacklo_epi32(rxcmp4_5, rxcmp6_7);
+		flags_type = _mm256_unpacklo_epi64(t0, t1);
+
 		mbuf01 = _mm256_shuffle_epi8(rxcmp0_1, shuf_msk);
 		mbuf23 = _mm256_shuffle_epi8(rxcmp2_3, shuf_msk);
 		mbuf45 = _mm256_shuffle_epi8(rxcmp4_5, shuf_msk);
@@ -1194,29 +1191,18 @@ recv_burst_vec_avx2_v3(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pk
 		mbuf67 = _mm256_blend_epi32(mbuf67,
 					_mm256_srli_si256(ptypes, 12), 0x11);
 
-		const __m256i tci_perm_01 = _mm256_set_epi32(1, 1, 1, 1, 0, 0, 0, 0);
-		const __m256i tci_perm_23 = _mm256_set_epi32(3, 3, 3, 3, 2, 2, 2, 2);
-		const __m256i tci_perm_45 = _mm256_set_epi32(5, 5, 5, 5, 4, 4, 4, 4);
-		const __m256i tci_perm_67 = _mm256_set_epi32(7, 7, 7, 7, 6, 6, 6, 6);
-
-		mbuf01 = _mm256_blend_epi16(mbuf01,
-			_mm256_slli_si256(_mm256_permutevar8x32_epi32(vlan_tci,
-						tci_perm_01), 10), 0x20);
-		mbuf23 = _mm256_blend_epi16(mbuf23,
-			_mm256_slli_si256(_mm256_permutevar8x32_epi32(vlan_tci,
-						tci_perm_23), 10), 0x20);
-		mbuf45 = _mm256_blend_epi16(mbuf45,
-			_mm256_slli_si256(_mm256_permutevar8x32_epi32(vlan_tci,
-						tci_perm_45), 10), 0x20);
-		mbuf67 = _mm256_blend_epi16(mbuf67,
-			_mm256_slli_si256(_mm256_permutevar8x32_epi32(vlan_tci,
-						tci_perm_67), 10), 0x20);
-
 		rearm0 = _mm256_permute2f128_si256(mbuf_init, mbuf01, 0x20);
 		rearm1 = _mm256_blend_epi32(mbuf_init, mbuf01, 0xF0);
 		rearm2 = _mm256_permute2f128_si256(mbuf_init, mbuf23, 0x20);
 		rearm3 = _mm256_blend_epi32(mbuf_init, mbuf23, 0xF0);
 
+		/* Extract RSS valid flags for eight packets
+		 * mask_1s is being used in place of
+		 * RX_PKT_V3_CMPL_FLAGS_RSS_VALID
+		 */
+		rss_flags = _mm256_and_si256(flags_type,
+					     _mm256_slli_epi32(mask_1s, 10));
+		rss_flags = _mm256_srli_epi32(rss_flags, 9);
 		ol_flags = _mm256_or_si256(ol_flags, rss_flags);
 		ol_flags = _mm256_or_si256(ol_flags, vlan_flags);
 		ol_flags_hi = _mm256_permute2f128_si256(ol_flags,
diff --git a/drivers/net/bnxt/bnxt_rxtx_vec_common.h b/drivers/net/bnxt/bnxt_rxtx_vec_common.h
index e8da010dc3..d8659d1001 100644
--- a/drivers/net/bnxt/bnxt_rxtx_vec_common.h
+++ b/drivers/net/bnxt/bnxt_rxtx_vec_common.h
@@ -178,7 +178,7 @@ bnxt_tx_cmp_vec(struct bnxt_tx_queue *txq, uint32_t nr_pkts)
 	txr->tx_raw_cons = raw_cons;
 }
 
-static const uint64_t errors_to_olflags_v3[16] = {
+static const uint32_t errors_to_olflags_v3[16] = {
 	RTE_MBUF_F_RX_OUTER_L4_CKSUM_GOOD | RTE_MBUF_F_RX_L4_CKSUM_GOOD |
 	RTE_MBUF_F_RX_IP_CKSUM_GOOD,
 	RTE_MBUF_F_RX_OUTER_L4_CKSUM_GOOD | RTE_MBUF_F_RX_L4_CKSUM_GOOD |
-- 
2.47.3

