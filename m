Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 730B8E9A03E
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Feb 2026 09:50:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A0BD840663;
	Wed, 18 Feb 2026 10:50:13 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id D6FE940299
 for <dev@dpdk.org>; Wed, 18 Feb 2026 10:50:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771408209; x=1802944209;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1Bhbs/hLxiWNAEuUmt8atxXl8kXhUoTwA6G58ciP65Y=;
 b=VqMs5/nHSk1NBvkb/Ga6PZgWdfFe+Mc/8QNfuM0YNAxLZJG9jaqEeuAw
 CaqvOd0V9qypoppaVeI7kgzVeScN+4JvzeX4n+2RjLQeM5R9uRAxpJlYb
 /DFY0Pt6zRJvB28ELWz0K1jByK4W2e/cP9Pah4n8TJvQQ0V8cEk1XCfvX
 o99Wmmqz5Vv6sXfaTXqi9PEyjZt+mb7wE7PnsSiRCudRyecKV1RtqBa/g
 HWZ4Ykurm9YNNYEssJtC0TMvJxzZXZ7W7ecM6o7FQw0yPvxDZc2Gt2n6t
 fO9xH+Qe1Tw4h06BlOfBfoiZM87gheayV/CX1B+nz5wRq93fmsqZeCcPm g==;
X-CSE-ConnectionGUID: h3lNDiqXRSK92dVAf/0nfA==
X-CSE-MsgGUID: aS2dx+KTSKuX3NL30iQdMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11704"; a="83929846"
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; d="scan'208";a="83929846"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2026 01:50:08 -0800
X-CSE-ConnectionGUID: Hexqbtb/Tw6aiw59bMDvXQ==
X-CSE-MsgGUID: zub8G40zTG2DZzMap3xStg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; d="scan'208";a="214257114"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa007.jf.intel.com with ESMTP; 18 Feb 2026 01:50:07 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v3 05/10] net/cpfl: prevent Rx path selection after device
 start
Date: Wed, 18 Feb 2026 09:49:32 +0000
Message-ID: <20260218094937.1652391-6-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260218094937.1652391-1-ciara.loftus@intel.com>
References: <20260205124627.371733-1-ciara.loftus@intel.com>
 <20260218094937.1652391-1-ciara.loftus@intel.com>
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
index 11451e1666..dc729d31af 100644
--- a/drivers/net/intel/cpfl/cpfl_rxtx.c
+++ b/drivers/net/intel/cpfl/cpfl_rxtx.c
@@ -1446,11 +1446,17 @@ cpfl_set_rx_function(struct rte_eth_dev *dev)
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
@@ -1479,6 +1485,7 @@ cpfl_set_rx_function(struct rte_eth_dev *dev)
 	}
 #endif
 
+out:
 	dev->rx_pkt_burst = idpf_rx_path_infos[ad->rx_func_type].pkt_burst;
 	PMD_DRV_LOG(NOTICE, "Using %s Rx (port %d).",
 			idpf_rx_path_infos[ad->rx_func_type].info, dev->data->port_id);
-- 
2.43.0

