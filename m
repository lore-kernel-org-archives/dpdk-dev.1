Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA22CD37AC
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 May 2026 09:18:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 94BC64066F;
	Mon, 11 May 2026 11:17:59 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id E80FC40662
 for <dev@dpdk.org>; Mon, 11 May 2026 11:17:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778491077; x=1810027077;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+s4RFQL5xGZsl5i14PMWJ6hHIe3IUOPoO5JAB0zK3do=;
 b=cXmhdKLMo+gzjSEmMc/zZpHFD++dxQ2zwQ3SvS1esaDr4ot09CDdu1nw
 OnRZg4GZxTudLuVRpWYwV8+YszK1O8V0/y7f0YvyJdoC3ssulOMlqttzV
 2mUL4ZWqHmgDCwiub7mCq4u1jtqlArbklxG5ZuejeBc1y7kG5bi+7XVnm
 OOwLxQmoNOcpustMBowqNhH2p0SlvyYyrw9ftCjPMQh5LCr/8C9zMnqbE
 6/C0N+7GvpBVE9WRYYVXFf00Y4wxCNZcRtaRmuaQ0DBTBcAMuvdTHJqj9
 BzVUjNn56/Uxh6twny8tVVsOY2wWo6h9nvIlN1LxzT6DxT1STNZ0kq/On Q==;
X-CSE-ConnectionGUID: +BpTuFHyTpKQsdlpJYLGGQ==
X-CSE-MsgGUID: Uupqw6s5SYKMrAyHRZ8oaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="96937079"
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; d="scan'208";a="96937079"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 May 2026 02:17:56 -0700
X-CSE-ConnectionGUID: qyCQisXZSR+2v6nlcL+kcA==
X-CSE-MsgGUID: FN2NSzPyR/2TEGQfl5ou6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; d="scan'208";a="234739694"
Received: from unknown (HELO sprmax15..) ([10.138.182.128])
 by fmviesa008.fm.intel.com with ESMTP; 11 May 2026 02:17:55 -0700
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com
Cc: aman.deep.singh@intel.com
Subject: [PATCH 5/6] net/idpf: fix split queue AVX2 Tx buffer size shift
Date: Mon, 11 May 2026 14:39:34 +0530
Message-ID: <20260511090935.2288837-6-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260511090935.2288837-1-shaiq.wani@intel.com>
References: <20260511090935.2288837-1-shaiq.wani@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The flex scheduled Tx descriptor (DTYPE 0x0C) used in split queue mode
places the buffer size at bits 48-63 of QW1, requiring a left-shift
of 48.  The code incorrectly used IDPF_TXD_QW1_TX_BUF_SZ_S (34),
which is the shift for base Tx descriptors (DTYPE 0x0) used in single
queue mode.

This caused the data_len to be placed in the wrong bit position,
resulting in hardware reading an incorrect buffer size of zero.

Define IDPF_TXD_FLEX_QW1_TX_BUF_SZ_S (48) for the flex descriptor
layout and use it in both vtx1 and vtx_avx2, consistent with the
AVX512 split queue Tx path.

Fixes: 57560a92167a ("net/idpf: add AVX2 Tx path for split queue config")
Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
---
 drivers/net/intel/idpf/idpf_common_rxtx_avx2.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
index e66dcc7a14..7c547b5f09 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
@@ -819,6 +819,8 @@ idpf_splitq_scan_cq_ring(struct ci_tx_queue *cq)
 	cq->tx_tail = cq_qid;
 }
 
+#define IDPF_TXD_FLEX_QW1_TX_BUF_SZ_S  48
+
 static __rte_always_inline void
 idpf_splitq_vtx1_avx2(struct idpf_flex_tx_sched_desc *txdp,
 				struct rte_mbuf *pkt, uint64_t flags)
@@ -826,7 +828,7 @@ idpf_splitq_vtx1_avx2(struct idpf_flex_tx_sched_desc *txdp,
 	uint64_t high_qw =
 		IDPF_TX_DESC_DTYPE_FLEX_FLOW_SCHE |
 		((uint64_t)flags) |
-		((uint64_t)pkt->data_len << IDPF_TXD_QW1_TX_BUF_SZ_S);
+		((uint64_t)pkt->data_len << IDPF_TXD_FLEX_QW1_TX_BUF_SZ_S);
 
 	__m128i descriptor = _mm_set_epi64x(high_qw,
 						pkt->buf_iova + pkt->data_off);
@@ -848,13 +850,13 @@ idpf_splitq_vtx_avx2(struct idpf_flex_tx_sched_desc *txdp,
 	for (; nb_pkts >= IDPF_VPMD_DESCS_PER_LOOP; txdp += IDPF_VPMD_DESCS_PER_LOOP,
 			pkt += IDPF_VPMD_DESCS_PER_LOOP, nb_pkts -= IDPF_VPMD_DESCS_PER_LOOP) {
 		uint64_t hi_qw0 = hi_qw_tmpl |
-			((uint64_t)pkt[0]->data_len << IDPF_TXD_QW1_TX_BUF_SZ_S);
+			((uint64_t)pkt[0]->data_len << IDPF_TXD_FLEX_QW1_TX_BUF_SZ_S);
 		uint64_t hi_qw1 = hi_qw_tmpl |
-			((uint64_t)pkt[1]->data_len << IDPF_TXD_QW1_TX_BUF_SZ_S);
+			((uint64_t)pkt[1]->data_len << IDPF_TXD_FLEX_QW1_TX_BUF_SZ_S);
 		uint64_t hi_qw2 = hi_qw_tmpl |
-			((uint64_t)pkt[2]->data_len << IDPF_TXD_QW1_TX_BUF_SZ_S);
+			((uint64_t)pkt[2]->data_len << IDPF_TXD_FLEX_QW1_TX_BUF_SZ_S);
 		uint64_t hi_qw3 = hi_qw_tmpl |
-			((uint64_t)pkt[3]->data_len << IDPF_TXD_QW1_TX_BUF_SZ_S);
+			((uint64_t)pkt[3]->data_len << IDPF_TXD_FLEX_QW1_TX_BUF_SZ_S);
 
 		__m256i desc0_1 = _mm256_set_epi64x(hi_qw1,
 			pkt[1]->buf_iova + pkt[1]->data_off,
-- 
2.34.1

