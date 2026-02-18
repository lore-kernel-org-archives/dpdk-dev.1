Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2EA7E9A03B
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Feb 2026 09:50:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B7BA04065B;
	Wed, 18 Feb 2026 10:50:12 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 8B15C4042E
 for <dev@dpdk.org>; Wed, 18 Feb 2026 10:50:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771408208; x=1802944208;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=fRRX2oaaz/wOUfL8/bAlDTQL5Js58PbzKhFTeuqhFeE=;
 b=iQKZT1yhMJ76+0q4qlVXGB3OiLfTno3vVeWWHleJ6UIi6Oz26pZx4Ri2
 Z+36CaZEylfXN9H0HiI5/c/D0xC9ZbBZLM6ImAK8Vk17isAT4SBAVxZdh
 lVljvGE4g14P8aYL3F/UEKgHXPnhTRLpUakIDjZcDI9me9oU10F6F41Ou
 nC2nra7i5FhD5OJ99nDph0dOowAwmkM0tlLZYP+ANUUYUNX2bdov5AtAl
 RESZx8F3nQJxnSblWfEbPackNvyOo0DVUahFuxYRBUnvYk8DIGKHTv2SZ
 o/XojoidHalUzGVWTNX7C9A9W6nBdlHBwVWQMNWVVKU/xK8g350h6uOK3 Q==;
X-CSE-ConnectionGUID: r2BBN4H+Q4eNzMPXFKBGGw==
X-CSE-MsgGUID: tH6h5PpeRfeceFMRs6666g==
X-IronPort-AV: E=McAfee;i="6800,10657,11704"; a="83929845"
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; d="scan'208";a="83929845"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2026 01:50:07 -0800
X-CSE-ConnectionGUID: +bLTD9avR92RIlQoGi4Bsw==
X-CSE-MsgGUID: c+87xPDoTny+v0ecNRzFnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; d="scan'208";a="214257098"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa007.jf.intel.com with ESMTP; 18 Feb 2026 01:50:06 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v3 04/10] net/idpf: prevent Rx path selection after device
 start
Date: Wed, 18 Feb 2026 09:49:31 +0000
Message-ID: <20260218094937.1652391-5-ciara.loftus@intel.com>
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
v2:
* Fix unused label error for non x86 arch
---
 drivers/net/intel/idpf/idpf_rxtx.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/intel/idpf/idpf_rxtx.c b/drivers/net/intel/idpf/idpf_rxtx.c
index 6317112353..81bcc08126 100644
--- a/drivers/net/intel/idpf/idpf_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_rxtx.c
@@ -795,11 +795,17 @@ idpf_set_rx_function(struct rte_eth_dev *dev)
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
@@ -827,6 +833,7 @@ idpf_set_rx_function(struct rte_eth_dev *dev)
 	}
 #endif
 
+out:
 	dev->rx_pkt_burst = idpf_rx_path_infos[ad->rx_func_type].pkt_burst;
 	PMD_DRV_LOG(NOTICE, "Using %s Rx (port %d).",
 			idpf_rx_path_infos[ad->rx_func_type].info, dev->data->port_id);
-- 
2.43.0

