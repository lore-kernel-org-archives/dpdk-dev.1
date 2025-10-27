Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1AB1CCF9E0
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Oct 2025 08:08:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4CB99402E4;
	Mon, 27 Oct 2025 09:08:08 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id E020C402A6
 for <dev@dpdk.org>; Mon, 27 Oct 2025 09:08:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761552485; x=1793088485;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=n7+Tk0IyC3eBjM/4N3JaA7H22DjydzsVtdlF3njYHuE=;
 b=YRT4ZkVJTFy8MMCGTyENkIXWUxYdKTv11RYpDdg+zDrwUACb/Zo1sqh9
 FNv1J85XRXUcSeFZpRTY3tnrDuZeL+HLNN+oIm4+weV5hcnyLvoMqDIen
 tpjXQG9IE3Vq58UjdSYqyKblzy0qOilb74cjE0j2ACYOGhESpbiiac8wE
 Jylhk3+p2In02oHiYx0ukQEq2S7M5BOsEnggmZKOY8J10SAiLK42HkSx7
 q60wQu9hmSQnh/QOJ2j8G2R31OcbQDNpza+XX0LKy+W0usLlFI4ZkSVML
 ebMjmKDabGAOkanG080+pjPY10bC1GxTHkRWR6QADsES9M7yWq/Ke1441 w==;
X-CSE-ConnectionGUID: nHqBPGlpQriTluLmhiMdpQ==
X-CSE-MsgGUID: Y0QtslXsQ6S6qCDuMFz0Eg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="81258182"
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; d="scan'208";a="81258182"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2025 01:08:05 -0700
X-CSE-ConnectionGUID: 0gy6aMsLSU6EyJHhshJoIA==
X-CSE-MsgGUID: eaQ1/vcVTauj6v3bpw11Bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; d="scan'208";a="215878858"
Received: from unknown (HELO srv24..) ([10.138.182.231])
 by fmviesa001.fm.intel.com with ESMTP; 27 Oct 2025 01:08:03 -0700
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com
Cc: aman.deep.singh@intel.com
Subject: [PATCH v8 2/3] net/idpf: enable AVX2 for split queue Tx
Date: Mon, 27 Oct 2025 13:37:57 +0530
Message-Id: <20251027080758.48410-3-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251027080758.48410-1-shaiq.wani@intel.com>
References: <20250917052658.582872-1-shaiq.wani@intel.com>
 <20251027080758.48410-1-shaiq.wani@intel.com>
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

In case some CPUs don't support AVX512. Enable AVX2 for them to
get better per-core performance.

In the single queue model, the same descriptor queue is used by SW
to post descriptors to the device and used by device to report completed
descriptors to SW. While as the split queue model separates them into
different queues for parallel processing and improved performance.

Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
---
 drivers/net/intel/idpf/idpf_common_rxtx.h | 3 +++
 drivers/net/intel/idpf/idpf_rxtx.c        | 9 +++++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.h b/drivers/net/intel/idpf/idpf_common_rxtx.h
index 87f6895c4c..3636d55272 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx.h
+++ b/drivers/net/intel/idpf/idpf_common_rxtx.h
@@ -264,6 +264,9 @@ uint16_t idpf_dp_singleq_recv_pkts_avx2(void *rx_queue,
 					struct rte_mbuf **rx_pkts,
 					uint16_t nb_pkts);
 __rte_internal
+uint16_t idpf_dp_splitq_xmit_pkts_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
+				       uint16_t nb_pkts);
+__rte_internal
 uint16_t idpf_dp_singleq_xmit_pkts_avx2(void *tx_queue,
 					struct rte_mbuf **tx_pkts,
 					uint16_t nb_pkts);
diff --git a/drivers/net/intel/idpf/idpf_rxtx.c b/drivers/net/intel/idpf/idpf_rxtx.c
index 1c725065df..6950fabb49 100644
--- a/drivers/net/intel/idpf/idpf_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_rxtx.c
@@ -850,6 +850,15 @@ idpf_set_tx_function(struct rte_eth_dev *dev)
 				return;
 			}
 #endif /* CC_AVX512_SUPPORT */
+			if (tx_simd_width == RTE_VECT_SIMD_256) {
+				PMD_DRV_LOG(NOTICE,
+					    "Using Split AVX2 Vector Tx (port %d).",
+					    dev->data->port_id);
+				dev->tx_pkt_burst = idpf_dp_splitq_xmit_pkts_avx2;
+				dev->tx_pkt_prepare = idpf_dp_prep_pkts;
+				return;
+			}
+
 		}
 		PMD_DRV_LOG(NOTICE,
 			    "Using Split Scalar Tx (port %d).",
-- 
2.34.1

