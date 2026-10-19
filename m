Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031E7606C152
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 15:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ANSzyaHx
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 54DFE40609;
	Mon, 19 Oct 2026 17:53:43 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 2043540298
 for <dev@dpdk.org>; Mon, 19 Oct 2026 17:53:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792425222; x=1823961222;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=OMemWHg22UE6ov/T4CejWImMsEuf48t5QKQz2c6UWZY=;
 b=ANSzyaHxUaRAURfiJjnabOC+pvulPB4pZpIw4gL+jbRVj+mkSLLnXpJV
 SB4wc0c06LMbxHIMqBBlN1aQWZNvxTzlE0q7SWg5jPbFkb7nN9Eddy0eZ
 cIBVFl0gt5uLQNvCdsdLrrvrR845LRSzqflwY3Ao4+zRI4Fj6BmEW5zSs
 XZgF4CYNcNrYxwiwkU6r/G1fbM7sMDcXP6UWEY3sbDl87mYhGl7p9B4lS
 Yi2s+pvhvnStPPNSpHl7+LHI7CCi7YDduPTwz75VOTGWWOApSYjw8LtDW
 8h2ZWnz9YhPNATt+h884UqBE4z5wd396la45bIGoYy+/WPR5PRFsEl/FJ g==;
X-CSE-ConnectionGUID: mdLy/pi8QwKlfDN+2hbQbg==
X-CSE-MsgGUID: DUbfhshGQuSAP8/5LmYpgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1096263"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1096263"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2026 08:53:41 -0700
X-CSE-ConnectionGUID: 9XfBA2nJQRuwcMk4qVYKdw==
X-CSE-MsgGUID: oMA7ezdFS3eIPfhopcInlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2574459"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa004.fm.intel.com with ESMTP; 19 Oct 2026 08:53:39 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: anurag.mandal@intel.com
Cc: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2] net/i40e: add IEEE1588 handling to AVX vector paths
Date: Mon, 19 Oct 2026 16:53:01 +0100
Message-ID: <20261019155300.755825-2-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009053449.843546-1-anurag.mandal@intel.com>
References: <20261009053449.843546-1-anurag.mandal@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The IEEE1588 timesync support was only supported on the scalar RX paths,
but is, in a number of ways, quite similar to how FDIR support works: we
read and process values from the various per-packet flags and then do a
single store to the mbuf. Add support for IEEE1588 to the AVX2 and
AVX-512 vector functions inline in the main descriptor processing loop,
as well as the appropriate one-line fix for the case of scattered
packets.

Suggested-by: Anurag Mandal <anurag.mandal@intel.com>
Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/common/rx.h                 |  3 +
 drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c   | 59 ++++++++++++++++++
 drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c | 61 +++++++++++++++++++
 drivers/net/intel/i40e/i40e_rxtx_vec_common.h | 12 ++--
 4 files changed, 131 insertions(+), 4 deletions(-)

diff --git a/drivers/net/intel/common/rx.h b/drivers/net/intel/common/rx.h
index e0bf520ebd..8f4454d477 100644
--- a/drivers/net/intel/common/rx.h
+++ b/drivers/net/intel/common/rx.h
@@ -167,6 +167,9 @@ ci_rx_reassemble_packets(struct rte_mbuf **rx_bufs, uint16_t nb_bufs, uint8_t *s
 				start->hash = end->hash;
 				start->vlan_tci = end->vlan_tci;
 				start->ol_flags = end->ol_flags;
+#ifdef RTE_LIBRTE_IEEE1588
+				start->timesync = end->timesync;
+#endif
 				/* we need to strip crc for the whole packet */
 				start->pkt_len -= crc_len;
 				if (end->data_len > crc_len) {
diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c b/drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c
index dd06e258ad..652a915db2 100644
--- a/drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c
+++ b/drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c
@@ -494,6 +494,65 @@ _recv_raw_pkts_vec_avx2(struct ci_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 
 		} /* if() on FDIR enabled */
 
+#ifdef RTE_LIBRTE_IEEE1588
+		/* The TSYNVALID and TSYNINDX bits are already present in
+		 * status0_7, so the PTP timestamp flags can be built with
+		 * no extra descriptor reads, the same way the RSS/FDIR flags
+		 * are above. Only the 2-bit timestamp register index has to
+		 * land in a specific mbuf field, so it still needs a
+		 * per-packet store, done the same way as the FDIR ID above.
+		 */
+		const __m256i tsyn_valid_mask = _mm256_set1_epi32(
+				1 << I40E_RXD_QW1_STATUS_TSYNVALID_SHIFT);
+		const __m256i tsyn_valid = _mm256_cmpeq_epi32(
+				_mm256_and_si256(status0_7, tsyn_valid_mask),
+				tsyn_valid_mask);
+		const __m256i tmst_flags = _mm256_and_si256(tsyn_valid,
+				_mm256_set1_epi32(RTE_MBUF_F_RX_IEEE1588_TMST));
+		mbuf_flags = _mm256_or_si256(mbuf_flags, tmst_flags);
+
+		/* zero the index unless TSYNVALID is set, to match the
+		 * scalar driver, which only ever assigns tsyn & 0x03
+		 */
+		const __m256i tsyn_indx = _mm256_and_si256(tsyn_valid,
+				_mm256_srli_epi32(_mm256_and_si256(status0_7,
+					_mm256_set1_epi32(0x3 << I40E_RXD_QW1_STATUS_TSYNINDX_SHIFT)),
+					I40E_RXD_QW1_STATUS_TSYNINDX_SHIFT));
+
+		/* status0_7 packet order is (hi->lo): [1, 3, 5, 7, 0, 2, 4, 6] */
+		rx_pkts[i + 1]->timesync = _mm256_extract_epi32(tsyn_indx, 7);
+		rx_pkts[i + 3]->timesync = _mm256_extract_epi32(tsyn_indx, 6);
+		rx_pkts[i + 5]->timesync = _mm256_extract_epi32(tsyn_indx, 5);
+		rx_pkts[i + 7]->timesync = _mm256_extract_epi32(tsyn_indx, 4);
+		rx_pkts[i + 0]->timesync = _mm256_extract_epi32(tsyn_indx, 3);
+		rx_pkts[i + 2]->timesync = _mm256_extract_epi32(tsyn_indx, 2);
+		rx_pkts[i + 4]->timesync = _mm256_extract_epi32(tsyn_indx, 1);
+		rx_pkts[i + 6]->timesync = _mm256_extract_epi32(tsyn_indx, 0);
+
+		/* the PTP flag only depends on packet_type, which was already
+		 * looked up above for each packet, so again no extra reads
+		 * are needed to build it
+		 */
+		const __m256i ptp_flags = _mm256_set_epi32(
+			(ptype_tbl[ptype1] & RTE_PTYPE_L2_MASK) == RTE_PTYPE_L2_ETHER_TIMESYNC ?
+				RTE_MBUF_F_RX_IEEE1588_PTP : 0,
+			(ptype_tbl[ptype3] & RTE_PTYPE_L2_MASK) == RTE_PTYPE_L2_ETHER_TIMESYNC ?
+				RTE_MBUF_F_RX_IEEE1588_PTP : 0,
+			(ptype_tbl[ptype5] & RTE_PTYPE_L2_MASK) == RTE_PTYPE_L2_ETHER_TIMESYNC ?
+				RTE_MBUF_F_RX_IEEE1588_PTP : 0,
+			(ptype_tbl[ptype7] & RTE_PTYPE_L2_MASK) == RTE_PTYPE_L2_ETHER_TIMESYNC ?
+				RTE_MBUF_F_RX_IEEE1588_PTP : 0,
+			(ptype_tbl[ptype0] & RTE_PTYPE_L2_MASK) == RTE_PTYPE_L2_ETHER_TIMESYNC ?
+				RTE_MBUF_F_RX_IEEE1588_PTP : 0,
+			(ptype_tbl[ptype2] & RTE_PTYPE_L2_MASK) == RTE_PTYPE_L2_ETHER_TIMESYNC ?
+				RTE_MBUF_F_RX_IEEE1588_PTP : 0,
+			(ptype_tbl[ptype4] & RTE_PTYPE_L2_MASK) == RTE_PTYPE_L2_ETHER_TIMESYNC ?
+				RTE_MBUF_F_RX_IEEE1588_PTP : 0,
+			(ptype_tbl[ptype6] & RTE_PTYPE_L2_MASK) == RTE_PTYPE_L2_ETHER_TIMESYNC ?
+				RTE_MBUF_F_RX_IEEE1588_PTP : 0);
+		mbuf_flags = _mm256_or_si256(mbuf_flags, ptp_flags);
+#endif /* RTE_LIBRTE_IEEE1588 */
+
 		/*
 		 * At this point, we have the 8 sets of flags in the low 16-bits
 		 * of each 32-bit value in vlan0.
diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c b/drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c
index ea2e6dc024..f96e965914 100644
--- a/drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c
+++ b/drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c
@@ -543,6 +543,67 @@ _recv_raw_pkts_vec_avx512(struct ci_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 
 		} /* if() on FDIR enabled */
 
+#ifdef RTE_LIBRTE_IEEE1588
+		/* The TSYNVALID and TSYNINDX bits are already present in
+		 * status0_7, so the PTP timestamp flags can be built with
+		 * no extra descriptor reads, the same way the RSS/FDIR flags
+		 * are above. Only the 2-bit timestamp register index has to
+		 * land in a specific mbuf field, so it still needs a
+		 * per-packet store, done the same way as the FDIR ID above.
+		 */
+		const __m256i tsyn_valid_mask = _mm256_set1_epi32(
+				1 << I40E_RXD_QW1_STATUS_TSYNVALID_SHIFT);
+		const __m256i tsyn_valid = _mm256_cmpeq_epi32(
+				_mm256_and_si256(status0_7, tsyn_valid_mask),
+				tsyn_valid_mask);
+		const __m256i tmst_flags = _mm256_and_si256(tsyn_valid,
+				_mm256_set1_epi32(RTE_MBUF_F_RX_IEEE1588_TMST));
+
+		mbuf_flags = _mm256_or_si256(mbuf_flags, tmst_flags);
+
+		/* zero the index unless TSYNVALID is set, to match the
+		 * scalar driver, which only ever assigns tsyn & 0x03
+		 */
+		const __m256i tsyn_indx = _mm256_and_si256(tsyn_valid,
+				_mm256_srli_epi32(_mm256_and_si256(status0_7,
+					_mm256_set1_epi32(0x3 << I40E_RXD_QW1_STATUS_TSYNINDX_SHIFT)),
+					I40E_RXD_QW1_STATUS_TSYNINDX_SHIFT));
+
+		/* status0_7 packet order is (hi->lo): [1, 3, 5, 7, 0, 2, 4, 6] */
+		rx_pkts[i + 1]->timesync = _mm256_extract_epi32(tsyn_indx, 7);
+		rx_pkts[i + 3]->timesync = _mm256_extract_epi32(tsyn_indx, 6);
+		rx_pkts[i + 5]->timesync = _mm256_extract_epi32(tsyn_indx, 5);
+		rx_pkts[i + 7]->timesync = _mm256_extract_epi32(tsyn_indx, 4);
+		rx_pkts[i + 0]->timesync = _mm256_extract_epi32(tsyn_indx, 3);
+		rx_pkts[i + 2]->timesync = _mm256_extract_epi32(tsyn_indx, 2);
+		rx_pkts[i + 4]->timesync = _mm256_extract_epi32(tsyn_indx, 1);
+		rx_pkts[i + 6]->timesync = _mm256_extract_epi32(tsyn_indx, 0);
+
+		/* the PTP flag only depends on packet_type, which was already
+		 * looked up above for each packet, so again no extra reads
+		 * are needed to build it
+		 */
+		const __m256i ptp_flags = _mm256_set_epi32(
+			(ptype_tbl[ptype1] & RTE_PTYPE_L2_MASK) == RTE_PTYPE_L2_ETHER_TIMESYNC ?
+				RTE_MBUF_F_RX_IEEE1588_PTP : 0,
+			(ptype_tbl[ptype3] & RTE_PTYPE_L2_MASK) == RTE_PTYPE_L2_ETHER_TIMESYNC ?
+				RTE_MBUF_F_RX_IEEE1588_PTP : 0,
+			(ptype_tbl[ptype5] & RTE_PTYPE_L2_MASK) == RTE_PTYPE_L2_ETHER_TIMESYNC ?
+				RTE_MBUF_F_RX_IEEE1588_PTP : 0,
+			(ptype_tbl[ptype7] & RTE_PTYPE_L2_MASK) == RTE_PTYPE_L2_ETHER_TIMESYNC ?
+				RTE_MBUF_F_RX_IEEE1588_PTP : 0,
+			(ptype_tbl[ptype0] & RTE_PTYPE_L2_MASK) == RTE_PTYPE_L2_ETHER_TIMESYNC ?
+				RTE_MBUF_F_RX_IEEE1588_PTP : 0,
+			(ptype_tbl[ptype2] & RTE_PTYPE_L2_MASK) == RTE_PTYPE_L2_ETHER_TIMESYNC ?
+				RTE_MBUF_F_RX_IEEE1588_PTP : 0,
+			(ptype_tbl[ptype4] & RTE_PTYPE_L2_MASK) == RTE_PTYPE_L2_ETHER_TIMESYNC ?
+				RTE_MBUF_F_RX_IEEE1588_PTP : 0,
+			(ptype_tbl[ptype6] & RTE_PTYPE_L2_MASK) == RTE_PTYPE_L2_ETHER_TIMESYNC ?
+				RTE_MBUF_F_RX_IEEE1588_PTP : 0);
+
+		mbuf_flags = _mm256_or_si256(mbuf_flags, ptp_flags);
+#endif /* RTE_LIBRTE_IEEE1588 */
+
 		/* At this point, we have the 8 sets of flags in the low 16-bits
 		 * of each 32-bit value in vlan0.
 		 * We want to extract these, and merge them with the mbuf init data
diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_common.h b/drivers/net/intel/i40e/i40e_rxtx_vec_common.h
index 292a39501e..521e206438 100644
--- a/drivers/net/intel/i40e/i40e_rxtx_vec_common.h
+++ b/drivers/net/intel/i40e/i40e_rxtx_vec_common.h
@@ -53,7 +53,14 @@ _i40e_rx_queue_release_mbufs_vec(struct ci_rx_queue *rxq)
 static inline int
 i40e_rx_vec_dev_conf_condition_check_default(struct rte_eth_dev *dev)
 {
-#ifndef RTE_LIBRTE_IEEE1588
+#if defined(RTE_LIBRTE_IEEE1588) && !defined(RTE_ARCH_X86)
+	/* Only the AVX2/AVX512 Rx paths propagate the IEEE1588 PTP flags and
+	 * the hardware timestamp register index, so other architectures
+	 * still have to fall back to the scalar Rx path.
+	 */
+	RTE_SET_USED(dev);
+	return -1;
+#else
 	/**
 	 * Vector mode is allowed only when number of Rx queue
 	 * descriptor is power of 2.
@@ -67,9 +74,6 @@ i40e_rx_vec_dev_conf_condition_check_default(struct rte_eth_dev *dev)
 	}
 
 	return 0;
-#else
-	RTE_SET_USED(dev);
-	return -1;
 #endif
 }
 
-- 
2.53.0

