Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FDA3CD6E55
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Jun 2026 03:17:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BE5AB40A6F;
	Thu,  4 Jun 2026 05:17:20 +0200 (CEST)
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com
 [209.85.214.228])
 by mails.dpdk.org (Postfix) with ESMTP id 2831140693
 for <dev@dpdk.org>; Thu,  4 Jun 2026 05:17:18 +0200 (CEST)
Received: by mail-pl1-f228.google.com with SMTP id
 d9443c01a7336-2c132ac5ec2so2459025ad.1
 for <dev@dpdk.org>; Wed, 03 Jun 2026 20:17:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780543037; x=1781147837;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6k/fceR1zjPtAxiwvUGt0nP+rHXQ7De9/mz9x8kNC1I=;
 b=LOdtXIuDTj7IdHHrC54B+ILgIorBShk9AIKDPRi44ijQVfNOMDWdUTbPSGYid63QNd
 /n4ZOx/oOZ30rRJucF7Do2LP1AF86WqxmxbsBN3SVlR321qr3fsN5KaS2kiNltn41ZFc
 s3Xxtx7CT1tgDMvaIUDB+08X6ZTTzXga31oJZgbtIhITbfGSxblGDLhzDME5c2kQs7SY
 na5AiUjWMuxRhRN8P2bay7S5K3BvEc9Q0xydRS3o5d0WrGlJAH3fSKbjMdINBd55Q+0s
 UaPMYt/Gp94pLJ/sQLnBGsHpMus3XZW6ceL5jmhcZi7dz+woDqCA7xjFcomxrpG8M+HX
 0sAA==
X-Gm-Message-State: AOJu0Yxdcadmb6637u0WAU3yIQNuWxfjRHYw819PwGISTtwFra5hV+dj
 RL5B4IhlHwGTo+hRSrdGImEG1PjIRYvzWMzTrnvIVOFz9yXlxvOiu42qRGPHRxuJfThLh2v5/JP
 JYPeSQV8FMXabzX4c0mECPDUSC1Tg7SbioV7DmlxOkuz/wAVgln2MEi/ZrYb7mGOwJKYei6nSw0
 iKPc10rk1fcsNzPxPDo9UKkSxreKsq2BzPKk2a/fqjaejtuXT8sTf6kNa8S01/jb7JoCRfXwvND
 gg39vZBXE/u
X-Gm-Gg: Acq92OFBG65i7m/W+DsWkpvbpLc379C+TFrcKa7vBRZxWaFJO8XBBd7BYMkl3PuLqXy
 ciJbh/Ln5LlPodbnvAQ6fOuT608+bcxwZf0tdBTqOpmZl/wKUJ79UxUiKoREyrDc28OxBOB4p9q
 LnCz+HuZbXTxinDuTLsktzbJsekLwqDptiItngmIBvfchL7QDyQYrRfo6cki9rGSCjSeZktac2L
 60sYBYHt+P2RbWQs5zxmFlg6qy7TPbnX3XXFW4vIqiykY9v5XmIcKetkWKvt/uSG7GXk9KYhzp7
 KwD2fgzwYZOHCkzbs6WtKVWxAR/o2LU2Xlc3NyJKVG3Y3k0+83Qegq5U9FO8lug0+466mLoQDk6
 /G9Px5RUfhn8feyOs2kgTG6K4catR7+L4JTshrd5ofO48ik5B4JaOi5ZFDyB6qRTYzgzjjNJ6LQ
 /YZ7ThsaUFkd47dlArCBqOiG46XTzWBg==
X-Received: by 2002:a17:903:2446:b0:2bf:305a:312a with SMTP id
 d9443c01a7336-2c163fa8208mr65541905ad.22.1780543037128; 
 Wed, 03 Jun 2026 20:17:17 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 ([144.49.247.127]) by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-2c16648c978sm4276005ad.45.2026.06.03.20.17.16
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 03 Jun 2026 20:17:17 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-9157929bf8fso24148385a.0
 for <dev@dpdk.org>; Wed, 03 Jun 2026 20:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1780543036; x=1781147836; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6k/fceR1zjPtAxiwvUGt0nP+rHXQ7De9/mz9x8kNC1I=;
 b=UFLhOT5M0IgVdz0L0jN2oxOrB6o/F9XtWcQJpvjxPsytQ35R6x3JJGG/+AB18MDvWg
 RKRSQhTfpyXMnzCEUTiHicnHNI/JbHnCVuVGgxAsTw0wS5Kj69gDh5DhZ6i35NmU4VS4
 2hs3Qz1lhvJdNUb37JwqNf7+rxa/xqY9bboyk=
X-Received: by 2002:a05:620a:4806:b0:914:bd27:2d1 with SMTP id
 af79cd13be357-9158a659ba7mr1047759585a.11.1780543036072; 
 Wed, 03 Jun 2026 20:17:16 -0700 (PDT)
X-Received: by 2002:a05:620a:4806:b0:914:bd27:2d1 with SMTP id
 af79cd13be357-9158a659ba7mr1047755785a.11.1780543035354; 
 Wed, 03 Jun 2026 20:17:15 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9158a009fe7sm446421685a.8.2026.06.03.20.17.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 20:17:14 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, stable@dpdk.org,
 Keegan Freyhof <keegan.freyhof@broadcom.com>,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH 08/10] net/bnxt: fix for VLAN stripping being set incorrectly
Date: Wed,  3 Jun 2026 21:18:49 -0600
Message-ID: <20260604031851.2267548-9-Mohammad-Shuab.Siddique@broadcom.com>
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

Driver was setting the VLAN strip ol flag based on port
settings rather than per packet for V3. This caused
TruFlow's per packet flows to incorrectly not report
VLAN_STRIPPED, as the TruFlow might set a flow to strip
VLAN based on other markers in the packet rather than
always for the port. Changed the logic to set the flag
per packet.

Fixes: 15276ba987bd ("net/bnxt: fix getting burst mode for Arm")
Cc: stable@dpdk.org
Signed-off-by: Keegan Freyhof <keegan.freyhof@broadcom.com>
Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
 drivers/net/bnxt/bnxt_rxr.c           |  6 +--
 drivers/net/bnxt/bnxt_rxr.h           | 12 +++---
 drivers/net/bnxt/bnxt_rxtx_vec_avx2.c | 54 +++++++++++++++++++++++----
 3 files changed, 56 insertions(+), 16 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_rxr.c b/drivers/net/bnxt/bnxt_rxr.c
index ee49d85d43..0fab4ddf78 100644
--- a/drivers/net/bnxt/bnxt_rxr.c
+++ b/drivers/net/bnxt/bnxt_rxr.c
@@ -1127,7 +1127,6 @@ static int bnxt_rx_pkt(struct rte_mbuf **rx_pkt,
 	uint16_t cmp_type;
 	uint32_t vfr_flag = 0, mark_id = 0;
 	struct bnxt *bp = rxq->bp;
-	struct bnxt_vnic_info *vnic = rxq->vnic;
 
 	rxcmp = (struct rx_pkt_cmpl *)
 	    &cpr->cp_desc_ring[cp_cons];
@@ -1236,8 +1235,7 @@ static int bnxt_rx_pkt(struct rte_mbuf **rx_pkt,
 	if (cmp_type == CMPL_BASE_TYPE_RX_L2_V3) {
 		bnxt_parse_csum_v3(mbuf, rxcmp1);
 		bnxt_parse_pkt_type_v3(mbuf, rxcmp, rxcmp1);
-		bnxt_rx_vlan_v3(mbuf, rxcmp, rxcmp1, vnic->vlan_strip);
-
+		bnxt_rx_vlan_v3(mbuf, rxcmp, rxcmp1);
 		/* Packet cannot be a PTP ethertype if it is detected as L4 */
 		if (mbuf->ol_flags & RTE_MBUF_F_RX_L4_CKSUM_GOOD) {
 			mbuf->ol_flags &= ~RTE_MBUF_F_RX_IEEE1588_PTP;
@@ -1259,7 +1257,7 @@ static int bnxt_rx_pkt(struct rte_mbuf **rx_pkt,
 	if (cmp_type == CMPL_BASE_TYPE_RX_L2_V2) {
 		bnxt_parse_csum_v2(mbuf, rxcmp1);
 		bnxt_parse_pkt_type_v2(mbuf, rxcmp, rxcmp1);
-		bnxt_rx_vlan_v2(mbuf, rxcmp, rxcmp1);
+		bnxt_rx_vlan_v2(mbuf, bp, rxcmp, rxcmp1);
 		/* TODO Add support for cfa_code parsing */
 		goto reuse_rx_mbuf;
 	}
diff --git a/drivers/net/bnxt/bnxt_rxr.h b/drivers/net/bnxt/bnxt_rxr.h
index 352d509210..c971233dc3 100644
--- a/drivers/net/bnxt/bnxt_rxr.h
+++ b/drivers/net/bnxt/bnxt_rxr.h
@@ -276,12 +276,15 @@ static inline void bnxt_set_vlan(struct rx_pkt_cmpl_hi *rxcmp1,
 	  RX_PKT_V2_CMPL_HI_METADATA0_PRI_MASK))
 
 static inline void bnxt_rx_vlan_v2(struct rte_mbuf *mbuf,
+				   const struct bnxt *bp,
 				   struct rx_pkt_cmpl *rxcmp,
 				   struct rx_pkt_cmpl_hi *rxcmp1)
 {
 	if (RX_CMP_VLAN_VALID(rxcmp)) {
 		mbuf->vlan_tci = RX_CMP_METADATA0_VID(rxcmp1);
-		mbuf->ol_flags |= RTE_MBUF_F_RX_VLAN | RTE_MBUF_F_RX_VLAN_STRIPPED;
+		mbuf->ol_flags |= RTE_MBUF_F_RX_VLAN;
+		if (BNXT_RX_VLAN_STRIP_EN(bp))
+			mbuf->ol_flags |= RTE_MBUF_F_RX_VLAN_STRIPPED;
 	}
 }
 
@@ -483,14 +486,13 @@ bnxt_parse_pkt_type_v2(struct rte_mbuf *mbuf,
 	  RX_PKT_V3_CMPL_HI_METADATA0_PRI_MASK))
 
 static inline void bnxt_rx_vlan_v3(struct rte_mbuf *mbuf,
-	struct rx_pkt_cmpl *rxcmp,
-	struct rx_pkt_cmpl_hi *rxcmp1,
-	bool stripped)
+				   struct rx_pkt_cmpl *rxcmp,
+				   struct rx_pkt_cmpl_hi *rxcmp1)
 {
 	if (RX_CMP_V3_VLAN_VALID(rxcmp)) {
 		mbuf->vlan_tci = RX_CMP_V3_METADATA0_VID(rxcmp1);
 		mbuf->ol_flags |= RTE_MBUF_F_RX_VLAN;
-		if (stripped)
+		if (rxcmp1->flags2 & RX_PKT_V3_CMPL_HI_FLAGS2_META_FORMAT_MASK)
 			mbuf->ol_flags |= RTE_MBUF_F_RX_VLAN_STRIPPED;
 	}
 }
diff --git a/drivers/net/bnxt/bnxt_rxtx_vec_avx2.c b/drivers/net/bnxt/bnxt_rxtx_vec_avx2.c
index 5e22b4fc11..38aca98cb1 100644
--- a/drivers/net/bnxt/bnxt_rxtx_vec_avx2.c
+++ b/drivers/net/bnxt/bnxt_rxtx_vec_avx2.c
@@ -70,6 +70,17 @@ recv_burst_vec_avx2(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 		_mm256_set1_epi32(RX_PKT_CMPL_FLAGS2_IP_TYPE);
 	const __m256i rss_mask =
 		_mm256_set1_epi32(RX_PKT_CMPL_FLAGS_RSS_VALID);
+	/*
+	 * ol_flags_table already sets RX_VLAN|RX_VLAN_STRIPPED when VLAN strip
+	 * is enabled.  For completeness, also OR in the flags here based on the
+	 * per-packet VLAN-metadata bit so that the two sources agree.  The
+	 * constant is broadcast once: non-zero only when strip offload is on.
+	 */
+	const __m256i vlan_ol_val =
+		BNXT_RX_VLAN_STRIP_EN(rxq->bp) ?
+		_mm256_set1_epi32((uint32_t)(RTE_MBUF_F_RX_VLAN |
+					     RTE_MBUF_F_RX_VLAN_STRIPPED)) :
+					     _mm256_setzero_si256();
 	__m256i t0, t1, flags_type, flags2, index, errors;
 	__m256i ptype_idx, ptypes, is_tunnel;
 	__m256i mbuf01, mbuf23, mbuf45, mbuf67;
@@ -286,6 +297,25 @@ recv_burst_vec_avx2(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 		rss_flags = _mm256_srli_epi32(rss_flags, 9);
 		ol_flags = _mm256_or_si256(ol_flags, errors);
 		ol_flags = _mm256_or_si256(ol_flags, rss_flags);
+		/*
+		 * Set RX_VLAN | RX_VLAN_STRIPPED for packets whose vlan_tci
+		 * is non-zero (i.e. hardware reported VLAN metadata, indicated
+		 * by RX_PKT_CMPL_FLAGS2_META_FORMAT_VLAN in index bit 4).
+		 * vlan_ol_val is the broadcast constant computed before the
+		 * loop: non-zero only when VLAN RX strip offload is enabled.
+		 * _mm256_cmpeq_epi32 produces 0xFFFFFFFF per lane when the
+		 * VLAN bit is set, masking the constant to those lanes only.
+		 */
+		{
+			const __m256i vlan_bit =
+				_mm256_set1_epi32(RX_PKT_CMPL_FLAGS2_META_FORMAT_VLAN);
+			__m256i vlan_mask =
+				_mm256_cmpeq_epi32(_mm256_and_si256(index, vlan_bit),
+						   vlan_bit);
+			ol_flags = _mm256_or_si256(ol_flags,
+					_mm256_and_si256(vlan_mask,
+							 vlan_ol_val));
+		}
 		ol_flags_hi = _mm256_permute2f128_si256(ol_flags,
 							ol_flags, 0x11);
 
@@ -908,7 +938,6 @@ static uint16_t
 recv_burst_vec_avx2_v3(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 {
 	struct bnxt_rx_queue *rxq = rx_queue;
-	struct bnxt_vnic_info *vnic = rxq->vnic;
 	const __m256i mbuf_init =
 		_mm256_set_epi64x(0, 0, 0, rxq->mbuf_initializer);
 	struct bnxt_cp_ring_info *cpr = rxq->cp_ring;
@@ -1001,8 +1030,8 @@ recv_burst_vec_avx2_v3(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pk
 				  mbcons += BNXT_RX_DESCS_PER_LOOP_VEC256) {
 		__m256i desc0, desc1, desc2, desc3, desc4, desc5, desc6, desc7;
 		__m256i rxcmp0_1, rxcmp2_3, rxcmp4_5, rxcmp6_7, info3_v;
+		__m256i errors_v2, cs_calc, cs_valid, meta_format;
 		__m256i md1_0123, lo2_3, md1_4567, lo6_7;
-		__m256i errors_v2, cs_calc, cs_valid;
 		uint32_t num_valid;
 
 		t0 = _mm256_loadu_si256((void *)&rxr->rx_buf_ring[mbcons]);
@@ -1070,7 +1099,9 @@ recv_burst_vec_avx2_v3(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pk
 		flags2 = _mm256_unpackhi_epi64(t0, t1);
 		/* fs mask used for RX_PKT_CMPL_CALC */
 		cs_calc = _mm256_and_si256(flags2, mask_fs);
-		cs_valid = _mm256_cmpeq_epi32(cs_calc, _mm256_setzero_si256());
+		/* Add the meta_format to cs_calc */
+		cs_calc = _mm256_or_si256(cs_calc, _mm256_and_si256(flags2,
+							_mm256_slli_epi32(mask_fs, 4)));
 
 		/* Extract metadata0 and errors from high completion */
 		t0 = _mm256_unpackhi_epi32(rxcmp0_1, rxcmp2_3);
@@ -1082,6 +1113,11 @@ recv_burst_vec_avx2_v3(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pk
 		 */
 		errors_csum_idx = _mm256_srli_epi32(_mm256_and_si256(errors_v2,
 						    _mm256_slli_epi32(mask_fs, 4)), 4);
+		meta_format = _mm256_cmpeq_epi32(_mm256_and_si256(cs_calc,
+							_mm256_slli_epi32(mask_fs, 4)),
+							_mm256_setzero_si256());
+		cs_valid = _mm256_cmpeq_epi32(_mm256_and_si256(cs_calc, mask_fs),
+							_mm256_setzero_si256());
 		errors_csum_idx = _mm256_andnot_si256(cs_valid, errors_csum_idx);
 
 		/*
@@ -1104,10 +1140,14 @@ recv_burst_vec_avx2_v3(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pk
 		vlan_flags = _mm256_and_si256(metadata1, _mm256_slli_epi32(mask_1s, 15));
 		vlan_flags = _mm256_min_epu32(vlan_flags, mask_1s);
 
-		if (vnic->vlan_strip) {
-			vlan_flags = _mm256_or_si256(vlan_flags,
-					_mm256_slli_epi32(vlan_flags, 6));
-		}
+		/*
+		 * VLAN present in mbuf when metadata valid (vlan_flags) and
+		 * meta_format is non-zero in flags2. andnot(cmpeq(tci,0), vlan_flags) is
+		 * (~zero_mask) & vlan_flags.
+		 */
+		t0 = _mm256_andnot_si256(meta_format, vlan_flags);
+		/* RTE_MBUF_F_RX_VLAN + STRIPPED when hardware reports valid VLAN. */
+		vlan_flags = _mm256_or_si256(vlan_flags, _mm256_slli_epi32(t0, 6));
 
 		/* Extract flags_type from low completion for eight packets */
 		t0 = _mm256_unpacklo_epi32(rxcmp0_1, rxcmp2_3);
-- 
2.47.3

