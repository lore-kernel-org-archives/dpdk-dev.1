Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C581CD37B5
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 May 2026 09:17:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8741740615;
	Mon, 11 May 2026 11:17:53 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 70389402BC
 for <dev@dpdk.org>; Mon, 11 May 2026 11:17:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778491072; x=1810027072;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=TfMUpjs5A/0J50oV0mgQJuOVh07z3Ginr8buOYT0Qvg=;
 b=SpSiWZo7WGPIrV/t7UvBlXJGCfGjQ2fUSFvG7aaQj+W64GBtSaRNvB57
 aflMMzdqQbeh9N7wjgvRIJ+rblKqevJahKRNUAsL/Wyg7Yhp3rk59tPuO
 abXl+b5VJH7xnzVyU3Y74OJ0AqeI/iOa/ac4T7+sZCEilfDYUtF3axGyb
 uhoz0M2KEw0g3Kqi4RRAZYtm1nz65+bagmnnU2cQG5h2WYRY2FX3f69wi
 j+5WFGCCqwfyANsQQBJyJ3ZT0TfyFD6K1Qu89lCED9ImcnTvANCXvvqca
 14lOHCnTorKl1kPNOB3GALkSuyV2YzUIbQRosadtKkHXaudCJociHiqSu Q==;
X-CSE-ConnectionGUID: 2mfTEd3VSoqYgmZhl2ghBw==
X-CSE-MsgGUID: Y2cF/EvqT2ypDD+LyWFh3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="96937050"
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; d="scan'208";a="96937050"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 May 2026 02:17:51 -0700
X-CSE-ConnectionGUID: ILCRlNdhTqG1TCd/60FH8w==
X-CSE-MsgGUID: JQhYMoFiQvWsmNwtypNWAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; d="scan'208";a="234739676"
Received: from unknown (HELO sprmax15..) ([10.138.182.128])
 by fmviesa008.fm.intel.com with ESMTP; 11 May 2026 02:17:50 -0700
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com
Cc: aman.deep.singh@intel.com
Subject: [PATCH 1/6] net/idpf: fix gen bit extraction in split queue AVX2 Rx
Date: Mon, 11 May 2026 14:39:30 +0530
Message-ID: <20260511090935.2288837-2-shaiq.wani@intel.com>
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

The generation bit in the pktlen_gen_bufq_id field of the split queue
completion descriptor (virtchnl2_rx_flex_desc_adv_nic_3) must be
extracted by masking first and then shifting, not the other way around.

With shift-then-mask, the mask is applied to already-shifted bits,
which can produce incorrect results when upper bits (packet length,
buffer queue ID) leak into the extracted value.

Change to mask-then-shift to correctly isolate the generation bit
before comparing it with the expected generation ID.

Fixes: 1f065f9d75ff ("net/idpf: add AVX2 Rx path for split queue config")
Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
---
 .../net/intel/idpf/idpf_common_rxtx_avx2.c    | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
index db7728afad..cd10c27a30 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
@@ -524,8 +524,8 @@ idpf_dp_splitq_recv_pkts_avx2(void *rxq, struct rte_mbuf **rx_pkts, uint16_t nb_
 
 	/* check if there is at least one packet available */
 	head_gen = rxdp->flex_adv_nic_3_wb.pktlen_gen_bufq_id;
-	if (((head_gen >> VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_S) &
-		 VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_M) != queue->expected_gen_id)
+	if (((head_gen & VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_M) >>
+		 VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_S) != queue->expected_gen_id)
 		return 0;
 
 	for (i = 0; i < nb_pkts;
@@ -599,17 +599,17 @@ idpf_dp_splitq_recv_pkts_avx2(void *rxq, struct rte_mbuf **rx_pkts, uint16_t nb_
 		pktlen_gen3 = (uint16_t)_mm_extract_epi16(d3, 2);
 
 		valid0 = (stat0 & 1) &&
-			 (((pktlen_gen0 >> VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_S) &
-			   VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_M) == queue->expected_gen_id);
+			 (((pktlen_gen0 & VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_M) >>
+			   VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_S) == queue->expected_gen_id);
 		valid1 = (stat1 & 1) &&
-			 (((pktlen_gen1 >> VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_S) &
-			   VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_M) == queue->expected_gen_id);
+			 (((pktlen_gen1 & VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_M) >>
+			   VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_S) == queue->expected_gen_id);
 		valid2 = (stat2 & 1) &&
-			 (((pktlen_gen2 >> VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_S) &
-			   VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_M) == queue->expected_gen_id);
+			 (((pktlen_gen2 & VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_M) >>
+			   VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_S) == queue->expected_gen_id);
 		valid3 = (stat3 & 1) &&
-			 (((pktlen_gen3 >> VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_S) &
-			   VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_M) == queue->expected_gen_id);
+			 (((pktlen_gen3 & VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_M) >>
+			   VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_S) == queue->expected_gen_id);
 
 		/* count valid descriptors (holes are impossible because
 		 * descriptors are read in reverse order while the NIC
-- 
2.34.1

