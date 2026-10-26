Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273E5606A31A
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 19:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=cztVxUXu
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9847840A8A;
	Mon, 26 Oct 2026 20:09:36 +0100 (CET)
Received: from mail-dy1-f226.google.com (mail-dy1-f226.google.com
 [74.125.82.226])
 by mails.dpdk.org (Postfix) with ESMTPS id C53C74069F
 for <dev@dpdk.org>; Mon, 26 Oct 2026 20:09:29 +0100 (CET)
Received: by mail-dy1-f226.google.com with SMTP id
 5a478bee46e88-369f33df08eso3634670eec.0
 for <dev@dpdk.org>; Mon, 26 Oct 2026 12:09:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793041768; x=1793646568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=av46vms2X9T1/tieAqnZGKa2uC0sM5TKdmnK+Sh1xb4=;
 b=cwOXBNWnN+Aoz7O6OsPSz5x39C0NKoBeXZaIL9jtdM2otbzPI+anRNj5z+YObUO6I5
 bWuCcIpCEpMItYAVoWbWUDdT3nWhsho0cm+n+DUEaNDAM6iZgKO6VKipfp7GAnOBkXz6
 JEm4q2E++XXmrRb+TbQMLUBprwoelYTMCXUq2ZIY5BjjqYHHr13TJnia3Hzjigfo1KdK
 JAt3VWhFEOAfgyoY97EZaX+jok+VERJ12bc0vtnYUci3PD20ncAyW0lg6WZzQzYFt+z7
 /m+BtFswkpCNJdSv6vnlRSEcWuqg1x3fwdJ4dMwEMlHqQD5PPFzuWJyVX4ibX8RmFcDM
 oTZg==
X-Gm-Message-State: AFq9FYK2T85dTOuqAuwpMx37J7RUmLapXv+/IruDZ7v43hDHtCTUiTVW
 W1mVi8yrmUizPmqVQ7CfXTpEAPlxvqquN0V5CoS1pRSmmmprYu+GBlAh4LKmCnCYJ0iDy/Q86XQ
 JEFWxDo1RVKLox9c4gU1X8RrHkzqlEWDtwdJiAKzYCdTYtPWUJttR4LxkAM608YNBlWCurV7zq+
 n9xD2gao3MG43hWxn7OUVs+TIpXhEFF3lzz9cwsPaw9kPm0Qwbt3HE8QUTpXVIPvqt7/SNFqy4v
 E28ajLOMXgL
X-Gm-Gg: AYBFou30srFOTefFIn0QNbucIf34bLS5mpt8PQDYfjQQgdA4ENPQnhXm8Sxs06SnTzR
 4S+gIefxeVtX71pM8QV2hMq3K5z4GJaKqdIXedBQDaygID8o4Dw5Ag4kIaeOBpR4hUmkfF3GJ5a
 Z5l+W5N1W8iEAMOvSBOTuvZJVToVIn83wCZA2oFfd55UXYBJVqgdo/HmuVKgCFv3QjpWMIG7v90
 KGpQLRpoX6sc3QC4XsOlzXGa/ZnoUSnc5gj5kuMU3vM42eNqwkDD00puqd+ww3yhI+eE8DlwG3l
 8eE+S+cJZqTQH/rYIHXY/AyGJF8a1x3gMzKHptcVCn9M4e0EgPihJCUcnM4TVJN0a0i4dALpfzs
 Jwu5CKyzLkV+7652hnb3uu9yWgIV5/avpoC+U8m6zB+bUdR3BnDMIoIcbt/28YVeKVkk6k3f56Y
 +N3Ust8KJVDF/KANW8Ycib/mbVMfER12nyKH9TSK9blhBV3W34DA==
X-Received: by 2002:a05:693c:408b:b0:35c:ba31:6fef with SMTP id
 5a478bee46e88-369e86749a5mr13739156eec.36.1793041767803; 
 Mon, 26 Oct 2026 12:09:27 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
 by smtp-relay.gmail.com with ESMTPS id
 5a478bee46e88-369e8f03855sm81016eec.7.2026.10.26.12.09.27
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 26 Oct 2026 12:09:27 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-36637676140so5481148eec.0
 for <dev@dpdk.org>; Mon, 26 Oct 2026 12:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1793041766; x=1793646566; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=av46vms2X9T1/tieAqnZGKa2uC0sM5TKdmnK+Sh1xb4=;
 b=cztVxUXu/DgxCiYucJBBGHODv2Ji8cryso6mq69epBL7Jk+rXe0OF1UdcbR/301ID/
 gdfnxnRe8x67cpcAFhrniySPkBQ4Pz71eLHi2Usujle3jznMdkfAOYF3eOuGO3HRnOr/
 tS+zDlAEEypXv9QoNST4v3XLS5DrWwedj1s1Q=
X-Received: by 2002:a05:693c:240d:b0:369:ffa5:1fab with SMTP id
 5a478bee46e88-369ffa524acmr5583393eec.22.1793041765453; 
 Mon, 26 Oct 2026 12:09:25 -0700 (PDT)
X-Received: by 2002:a05:693c:240d:b0:369:ffa5:1fab with SMTP id
 5a478bee46e88-369ffa524acmr5583356eec.22.1793041764440; 
 Mon, 26 Oct 2026 12:09:24 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369e8db7b23sm37103906eec.19.2026.10.26.12.09.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 12:09:23 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com, kishore.padmanabha@broadcom.com,
 Keegan Freyhof <keegan.freyhof@broadcom.com>, stable@dpdk.org,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH v2 6/7] net/bnxt: modify AVX2 CRX path to prevent OOB accesses
Date: Mon, 26 Oct 2026 13:12:50 -0600
Message-ID: <20261026191251.1274062-7-Mohammad-Shuab.Siddique@broadcom.com>
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

The AVX2 Rx burst function for the compressed completion format always
loads eight completions and stores eight mbuf pointers per loop
iteration. When the request was shorter than eight, or the end of the
completion ring left fewer than eight entries, the extra descriptors
were only masked off after being read, so the loop could read past
the end of the completion ring and write past the end of the
caller's array.

Run the vector loop only for whole groups of eight that stay inside
both rings, and receive the remaining packets one completion at a
time with a scalar helper, crx_one_vec_avx2(). A call no longer wraps
either ring.

A request for fewer than eight packets is now served instead of
returning none.

The checksum, VLAN, RSS and packet type fields of a compressed
completion are now decoded with lookup tables (crx_csum_012_lut,
crx_csum_345_lut, crx_csum_67x_lut and crx_pkt_t_inner_lut) that are
shared by the vector loop and the scalar helper, so the packets
received by the scalar tail get the same flags as the ones received
by the vector loop. These tables replace the rxr->ol_flags_table,
ol_flags_err_table and bnxt_ptype_table lookups the vector loop used
before.

Fixes: d58c6c077cc2 ("net/bnxt: add AVX2 Rx for compressed CQE")
Cc: stable@dpdk.org

Signed-off-by: Keegan Freyhof <keegan.freyhof@broadcom.com>
Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
 drivers/net/bnxt/bnxt_rxtx_vec_avx2.c   | 514 ++++++++++++------------
 drivers/net/bnxt/bnxt_rxtx_vec_common.h |  93 +++++
 2 files changed, 358 insertions(+), 249 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_rxtx_vec_avx2.c b/drivers/net/bnxt/bnxt_rxtx_vec_avx2.c
index 39de9aa09cd..3f0de7bd5fb 100644
--- a/drivers/net/bnxt/bnxt_rxtx_vec_avx2.c
+++ b/drivers/net/bnxt/bnxt_rxtx_vec_avx2.c
@@ -424,101 +424,195 @@ recv_burst_vec_avx2(struct bnxt_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 	return nb_rx_pkts;
 }
 
-static uint16_t
-crx_burst_vec_avx2(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
+uint16_t
+bnxt_recv_pkts_vec_avx2(void *rx_queue, struct rte_mbuf **rx_pkts,
+			 uint16_t nb_pkts)
 {
 	struct bnxt_rx_queue *rxq = rx_queue;
-	const __m256i mbuf_init =
-		_mm256_set_epi64x(0, 0, 0, rxq->mbuf_initializer);
+	uint16_t brst = (uint16_t)RTE_MAX((uint32_t)rxq->rx_free_thresh,
+					   BNXT_RX_DESCS_PER_LOOP_VEC256);
 	struct bnxt_cp_ring_info *cpr = rxq->cp_ring;
 	struct bnxt_rx_ring_info *rxr = rxq->rx_ring;
 	uint32_t cp_ring_size = cpr->cp_ring_struct->ring_size;
 	uint32_t rx_ring_size = rxr->rx_ring_struct->ring_size;
 	struct cmpl_base *cp_desc_ring = cpr->cp_desc_ring;
-	uint64_t valid, desc_valid_mask = ~0ULL;
-	const __m256i info3_v_mask = _mm256_set1_epi32(CMPL_BASE_V);
-	uint32_t raw_cons = cpr->cp_raw_cons;
-	uint32_t cons, mbcons;
-	int nb_rx_pkts = 0;
-	int i;
-	const __m256i valid_target =
-		_mm256_set1_epi32(!!(raw_cons & cp_ring_size));
-	const __m256i shuf_msk =
-		_mm256_set_epi8(15, 14, 13, 12,          /* rss */
-				7, 6,                    /* vlan_tci */
-				3, 2,                    /* data_len */
-				0xFF, 0xFF, 3, 2,        /* pkt_len */
-				0xFF, 0xFF, 0xFF, 0xFF,  /* pkt_type (zeroes) */
-				15, 14, 13, 12,          /* rss */
-				7, 6,                    /* vlan_tci */
-				3, 2,                    /* data_len */
-				0xFF, 0xFF, 3, 2,        /* pkt_len */
-				0xFF, 0xFF, 0xFF, 0xFF); /* pkt_type (zeroes) */
-	const __m256i flags_type_mask =
-		_mm256_set1_epi32(RX_PKT_COMPRESS_CMPL_FLAGS_ITYPE_MASK);
-	const __m256i flags2_mask1 =
-		_mm256_set1_epi32(CMPL_FLAGS2_VLAN_TUN_MSK_CRX);
-	const __m256i flags2_mask2 =
-		_mm256_set1_epi32(RX_PKT_COMPRESS_CMPL_FLAGS_IP_TYPE);
-	const __m256i rss_mask =
-		_mm256_set1_epi32(RX_PKT_COMPRESS_CMPL_FLAGS_RSS_VALID);
-	__m256i t0, t1, flags_type, flags2, index, errors;
-	__m256i ptype_idx, ptypes, is_tunnel;
-	__m256i mbuf01, mbuf23, mbuf45, mbuf67;
-	__m256i rearm0, rearm1, rearm2, rearm3, rearm4, rearm5, rearm6, rearm7;
-	__m256i ol_flags, ol_flags_hi;
-	__m256i rss_flags;
-	__m256i errors_v2;
-	__m256i cs_err_v2;
-
-	/* Validate ptype table indexing at build time. */
-	bnxt_check_ptype_constants();
+	struct rte_mbuf **rx_buf_ring = rxr->rx_buf_ring;
+	uint16_t cnt = 0;
 
-	/* If Rx Q was stopped return */
 	if (unlikely(!rxq->rx_started))
 		return 0;
 
-	if (rxq->rxrearm_nb >= rxq->rx_free_thresh)
-		bnxt_rxq_rearm(rxq, rxr);
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
 
-	nb_pkts = RTE_ALIGN_FLOOR(nb_pkts, BNXT_RX_DESCS_PER_LOOP_VEC256);
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
 
-	cons = raw_cons & (cp_ring_size - 1);
-	mbcons = raw_cons & (rx_ring_size - 1);
+		if (received == 0)
+			break;
 
-	/* Return immediately if there is not at least one completed packet. */
-	if (!bnxt_cpr_cmp_valid(&cp_desc_ring[cons], raw_cons, cp_ring_size))
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
+	}
+
+	return cnt;
+}
+
+static uint16_t
+crx_one_vec_avx2(struct rte_mbuf **rx_pkts,
+		 uint32_t cons, uint32_t mbcons, uint32_t valid_bit,
+		 uint64_t mbuf_init, struct cmpl_base *cp_desc_ring,
+		 struct rte_mbuf **rx_buf_ring)
+{
+	struct rx_pkt_compress_cmpl *rxcmp = (struct rx_pkt_compress_cmpl *)&cp_desc_ring[cons];
+	uint64_t hi, rss = 0, vlan_tci, pkt_type, ol_flags = RTE_MBUF_F_RX_IP_CKSUM_UNKNOWN;
+	uint32_t cs_error_calc, csum_67x, itype, ptype_inner, ip_type;
+	uint32_t flags_type;
+	uint16_t error_v1, tunnel;
+	struct rte_mbuf *mbuf;
+	uint64_t *rearm;
+
+	error_v1 = rxcmp->metadata1_cs_error_calc_v1;
+
+	if (!((error_v1 & CMPL_BASE_V) ^ valid_bit))
 		return 0;
 
-	/* Ensure that we do not go past the ends of the rings. */
-	nb_pkts = RTE_MIN(nb_pkts, RTE_MIN(rx_ring_size - mbcons,
-					   cp_ring_size - cons));
-	/*
-	 * If we are at the end of the ring, ensure that descriptors after the
-	 * last valid entry are not treated as valid. Otherwise, force the
-	 * maximum number of packets to receive to be a multiple of the per-
-	 * loop count.
-	 */
-	if (nb_pkts < BNXT_RX_DESCS_PER_LOOP_VEC256) {
-		desc_valid_mask >>=
-			CHAR_BIT * (BNXT_RX_DESCS_PER_LOOP_VEC256 - nb_pkts);
+	rte_compiler_barrier();
+
+	mbuf = rx_buf_ring[mbcons];
+	RTE_ASSERT(mbuf != NULL);
+	rx_pkts[0] = mbuf;
+	rearm = (uint64_t *)&mbuf->rearm_data[0];
+
+	cs_error_calc = (uint32_t)(error_v1 >> 4) & 0xff;
+	csum_67x = crx_csum_67x_lut[(cs_error_calc >> 6) & 7];
+	ol_flags |= crx_csum_012_lut[cs_error_calc & 7] &
+		    crx_csum_345_lut[(cs_error_calc >> 3) & 7] &
+		    csum_67x;
+	tunnel = (uint16_t)(csum_67x >> 31);
+
+	if (error_v1 & RX_PKT_COMPRESS_CMPL_METADATA1_VALID) {
+		vlan_tci = rxcmp->vlanc_tcid;
+		pkt_type = RTE_PTYPE_L2_ETHER_VLAN;
+		ol_flags |= RTE_MBUF_F_RX_VLAN | RTE_MBUF_F_RX_VLAN_STRIPPED;
 	} else {
-		nb_pkts =
-			RTE_ALIGN_FLOOR(nb_pkts, BNXT_RX_DESCS_PER_LOOP_VEC256);
+		vlan_tci = 0;
+		pkt_type = RTE_PTYPE_L2_ETHER;
 	}
+	flags_type = rxcmp->flags_type;
+
+	if (flags_type & RX_PKT_COMPRESS_CMPL_FLAGS_RSS_VALID) {
+		rss = rxcmp->rss_hash;
+		ol_flags |= RTE_MBUF_F_RX_RSS_HASH;
+	}
+
+	itype = (flags_type >> 12) & 0xf;
+	ptype_inner = (itype < 8) ? crx_pkt_t_inner_lut[itype] : 0;
+	ip_type = ((flags_type & RX_PKT_COMPRESS_CMPL_FLAGS_IP_TYPE) ?
+			RTE_MBUF_INDETERMINATE_INNER_OUTER_IPV6 :
+			RTE_MBUF_INDETERMINATE_INNER_OUTER_IPV4) |
+		  RTE_MBUF_INDETERMINATE_INNER_OUTER_TCP |
+		  RTE_MBUF_INDETERMINATE_INNER_OUTER_UDP |
+		  RTE_MBUF_INDETERMINATE_INNER_OUTER_ICMP;
+
+	pkt_type |= ptype_inner & ip_type &
+		    (tunnel ? RTE_MBUF_INNER_ALL : RTE_MBUF_OUTER_ALL);
+
+	mbuf->next = NULL;
+	hi = rxcmp->len;
+	pkt_type |= hi << 32;
+	hi |= vlan_tci << 16;
+	hi |= rss << 32;
+	rearm[0] = mbuf_init;
+	rearm[1] = ol_flags;
+	rearm[2] = pkt_type;
+	rearm[3] = hi;
+	return 1;
+}
+
+static uint16_t
+crx_burst_vec_avx2(struct rte_mbuf **rx_pkts,
+		    uint16_t nb_pkts, uint32_t cons, uint32_t mbcons, uint32_t valid_bit,
+		    uint64_t mbuf_init, struct cmpl_base *cp_desc_ring,
+		    struct rte_mbuf **rx_buf_ring)
+{
+	const __m256i mask_1s =
+		_mm256_set1_epi32(0x1);
+	const __m256i mask_fs =
+		_mm256_set1_epi32(0xf);
+	const __m256i mbuf_init_v =
+		_mm256_set1_epi64x(mbuf_init);
+	const __m256i crx_csum_012_lut_v =
+		_mm256_load_si256((const __m256i *)crx_csum_012_lut);
+	const __m256i crx_csum_345_lut_v =
+		_mm256_load_si256((const __m256i *)crx_csum_345_lut);
+	const __m256i crx_csum_67x_lut_v =
+		_mm256_load_si256((const __m256i *)crx_csum_67x_lut);
+	const __m256i crx_pkt_t_inner_lut_v =
+		_mm256_load_si256((const __m256i *)crx_pkt_t_inner_lut);
+
+	const uint32_t valid_mask8 = valid_bit ? 0xffu : 0u;
+	int nb_rx_pkts = 0, i;
+	uint32_t valid;
 
-	/* Handle RX burst request */
 	for (i = 0; i < nb_pkts; i += BNXT_RX_DESCS_PER_LOOP_VEC256,
 				  cons += BNXT_RX_DESCS_PER_LOOP_VEC256,
 				  mbcons += BNXT_RX_DESCS_PER_LOOP_VEC256) {
-		__m256i rxcmp0_1, rxcmp2_3, rxcmp4_5, rxcmp6_7, info3_v;
+		__m256i rearm0, rearm1, rearm2, rearm3, rearm4, rearm5, rearm6, rearm7;
+		__m256i third_64_6475, third_64_2031, last_64_6475, last_64_2031;
+		__m256i ol_flags, ol_flags_2031, ol_flags_6475;
+		__m256i rxcmp0_1, rxcmp2_3, rxcmp4_5, rxcmp6_7;
+		__m256i error_v1, flags_type, cs_error_calc;
+		__m256i ptypes, pkt_type, pkt_type_inner;
+		__m256i itype, ip_type, itype_mask;
+		__m256i tunnel_mask, t0, t1;
+		__m256i vlan_mask, vlan_tci;
+		__m256i vlan_tci_len, len;
+		__m256i rss_mask, rss;
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
 
@@ -527,147 +621,120 @@ crx_burst_vec_avx2(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 		 * registers. Loads are issued in reverse order in order to
 		 * ensure consistent state.
 		 */
-		rxcmp6_7 = _mm256_loadu_si256((void *)&cp_desc_ring[cons + 6]);
+		rxcmp6_7 = _mm256_lddqu_si256((void *)&cp_desc_ring[cons + 6]);
 		rte_compiler_barrier();
-		rxcmp4_5 = _mm256_loadu_si256((void *)&cp_desc_ring[cons + 4]);
+		rxcmp4_5 = _mm256_lddqu_si256((void *)&cp_desc_ring[cons + 4]);
 		rte_compiler_barrier();
-		rxcmp2_3 = _mm256_loadu_si256((void *)&cp_desc_ring[cons + 2]);
+		rxcmp2_3 = _mm256_lddqu_si256((void *)&cp_desc_ring[cons + 2]);
 		rte_compiler_barrier();
-		rxcmp0_1 = _mm256_loadu_si256((void *)&cp_desc_ring[cons + 0]);
+		rxcmp0_1 = _mm256_lddqu_si256((void *)&cp_desc_ring[cons + 0]);
 		rte_compiler_barrier();
 
-		/* Compute packet type table indices for eight packets. */
-		t0 = _mm256_unpacklo_epi32(rxcmp0_1, rxcmp2_3);
-		t1 = _mm256_unpacklo_epi32(rxcmp4_5, rxcmp6_7);
+		/*64207531*/
+		t0 = _mm256_unpacklo_epi32(rxcmp6_7, rxcmp4_5);
+		t1 = _mm256_unpacklo_epi32(rxcmp2_3, rxcmp0_1);
 		flags_type = _mm256_unpacklo_epi64(t0, t1);
-		ptype_idx = _mm256_and_si256(flags_type, flags_type_mask);
-		ptype_idx = _mm256_srli_epi32(ptype_idx,
-					      RX_PKT_COMPRESS_CMPL_FLAGS_ITYPE_SFT -
-					      BNXT_PTYPE_TBL_TYPE_SFT);
-
-		t0 = _mm256_unpackhi_epi32(rxcmp0_1, rxcmp2_3);
-		t1 = _mm256_unpackhi_epi32(rxcmp4_5, rxcmp6_7);
-		cs_err_v2 = _mm256_unpacklo_epi64(t0, t1);
-
-		t0 = _mm256_srli_epi32(_mm256_and_si256(cs_err_v2, flags2_mask1),
-				       RX_PKT_COMPRESS_CMPL_METADATA1_SFT -
-				       BNXT_PTYPE_TBL_VLAN_SFT);
-		ptype_idx = _mm256_or_si256(ptype_idx, t0);
-
-		t0 = _mm256_srli_epi32(_mm256_and_si256(cs_err_v2, flags2_mask2),
-				       RX_PKT_CMPL_FLAGS2_IP_TYPE_SFT -
-				       BNXT_PTYPE_TBL_IP_VER_SFT);
-		ptype_idx = _mm256_or_si256(ptype_idx, t0);
-
-		/*
-		 * Load ptypes for eight packets using gather. Gather operations
-		 * have extremely high latency (~19 cycles), execution and use
-		 * of result should be separated as much as possible.
-		 */
-		ptypes = _mm256_i32gather_epi32((int *)bnxt_ptype_table,
-						ptype_idx, sizeof(uint32_t));
-		/*
-		 * Compute ol_flags and checksum error table indices for eight
-		 * packets.
-		 */
-		is_tunnel = _mm256_and_si256(cs_err_v2,
-					     _mm256_set1_epi32(BNXT_CRX_TUN_CS_CALC));
-		is_tunnel = _mm256_slli_epi32(is_tunnel, 3);
-
-		flags2 = _mm256_and_si256(cs_err_v2,
-					  _mm256_set1_epi32(BNXT_CRX_CQE_CSUM_CALC_MASK));
-		flags2 = _mm256_srli_epi64(flags2, 8);
-
-		/* Extract errors_v2 fields for eight packets. */
-		t0 = _mm256_unpackhi_epi32(rxcmp0_1, rxcmp2_3);
-		t1 = _mm256_unpackhi_epi32(rxcmp4_5, rxcmp6_7);
-		errors_v2 = _mm256_unpacklo_epi64(t0, t1);
-
-		/* Compute errors out of cs_err_v2 to index into flags table. */
-		errors = _mm256_and_si256(cs_err_v2, _mm256_set1_epi32(0xF0));
-		errors = _mm256_srli_epi32(errors, 4);
-		errors = _mm256_and_si256(errors, flags2);
+		rss = _mm256_unpackhi_epi64(t0, t1);
 
-		index = _mm256_andnot_si256(errors, flags2);
-		errors = _mm256_or_si256(errors,
-					 _mm256_srli_epi32(is_tunnel, 1));
-		index = _mm256_or_si256(index, is_tunnel);
-
-		/*
-		 * Load ol_flags for eight packets using gather. Gather
-		 * operations have extremely high latency (~19 cycles),
-		 * execution and use of result should be separated as much
-		 * as possible.
-		 */
-		ol_flags = _mm256_i32gather_epi32((int *)rxr->ol_flags_table,
-						  index, sizeof(uint32_t));
-		errors = _mm256_i32gather_epi32((int *)rxr->ol_flags_err_table,
-						errors, sizeof(uint32_t));
+		t0 = _mm256_unpackhi_epi32(rxcmp6_7, rxcmp4_5);
+		t1 = _mm256_unpackhi_epi32(rxcmp2_3, rxcmp0_1);
+		error_v1 = _mm256_unpacklo_epi64(t0, t1);
 
+		valid = _mm256_movemask_ps(_mm256_castsi256_ps(_mm256_slli_epi32(error_v1, 31))) ^
+			valid_mask8;
 		/*
-		 * Pack the 128-bit array of valid descriptor flags into 64
-		 * bits and count the number of set bits in order to determine
-		 * the number of valid descriptors.
+		 * Popcount is permutation invariant and mid sequence invalid
+		 * completions are not expected.
 		 */
-		const __m256i perm_msk =
-				_mm256_set_epi32(7, 3, 6, 2, 5, 1, 4, 0);
-		info3_v = _mm256_permutevar8x32_epi32(errors_v2, perm_msk);
-		info3_v = _mm256_and_si256(errors_v2, info3_v_mask);
-		info3_v = _mm256_xor_si256(info3_v, valid_target);
-
-		info3_v = _mm256_packs_epi32(info3_v, _mm256_setzero_si256());
-		valid = _mm_cvtsi128_si64(_mm256_extracti128_si256(info3_v, 1));
-		valid = (valid << CHAR_BIT) |
-			_mm_cvtsi128_si64(_mm256_castsi256_si128(info3_v));
-		num_valid = rte_popcount64(valid & desc_valid_mask);
+		num_valid = rte_popcount32(valid);
 
 		if (num_valid == 0)
 			break;
 
-		/* Update mbuf rearm_data for eight packets. */
-		mbuf01 = _mm256_shuffle_epi8(rxcmp0_1, shuf_msk);
-		mbuf23 = _mm256_shuffle_epi8(rxcmp2_3, shuf_msk);
-		mbuf45 = _mm256_shuffle_epi8(rxcmp4_5, shuf_msk);
-		mbuf67 = _mm256_shuffle_epi8(rxcmp6_7, shuf_msk);
+		cs_error_calc = _mm256_srli_epi32(error_v1, 4);
+		t0 = _mm256_permutevar8x32_epi32(crx_csum_012_lut_v, cs_error_calc);
+		cs_error_calc = _mm256_srli_epi32(cs_error_calc, 3);
+		t1 = _mm256_permutevar8x32_epi32(crx_csum_345_lut_v, cs_error_calc);
+		cs_error_calc = _mm256_srli_epi32(cs_error_calc, 3);
+		t1 = _mm256_and_si256(t0, t1);
+		t0 = _mm256_permutevar8x32_epi32(crx_csum_67x_lut_v, cs_error_calc);
+		ol_flags = _mm256_and_si256(t0, t1);
+
+		tunnel_mask = _mm256_srai_epi32(t0, 31);
+		t0 = _mm256_andnot_si256(tunnel_mask, _mm256_set1_epi32(RTE_MBUF_OUTER_ALL));
+		t1 = _mm256_and_si256(tunnel_mask, _mm256_set1_epi32(RTE_MBUF_INNER_ALL));
+		tunnel_mask = _mm256_or_si256(t0, t1);
+
+		vlan_mask = _mm256_srli_epi32(error_v1, 15);
+		vlan_mask = _mm256_and_si256(vlan_mask, mask_1s);
+		vlan_mask = _mm256_cmpeq_epi32(vlan_mask, mask_1s);
+		vlan_tci = _mm256_and_si256(error_v1, vlan_mask);
+		t0 = _mm256_andnot_si256(vlan_mask, _mm256_set1_epi32(RTE_PTYPE_L2_ETHER));
+		t1 = _mm256_and_si256(vlan_mask, _mm256_set1_epi32(RTE_PTYPE_L2_ETHER_VLAN));
+		pkt_type = _mm256_or_si256(t0, t1);
+		t1 = _mm256_and_si256(vlan_mask,
+			_mm256_set1_epi32(RTE_MBUF_F_RX_VLAN | RTE_MBUF_F_RX_VLAN_STRIPPED));
+		ol_flags = _mm256_or_si256(ol_flags, t1);
+
+		rss_mask = _mm256_srli_epi32(flags_type, 10);
+		rss_mask = _mm256_and_si256(rss_mask, mask_1s);
+		t0 = _mm256_slli_epi32(rss_mask, 1);
+		ol_flags = _mm256_or_si256(ol_flags, t0);
+		rss_mask = _mm256_cmpeq_epi32(rss_mask, mask_1s);
+		rss = _mm256_and_si256(rss, rss_mask);
+
+		itype = _mm256_srli_epi32(flags_type, 12);
+		itype = _mm256_and_si256(itype, mask_fs);
+		itype_mask = _mm256_cmpgt_epi32(_mm256_set1_epi32(8), itype);
+		itype = _mm256_permutevar8x32_epi32(crx_pkt_t_inner_lut_v, itype);
+		ip_type = _mm256_and_si256(flags_type,
+				_mm256_set1_epi32(RX_PKT_COMPRESS_CMPL_FLAGS_IP_TYPE));
+		ip_type = _mm256_cmpgt_epi32(ip_type, mask_1s);
+		t0 = _mm256_andnot_si256(ip_type,
+				_mm256_set1_epi32(RTE_MBUF_INDETERMINATE_INNER_OUTER_IPV4));
+		t1 = _mm256_and_si256(ip_type,
+				_mm256_set1_epi32(RTE_MBUF_INDETERMINATE_INNER_OUTER_IPV6));
+		ip_type = _mm256_or_si256(t0, t1);
+		ip_type = _mm256_or_si256(ip_type,
+			      _mm256_set1_epi32(RTE_MBUF_INDETERMINATE_INNER_OUTER_TCP |
+				RTE_MBUF_INDETERMINATE_INNER_OUTER_UDP |
+				RTE_MBUF_INDETERMINATE_INNER_OUTER_ICMP));
+		itype = _mm256_and_si256(itype, itype_mask);
+		pkt_type_inner = _mm256_and_si256(itype, ip_type);
+		pkt_type_inner = _mm256_and_si256(pkt_type_inner, tunnel_mask);
+		ptypes = _mm256_or_si256(pkt_type, pkt_type_inner);
 
-		/* Blend in ptype field for two mbufs at a time. */
-		mbuf01 = _mm256_blend_epi32(mbuf01, ptypes, 0x11);
-		mbuf23 = _mm256_blend_epi32(mbuf23,
-					_mm256_srli_si256(ptypes, 4), 0x11);
-		mbuf45 = _mm256_blend_epi32(mbuf45,
-					_mm256_srli_si256(ptypes, 8), 0x11);
-		mbuf67 = _mm256_blend_epi32(mbuf67,
-					_mm256_srli_si256(ptypes, 12), 0x11);
+		len = _mm256_srli_epi32(flags_type, 16);
+		vlan_tci_len = _mm256_blend_epi16(len, vlan_tci, 0xaa);
 
-		/* Unpack rearm data, set fixed fields for first four mbufs. */
-		rearm0 = _mm256_permute2f128_si256(mbuf_init, mbuf01, 0x20);
-		rearm1 = _mm256_blend_epi32(mbuf_init, mbuf01, 0xF0);
-		rearm2 = _mm256_permute2f128_si256(mbuf_init, mbuf23, 0x20);
-		rearm3 = _mm256_blend_epi32(mbuf_init, mbuf23, 0xF0);
+		third_64_6475 = _mm256_unpacklo_epi32(ptypes, len);
+		third_64_2031 = _mm256_unpackhi_epi32(ptypes, len);
 
-		/* Compute final ol_flags values for eight packets. */
-		rss_flags = _mm256_and_si256(flags_type, rss_mask);
-		rss_flags = _mm256_srli_epi32(rss_flags, 9);
-		ol_flags = _mm256_or_si256(ol_flags, errors);
-		ol_flags = _mm256_or_si256(ol_flags, rss_flags);
-		ol_flags_hi = _mm256_permute2f128_si256(ol_flags,
-							ol_flags, 0x11);
+		last_64_6475 = _mm256_unpacklo_epi32(vlan_tci_len, rss);
+		last_64_2031 = _mm256_unpackhi_epi32(vlan_tci_len, rss);
 
-		/* Set ol_flags fields for first four packets. */
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
+		t1 = _mm256_setzero_si256();
+		ol_flags_6475 = _mm256_unpacklo_epi32(ol_flags, t1);
+		ol_flags_2031 = _mm256_unpackhi_epi32(ol_flags, t1);
+
+		rearm0 = _mm256_unpackhi_epi64(mbuf_init_v, ol_flags_2031);
+		rearm4 = _mm256_unpackhi_epi64(mbuf_init_v, ol_flags_6475);
+		t0 = _mm256_unpackhi_epi64(third_64_6475, last_64_6475);
+		t1 = _mm256_unpackhi_epi64(third_64_2031, last_64_2031);
+		rearm1 = _mm256_permute2f128_si256(rearm0, t1, 0x31);
+		rearm0 = _mm256_permute2f128_si256(rearm0, t1, 0x20);
+		rearm5 = _mm256_permute2f128_si256(rearm4, t0, 0x31);
+		rearm4 = _mm256_permute2f128_si256(rearm4, t0, 0x20);
+
+		rearm2 = _mm256_unpacklo_epi64(mbuf_init_v, ol_flags_2031);
+		rearm6 = _mm256_unpacklo_epi64(mbuf_init_v, ol_flags_6475);
+		t0 = _mm256_unpacklo_epi64(third_64_6475, last_64_6475);
+		t1 = _mm256_unpacklo_epi64(third_64_2031, last_64_2031);
+		rearm3 = _mm256_permute2f128_si256(rearm2, t1, 0x31);
+		rearm2 = _mm256_permute2f128_si256(rearm2, t1, 0x20);
+		rearm7 = _mm256_permute2f128_si256(rearm6, t0, 0x31);
+		rearm6 = _mm256_permute2f128_si256(rearm6, t0, 0x20);
 
-		/* Store all mbuf fields for first four packets. */
 		_mm256_storeu_si256((void *)&rx_pkts[i + 0]->rearm_data,
 				    rearm0);
 		_mm256_storeu_si256((void *)&rx_pkts[i + 1]->rearm_data,
@@ -676,24 +743,6 @@ crx_burst_vec_avx2(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 				    rearm2);
 		_mm256_storeu_si256((void *)&rx_pkts[i + 3]->rearm_data,
 				    rearm3);
-
-		/* Unpack rearm data, set fixed fields for final four mbufs. */
-		rearm4 = _mm256_permute2f128_si256(mbuf_init, mbuf45, 0x20);
-		rearm5 = _mm256_blend_epi32(mbuf_init, mbuf45, 0xF0);
-		rearm6 = _mm256_permute2f128_si256(mbuf_init, mbuf67, 0x20);
-		rearm7 = _mm256_blend_epi32(mbuf_init, mbuf67, 0xF0);
-
-		/* Set ol_flags fields for final four packets. */
-		rearm4 = _mm256_blend_epi32(rearm4, ol_flags, 0x04);
-		rearm5 = _mm256_blend_epi32(rearm5, ol_flags_hi, 0x04);
-		rearm6 = _mm256_blend_epi32(rearm6,
-					    _mm256_srli_si256(ol_flags, 4),
-					    0x04);
-		rearm7 = _mm256_blend_epi32(rearm7,
-					    _mm256_srli_si256(ol_flags_hi, 4),
-					    0x04);
-
-		/* Store all mbuf fields for final four packets. */
 		_mm256_storeu_si256((void *)&rx_pkts[i + 4]->rearm_data,
 				    rearm4);
 		_mm256_storeu_si256((void *)&rx_pkts[i + 5]->rearm_data,
@@ -708,21 +757,12 @@ crx_burst_vec_avx2(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 			break;
 	}
 
-	if (nb_rx_pkts) {
-		rxr->rx_raw_prod = RING_ADV(rxr->rx_raw_prod, nb_rx_pkts);
-
-		rxq->rxrearm_nb += nb_rx_pkts;
-		cpr->cp_raw_cons += nb_rx_pkts;
-		bnxt_db_cq(cpr);
-	}
-
 	return nb_rx_pkts;
 }
 
-
 uint16_t
-bnxt_recv_pkts_vec_avx2(void *rx_queue, struct rte_mbuf **rx_pkts,
-			 uint16_t nb_pkts)
+bnxt_crx_pkts_vec_avx2(void *rx_queue, struct rte_mbuf **rx_pkts,
+		       uint16_t nb_pkts)
 {
 	struct bnxt_rx_queue *rxq = rx_queue;
 	uint16_t brst = (uint16_t)RTE_MAX((uint32_t)rxq->rx_free_thresh,
@@ -746,17 +786,17 @@ bnxt_recv_pkts_vec_avx2(void *rx_queue, struct rte_mbuf **rx_pkts,
 
 		valid_bit = !!(cpr->cp_raw_cons & cp_ring_size);
 		cons = cpr->cp_raw_cons & (cp_ring_size - 1);
-		mbcons = (cpr->cp_raw_cons / 2) & (rx_ring_size - 1);
+		mbcons = (cpr->cp_raw_cons) & (rx_ring_size - 1);
 
 		/* Never wrap either ring within one pass. */
 		num = RTE_MIN((uint32_t)nb_pkts, brst);
 		num = RTE_MIN(num, rx_ring_size - mbcons);
-		num = RTE_MIN(num, (cp_ring_size - cons) / 2);
+		num = RTE_MIN(num, (cp_ring_size - cons));
 
 		num_vec = RTE_ALIGN_FLOOR(num, BNXT_RX_DESCS_PER_LOOP_VEC256);
 
 		if (num_vec)
-			received = recv_burst_vec_avx2(rxq, rx_pkts + cnt,
+			received = crx_burst_vec_avx2(rx_pkts + cnt,
 						     num_vec, cons, mbcons,
 						     valid_bit,
 						     rxq->mbuf_initializer,
@@ -765,8 +805,8 @@ bnxt_recv_pkts_vec_avx2(void *rx_queue, struct rte_mbuf **rx_pkts,
 		/* Only chase the tail if the vector loops all filled. */
 		if (received == num_vec) {
 			while (received < num &&
-				recv_one_vec_avx2(rxq, rx_pkts + cnt + received,
-						     cons + 2 * received, mbcons + received,
+				crx_one_vec_avx2(rx_pkts + cnt + received,
+						     cons + received, mbcons + received,
 						     valid_bit,
 						     rxq->mbuf_initializer,
 						     cp_desc_ring, rx_buf_ring))
@@ -778,7 +818,7 @@ bnxt_recv_pkts_vec_avx2(void *rx_queue, struct rte_mbuf **rx_pkts,
 
 		rxr->rx_raw_prod = RING_ADV(rxr->rx_raw_prod, received);
 		rxq->rxrearm_nb += received;
-		cpr->cp_raw_cons += 2 * received;
+		cpr->cp_raw_cons += received;
 		bnxt_db_cq(cpr);
 
 		cnt += received;
@@ -787,33 +827,9 @@ bnxt_recv_pkts_vec_avx2(void *rx_queue, struct rte_mbuf **rx_pkts,
 		if (received < num)
 			break;
 	}
-
 	return cnt;
 }
 
-uint16_t
-bnxt_crx_pkts_vec_avx2(void *rx_queue, struct rte_mbuf **rx_pkts,
-		       uint16_t nb_pkts)
-{
-	struct bnxt_rx_queue *rxq = rx_queue;
-	uint16_t brst = (uint16_t)RTE_MAX((uint32_t)rxq->rx_free_thresh,
-					   BNXT_RX_DESCS_PER_LOOP_VEC256);
-	uint16_t cnt = 0;
-
-	while (nb_pkts > brst) {
-		uint16_t burst;
-
-		burst = crx_burst_vec_avx2(rx_queue, rx_pkts + cnt, brst);
-
-		cnt += burst;
-		nb_pkts -= burst;
-
-		if (burst < brst)
-			return cnt;
-	}
-	return cnt + crx_burst_vec_avx2(rx_queue, rx_pkts + cnt, nb_pkts);
-}
-
 static void
 bnxt_handle_tx_cp_vec(struct bnxt_tx_queue *txq)
 {
diff --git a/drivers/net/bnxt/bnxt_rxtx_vec_common.h b/drivers/net/bnxt/bnxt_rxtx_vec_common.h
index 3a095682d12..37aa9fb8546 100644
--- a/drivers/net/bnxt/bnxt_rxtx_vec_common.h
+++ b/drivers/net/bnxt/bnxt_rxtx_vec_common.h
@@ -180,6 +180,99 @@ bnxt_tx_cmp_vec(struct bnxt_tx_queue *txq, uint32_t nr_pkts)
 	txr->tx_raw_cons = raw_cons;
 }
 
+#define RTE_MBUF_INDETERMINATE_IP	\
+	(RTE_MBUF_F_RX_IP_CKSUM_GOOD | RTE_MBUF_F_RX_IP_CKSUM_BAD)
+#define RTE_MBUF_INDETERMINATE_L4	\
+	(RTE_MBUF_F_RX_L4_CKSUM_GOOD | RTE_MBUF_F_RX_L4_CKSUM_BAD)
+#define RTE_MBUF_INDETERMINATE_OUTER_L4	\
+	(RTE_MBUF_F_RX_OUTER_L4_CKSUM_GOOD | RTE_MBUF_F_RX_OUTER_L4_CKSUM_BAD)
+
+static const alignas(32) uint32_t crx_csum_012_lut[8] = {
+	RTE_MBUF_INDETERMINATE_OUTER_L4 | RTE_MBUF_F_RX_IP_CKSUM_GOOD |
+	RTE_MBUF_F_RX_L4_CKSUM_GOOD,
+	RTE_MBUF_INDETERMINATE_OUTER_L4 | RTE_MBUF_F_RX_IP_CKSUM_BAD |
+	RTE_MBUF_F_RX_L4_CKSUM_GOOD | RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD,
+	RTE_MBUF_INDETERMINATE_OUTER_L4 | RTE_MBUF_F_RX_IP_CKSUM_GOOD |
+	RTE_MBUF_F_RX_L4_CKSUM_BAD,
+	RTE_MBUF_INDETERMINATE_OUTER_L4 | RTE_MBUF_F_RX_IP_CKSUM_BAD |
+	RTE_MBUF_F_RX_L4_CKSUM_BAD | RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD,
+	RTE_MBUF_INDETERMINATE_OUTER_L4 | RTE_MBUF_F_RX_IP_CKSUM_GOOD |
+	RTE_MBUF_F_RX_L4_CKSUM_GOOD,
+	RTE_MBUF_INDETERMINATE_OUTER_L4 | RTE_MBUF_F_RX_IP_CKSUM_BAD |
+	RTE_MBUF_F_RX_L4_CKSUM_GOOD | RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD,
+	RTE_MBUF_INDETERMINATE_OUTER_L4 | RTE_MBUF_F_RX_IP_CKSUM_GOOD |
+	RTE_MBUF_F_RX_L4_CKSUM_BAD,
+	RTE_MBUF_INDETERMINATE_OUTER_L4 | RTE_MBUF_F_RX_IP_CKSUM_BAD |
+	RTE_MBUF_F_RX_L4_CKSUM_BAD | RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD
+};
+
+static const alignas(32) uint32_t crx_csum_345_lut[8] = {
+	RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD | RTE_MBUF_F_RX_OUTER_L4_CKSUM_GOOD,
+	RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD | RTE_MBUF_F_RX_OUTER_L4_CKSUM_BAD,
+	RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD | RTE_MBUF_F_RX_OUTER_L4_CKSUM_GOOD |
+	RTE_MBUF_INDETERMINATE_IP,
+	RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD | RTE_MBUF_F_RX_OUTER_L4_CKSUM_BAD |
+	RTE_MBUF_INDETERMINATE_IP,
+	RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD | RTE_MBUF_F_RX_OUTER_L4_CKSUM_GOOD |
+	RTE_MBUF_INDETERMINATE_L4,
+	RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD | RTE_MBUF_F_RX_OUTER_L4_CKSUM_BAD |
+	RTE_MBUF_INDETERMINATE_L4,
+	RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD | RTE_MBUF_F_RX_OUTER_L4_CKSUM_GOOD |
+	RTE_MBUF_INDETERMINATE_IP | RTE_MBUF_INDETERMINATE_L4,
+	RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD | RTE_MBUF_F_RX_OUTER_L4_CKSUM_BAD |
+	RTE_MBUF_INDETERMINATE_IP | RTE_MBUF_INDETERMINATE_L4
+};
+
+/* Note that this LUT also defines tunnel or not. */
+#define BNXT_TUNNEL (0x1u << 31)
+
+static const alignas(32) uint32_t crx_csum_67x_lut[8] = {
+	RTE_MBUF_INDETERMINATE_IP | RTE_MBUF_INDETERMINATE_L4,
+	RTE_MBUF_INDETERMINATE_IP | RTE_MBUF_INDETERMINATE_L4 |
+	RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD | BNXT_TUNNEL,
+	RTE_MBUF_INDETERMINATE_IP | RTE_MBUF_INDETERMINATE_L4 |
+	RTE_MBUF_INDETERMINATE_OUTER_L4 | BNXT_TUNNEL,
+	RTE_MBUF_INDETERMINATE_IP | RTE_MBUF_INDETERMINATE_L4 |
+	RTE_MBUF_INDETERMINATE_OUTER_L4 | RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD | BNXT_TUNNEL,
+	RTE_MBUF_INDETERMINATE_IP | RTE_MBUF_INDETERMINATE_L4,
+	RTE_MBUF_INDETERMINATE_IP | RTE_MBUF_INDETERMINATE_L4 |
+	RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD | BNXT_TUNNEL,
+	RTE_MBUF_INDETERMINATE_IP | RTE_MBUF_INDETERMINATE_L4 |
+	RTE_MBUF_INDETERMINATE_OUTER_L4 | BNXT_TUNNEL,
+	RTE_MBUF_INDETERMINATE_IP | RTE_MBUF_INDETERMINATE_L4 |
+	RTE_MBUF_INDETERMINATE_OUTER_L4 | RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD | BNXT_TUNNEL,
+};
+
+#define RTE_MBUF_INNER_ALL (RTE_PTYPE_INNER_L4_TCP | RTE_PTYPE_INNER_L4_UDP |	\
+		RTE_PTYPE_INNER_L4_ICMP | RTE_PTYPE_INNER_L3_IPV4_EXT_UNKNOWN |	\
+		RTE_PTYPE_INNER_L3_IPV6_EXT_UNKNOWN)
+#define RTE_MBUF_OUTER_ALL (RTE_PTYPE_L4_TCP | RTE_PTYPE_L4_UDP |	\
+		RTE_PTYPE_L4_ICMP | RTE_PTYPE_L3_IPV4_EXT_UNKNOWN |	\
+		RTE_PTYPE_L3_IPV6_EXT_UNKNOWN)
+#define RTE_MBUF_INDETERMINATE_INNER_OUTER_TCP	\
+	(RTE_PTYPE_L4_TCP | RTE_PTYPE_INNER_L4_TCP)
+#define RTE_MBUF_INDETERMINATE_INNER_OUTER_UDP	\
+	(RTE_PTYPE_L4_UDP | RTE_PTYPE_INNER_L4_UDP)
+#define RTE_MBUF_INDETERMINATE_INNER_OUTER_ICMP	\
+	(RTE_PTYPE_L4_ICMP | RTE_PTYPE_INNER_L4_ICMP)
+#define RTE_MBUF_INDETERMINATE_INNER_OUTER_IPV4	\
+	(RTE_PTYPE_L3_IPV4_EXT_UNKNOWN | RTE_PTYPE_INNER_L3_IPV4_EXT_UNKNOWN)
+#define RTE_MBUF_INDETERMINATE_INNER_OUTER_IPV6	\
+	(RTE_PTYPE_L3_IPV6_EXT_UNKNOWN | RTE_PTYPE_INNER_L3_IPV6_EXT_UNKNOWN)
+#define RTE_MBUF_INDETERMINATE_L3		\
+	(RTE_MBUF_INDETERMINATE_INNER_OUTER_IPV4 | RTE_MBUF_INDETERMINATE_INNER_OUTER_IPV6)
+
+static const alignas(32) uint32_t crx_pkt_t_inner_lut[8] = {
+	0,
+	RTE_MBUF_INDETERMINATE_L3,
+	RTE_MBUF_INDETERMINATE_L3 | RTE_MBUF_INDETERMINATE_INNER_OUTER_TCP,
+	RTE_MBUF_INDETERMINATE_L3 | RTE_MBUF_INDETERMINATE_INNER_OUTER_UDP,
+	0,
+	0,
+	0,
+	RTE_MBUF_INDETERMINATE_L3 | RTE_MBUF_INDETERMINATE_INNER_OUTER_ICMP
+};
+
 static const uint32_t errors_to_olflags_v3[17] = {
 	RTE_MBUF_F_RX_IP_CKSUM_UNKNOWN,
 	RTE_MBUF_F_RX_OUTER_L4_CKSUM_GOOD | RTE_MBUF_F_RX_L4_CKSUM_GOOD |
