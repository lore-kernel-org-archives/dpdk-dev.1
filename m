Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F4A4EC1E91
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 10:31:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4EC5B40EA5;
	Thu,  5 Feb 2026 11:30:34 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 7C79540E3E
 for <dev@dpdk.org>; Thu,  5 Feb 2026 11:30:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770287430; x=1801823430;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=vmyzOOhYCu4BIb8OQc1Tc41pP3ruZ0FFjJvtDc9brvo=;
 b=jqguSC5kqJDJ7qQTgwLgv61BL6ielEO+kpFk7TQjWIZDaQUGm9UXtylC
 MA5BFXEq6GbxqF8hCv7+QF9jhYgoLYjnGhxnDhrtigOCq07wN2TzaJ+S/
 Hb4iR7vBmDCzYLrt+C/vcxT+2CuPvHd2knvk+w7iId0uazfQfQJbI5Fqy
 9W4HNVGsJB0VbsiRJWCWIN/Cn5tNrdYfnLRaxyivznZBVtSMXBiAS6GTt
 Yb30hAY7r1bUoU3/ZA5f3EhbnJUfue+JIaIcyflERxyNmS6QuoY24S/jN
 nS9SAw2KerPsj2VdOgCfoBNpy5tJPZ2uOWi3I5Kg4YrMadxmGmajn9QL3 w==;
X-CSE-ConnectionGUID: Du5CeCCoRj2P8mrF1MraYw==
X-CSE-MsgGUID: fFCzWdGITsKjR5/LQ83hkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="89064772"
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; d="scan'208";a="89064772"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Feb 2026 02:30:30 -0800
X-CSE-ConnectionGUID: KMhGLSroT2iWX4G1gQp9ZQ==
X-CSE-MsgGUID: Wtf00NodRpCtauNfz3j7yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; d="scan'208";a="210447571"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa008.fm.intel.com with ESMTP; 05 Feb 2026 02:30:29 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH 05/10] net/cpfl: prevent Rx path selection after device start
Date: Thu,  5 Feb 2026 10:30:03 +0000
Message-ID: <20260205103008.190493-6-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260205103008.190493-1-ciara.loftus@intel.com>
References: <20260205103008.190493-1-ciara.loftus@intel.com>
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
 drivers/net/intel/cpfl/cpfl_rxtx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/intel/cpfl/cpfl_rxtx.c b/drivers/net/intel/cpfl/cpfl_rxtx.c
index d0438b5da0..1de53f8827 100644
--- a/drivers/net/intel/cpfl/cpfl_rxtx.c
+++ b/drivers/net/intel/cpfl/cpfl_rxtx.c
@@ -1430,6 +1430,10 @@ cpfl_set_rx_function(struct rte_eth_dev *dev)
 	struct cpfl_rx_queue *cpfl_rxq;
 	int i;
 
+	/* If the device has started the function has already been selected. */
+	if (dev->data->dev_started)
+		goto out;
+
 	if (cpfl_rx_vec_dev_check_default(dev) == CPFL_VECTOR_PATH &&
 	    rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_256)
 		req_features.simd_width = cpfl_get_max_simd_bitwidth();
@@ -1462,6 +1466,7 @@ cpfl_set_rx_function(struct rte_eth_dev *dev)
 	}
 #endif
 
+out:
 	dev->rx_pkt_burst = idpf_rx_path_infos[ad->rx_func_type].pkt_burst;
 	PMD_DRV_LOG(NOTICE, "Using %s Rx (port %d).",
 			idpf_rx_path_infos[ad->rx_func_type].info, dev->data->port_id);
-- 
2.43.0

