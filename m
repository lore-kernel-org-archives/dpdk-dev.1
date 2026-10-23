Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D61606A326
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 16:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=YJ7ALcrs
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A739940DCA;
	Fri, 23 Oct 2026 18:51:37 +0200 (CEST)
Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com
 [209.85.216.99]) by mails.dpdk.org (Postfix) with ESMTP id 8F7D040A72
 for <dev@dpdk.org>; Fri, 23 Oct 2026 18:51:33 +0200 (CEST)
Received: by mail-pj1-f99.google.com with SMTP id
 98e67ed59e1d1-3ade49a7ebdso113367a91.3
 for <dev@dpdk.org>; Fri, 23 Oct 2026 09:51:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792774293; x=1793379093;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EVxtVUCgWU6DnA2DnSkduVXJQ5WBFQouoiO2AgAgi6c=;
 b=ne3b/3gGMJWR8RiqDV6zhCLT/tY4/i5F/zZw56kv2h7ohCbr/QHaCDZFq3v7aVXEuf
 zqNSFeQ/J678QvQBNpHD64lN7LRqaOsMBASMPXBBBa3rgPHR0F1TW71QSs26ouE5tIFk
 cqwejOoHMivwdGXROo8C+W1sATJCBPAKBBI3Q4fgMjXabvqc/uXn3dudLlIPqll1KYih
 UCBrTy1O+1ioWtEJmZvGi6znR/lmIEPivrQk1euk3jnMP8a0PJMYWMMrlE4elEumjvRl
 vvwezm5NJXcDusw6r1voBO3wokSQyE4+IcoE45ZYBGFGLQwBKr7tMGDZjuE5ZT/ddQcG
 hSpg==
X-Gm-Message-State: AFq9FYLqHk8lFMhzyQxJwLMPLotSDquHlTZZ6JOgDkLCIZfUQtIWZtfp
 1Ev9rEKpT5yxZoUMGTjEt4sozl9NuEfE9Ze7u0sRueJ+r6DeAYAWIqdASiAi6NM7OU3z0DY+Mog
 3hgc3cGfIEzkeCjvYQdSrBgzz/sBbLxfncAGvcDH1Ma74Wyj2wpq85OD/Px0qSoBsg5adkcyBaG
 OVkC0hAK0w+P4/sP6DjuGXwJsD8CQHYF2Y0YQS6KKabfOtejjxjybhQESnM5K2LqTEUNydXRE4u
 +0juUOew+8A
X-Gm-Gg: AYBFou2les287atip7pga0Mgk8xaLMnLh4powQpMBQZwmUG4MrijCjSERsOJHStN/fa
 8ZFCIKgk7dSES71EmZX1mASponqVqJQbkBqViTmluzwZJkOaeOYeHUC/TlYzQtDTSVstFo5VzIg
 zgLKaXmmyOGfnQUnYixT5djy64r34bZ26ohe+cXi9coPrQPkfBgr1msjRHukWhXxblIdowicCrI
 1o6WhLW3nZIE2E7NYk4tgFZdNBWkHioIvWCvbj2ZH+m5NE2HDyPT2bxe3qeCAnuhUlQ5swrEfdl
 tj+B01T5fUAb+vKF12CURnaknAi6WCYHFrFnBb3lJaLWMkueQMDfQsY3BZhoyXnUJIUmbolpAv+
 vVpjAOAT/40Pym9UpywVnT14v/91Ek8lYh+fFUO2ZfiDiYlq/Y+3tcbmFjdyy9omdBdCdXtevHi
 pB2Ev/ztztqaFjLBnppCeHxy9IQokOzcgHCv+V4D7X8CIfSTPAQ5Fr
X-Received: by 2002:a17:90b:5246:b0:3ac:8fff:5a1b with SMTP id
 98e67ed59e1d1-3adce7dd700mr2241441a91.34.1792774292697; 
 Fri, 23 Oct 2026 09:51:32 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3ade2231432sm126494a91.0.2026.10.23.09.51.32
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 23 Oct 2026 09:51:32 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5376f1849bbso6738761cf.0
 for <dev@dpdk.org>; Fri, 23 Oct 2026 09:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1792774291; x=1793379091; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EVxtVUCgWU6DnA2DnSkduVXJQ5WBFQouoiO2AgAgi6c=;
 b=YJ7ALcrs0q79ch7pKUdZsLF0rp51kWBCnta4uvOmjM3WLE+llQSLSlM4jXvDV5paNN
 Nte3kFP8hDzkMmEabTzB7UrC6FzyKCVoi/3iRTpTBguSIo0alabYL4ZbSuTRjQNa/4Yi
 isJjIaFU/rnE0xQboI6/Lu90MhIYo3lDGSNwA=
X-Received: by 2002:a05:622a:5512:b0:536:65fb:fff5 with SMTP id
 d75a77b69052e-536c298931dmr40184401cf.60.1792774291072; 
 Fri, 23 Oct 2026 09:51:31 -0700 (PDT)
X-Received: by 2002:a05:622a:5512:b0:536:65fb:fff5 with SMTP id
 d75a77b69052e-536c298931dmr40183871cf.60.1792774290174; 
 Fri, 23 Oct 2026 09:51:30 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91c45228d8bsm5928056d6.21.2026.10.23.09.51.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 09:51:29 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com,
 Keegan Freyhof <keegan.freyhof@broadcom.com>, stable@dpdk.org
Subject: [PATCH 5/7] net/bnxt: modify AVX2 v2 path to prevent OOB accesses
Date: Fri, 23 Oct 2026 10:54:54 -0600
Message-ID: <20261023165457.1225312-6-mohammad-shuab.siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261023165457.1225312-1-mohammad-shuab.siddique@broadcom.com>
References: <20261023165457.1225312-1-mohammad-shuab.siddique@broadcom.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Keegan Freyhof <keegan.freyhof@broadcom.com>

The AVX2 Rx burst function for the standard completion format always
loads eight completion pairs and stores eight mbuf pointers per loop
iteration. When the request was shorter than eight, or the end of the
completion ring left fewer than eight entries, the extra descriptors
were only masked off after being read, so the loop could read past
the end of the completion ring and write past the end of the
caller's array.

Run the vector loop only for whole groups of eight that stay inside
both rings, and receive the remaining packets one completion at a
time with a scalar helper, recv_one_vec_avx2(). A call no longer wraps
either ring.

A request for fewer than eight packets is now served instead of
returning none.

Move bnxt_parse_pkt_type() to bnxt_rxr.h so the helper can use it.

Fixes: c4e4c18963b0 ("net/bnxt: add AVX2 RX/Tx")
Cc: stable@dpdk.org

Signed-off-by: Keegan Freyhof <keegan.freyhof@broadcom.com>
Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
 drivers/net/bnxt/bnxt_rxr.c             |  26 ---
 drivers/net/bnxt/bnxt_rxr.h             |  26 +++
 drivers/net/bnxt/bnxt_rxtx_vec_avx2.c   | 243 ++++++++++++++++--------
 drivers/net/bnxt/bnxt_rxtx_vec_common.h |   1 -
 4 files changed, 192 insertions(+), 104 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_rxr.c b/drivers/net/bnxt/bnxt_rxr.c
index 559c208437..43b13790f8 100644
--- a/drivers/net/bnxt/bnxt_rxr.c
+++ b/drivers/net/bnxt/bnxt_rxr.c
@@ -540,32 +540,6 @@ bnxt_init_ptype_table(void)
 	initialized = true;
 }
 
-static uint32_t
-bnxt_parse_pkt_type(struct rx_pkt_cmpl *rxcmp, struct rx_pkt_cmpl_hi *rxcmp1)
-{
-	uint32_t flags_type, flags2;
-	uint8_t index;
-
-	flags_type = rte_le_to_cpu_16(rxcmp->flags_type);
-	flags2 = rte_le_to_cpu_32(rxcmp1->flags2);
-
-	/* Validate ptype table indexing at build time. */
-	bnxt_check_ptype_constants();
-
-	/*
-	 * Index format:
-	 *     bit 0: Set if IP tunnel encapsulated packet.
-	 *     bit 1: Set if IPv6 packet, clear if IPv4.
-	 *     bit 2: Set if VLAN tag present.
-	 *     bits 3-6: Four-bit hardware packet type field.
-	 */
-	index = BNXT_CMPL_ITYPE_TO_IDX(flags_type) |
-		BNXT_CMPL_VLAN_TUN_TO_IDX(flags2) |
-		BNXT_CMPL_IP_VER_TO_IDX(flags2);
-
-	return bnxt_ptype_table[index];
-}
-
 static void
 bnxt_parse_pkt_type_v3(struct rte_mbuf *mbuf,
 		       struct rx_pkt_cmpl *rxcmp_v1,
diff --git a/drivers/net/bnxt/bnxt_rxr.h b/drivers/net/bnxt/bnxt_rxr.h
index 0d05606fe3..4e745bd7b7 100644
--- a/drivers/net/bnxt/bnxt_rxr.h
+++ b/drivers/net/bnxt/bnxt_rxr.h
@@ -254,6 +254,32 @@ bnxt_check_ptype_constants(void)
 
 extern uint32_t bnxt_ptype_table[BNXT_PTYPE_TBL_DIM];
 
+static inline uint32_t
+bnxt_parse_pkt_type(struct rx_pkt_cmpl *rxcmp, struct rx_pkt_cmpl_hi *rxcmp1)
+{
+	uint32_t flags_type, flags2;
+	uint8_t index;
+
+	flags_type = rte_le_to_cpu_16(rxcmp->flags_type);
+	flags2 = rte_le_to_cpu_32(rxcmp1->flags2);
+
+	/* Validate ptype table indexing at build time. */
+	bnxt_check_ptype_constants();
+
+	/*
+	 * Index format:
+	 *     bit 0: Set if IP tunnel encapsulated packet.
+	 *     bit 1: Set if IPv6 packet, clear if IPv4.
+	 *     bit 2: Set if VLAN tag present.
+	 *     bits 3-6: Four-bit hardware packet type field.
+	 */
+	index = BNXT_CMPL_ITYPE_TO_IDX(flags_type) |
+		BNXT_CMPL_VLAN_TUN_TO_IDX(flags2) |
+		BNXT_CMPL_IP_VER_TO_IDX(flags2);
+
+	return bnxt_ptype_table[index];
+}
+
 static inline void bnxt_set_vlan(struct rx_pkt_cmpl_hi *rxcmp1,
 				 struct rte_mbuf *mbuf)
 {
diff --git a/drivers/net/bnxt/bnxt_rxtx_vec_avx2.c b/drivers/net/bnxt/bnxt_rxtx_vec_avx2.c
index dcbff3ca4b..d8031232bb 100644
--- a/drivers/net/bnxt/bnxt_rxtx_vec_avx2.c
+++ b/drivers/net/bnxt/bnxt_rxtx_vec_avx2.c
@@ -19,25 +19,99 @@
 #include "bnxt_rxtx_vec_common.h"
 #include <unistd.h>
 
+/*
+ * Scalar tail handler for the V2 completion format. Processes a
+ * single completion pair so that the caller can drain the packets left over
+ * once the eight-wide vector loop can no longer be run without stepping past
+ * the end of either ring.
+ */
 static uint16_t
-recv_burst_vec_avx2(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
+recv_one_vec_avx2(struct bnxt_rx_queue *rxq, struct rte_mbuf **rx_pkts,
+		  uint32_t cons, uint32_t mbcons, uint32_t valid_bit,
+		  uint64_t mbuf_init, struct cmpl_base *cp_desc_ring,
+		  struct rte_mbuf **rx_buf_ring)
+{
+	struct rx_pkt_cmpl *rxcmp = (struct rx_pkt_cmpl *)&cp_desc_ring[cons];
+	struct rx_pkt_cmpl_hi *rxcmp1 = (struct rx_pkt_cmpl_hi *)&cp_desc_ring[cons + 1];
+	struct bnxt_rx_ring_info *rxr = rxq->rx_ring;
+	uint32_t flags_type, flags2, index, errors;
+	struct rte_mbuf *mbuf;
+	uint16_t errors_v2;
+	uint64_t ol_flags;
+
+	errors_v2 = rxcmp1->errors_v2;
+
+	if (!((errors_v2 & CMPL_BASE_V) ^ valid_bit))
+		return 0;
+
+	rte_compiler_barrier();
+
+	mbuf = rx_buf_ring[mbcons];
+	RTE_ASSERT(mbuf != NULL);
+
+	flags_type = rxcmp->flags_type;
+	/* The vector loop only ever consumes the low 16 bits of flags2. */
+	flags2 = rxcmp1->flags2 & 0xffff;
+
+	/*
+	 * Build the ol_flags and checksum error table indices exactly as the
+	 * vector loop does: the tunnel bit (RX_PKT_CMPL_FLAGS2_T_IP_CS_CALC)
+	 * is folded into bit 5 of the ol_flags index and bit 4 of the error
+	 * index. ol_flags_err_table[] is zero for every entry with no error
+	 * bit set, so the lookup is unconditional here as well.
+	 */
+	errors = ((errors_v2 >> 4) & 0xf) & flags2;
+	index = (flags2 & 0x1f) & ~errors;
+	index |= (flags2 & RX_PKT_CMPL_FLAGS2_T_IP_CS_CALC) << 3;
+	errors |= (flags2 & RX_PKT_CMPL_FLAGS2_T_IP_CS_CALC) << 2;
+
+	ol_flags = rxr->ol_flags_table[index];
+	ol_flags |= rxr->ol_flags_err_table[errors];
+
+	mbuf->hash.rss = rxcmp->rss_hash;
+	if (flags_type & RX_PKT_CMPL_FLAGS_RSS_VALID)
+		ol_flags |= RTE_MBUF_F_RX_RSS_HASH;
+
+	/*
+	 * ol_flags_table already carries RX_VLAN|RX_VLAN_STRIPPED when strip
+	 * offload is enabled; mirror the vector loop and OR them in from the
+	 * per-packet VLAN metadata bit so that the two sources agree.
+	 */
+	if ((flags2 & RX_PKT_CMPL_FLAGS2_META_FORMAT_VLAN) &&
+	    BNXT_RX_VLAN_STRIP_EN(rxq->bp))
+		ol_flags |= RTE_MBUF_F_RX_VLAN | RTE_MBUF_F_RX_VLAN_STRIPPED;
+
+	mbuf->ol_flags = ol_flags;
+
+	mbuf->next = NULL;
+	mbuf->pkt_len = rxcmp->len;
+	mbuf->data_len = mbuf->pkt_len;
+	mbuf->rearm_data[0] = mbuf_init;
+	mbuf->packet_type = bnxt_parse_pkt_type(rxcmp, rxcmp1);
+	mbuf->vlan_tci = rxcmp1->metadata;
+
+	rx_pkts[0] = mbuf;
+	return 1;
+}
+
+/*
+ * AVX2 V2 RX burst processing
+ *
+ * The function will always consume 2 * nb_pkts cpr bds and write nb_pkts
+ * packets given valid. Bounds are enforced by bnxt_recv_pkts_vec_avx2.
+ */
+static uint16_t
+recv_burst_vec_avx2(struct bnxt_rx_queue *rxq, struct rte_mbuf **rx_pkts,
+		    uint16_t nb_pkts, uint32_t cons, uint32_t mbcons,
+		    uint32_t valid_bit, uint64_t mbuf_init,
+		    struct cmpl_base *cp_desc_ring, struct rte_mbuf **rx_buf_ring)
 {
-	struct bnxt_rx_queue *rxq = rx_queue;
-	const __m256i mbuf_init =
-		_mm256_set_epi64x(0, 0, 0, rxq->mbuf_initializer);
-	struct bnxt_cp_ring_info *cpr = rxq->cp_ring;
 	struct bnxt_rx_ring_info *rxr = rxq->rx_ring;
-	uint32_t cp_ring_size = cpr->cp_ring_struct->ring_size;
-	uint32_t rx_ring_size = rxr->rx_ring_struct->ring_size;
-	struct cmpl_base *cp_desc_ring = cpr->cp_desc_ring;
-	uint64_t valid, desc_valid_mask = ~0ULL;
 	const __m256i info3_v_mask = _mm256_set1_epi32(CMPL_BASE_V);
-	uint32_t raw_cons = cpr->cp_raw_cons;
-	uint32_t cons, mbcons;
-	int nb_rx_pkts = 0;
-	int i;
+	const __m256i mbuf_init_v =
+		_mm256_set_epi64x(0, 0, 0, mbuf_init);
 	const __m256i valid_target =
-		_mm256_set1_epi32(!!(raw_cons & cp_ring_size));
+		_mm256_set1_epi32(valid_bit);
 	const __m256i dsc_shuf_msk =
 		_mm256_set_epi8(0xff, 0xff, 0xff, 0xff,  /* Zeroes. */
 				7, 6,                    /* metadata type */
@@ -88,42 +162,13 @@ recv_burst_vec_avx2(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 	__m256i ol_flags, ol_flags_hi;
 	__m256i rss_flags;
 
+	int nb_rx_pkts = 0;
+	uint64_t valid;
+	int i;
+
 	/* Validate ptype table indexing at build time. */
 	bnxt_check_ptype_constants();
 
-	/* If Rx Q was stopped return */
-	if (unlikely(!rxq->rx_started))
-		return 0;
-
-	if (rxq->rxrearm_nb >= rxq->rx_free_thresh)
-		bnxt_rxq_rearm(rxq, rxr);
-
-	nb_pkts = RTE_ALIGN_FLOOR(nb_pkts, BNXT_RX_DESCS_PER_LOOP_VEC256);
-
-	cons = raw_cons & (cp_ring_size - 1);
-	mbcons = (raw_cons / 2) & (rx_ring_size - 1);
-
-	/* Return immediately if there is not at least one completed packet. */
-	if (!bnxt_cpr_cmp_valid(&cp_desc_ring[cons], raw_cons, cp_ring_size))
-		return 0;
-
-	/* Ensure that we do not go past the ends of the rings. */
-	nb_pkts = RTE_MIN(nb_pkts, RTE_MIN(rx_ring_size - mbcons,
-					   (cp_ring_size - cons) / 2));
-	/*
-	 * If we are at the end of the ring, ensure that descriptors after the
-	 * last valid entry are not treated as valid. Otherwise, force the
-	 * maximum number of packets to receive to be a multiple of the per-
-	 * loop count.
-	 */
-	if (nb_pkts < BNXT_RX_DESCS_PER_LOOP_VEC256) {
-		desc_valid_mask >>=
-			CHAR_BIT * (BNXT_RX_DESCS_PER_LOOP_VEC256 - nb_pkts);
-	} else {
-		nb_pkts =
-			RTE_ALIGN_FLOOR(nb_pkts, BNXT_RX_DESCS_PER_LOOP_VEC256);
-	}
-
 	/* Handle RX burst request */
 	for (i = 0; i < nb_pkts; i += BNXT_RX_DESCS_PER_LOOP_VEC256,
 				  cons += BNXT_RX_DESCS_PER_LOOP_VEC256 * 2,
@@ -134,10 +179,10 @@ recv_burst_vec_avx2(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 		uint32_t num_valid;
 
 		/* Copy eight mbuf pointers to output array. */
-		t0 = _mm256_loadu_si256((void *)&rxr->rx_buf_ring[mbcons]);
+		t0 = _mm256_loadu_si256((void *)&rx_buf_ring[mbcons]);
 		_mm256_storeu_si256((void *)&rx_pkts[i], t0);
 #ifdef RTE_ARCH_X86_64
-		t0 = _mm256_loadu_si256((void *)&rxr->rx_buf_ring[mbcons + 4]);
+		t0 = _mm256_loadu_si256((void *)&rx_buf_ring[mbcons + 4]);
 		_mm256_storeu_si256((void *)&rx_pkts[i + 4], t0);
 #endif
 
@@ -266,11 +311,13 @@ recv_burst_vec_avx2(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 		valid = _mm_cvtsi128_si64(_mm256_extracti128_si256(info3_v, 1));
 		valid = (valid << CHAR_BIT) |
 			_mm_cvtsi128_si64(_mm256_castsi256_si128(info3_v));
-		num_valid = rte_popcount64(valid & desc_valid_mask);
+		num_valid = rte_popcount64(valid);
 
 		if (num_valid == 0)
 			break;
 
+		rte_compiler_barrier();
+
 		/* Update mbuf rearm_data for eight packets. */
 		mbuf01 = _mm256_shuffle_epi8(rxcmp0_1, shuf_msk);
 		mbuf23 = _mm256_shuffle_epi8(rxcmp2_3, shuf_msk);
@@ -287,10 +334,10 @@ recv_burst_vec_avx2(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 					_mm256_srli_si256(ptypes, 12), 0x11);
 
 		/* Unpack rearm data, set fixed fields for first four mbufs. */
-		rearm0 = _mm256_permute2f128_si256(mbuf_init, mbuf01, 0x20);
-		rearm1 = _mm256_blend_epi32(mbuf_init, mbuf01, 0xF0);
-		rearm2 = _mm256_permute2f128_si256(mbuf_init, mbuf23, 0x20);
-		rearm3 = _mm256_blend_epi32(mbuf_init, mbuf23, 0xF0);
+		rearm0 = _mm256_permute2f128_si256(mbuf_init_v, mbuf01, 0x20);
+		rearm1 = _mm256_blend_epi32(mbuf_init_v, mbuf01, 0xF0);
+		rearm2 = _mm256_permute2f128_si256(mbuf_init_v, mbuf23, 0x20);
+		rearm3 = _mm256_blend_epi32(mbuf_init_v, mbuf23, 0xF0);
 
 		/* Compute final ol_flags values for eight packets. */
 		rss_flags = _mm256_and_si256(flags_type, rss_mask);
@@ -344,10 +391,10 @@ recv_burst_vec_avx2(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 				    rearm3);
 
 		/* Unpack rearm data, set fixed fields for final four mbufs. */
-		rearm4 = _mm256_permute2f128_si256(mbuf_init, mbuf45, 0x20);
-		rearm5 = _mm256_blend_epi32(mbuf_init, mbuf45, 0xF0);
-		rearm6 = _mm256_permute2f128_si256(mbuf_init, mbuf67, 0x20);
-		rearm7 = _mm256_blend_epi32(mbuf_init, mbuf67, 0xF0);
+		rearm4 = _mm256_permute2f128_si256(mbuf_init_v, mbuf45, 0x20);
+		rearm5 = _mm256_blend_epi32(mbuf_init_v, mbuf45, 0xF0);
+		rearm6 = _mm256_permute2f128_si256(mbuf_init_v, mbuf67, 0x20);
+		rearm7 = _mm256_blend_epi32(mbuf_init_v, mbuf67, 0xF0);
 
 		/* Set ol_flags fields for final four packets. */
 		rearm4 = _mm256_blend_epi32(rearm4, ol_flags, 0x04);
@@ -374,14 +421,6 @@ recv_burst_vec_avx2(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 			break;
 	}
 
-	if (nb_rx_pkts) {
-		rxr->rx_raw_prod = RING_ADV(rxr->rx_raw_prod, nb_rx_pkts);
-
-		rxq->rxrearm_nb += nb_rx_pkts;
-		cpr->cp_raw_cons += 2 * nb_rx_pkts;
-		bnxt_db_cq(cpr);
-	}
-
 	return nb_rx_pkts;
 }
 
@@ -680,27 +719,76 @@ crx_burst_vec_avx2(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 	return nb_rx_pkts;
 }
 
+
 uint16_t
 bnxt_recv_pkts_vec_avx2(void *rx_queue, struct rte_mbuf **rx_pkts,
 			 uint16_t nb_pkts)
 {
 	struct bnxt_rx_queue *rxq = rx_queue;
-	uint32_t brst = (uint16_t)RTE_MAX((uint32_t)rxq->rx_free_thresh,
+	uint16_t brst = (uint16_t)RTE_MAX((uint32_t)rxq->rx_free_thresh,
 					   BNXT_RX_DESCS_PER_LOOP_VEC256);
+	struct bnxt_cp_ring_info *cpr = rxq->cp_ring;
+	struct bnxt_rx_ring_info *rxr = rxq->rx_ring;
+	uint32_t cp_ring_size = cpr->cp_ring_struct->ring_size;
+	uint32_t rx_ring_size = rxr->rx_ring_struct->ring_size;
+	struct cmpl_base *cp_desc_ring = cpr->cp_desc_ring;
+	struct rte_mbuf **rx_buf_ring = rxr->rx_buf_ring;
 	uint16_t cnt = 0;
 
-	while (nb_pkts > brst) {
-		uint16_t burst;
+	if (unlikely(!rxq->rx_started))
+		return 0;
 
-		burst = recv_burst_vec_avx2(rx_queue, rx_pkts + cnt, brst);
+	while (nb_pkts) {
+		uint32_t cons, mbcons, valid_bit, num, num_vec, received = 0;
 
-		cnt += burst;
-		nb_pkts -= burst;
+		if (rxq->rxrearm_nb >= rxq->rx_free_thresh)
+			bnxt_rxq_rearm(rxq, rxr);
 
-		if (burst < brst)
-			return cnt;
+		valid_bit = !!(cpr->cp_raw_cons & cp_ring_size);
+		cons = cpr->cp_raw_cons & (cp_ring_size - 1);
+		mbcons = (cpr->cp_raw_cons / 2) & (rx_ring_size - 1);
+
+		/* Never wrap either ring within one pass. */
+		num = RTE_MIN((uint32_t)nb_pkts, brst);
+		num = RTE_MIN(num, rx_ring_size - mbcons);
+		num = RTE_MIN(num, (cp_ring_size - cons) / 2);
+
+		num_vec = RTE_ALIGN_FLOOR(num, BNXT_RX_DESCS_PER_LOOP_VEC256);
+
+		if (num_vec)
+			received = recv_burst_vec_avx2(rxq, rx_pkts + cnt,
+						     num_vec, cons, mbcons,
+						     valid_bit,
+						     rxq->mbuf_initializer,
+						     cp_desc_ring, rx_buf_ring);
+
+		/* Only chase the tail if the vector loops all filled. */
+		if (received == num_vec) {
+			while (received < num &&
+				recv_one_vec_avx2(rxq, rx_pkts + cnt + received,
+						     cons + 2 * received, mbcons + received,
+						     valid_bit,
+						     rxq->mbuf_initializer,
+						     cp_desc_ring, rx_buf_ring))
+				received++;
+		}
+
+		if (received == 0)
+			break;
+
+		rxr->rx_raw_prod = RING_ADV(rxr->rx_raw_prod, received);
+		rxq->rxrearm_nb += received;
+		cpr->cp_raw_cons += 2 * received;
+		bnxt_db_cq(cpr);
+
+		cnt += received;
+		nb_pkts -= received;
+
+		if (received < num)
+			break;
 	}
-	return cnt + recv_burst_vec_avx2(rx_queue, rx_pkts + cnt, nb_pkts);
+
+	return cnt;
 }
 
 uint16_t
@@ -948,7 +1036,7 @@ bnxt_xmit_pkts_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
 	return nb_sent;
 }
 
-static uint16_t
+static inline uint16_t
 recv_one_vec_avx2_v3(struct rte_mbuf **rx_pkts, uint32_t cons, uint32_t mbcons,
 		      uint32_t valid_bit, uint64_t mbuf_init,
 		      struct cmpl_base *cp_desc_ring, struct rte_mbuf **rx_buf_ring)
@@ -1031,7 +1119,7 @@ recv_one_vec_avx2_v3(struct rte_mbuf **rx_pkts, uint32_t cons, uint32_t mbcons,
  * The function will always consume 8 cpr bds and write 8 packets given valid.
  * Bounds are enforced by bnxt_recv_pkts_vec_avx2_v3.
  */
-static uint16_t
+static inline uint16_t
 recv_burst_vec_avx2_v3(struct rte_mbuf **rx_pkts, uint16_t nb_pkts,
 			uint32_t cons, uint32_t mbcons, uint32_t valid_bit, uint64_t mbuf_init,
 			struct cmpl_base *cp_desc_ring, struct rte_mbuf **rx_buf_ring)
@@ -1160,6 +1248,7 @@ recv_burst_vec_avx2_v3(struct rte_mbuf **rx_pkts, uint16_t nb_pkts,
 
 		vlan_s_mask = _mm256_and_si256(flags2,
 				_mm256_set1_epi32(RX_PKT_V3_CMPL_HI_FLAGS2_META_FORMAT_MASK));
+		/* mask_1s used in place of RX_PKT_V3_CMPL_HI_FLAGS2_IP_TYPE*/
 		/* mask_1s is used in place of RX_PKT_V3_CMPL_HI_FLAGS2_IP_TYPE */
 		tun_ip6 = _mm256_and_si256(_mm256_srli_epi32(flags2,
 					   RX_PKT_V3_CMPL_FLAGS2_IP_TYPE_SFT), mask_1s);
diff --git a/drivers/net/bnxt/bnxt_rxtx_vec_common.h b/drivers/net/bnxt/bnxt_rxtx_vec_common.h
index df20e7280c..3a095682d1 100644
--- a/drivers/net/bnxt/bnxt_rxtx_vec_common.h
+++ b/drivers/net/bnxt/bnxt_rxtx_vec_common.h
@@ -227,7 +227,6 @@ static const alignas(32) uint32_t olflags_v3_lut[8] = {
 	RTE_MBUF_F_RX_IP_CKSUM_BAD | RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD | RTE_MBUF_F_RX_L4_CKSUM_BAD,
 };
 
-
 /* Split tables to reduce the latency from the old ptypes table look up as most
  * of the ptypes table isn't needed.
  * Because the hotpath code does not incur any cost from having all of the
-- 
2.47.3

