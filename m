Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945D7606A327
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 19:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=WFhpStkg
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A29B4406A2;
	Mon, 26 Oct 2026 20:09:30 +0100 (CET)
Received: from mail-pg1-f225.google.com (mail-pg1-f225.google.com
 [209.85.215.225])
 by mails.dpdk.org (Postfix) with ESMTPS id 5A9934067D
 for <dev@dpdk.org>; Mon, 26 Oct 2026 20:09:26 +0100 (CET)
Received: by mail-pg1-f225.google.com with SMTP id
 41be03b00d2f7-cd60c5da24cso1838077a12.0
 for <dev@dpdk.org>; Mon, 26 Oct 2026 12:09:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793041765; x=1793646565;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Y1l8rIXXZSgvSi3OvXrHT+gvi/V0YkOzs8+yQNGCX/U=;
 b=aZkYQjJzIqbvHVA6k+aHT73Ncgp9xdXYPhgEcKb6BAkds7TToIUp1C9CtmC2QFI4EA
 p08NyORCJt03QEL2T3h7p+BXfKqfuZrHag+yK3Mx5AE+tALolG66JdLbXSYpNX0hAlU+
 gC8aSeafEALGJfOX4yA0YkDz5NOJWXdKotH1oeFbUocLjS7SOaDU14eZvcEDxToLTTRP
 wHwN6E6eT4jnqtpbwCnuZFAMysfxB53K2V9hR0MPyeANPdjvDBdzrUH3x3RPR3QHQ+2F
 7mUDdS1RZgZpNMRkUX8M8RRrTwt+Wytr/uTzk34HlRZf9PaBYgHdND7MGU1fyIg8T+ue
 TH4A==
X-Gm-Message-State: AFq9FYJZZSTBIO0ZXUYPPe8UlAC938TrIHw7N26mBqysRDiB1BMJ0PZi
 TWK7zBE1urge/6ePqRybW+ijRqKZtHC/jW57uw/e2stRddShp+8ZtQB/QkAg54vDOQ8bq3q+lyI
 6kzsCTq8uMOoNgZG4e5w2lPzh1xBTPYZe3WtkcT3d19FuMJqirfvecTi+EixL6YpULi+43z9Efo
 kALkNPH/TylLyhhiEWAd1tV0LYdWDGrnM0KSMTcpEAj0XNBxWqeiq9usp3e17HkywdJDwfqIInJ
 It7z3kMBU6z
X-Gm-Gg: AYBFou1KK0qzEX1bCiYoIcl76b8/rvIQ9PN7zohGx3zVcOIZpozmd5AiqYIxe4v93Og
 0elfCPM3GErxxAHo1aH4SsPcrA42BygJWLPRSB5mXevQ84mWwvqdZc7n6G2kEd3KOBccDW6nPjZ
 XImzjir0rzeHmcsZEMXdf4Zx4HwrzEtVKXgz7ZyojGoh+64iPGF9VNgwi5tciChIDVwWjrzLWGs
 KzO945GiYWKEC6b1eTxFuYhMTJ9zMfMDHsZ0zw8R+aljCKVLsbosupRuZrT7VfSFzzePLYxA5Oe
 GX/eT1Vir6pIlDz7NQfietlHWQ57yy3l1so3ROdrMJUswQR/X53N+dlmiVl3p2sadDemXCcfg2s
 WUkfBa4axfNBWZ3vgukuVhdGNrWNknofOn46t8Xz1ozESiMsV56n3RKqxIWrANIT3wp9tUo0WOA
 T4rl+xpTnoWHCjwlR7jRh2LiSG8RYMqv1AFniMKQuic308BGwXFrsL
X-Received: by 2002:a17:90b:534b:b0:3ad:ce34:f63c with SMTP id
 98e67ed59e1d1-3adeae9c576mr6327848a91.30.1793041764719; 
 Mon, 26 Oct 2026 12:09:24 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3ae405c32d4sm326436a91.0.2026.10.26.12.09.24
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 26 Oct 2026 12:09:24 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-341eff9e381so9604528eec.1
 for <dev@dpdk.org>; Mon, 26 Oct 2026 12:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1793041763; x=1793646563; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Y1l8rIXXZSgvSi3OvXrHT+gvi/V0YkOzs8+yQNGCX/U=;
 b=WFhpStkgCZ01ow7F/VoHmyaVm5z88hbQwQUTAhj+D71uXHt2Fa90QRLmi/P1uAdXXN
 Osi//3KsAUttgPbgMNc2zY0fqnPvE/FpakpeMxLQRrtr4tBEn27teOJbEnud5/n2Um33
 yrY5N2PIQdovJYI2EdR7om0Lb9FHLy15kplxo=
X-Received: by 2002:a05:7300:ec14:b0:351:202c:c7a5 with SMTP id
 5a478bee46e88-369e81c4c2bmr17117678eec.0.1793041762472; 
 Mon, 26 Oct 2026 12:09:22 -0700 (PDT)
X-Received: by 2002:a05:7300:ec14:b0:351:202c:c7a5 with SMTP id
 5a478bee46e88-369e81c4c2bmr17117619eec.0.1793041761446; 
 Mon, 26 Oct 2026 12:09:21 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369e8db7b23sm37103906eec.19.2026.10.26.12.09.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 12:09:20 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com, kishore.padmanabha@broadcom.com,
 Keegan Freyhof <keegan.freyhof@broadcom.com>, stable@dpdk.org,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH v2 4/7] net/bnxt: modify AVX2 v3 path to prevent OOB accesses
Date: Mon, 26 Oct 2026 13:12:48 -0600
Message-ID: <20261026191251.1274062-5-Mohammad-Shuab.Siddique@broadcom.com>
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

The AVX2 Rx burst function for the Thor2 (v3) completion format always
loads eight completion pairs and stores eight mbuf pointers per loop
iteration. When the request was shorter than eight, or the end of the
completion ring left fewer than eight entries, the extra descriptors
were only masked off after being read, so the loop could read past
the end of the completion ring and write past the end of the
caller's array.

Run the vector loop only for whole groups of eight that stay inside
both rings, and receive the remaining packets one completion at a
time with a new scalar helper, recv_one_vec_avx2_v3(). A call no
longer wraps either ring.

A request for fewer than eight packets is now served instead of
returning none.

The packet type of a tunneled packet is now taken from the tunnel bit
of flags2, which is folded into the ptype index, so the vector path
reports the inner L3/L4 packet type for such packets. The packet type
of other packets is unchanged, and bnxt_parse_pkt_type_v3(), which
the non-vector path uses, is not modified.

Fixes: ae347ed1b27d ("net/bnxt: add AVX2 Rx for Thor2")
Cc: stable@dpdk.org

Signed-off-by: Keegan Freyhof <keegan.freyhof@broadcom.com>
Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
 drivers/net/bnxt/bnxt_rxr.h             |   4 +
 drivers/net/bnxt/bnxt_rxtx_vec_avx2.c   | 556 +++++++++++-------------
 drivers/net/bnxt/bnxt_rxtx_vec_common.h |  56 +++
 3 files changed, 318 insertions(+), 298 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_rxr.h b/drivers/net/bnxt/bnxt_rxr.h
index f38fb4f0ba3..0d05606fe37 100644
--- a/drivers/net/bnxt/bnxt_rxr.h
+++ b/drivers/net/bnxt/bnxt_rxr.h
@@ -463,6 +463,10 @@ bnxt_parse_pkt_type_v2(struct rte_mbuf *mbuf,
 #define RX_PKT_V3_CMPL_FLAGS2_IP_TYPE_SFT	8
 #define RX_PKT_V3_CMPL_METADATA1_VALID_SFT	15
 
+#define BNXT_V3_FLAGS2_TUN_MSK				\
+	(RX_PKT_V3_CMPL_HI_FLAGS2_T_IP_CS_CALC |	\
+	 RX_PKT_V3_CMPL_HI_FLAGS2_T_L4_CS_CALC)
+
 #define BNXT_CMPL_V3_ITYPE_TO_IDX(ft) \
 	(((ft) & RX_PKT_V3_CMPL_FLAGS_ITYPE_MASK) >> \
 	 (RX_PKT_V3_CMPL_FLAGS_ITYPE_SFT - BNXT_PTYPE_TBL_TYPE_SFT))
diff --git a/drivers/net/bnxt/bnxt_rxtx_vec_avx2.c b/drivers/net/bnxt/bnxt_rxtx_vec_avx2.c
index 96ca3f4f070..4984b79feb0 100644
--- a/drivers/net/bnxt/bnxt_rxtx_vec_avx2.c
+++ b/drivers/net/bnxt/bnxt_rxtx_vec_avx2.c
@@ -948,116 +948,131 @@ bnxt_xmit_pkts_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
 	return nb_sent;
 }
 
+static uint16_t
+recv_one_vec_avx2_v3(struct rte_mbuf **rx_pkts, uint32_t cons, uint32_t mbcons,
+		      uint32_t valid_bit, uint64_t mbuf_init,
+		      struct cmpl_base *cp_desc_ring, struct rte_mbuf **rx_buf_ring)
+{
+	struct rx_pkt_v3_cmpl *rxcmp = (struct rx_pkt_v3_cmpl *)&cp_desc_ring[cons];
+	struct rx_pkt_v3_cmpl_hi *rxcmp1 = (struct rx_pkt_v3_cmpl_hi *)&cp_desc_ring[cons + 1];
+	uint64_t hi, pkt_type, ol_flags = RTE_MBUF_F_RX_IP_CKSUM_UNKNOWN;
+	uint64_t flags_type, flags2, meta, vlan_tci = 0, rss;
+	uint32_t tun, tun_ip6, vlan, type, im, im2;
+	struct rte_mbuf *mbuf;
+	uint64_t *rearm;
+	uint16_t error_v2;
+
+	error_v2 = rxcmp1->errors_v2;
+
+	if (!((error_v2 & CMPL_BASE_V) ^ valid_bit))
+		return 0;
+
+	rte_compiler_barrier();
+
+	mbuf = rx_buf_ring[mbcons];
+	RTE_ASSERT(mbuf != NULL);
+	rx_pkts[0] = mbuf;
+	rearm = (uint64_t *)&mbuf->rearm_data[0];
+
+	error_v2 &= RX_PKT_CMPL_ERRORS_MASK;
+	flags2 = rxcmp1->flags2;
+	flags_type = rxcmp->flags_type;
+	meta = rxcmp->metadata1_payload_offset;
+
+	im = (error_v2 >> 4) & 0xf;
+	ol_flags = errors_to_olflags_v3[1 + im];
+	ol_flags &= -(uint64_t)!!(flags2 & RX_PKT_CMPL_CALC);
+
+	rss = rxcmp->rss_hash;
+	if (flags_type & RX_PKT_V3_CMPL_FLAGS_RSS_VALID)
+		ol_flags |= RTE_MBUF_F_RX_RSS_HASH;
+
+	tun_ip6 = (flags2 & RX_PKT_V3_CMPL_HI_FLAGS2_IP_TYPE) >>
+		   RX_PKT_V3_CMPL_FLAGS2_IP_TYPE_SFT;
+	tun = (flags2 & BNXT_V3_FLAGS2_TUN_MSK) >> 1;
+	tun_ip6 |= tun;
+	type = (flags_type & RX_PKT_V3_CMPL_FLAGS_ITYPE_MASK) >>
+		RX_PKT_V3_CMPL_FLAGS_ITYPE_SFT;
+
+	im = tun_ip6_lut[tun_ip6];
+	im2 = l3_type_lut[type & 0x7];
+
+	vlan = (meta >> RX_PKT_V3_CMPL_METADATA1_VALID_SFT) & 1;
+	pkt_type = RTE_PTYPE_L2_ETHER + 5 * vlan;
+
+	im &= im2;
+
+	pkt_type |= -(uint64_t)!(type & 0x8) & im;
+
+	if (vlan) {
+		vlan_tci = RX_CMP_V3_METADATA0_VID(rxcmp1);
+		ol_flags |= RTE_MBUF_F_RX_VLAN;
+		if (rxcmp1->flags2 & RX_PKT_V3_CMPL_HI_FLAGS2_META_FORMAT_MASK)
+			ol_flags |= RTE_MBUF_F_RX_VLAN_STRIPPED;
+	}
+	mbuf->next = NULL;
+	hi = rxcmp->len;
+	pkt_type |= hi << 32;
+	hi |= vlan_tci << 16;
+	hi |= rss << 32;
+
+	rearm[0] = mbuf_init;
+	rearm[1] = ol_flags;
+	rearm[2] = pkt_type;
+	rearm[3] = hi;
+	return 1;
+}
+
 /*
  * V3 (Thor2) RX burst processing - AVX2 vectorized implementation
  *
  * V3 completions have a different layout for checksum and VLAN handling
  * compared to the standard and compressed completion formats.
+ * The function will always consume 8 cpr bds and write 8 packets given valid.
+ * Bounds are enforced by bnxt_recv_pkts_vec_avx2_v3.
  */
 static uint16_t
-recv_burst_vec_avx2_v3(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
+recv_burst_vec_avx2_v3(struct rte_mbuf **rx_pkts, uint16_t nb_pkts,
+			uint32_t cons, uint32_t mbcons, uint32_t valid_bit, uint64_t mbuf_init,
+			struct cmpl_base *cp_desc_ring, struct rte_mbuf **rx_buf_ring)
 {
-	struct bnxt_rx_queue *rxq = rx_queue;
-	const __m256i mbuf_init =
-		_mm256_set_epi64x(0, 0, 0, rxq->mbuf_initializer);
-	struct bnxt_cp_ring_info *cpr = rxq->cp_ring;
-	struct bnxt_rx_ring_info *rxr = rxq->rx_ring;
-	uint32_t cp_ring_size = cpr->cp_ring_struct->ring_size;
-	uint32_t rx_ring_size = rxr->rx_ring_struct->ring_size;
-	struct cmpl_base *cp_desc_ring = cpr->cp_desc_ring;
-	uint64_t valid, desc_valid_mask = ~0ULL;
-	uint32_t raw_cons = cpr->cp_raw_cons;
-	uint32_t cons, mbcons;
-	int nb_rx_pkts = 0;
-	int i;
-	const __m256i valid_target =
-		_mm256_set1_epi32(!!(raw_cons & cp_ring_size));
-
-	/*
-	 * Shuffle mask for V3 descriptors to rearrange fields into mbuf layout.
-	 */
-	const __m256i shuf_msk =
-		_mm256_set_epi8(15, 14, 13, 12,          /* rss */
-				11, 10,                  /* vlan_tci */
-				3, 2,                    /* data_len */
-				0xFF, 0xFF, 3, 2,        /* pkt_len */
-				0xFF, 0xFF, 0xFF, 0xFF,  /* pkt_type (zeroes) */
-				15, 14, 13, 12,          /* rss */
-				11, 10,                  /* vlan_tci */
-				3, 2,                    /* data_len */
-				0xFF, 0xFF, 3, 2,        /* pkt_len */
-				0xFF, 0xFF, 0xFF, 0xFF); /* pkt_type (zeroes) */
-
-	/* Shuffle mask for high completion to extract metadata0 and errors */
-	const __m256i dsc_shuf_msk =
-		_mm256_set_epi8(0xff, 0xff, 0xff, 0xff,  /* Zeroes */
-				11, 10,                  /* metadata0 (vlan_tci) */
-				9, 8,                    /* errors_v2 */
-				5, 4,                    /* metadata2 */
-				1, 0,                    /* flags2 low */
-				0xff, 0xff, 0xff, 0xff,  /* Zeroes */
-				0xff, 0xff, 0xff, 0xff,  /* Zeroes */
-				11, 10,                  /* metadata0 (vlan_tci) */
-				9, 8,                    /* errors_v2 */
-				5, 4,                    /* metadata2 */
-				1, 0,                    /* flags2 low */
-				0xff, 0xff, 0xff, 0xff); /* Zeroes */
 	const __m256i mask_1s =
 		_mm256_set1_epi32(0x1);
 	const __m256i mask_fs =
 		_mm256_set1_epi32(0xf);
+	const __m256i mbuf_init_v =
+		_mm256_set1_epi64x(mbuf_init);
+	const __m256i tun_ip6_v =
+		_mm256_load_si256((const __m256i *)tun_ip6_lut);
+	const __m256i l3_type_v =
+		_mm256_load_si256((const __m256i *)l3_type_lut);
+	const __m256i olflags_v3_v =
+		_mm256_load_si256((const __m256i *)olflags_v3_lut);
 
 	__m256i rearm0, rearm1, rearm2, rearm3, rearm4, rearm5, rearm6, rearm7;
-	__m256i t0, t1, flags_type, flags2, errors_csum_idx, metadata1;
-	__m256i mbuf01, mbuf23, mbuf45, mbuf67;
-	__m256i ptype_idx, ptypes, vlan_flags;
-	__m256i ol_flags, ol_flags_hi;
-	__m256i rss_flags;
+	__m256i ptypes, cs_mask, vlan_mask, vlan_s_mask, type, tun_ip6, tun;
+	__m256i third_64_0145, third_64_2367, last_64_0145, last_64_2367;
+	__m256i lo_0123, lo_4567, hi_0123, hi_4567, rss_0123, rss_4567;
+	__m256i ol_flags, ol_flags_0145, ol_flags_2367;
+	__m256i t0, t1, vlan_flags, rss_flags;
 
-	/* Validate ptype table indexing at build time. */
-	bnxt_check_ptype_constants();
+	const uint32_t valid_mask8 = valid_bit ? 0xffu : 0u;
 
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
-	if (!bnxt_cpr_cmp_valid(&cp_desc_ring[cons], raw_cons, cp_ring_size))
-		return 0;
-
-	nb_pkts = RTE_MIN(nb_pkts, RTE_MIN(rx_ring_size - mbcons,
-					   (cp_ring_size - cons) / 2));
-	/*
-	 * If we are at the end of the ring, ensure that descriptors after the
-	 * last valid entry are not treated as valid.
-	 */
-	if (nb_pkts < BNXT_RX_DESCS_PER_LOOP_VEC256) {
-		desc_valid_mask >>=
-			CHAR_BIT * (BNXT_RX_DESCS_PER_LOOP_VEC256 - nb_pkts);
-	} else {
-		nb_pkts =
-			RTE_ALIGN_FLOOR(nb_pkts, BNXT_RX_DESCS_PER_LOOP_VEC256);
-	}
+	int nb_rx_pkts = 0;
+	uint32_t valid;
+	int i;
 
 	for (i = 0; i < nb_pkts; i += BNXT_RX_DESCS_PER_LOOP_VEC256,
 				  cons += BNXT_RX_DESCS_PER_LOOP_VEC256 * 2,
 				  mbcons += BNXT_RX_DESCS_PER_LOOP_VEC256) {
+		__m256i vlan_tci_len, flags_type, flags2, errors_v2, metadata1, rss, len;
 		__m256i desc0, desc1, desc2, desc3, desc4, desc5, desc6, desc7;
-		__m256i rxcmp0_1, rxcmp2_3, rxcmp4_5, rxcmp6_7, info3_v;
-		__m256i errors_v2, cs_calc, cs_valid, meta_format;
-		__m256i md1_0123, lo2_3, md1_4567, lo6_7;
 		uint32_t num_valid;
 
-		t0 = _mm256_loadu_si256((void *)&rxr->rx_buf_ring[mbcons]);
+		t0 = _mm256_loadu_si256((void *)&rx_buf_ring[mbcons]);
 		_mm256_storeu_si256((void *)&rx_pkts[i], t0);
 #ifdef RTE_ARCH_X86_64
-		t0 = _mm256_loadu_si256((void *)&rxr->rx_buf_ring[mbcons + 4]);
+		t0 = _mm256_loadu_si256((void *)&rx_buf_ring[mbcons + 4]);
 		_mm256_storeu_si256((void *)&rx_pkts[i + 4], t0);
 #endif
 
@@ -1081,207 +1096,127 @@ recv_burst_vec_avx2_v3(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pk
 		rte_compiler_barrier();
 		desc0 = _mm256_load_si256((void *)&cp_desc_ring[cons + 0]);
 
-		/*
-		 * Pack needed fields from each descriptor pair.
-		 * extract rxcmp (low) for flags_type, len, rss
-		 * and rxcmp1 (hi) for flags2, metadata0, metadata1, errors_v2
-		 * metadata1 is incrementally extracted to save on
-		 * register pressure
-		 */
-		t0 = _mm256_permute2f128_si256(desc6, desc7, 0x20);
-		t1 = _mm256_permute2f128_si256(desc6, desc7, 0x31);
-		t1 = _mm256_shuffle_epi8(t1, dsc_shuf_msk);
-		rxcmp6_7 = _mm256_blend_epi32(t0, t1, 0x66);
-		lo6_7 = t0;
+		t0 = _mm256_unpacklo_epi32(desc6, desc7);
+		t1 = _mm256_unpacklo_epi32(desc4, desc5);
+		lo_4567 = _mm256_unpacklo_epi64(t1, t0);
 
-		t0 = _mm256_permute2f128_si256(desc4, desc5, 0x20);
-		t1 = _mm256_permute2f128_si256(desc4, desc5, 0x31);
-		t1 = _mm256_shuffle_epi8(t1, dsc_shuf_msk);
-		rxcmp4_5 = _mm256_blend_epi32(t0, t1, 0x66);
-		md1_4567 = _mm256_unpackhi_epi32(t0, lo6_7);
+		t0 = _mm256_unpackhi_epi32(desc6, desc7);
+		t1 = _mm256_unpackhi_epi32(desc4, desc5);
+		hi_4567 = _mm256_unpacklo_epi64(t1, t0);
+		rss_4567 = _mm256_unpackhi_epi64(t1, t0);
 
-		t0 = _mm256_permute2f128_si256(desc2, desc3, 0x20);
-		t1 = _mm256_permute2f128_si256(desc2, desc3, 0x31);
-		t1 = _mm256_shuffle_epi8(t1, dsc_shuf_msk);
-		rxcmp2_3 = _mm256_blend_epi32(t0, t1, 0x66);
-		lo2_3 = t0;
+		t0 = _mm256_unpacklo_epi32(desc2, desc3);
+		t1 = _mm256_unpacklo_epi32(desc0, desc1);
+		lo_0123 = _mm256_unpacklo_epi64(t1, t0);
 
-		t0 = _mm256_permute2f128_si256(desc0, desc1, 0x20);
-		t1 = _mm256_permute2f128_si256(desc0, desc1, 0x31);
-		t1 = _mm256_shuffle_epi8(t1, dsc_shuf_msk);
-		rxcmp0_1 = _mm256_blend_epi32(t0, t1, 0x66);
-		md1_0123 = _mm256_unpackhi_epi32(t0, lo2_3);
-		metadata1 = _mm256_unpacklo_epi64(md1_0123, md1_4567);
+		t0 = _mm256_unpackhi_epi32(desc2, desc3);
+		t1 = _mm256_unpackhi_epi32(desc0, desc1);
+		hi_0123 = _mm256_unpacklo_epi64(t1, t0);
+		rss_0123 = _mm256_unpackhi_epi64(t1, t0);
 
-		/* Extract flags2 from high completion for eight packets */
-		t0 = _mm256_unpacklo_epi32(rxcmp0_1, rxcmp2_3);
-		t1 = _mm256_unpacklo_epi32(rxcmp4_5, rxcmp6_7);
-		flags2 = _mm256_unpackhi_epi64(t0, t1);
-		/* fs mask used for RX_PKT_CMPL_CALC */
-		cs_calc = _mm256_and_si256(flags2, mask_fs);
-		/* Add the meta_format to cs_calc */
-		cs_calc = _mm256_or_si256(cs_calc, _mm256_and_si256(flags2,
-							_mm256_slli_epi32(mask_fs, 4)));
+		errors_v2 = _mm256_permute2f128_si256(hi_0123, hi_4567, 0x31);
+		metadata1 = _mm256_permute2f128_si256(hi_0123, hi_4567, 0x20);
+		flags2 = _mm256_permute2f128_si256(lo_0123, lo_4567, 0x31);
+		flags_type = _mm256_permute2f128_si256(lo_0123, lo_4567, 0x20);
+		rss = _mm256_permute2f128_si256(rss_0123, rss_4567, 0x20);
 
-		/* Extract metadata0 and errors from high completion */
-		t0 = _mm256_unpackhi_epi32(rxcmp0_1, rxcmp2_3);
-		t1 = _mm256_unpackhi_epi32(rxcmp4_5, rxcmp6_7);
-		errors_v2 = _mm256_unpacklo_epi64(t0, t1);
-		/* mask_fs used in place of RX_PKT_CMPL_ERRORS_T_L4_CS_ERROR |
-		 * RX_PKT_CMPL_ERRORS_T_IP_CS_ERROR | RX_PKT_CMPL_ERRORS_L4_CS_ERROR |
-		 * RX_PKT_CMPL_ERRORS_IP_CS_ERROR
-		 */
-		errors_csum_idx = _mm256_and_si256(_mm256_srli_epi32(errors_v2, 4),
-						   mask_fs);
-		meta_format = _mm256_cmpeq_epi32(_mm256_and_si256(cs_calc,
-						 _mm256_slli_epi32(mask_fs, 4)),
-						 _mm256_setzero_si256());
-		cs_valid = _mm256_cmpeq_epi32(_mm256_and_si256(cs_calc, mask_fs),
-					      _mm256_setzero_si256());
-		errors_csum_idx = _mm256_add_epi32(_mm256_andnot_si256(cs_valid, mask_1s),
-						   _mm256_andnot_si256(cs_valid,
-								       errors_csum_idx));
-
-		/*
-		 * Load ol_flags for eight packets using gather. Gather
-		 * operations have extremely high latency (~19 cycles),
-		 * execution and use of result should be separated as much
-		 * as possible.
-		 */
-		ol_flags = _mm256_i32gather_epi32((const int *)errors_to_olflags_v3,
-						  errors_csum_idx, sizeof(uint32_t));
+		len = _mm256_srli_epi32(flags_type, 16);
 
-		/* Extract if the packet is VLAN and the VLAN tci */
-		metadata1 = _mm256_srli_epi32(metadata1, 16);
-		/* mask_1s used in place of RX_PKT_V3_CMPL_METADATA1_VALID */
-		ptype_idx = _mm256_srli_epi32(_mm256_and_si256(metadata1,
-					      _mm256_slli_epi32(mask_1s, 15)),
-					      RX_PKT_V3_CMPL_METADATA1_VALID_SFT -
-					      BNXT_PTYPE_TBL_VLAN_SFT);
+		valid = _mm256_movemask_ps(_mm256_castsi256_ps(_mm256_slli_epi32(errors_v2, 31))) ^
+			valid_mask8;
+		num_valid = rte_popcount32(valid);
 
-		vlan_flags = _mm256_and_si256(metadata1, _mm256_slli_epi32(mask_1s, 15));
-		vlan_flags = _mm256_min_epu32(vlan_flags, mask_1s);
-
-		/*
-		 * VLAN present in mbuf when metadata valid (vlan_flags) and
-		 * meta_format is non-zero in flags2. andnot(cmpeq(tci,0), vlan_flags) is
-		 * (~zero_mask) & vlan_flags.
-		 */
-		t0 = _mm256_andnot_si256(meta_format, vlan_flags);
-		/* RTE_MBUF_F_RX_VLAN + STRIPPED when hardware reports valid VLAN. */
-		vlan_flags = _mm256_or_si256(vlan_flags, _mm256_slli_epi32(t0, 6));
-
-		/* Extract flags_type from low completion for eight packets */
-		t0 = _mm256_unpacklo_epi32(rxcmp0_1, rxcmp2_3);
-		t1 = _mm256_unpacklo_epi32(rxcmp4_5, rxcmp6_7);
-		flags_type = _mm256_unpacklo_epi64(t0, t1);
+		if (num_valid == 0)
+			break;
 
-		/* Compute ptype_idx from flags_type itype field
-		 * mask_fs is used in place of
-		 * RX_PKT_V3_CMPL_FLAGS_ITYPE_MASK
-		 */
-		t0 = _mm256_and_si256(flags_type,
-				      _mm256_slli_epi32(mask_fs, 12));
-		t0 = _mm256_srli_epi32(t0, RX_PKT_V3_CMPL_FLAGS_ITYPE_SFT -
-				       BNXT_PTYPE_TBL_TYPE_SFT);
-		ptype_idx = _mm256_or_si256(ptype_idx, t0);
+		rte_compiler_barrier();
 
-		/* Extract flags2 from low completion for eight packets
-		 * flags2 is re-extracted to save on registers
-		 */
-		t0 = _mm256_unpacklo_epi32(rxcmp0_1, rxcmp2_3);
-		t1 = _mm256_unpacklo_epi32(rxcmp4_5, rxcmp6_7);
-		flags2 = _mm256_unpackhi_epi64(t0, t1);
+		t0 = _mm256_srli_epi32(errors_v2, 4);
+		t0 = _mm256_permutevar8x32_epi32(olflags_v3_v, t0);
 
-		/* mask_fs is being used in place of
-		 * RX_PKT_CMPL_CALC
-		 */
-		cs_calc = _mm256_and_si256(flags2, mask_fs);
-		cs_valid = _mm256_cmpeq_epi32(cs_calc, _mm256_setzero_si256());
-		ol_flags = _mm256_andnot_si256(cs_valid, ol_flags);
+		t1 = _mm256_and_si256(errors_v2,
+				      _mm256_set1_epi32(RX_PKT_CMPL_ERRORS_T_L4_CS_ERROR));
+		t1 = _mm256_slli_epi32(t1, 14);
+		ol_flags = _mm256_sub_epi32(_mm256_set1_epi32(RTE_MBUF_F_RX_OUTER_L4_CKSUM_GOOD),
+					    t1);
+		ol_flags = _mm256_or_si256(ol_flags, t0);
 
-		/* mask_1s is being used in place of
-		 * RX_PKT_V3_CMPL_HI_FLAGS2_IP_TYPE
-		 */
-		t0 = _mm256_srli_epi32(_mm256_and_si256(flags2,
-				       _mm256_slli_epi32(mask_1s, 8)),
-				       RX_PKT_V3_CMPL_FLAGS2_IP_TYPE_SFT -
-				       BNXT_PTYPE_TBL_IP_VER_SFT);
-		ptype_idx = _mm256_or_si256(ptype_idx, t0);
+		/* mask_fs is used in place of RX_PKT_V3_CMPL_FLAGS_ITYPE_MASK */
+		type = _mm256_and_si256(_mm256_srli_epi32(flags_type,
+					RX_PKT_V3_CMPL_FLAGS_ITYPE_SFT), mask_fs);
 
-		/*
-		 * Load ptypes for eight packets using gather. Gather operations
-		 * have extremely high latency (~19 cycles), execution and use
-		 * of result should be separated as much as possible.
-		 */
-		ptypes = _mm256_i32gather_epi32((int *)bnxt_ptype_table,
-						ptype_idx, sizeof(uint32_t));
+		rss_flags = _mm256_and_si256(flags_type,
+					     _mm256_set1_epi32(RX_PKT_V3_CMPL_FLAGS_RSS_VALID));
+		rss_flags = _mm256_srli_epi32(rss_flags, 9);
+		t1 = _mm256_cmpgt_epi32(_mm256_set1_epi32(8), type);
+		type = _mm256_permutevar8x32_epi32(l3_type_v, type);
+
+		/* mask_fs used for RX_PKT_CMPL_CALC */
+		cs_mask = _mm256_and_si256(flags2, mask_fs);
+		cs_mask = _mm256_slli_epi32(cs_mask, 1);
+		cs_mask = _mm256_cmpgt_epi32(cs_mask, mask_1s);
+		ol_flags = _mm256_and_si256(ol_flags, cs_mask);
+		ol_flags = _mm256_or_si256(ol_flags, rss_flags);
 
-		/*
-		 * Pack the 128-bit array of valid descriptor flags into 64
-		 * bits and count the number of set bits in order to determine
-		 * the number of valid descriptors.
-		 * mask_1s is used in place of CMPL_BASE_V
-		 */
-		info3_v = _mm256_and_si256(errors_v2, mask_1s);
-		info3_v = _mm256_xor_si256(info3_v, valid_target);
+		vlan_s_mask = _mm256_and_si256(flags2,
+				_mm256_set1_epi32(RX_PKT_V3_CMPL_HI_FLAGS2_META_FORMAT_MASK));
+		/* mask_1s is used in place of RX_PKT_V3_CMPL_HI_FLAGS2_IP_TYPE */
+		tun_ip6 = _mm256_and_si256(_mm256_srli_epi32(flags2,
+					   RX_PKT_V3_CMPL_FLAGS2_IP_TYPE_SFT), mask_1s);
+		tun = _mm256_and_si256(flags2, _mm256_set1_epi32(BNXT_V3_FLAGS2_TUN_MSK));
+		tun = _mm256_srli_epi32(tun, 1);
+		tun_ip6 = _mm256_or_si256(tun_ip6, tun);
+		tun_ip6 = _mm256_permutevar8x32_epi32(tun_ip6_v, tun_ip6);
+		vlan_mask = _mm256_srai_epi32(metadata1, 31);
+		vlan_tci_len = _mm256_and_si256(vlan_mask, errors_v2);
+		vlan_tci_len = _mm256_blend_epi16(len, vlan_tci_len, 0xaa);
+		vlan_s_mask = _mm256_cmpgt_epi32(vlan_s_mask, mask_1s);
+		ptypes = _mm256_blendv_epi8(_mm256_set1_epi32(RTE_PTYPE_L2_ETHER),
+			_mm256_set1_epi32(RTE_PTYPE_L2_ETHER_VLAN), vlan_mask);
+		vlan_s_mask = _mm256_and_si256(vlan_s_mask,
+					       _mm256_set1_epi32(RTE_MBUF_F_RX_VLAN_STRIPPED));
+		/* mask_1s is used in place of RTE_MBUF_F_RX_VLAN */
+		vlan_flags = _mm256_or_si256(mask_1s, vlan_s_mask);
+		vlan_flags = _mm256_and_si256(vlan_mask, vlan_flags);
+		t0 = _mm256_and_si256(type, tun_ip6);
+		t0 = _mm256_and_si256(t0, t1);
+		ptypes = _mm256_or_si256(t0, ptypes);
+		ol_flags = _mm256_or_si256(ol_flags, vlan_flags);
 
-		info3_v = _mm256_packs_epi32(info3_v, _mm256_setzero_si256());
-		valid = _mm_cvtsi128_si64(_mm256_extracti128_si256(info3_v, 1));
-		valid = (valid << CHAR_BIT) |
-			_mm_cvtsi128_si64(_mm256_castsi256_si128(info3_v));
-		num_valid = rte_popcount64(valid & desc_valid_mask);
+		third_64_0145 = _mm256_unpacklo_epi32(ptypes, len);
+		third_64_2367 = _mm256_unpackhi_epi32(ptypes, len);
 
-		if (num_valid == 0)
-			break;
+		last_64_0145 = _mm256_unpacklo_epi32(vlan_tci_len, rss);
+		last_64_2367 = _mm256_unpackhi_epi32(vlan_tci_len, rss);
 
-		/* Extract flags_type from low completion for eight packets*/
-		t0 = _mm256_unpacklo_epi32(rxcmp0_1, rxcmp2_3);
-		t1 = _mm256_unpacklo_epi32(rxcmp4_5, rxcmp6_7);
-		flags_type = _mm256_unpacklo_epi64(t0, t1);
+		t1 = _mm256_setzero_si256();
+		ol_flags_0145 = _mm256_unpacklo_epi32(ol_flags, t1);
+		ol_flags_2367 = _mm256_unpackhi_epi32(ol_flags, t1);
 
-		mbuf01 = _mm256_shuffle_epi8(rxcmp0_1, shuf_msk);
-		mbuf23 = _mm256_shuffle_epi8(rxcmp2_3, shuf_msk);
-		mbuf45 = _mm256_shuffle_epi8(rxcmp4_5, shuf_msk);
-		mbuf67 = _mm256_shuffle_epi8(rxcmp6_7, shuf_msk);
+		ol_flags_0145 = _mm256_permute2f128_si256(ol_flags_0145,
+							  ol_flags_0145, 0x01);
+		ol_flags_2367 = _mm256_permute2f128_si256(ol_flags_2367,
+							  ol_flags_2367, 0x01);
 
-		mbuf01 = _mm256_blend_epi32(mbuf01, ptypes, 0x11);
-		mbuf23 = _mm256_blend_epi32(mbuf23,
-					_mm256_srli_si256(ptypes, 4), 0x11);
-		mbuf45 = _mm256_blend_epi32(mbuf45,
-					_mm256_srli_si256(ptypes, 8), 0x11);
-		mbuf67 = _mm256_blend_epi32(mbuf67,
-					_mm256_srli_si256(ptypes, 12), 0x11);
+		rearm4 = _mm256_unpacklo_epi64(mbuf_init_v, ol_flags_0145);
+		t1 = _mm256_unpacklo_epi64(third_64_0145, last_64_0145);
+		rearm0 = _mm256_permute2f128_si256(rearm4, t1, 0x21);
+		rearm4 = _mm256_blend_epi32(rearm4, t1, 0xf0);
 
-		rearm0 = _mm256_permute2f128_si256(mbuf_init, mbuf01, 0x20);
-		rearm1 = _mm256_blend_epi32(mbuf_init, mbuf01, 0xF0);
-		rearm2 = _mm256_permute2f128_si256(mbuf_init, mbuf23, 0x20);
-		rearm3 = _mm256_blend_epi32(mbuf_init, mbuf23, 0xF0);
+		rearm5 = _mm256_unpackhi_epi64(mbuf_init_v, ol_flags_0145);
+		t1 = _mm256_unpackhi_epi64(third_64_0145, last_64_0145);
+		rearm1 = _mm256_permute2f128_si256(rearm5, t1, 0x21);
+		rearm5 = _mm256_blend_epi32(rearm5, t1, 0xf0);
 
-		/* Extract RSS valid flags for eight packets
-		 * mask_1s is being used in place of
-		 * RX_PKT_V3_CMPL_FLAGS_RSS_VALID
-		 */
-		rss_flags = _mm256_and_si256(flags_type,
-					     _mm256_slli_epi32(mask_1s, 10));
-		rss_flags = _mm256_srli_epi32(rss_flags, 9);
-		ol_flags = _mm256_or_si256(ol_flags, rss_flags);
-		ol_flags = _mm256_or_si256(ol_flags, vlan_flags);
-		ol_flags_hi = _mm256_permute2f128_si256(ol_flags,
-							ol_flags, 0x11);
+		rearm6 = _mm256_unpacklo_epi64(mbuf_init_v, ol_flags_2367);
+		t1 = _mm256_unpacklo_epi64(third_64_2367, last_64_2367);
+		rearm2 = _mm256_permute2f128_si256(rearm6, t1, 0x21);
+		rearm6 = _mm256_blend_epi32(rearm6, t1, 0xf0);
 
-		rearm0 = _mm256_blend_epi32(rearm0,
-					    _mm256_slli_si256(ol_flags, 8),
-					    0x04);
-		rearm1 = _mm256_blend_epi32(rearm1,
-					    _mm256_slli_si256(ol_flags_hi, 8),
-					    0x04);
-		rearm2 = _mm256_blend_epi32(rearm2,
-					    _mm256_slli_si256(ol_flags, 4),
-					    0x04);
-		rearm3 = _mm256_blend_epi32(rearm3,
-					    _mm256_slli_si256(ol_flags_hi, 4),
-					    0x04);
+		rearm7 = _mm256_unpackhi_epi64(mbuf_init_v, ol_flags_2367);
+		t1 = _mm256_unpackhi_epi64(third_64_2367, last_64_2367);
+		rearm3 = _mm256_permute2f128_si256(rearm7, t1, 0x21);
+		rearm7 = _mm256_blend_epi32(rearm7, t1, 0xf0);
 
 		_mm256_storeu_si256((void *)&rx_pkts[i + 0]->rearm_data,
 				    rearm0);
@@ -1291,21 +1226,6 @@ recv_burst_vec_avx2_v3(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pk
 				    rearm2);
 		_mm256_storeu_si256((void *)&rx_pkts[i + 3]->rearm_data,
 				    rearm3);
-
-		rearm4 = _mm256_permute2f128_si256(mbuf_init, mbuf45, 0x20);
-		rearm5 = _mm256_blend_epi32(mbuf_init, mbuf45, 0xF0);
-		rearm6 = _mm256_permute2f128_si256(mbuf_init, mbuf67, 0x20);
-		rearm7 = _mm256_blend_epi32(mbuf_init, mbuf67, 0xF0);
-
-		rearm4 = _mm256_blend_epi32(rearm4, ol_flags, 0x04);
-		rearm5 = _mm256_blend_epi32(rearm5, ol_flags_hi, 0x04);
-		rearm6 = _mm256_blend_epi32(rearm6,
-					    _mm256_srli_si256(ol_flags, 4),
-					    0x04);
-		rearm7 = _mm256_blend_epi32(rearm7,
-					    _mm256_srli_si256(ol_flags_hi, 4),
-					    0x04);
-
 		_mm256_storeu_si256((void *)&rx_pkts[i + 4]->rearm_data,
 				    rearm4);
 		_mm256_storeu_si256((void *)&rx_pkts[i + 5]->rearm_data,
@@ -1320,14 +1240,6 @@ recv_burst_vec_avx2_v3(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pk
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
 
@@ -1336,20 +1248,68 @@ bnxt_recv_pkts_vec_avx2_v3(void *rx_queue, struct rte_mbuf **rx_pkts,
 			   uint16_t nb_pkts)
 {
 	struct bnxt_rx_queue *rxq = rx_queue;
-	uint32_t expected_burst = (uint16_t)RTE_MAX((uint32_t)rxq->rx_free_thresh,
-						     BNXT_RX_DESCS_PER_LOOP_VEC256);
+	struct bnxt_cp_ring_info *cpr = rxq->cp_ring;
+	struct bnxt_rx_ring_info *rxr = rxq->rx_ring;
+	uint32_t cp_ring_size = cpr->cp_ring_struct->ring_size;
+	uint32_t rx_ring_size = rxr->rx_ring_struct->ring_size;
+	struct cmpl_base *cp_desc_ring = cpr->cp_desc_ring;
+	struct rte_mbuf **rx_buf_ring = rxr->rx_buf_ring;
+	uint32_t chunk = RTE_MAX((uint32_t)rxq->rx_free_thresh,
+				 BNXT_RX_DESCS_PER_LOOP_VEC256);
 	uint16_t cnt = 0;
 
-	while (nb_pkts > expected_burst) {
-		uint16_t burst;
+	if (unlikely(!rxq->rx_started))
+		return 0;
 
-		burst = recv_burst_vec_avx2_v3(rx_queue, rx_pkts + cnt, expected_burst);
+	while (nb_pkts) {
+		uint32_t cons, mbcons, valid_bit, num, num_vec, received = 0;
+
+		if (rxq->rxrearm_nb >= rxq->rx_free_thresh)
+			bnxt_rxq_rearm(rxq, rxr);
+
+		valid_bit = !!(cpr->cp_raw_cons & cp_ring_size);
+		cons = cpr->cp_raw_cons & (cp_ring_size - 1);
+		mbcons = (cpr->cp_raw_cons / 2) & (rx_ring_size - 1);
+
+		/* Never wrap either ring within one pass. */
+		num = RTE_MIN((uint32_t)nb_pkts, chunk);
+		num = RTE_MIN(num, rx_ring_size - mbcons);
+		num = RTE_MIN(num, (cp_ring_size - cons) / 2);
+
+		num_vec = RTE_ALIGN_FLOOR(num, BNXT_RX_DESCS_PER_LOOP_VEC256);
+
+		if (num_vec)
+			received = recv_burst_vec_avx2_v3(rx_pkts + cnt,
+						     num_vec, cons, mbcons,
+						     valid_bit,
+						     rxq->mbuf_initializer,
+						     cp_desc_ring, rx_buf_ring);
+
+		/* Only chase the tail if the vector loops all filled. */
+		if (received == num_vec) {
+			while (received < num &&
+				recv_one_vec_avx2_v3(rx_pkts + cnt + received,
+						     cons + 2 * received, mbcons + received,
+						     valid_bit,
+						     rxq->mbuf_initializer,
+						     cp_desc_ring, rx_buf_ring))
+				received++;
+		}
 
-		cnt += burst;
-		nb_pkts -= burst;
+		if (received == 0)
+			break;
 
-		if (burst < expected_burst)
-			return cnt;
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
-	return cnt + recv_burst_vec_avx2_v3(rx_queue, rx_pkts + cnt, nb_pkts);
+
+	return cnt;
 }
diff --git a/drivers/net/bnxt/bnxt_rxtx_vec_common.h b/drivers/net/bnxt/bnxt_rxtx_vec_common.h
index bca18f936fb..df20e7280cc 100644
--- a/drivers/net/bnxt/bnxt_rxtx_vec_common.h
+++ b/drivers/net/bnxt/bnxt_rxtx_vec_common.h
@@ -216,4 +216,60 @@ static const uint32_t errors_to_olflags_v3[17] = {
 	RTE_MBUF_F_RX_L4_CKSUM_BAD | RTE_MBUF_F_RX_IP_CKSUM_BAD
 };
 
+static const alignas(32) uint32_t olflags_v3_lut[8] = {
+	RTE_MBUF_F_RX_L4_CKSUM_GOOD | RTE_MBUF_F_RX_IP_CKSUM_GOOD,
+	RTE_MBUF_F_RX_IP_CKSUM_BAD | RTE_MBUF_F_RX_L4_CKSUM_GOOD,
+	RTE_MBUF_F_RX_L4_CKSUM_BAD | RTE_MBUF_F_RX_IP_CKSUM_GOOD,
+	RTE_MBUF_F_RX_IP_CKSUM_BAD | RTE_MBUF_F_RX_L4_CKSUM_BAD,
+	RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD | RTE_MBUF_F_RX_L4_CKSUM_GOOD,
+	RTE_MBUF_F_RX_IP_CKSUM_BAD | RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD | RTE_MBUF_F_RX_L4_CKSUM_GOOD,
+	RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD | RTE_MBUF_F_RX_L4_CKSUM_BAD,
+	RTE_MBUF_F_RX_IP_CKSUM_BAD | RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD | RTE_MBUF_F_RX_L4_CKSUM_BAD,
+};
+
+
+/* Split tables to reduce the latency from the old ptypes table look up as most
+ * of the ptypes table isn't needed.
+ * Because the hotpath code does not incur any cost from having all of the
+ * macros ORed together on compile, the tun ip6 table can put in some of the
+ * work needed for the type table as the type table can only have 8 but would
+ * need 16 to factor in tun.
+ */
+#define BNXT_RTE_PTYPE_L3_ALL (RTE_PTYPE_L3_IPV4_EXT_UNKNOWN | RTE_PTYPE_L3_IPV6_EXT_UNKNOWN |	\
+			       RTE_PTYPE_INNER_L3_IPV4_EXT_UNKNOWN |				\
+			       RTE_PTYPE_INNER_L3_IPV6_EXT_UNKNOWN)
+
+static const alignas(32) uint32_t tun_ip6_lut[8] = {
+	RTE_PTYPE_L3_IPV4_EXT_UNKNOWN | RTE_PTYPE_L4_TCP |
+	RTE_PTYPE_L4_UDP | RTE_PTYPE_L4_ICMP, /* !ip6 !tun */
+	RTE_PTYPE_L3_IPV6_EXT_UNKNOWN | RTE_PTYPE_L4_TCP |
+	RTE_PTYPE_L4_UDP | RTE_PTYPE_L4_ICMP, /* ip6 !tun */
+	RTE_PTYPE_INNER_L3_IPV4_EXT_UNKNOWN | RTE_PTYPE_INNER_L4_TCP |
+	RTE_PTYPE_INNER_L4_UDP | RTE_PTYPE_INNER_L4_ICMP, /* !ip6 tun */
+	RTE_PTYPE_INNER_L3_IPV6_EXT_UNKNOWN | RTE_PTYPE_INNER_L4_TCP |
+	RTE_PTYPE_INNER_L4_UDP | RTE_PTYPE_INNER_L4_ICMP, /* ip6 tun */
+	RTE_PTYPE_INNER_L3_IPV4_EXT_UNKNOWN | RTE_PTYPE_INNER_L4_TCP |
+	RTE_PTYPE_INNER_L4_UDP | RTE_PTYPE_INNER_L4_ICMP, /* !ip6 tun */
+	RTE_PTYPE_INNER_L3_IPV6_EXT_UNKNOWN | RTE_PTYPE_INNER_L4_TCP |
+	RTE_PTYPE_INNER_L4_UDP | RTE_PTYPE_INNER_L4_ICMP, /* ip6 tun */
+	RTE_PTYPE_INNER_L3_IPV4_EXT_UNKNOWN | RTE_PTYPE_INNER_L4_TCP |
+	RTE_PTYPE_INNER_L4_UDP | RTE_PTYPE_INNER_L4_ICMP, /* !ip6 tun */
+	RTE_PTYPE_INNER_L3_IPV6_EXT_UNKNOWN | RTE_PTYPE_INNER_L4_TCP |
+	RTE_PTYPE_INNER_L4_UDP | RTE_PTYPE_INNER_L4_ICMP, /* ip6 tun */
+};
+
+static const alignas(32) uint32_t l3_type_lut[8] = {
+	0,
+	BNXT_RTE_PTYPE_L3_ALL, /* RTE_PTYPE_INNER_L4_TCP */
+	BNXT_RTE_PTYPE_L3_ALL |
+	RTE_PTYPE_INNER_L4_TCP | RTE_PTYPE_L4_TCP, /* BNXT_PTYPE_TBL_TYPE_TCP */
+	BNXT_RTE_PTYPE_L3_ALL |
+	RTE_PTYPE_INNER_L4_UDP | RTE_PTYPE_L4_UDP, /* BNXT_PTYPE_TBL_TYPE_UDP */
+	0,
+	0,
+	0,
+	BNXT_RTE_PTYPE_L3_ALL |
+	RTE_PTYPE_INNER_L4_ICMP | RTE_PTYPE_L4_ICMP, /* BNXT_PTYPE_TBL_TYPE_ICMP */
+};
+
 #endif /* _BNXT_RXTX_VEC_COMMON_H_ */
