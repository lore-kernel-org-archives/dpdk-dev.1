Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0E8606A31D
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 19:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=AQHRgB1I
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 916B7406BB;
	Mon, 26 Oct 2026 20:09:31 +0100 (CET)
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com
 [209.85.214.227])
 by mails.dpdk.org (Postfix) with ESMTPS id 5B68240698
 for <dev@dpdk.org>; Mon, 26 Oct 2026 20:09:27 +0100 (CET)
Received: by mail-pl1-f227.google.com with SMTP id
 d9443c01a7336-2e940d5d2beso12825955ad.0
 for <dev@dpdk.org>; Mon, 26 Oct 2026 12:09:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793041766; x=1793646566;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IymVDGGjlKHp2ncM3P1den0j4bNfCuG9rACGWCVkhtY=;
 b=X5CW3MOdb6wZPdllR7+46LiJ22C6oedWRRIfrMrtCDdb6U8taA4OJdaoAVdZ2wl3Ez
 nd/+zjmkgcHoo3lcQpxla0VIESah9xruXthL6L5/LLleRpgHVNt5hgbGOv9t7J60LHio
 ocjAHWZ1LA7brNK1YanfydJiXNCBi9AUWmXXtaGJYHcJKR6AouAYc/f3aZftsEo2tOL6
 sCnO35MPknXLG+7BMtNzEGQ9nNXk11jOMaHychGULXZmJJJTH9QQsv8Eod5e0LSBUr96
 DhteMMTjpQ4vHW9sPSApAn4Huy6L9jkgVmARtW9hjgpRecKOkB6SpExjDS171sP7PD7V
 zPSA==
X-Gm-Message-State: AFq9FYIKEjTgfchjUFZU+Uzk0FXnmaXZslhWC8Ic56xLGJRsXkfMyysN
 ZGYGZY7kZjOz3+VikIiK2DM661re+DPTEpJ5FkXSMTALVszRqEyKozAXrbK6K0zJIB1kWN5hFcN
 zwT8yRwv4nYRoqPHhdWa14u48aqGtEc8mDjC0uXSijZu6hkbWa9J0EOBPV9VKMz98FqMfcyaYzq
 0Pu06Y1pdkwE8iBUtj8Dzfvob755c1J12rHL7U+veo/W+H6KbT+d45agxxN0Q5AigXilXMQAW1l
 saeEWuGDPsZ
X-Gm-Gg: AYBFou0W1mIv8xB2nl80sL33T6Cv7cvlU6xavTtbrKHO2sf9wfvFqUvVmLBSVnF1wWC
 0BfElPhK91YEwt4jxZBXBJQ6C79XlO0GgA7iiQoAnAiVPEZ3fMCNvya5U/6T8A2a9jmgZ1LEeub
 8W0P5kyQ/OvpYFvEvHu7yXWLIW5W8X1SbunSVMY4/UdgH4cQUXyYM/g8XRJ8qX8hg24nlEz0QFF
 28G+vNrewJIaAPIJa+/H+BLqYEPQig+jx5BfSLP0c8Dmshl4Uqj3y+X9fuYMBWwZut7de6V8U8l
 TELc7f081SVuJ6KhJyx21bLfnwq0pfbrUmc2l67JPJtks6ptq9PBrSzALPUgKf+alJTxD/huTmB
 wa3HrBlgzXFZZxbPwlzHuJvmaJqRWA84eKpcVHcJl3VN3UXjP8p9ZWei55Ji5VpnF/ZKR1jbggj
 rFTsfj17H99t2xXj0+EaU80X9RjFpOHJTe5GR/NYp0fzDoIB1jpQ==
X-Received: by 2002:a17:90a:dfcc:b0:3ac:403d:6239 with SMTP id
 98e67ed59e1d1-3adeb0fb5d3mr6012743a91.43.1793041765744; 
 Mon, 26 Oct 2026 12:09:25 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-23.dlp.protect.broadcom.com. [144.49.247.23])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3adebae5655sm3099653a91.2.2026.10.26.12.09.25
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 26 Oct 2026 12:09:25 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30c0d568830so9130774eec.1
 for <dev@dpdk.org>; Mon, 26 Oct 2026 12:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1793041764; x=1793646564; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IymVDGGjlKHp2ncM3P1den0j4bNfCuG9rACGWCVkhtY=;
 b=AQHRgB1Iy8JaKSuKXyBVDGZZ5ULAPqmtD/I+DaEs6jKA2bYq2ProM0MCl6dDE76RQf
 LHMGhRKww7qFJcqxErc5ECBdip+nyw6AHcCgMiT/7AqiZlpGVT553116ulGXb+Pz/Lfq
 sceooPK7hRH2wzdn6t3swFAF0cGrgnIv23fgA=
X-Received: by 2002:a05:7301:3033:b0:366:9ac5:34fb with SMTP id
 5a478bee46e88-369e847ac9cmr11625243eec.13.1793041763774; 
 Mon, 26 Oct 2026 12:09:23 -0700 (PDT)
X-Received: by 2002:a05:7301:3033:b0:366:9ac5:34fb with SMTP id
 5a478bee46e88-369e847ac9cmr11625200eec.13.1793041762656; 
 Mon, 26 Oct 2026 12:09:22 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369e8db7b23sm37103906eec.19.2026.10.26.12.09.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 12:09:22 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com, kishore.padmanabha@broadcom.com,
 Keegan Freyhof <keegan.freyhof@broadcom.com>, stable@dpdk.org,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH v2 5/7] net/bnxt: modify AVX2 v2 path to prevent OOB accesses
Date: Mon, 26 Oct 2026 13:12:49 -0600
Message-ID: <20261026191251.1274062-6-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261026191251.1274062-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20261023165457.1225312-1-mohammad-shuab.siddique@broadcom.com>
 <20261026191251.1274062-1-Mohammad-Shuab.Siddique@broadcom.com>
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
 drivers/net/bnxt/bnxt_rxtx_vec_avx2.c   | 240 ++++++++++++++++--------
 drivers/net/bnxt/bnxt_rxtx_vec_common.h |   1 -
 4 files changed, 190 insertions(+), 103 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_rxr.c b/drivers/net/bnxt/bnxt_rxr.c
index 559c208437f..43b13790f87 100644
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
index 0d05606fe37..4e745bd7b7e 100644
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
index 4984b79feb0..39de9aa09cd 100644
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
 
@@ -680,6 +719,7 @@ crx_burst_vec_avx2(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 	return nb_rx_pkts;
 }
 
+
 uint16_t
 bnxt_recv_pkts_vec_avx2(void *rx_queue, struct rte_mbuf **rx_pkts,
 			 uint16_t nb_pkts)
@@ -687,20 +727,68 @@ bnxt_recv_pkts_vec_avx2(void *rx_queue, struct rte_mbuf **rx_pkts,
 	struct bnxt_rx_queue *rxq = rx_queue;
 	uint16_t brst = (uint16_t)RTE_MAX((uint32_t)rxq->rx_free_thresh,
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
diff --git a/drivers/net/bnxt/bnxt_rxtx_vec_common.h b/drivers/net/bnxt/bnxt_rxtx_vec_common.h
index df20e7280cc..3a095682d12 100644
--- a/drivers/net/bnxt/bnxt_rxtx_vec_common.h
+++ b/drivers/net/bnxt/bnxt_rxtx_vec_common.h
@@ -227,7 +227,6 @@ static const alignas(32) uint32_t olflags_v3_lut[8] = {
 	RTE_MBUF_F_RX_IP_CKSUM_BAD | RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD | RTE_MBUF_F_RX_L4_CKSUM_BAD,
 };
 
-
 /* Split tables to reduce the latency from the old ptypes table look up as most
  * of the ptypes table isn't needed.
  * Because the hotpath code does not incur any cost from having all of the
