Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47037EC1EAD
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 12:47:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 28D18410EA;
	Thu,  5 Feb 2026 13:46:46 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 9F5BC40ED3
 for <dev@dpdk.org>; Thu,  5 Feb 2026 13:46:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770295601; x=1801831601;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=TlqXVv6CaDpzUpRTfhVpsPKUo6tVa9GITvPkTFnv6Yo=;
 b=mfVPcHmlslbl5WdNNlbetzsb/pP83m8YUgasmUDvZKoTlXwUEA9dXtD4
 T39SlePJgD7YZkwB/qpiWabFxKcgsRl/3Ybt73ubNQqFHlxdZQjLpbai7
 0LVrsu0BCA/1colfGDZJNluCdaEBxn9KSIgVjoCGZ5JZf5G1xjka1Ov84
 vBY3mnkFFXf828K+EyALJBKbdylHesWsZ77ObVFk1q9iWik/1Xna/IvaS
 8gatJ396bK+yIQ4+LoZ0z53luy859jx3cBkrldWvgeb3KN3Lvvf4EE5Ei
 gvtPMpPmBaE/OsMWUHcgVA8vlnsBmHTwXM4j6nzzmNv768ZoRQbvv5G9d g==;
X-CSE-ConnectionGUID: msooXpBBSVW8L3Ni5EUSlg==
X-CSE-MsgGUID: 6Cbb0ZkaQkeLy1EZtA8s8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="71481851"
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; d="scan'208";a="71481851"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Feb 2026 04:46:40 -0800
X-CSE-ConnectionGUID: xsXA0j/USLC/cVyhkCn70w==
X-CSE-MsgGUID: r6PnmRRVTZmfCWfsl/yuZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; d="scan'208";a="233454864"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa002.fm.intel.com with ESMTP; 05 Feb 2026 04:46:40 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v2 05/10] net/cpfl: prevent Rx path selection after device
 start
Date: Thu,  5 Feb 2026 12:46:22 +0000
Message-ID: <20260205124627.371733-6-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260205124627.371733-1-ciara.loftus@intel.com>
References: <20260205103008.190493-1-ciara.loftus@intel.com>
 <20260205124627.371733-1-ciara.loftus@intel.com>
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

To fall in line with other drivers using the Rx path selection
infrastructure, prevent Rx path selection after the device has started.

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
* Fix unused label error for non x86 arch
---
 drivers/net/intel/cpfl/cpfl_rxtx.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/intel/cpfl/cpfl_rxtx.c b/drivers/net/intel/cpfl/cpfl_rxtx.c
index d0438b5da0..7da360d56e 100644
--- a/drivers/net/intel/cpfl/cpfl_rxtx.c
+++ b/drivers/net/intel/cpfl/cpfl_rxtx.c
@@ -1429,11 +1429,17 @@ cpfl_set_rx_function(struct rte_eth_dev *dev)
 #ifdef RTE_ARCH_X86
 	struct cpfl_rx_queue *cpfl_rxq;
 	int i;
+#endif
+
+	/* If the device has started the function has already been selected. */
+	if (dev->data->dev_started)
+		goto out;
 
+#ifdef RTE_ARCH_X86
 	if (cpfl_rx_vec_dev_check_default(dev) == CPFL_VECTOR_PATH &&
 	    rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_256)
 		req_features.simd_width = cpfl_get_max_simd_bitwidth();
-#endif /* RTE_ARCH_X86 */
+#endif
 
 	req_features.single_queue = (vport->rxq_model == VIRTCHNL2_QUEUE_MODEL_SINGLE);
 	req_features.scattered = dev->data->scattered_rx;
@@ -1462,6 +1468,7 @@ cpfl_set_rx_function(struct rte_eth_dev *dev)
 	}
 #endif
 
+out:
 	dev->rx_pkt_burst = idpf_rx_path_infos[ad->rx_func_type].pkt_burst;
 	PMD_DRV_LOG(NOTICE, "Using %s Rx (port %d).",
 			idpf_rx_path_infos[ad->rx_func_type].info, dev->data->port_id);
-- 
2.43.0

