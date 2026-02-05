Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D59EC1EAD
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 12:47:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 166D4410E7;
	Thu,  5 Feb 2026 13:46:45 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 77B5D4021F
 for <dev@dpdk.org>; Thu,  5 Feb 2026 13:46:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770295600; x=1801831600;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=UuGSxN69rwj+7RfH/CZ9Lnpwb2dKT1+zL9OJSLV00i4=;
 b=WrCUECDPmH6cs7Ac/5xW4Yy9xlge/ZrV45vlnCIzjHTfcO6Cz5AFD+qY
 U42w5vHIcMk96mWDvSbztX2Br9bSkVqsLCsBFKJBFk9HJCun8XUJHqD51
 TBXzgvqcnnxHiqKwmeHs+Sck1D3043Vxx76nE56v8WooIhnOu5qLr6CC6
 KvCW8zJyv+qUsWP51nIk6SVmZW+Zy8pgnAFEXHeHwbcBsX/qqjEbLuJE2
 HXzwqi1euZOrTmgNnxj7kfSqLoQAgU33dtkQ47KWBmPgQSss2SPLer8q/
 tpe6mqAwolatn2Vd3jlC2CbkL+vFlRuBP2zKHFhzSDu9NO3qqRckFc+es g==;
X-CSE-ConnectionGUID: M2r0PMY8TaGFPr40J9T/wA==
X-CSE-MsgGUID: 5fFoBuCkSKuC4nHMUIwsgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="71481848"
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; d="scan'208";a="71481848"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Feb 2026 04:46:40 -0800
X-CSE-ConnectionGUID: pKfalHwlRuKU+94QhmUU+w==
X-CSE-MsgGUID: N7JNY3/pRLqxWIlfewo2dA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; d="scan'208";a="233454861"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa002.fm.intel.com with ESMTP; 05 Feb 2026 04:46:39 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v2 04/10] net/idpf: prevent Rx path selection after device
 start
Date: Thu,  5 Feb 2026 12:46:21 +0000
Message-ID: <20260205124627.371733-5-ciara.loftus@intel.com>
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
v2:
* Fix unused label error for non x86 arch
---
 drivers/net/intel/idpf/idpf_rxtx.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/intel/idpf/idpf_rxtx.c b/drivers/net/intel/idpf/idpf_rxtx.c
index cee454244f..e7d44f7beb 100644
--- a/drivers/net/intel/idpf/idpf_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_rxtx.c
@@ -782,11 +782,17 @@ idpf_set_rx_function(struct rte_eth_dev *dev)
 #ifdef RTE_ARCH_X86
 	struct idpf_rx_queue *rxq;
 	int i;
+#endif
+
+	/* If the device has started the function has already been selected. */
+	if (dev->data->dev_started)
+		goto out;
 
+#ifdef RTE_ARCH_X86
 	if (idpf_rx_vec_dev_check_default(dev) == IDPF_VECTOR_PATH &&
 	    rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_256)
 		req_features.simd_width = idpf_get_max_simd_bitwidth();
-#endif /* RTE_ARCH_X86 */
+#endif
 
 	req_features.single_queue = (vport->rxq_model == VIRTCHNL2_QUEUE_MODEL_SINGLE);
 	req_features.scattered = dev->data->scattered_rx;
@@ -814,6 +820,7 @@ idpf_set_rx_function(struct rte_eth_dev *dev)
 	}
 #endif
 
+out:
 	dev->rx_pkt_burst = idpf_rx_path_infos[ad->rx_func_type].pkt_burst;
 	PMD_DRV_LOG(NOTICE, "Using %s Rx (port %d).",
 			idpf_rx_path_infos[ad->rx_func_type].info, dev->data->port_id);
-- 
2.43.0

