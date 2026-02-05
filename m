Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBBB1EC1E97
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 10:30:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5643140E72;
	Thu,  5 Feb 2026 11:30:33 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id A4C4440264
 for <dev@dpdk.org>; Thu,  5 Feb 2026 11:30:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770287430; x=1801823430;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=b8pL0cgm48yRAu0Zhu5ZsZpJvGW1Ch4ikmai9rV7JsU=;
 b=SbET3AovXon5Bby1Pn71nIPQUW5vIpQE4+IXbzLqXVyx1MJL4zAbGsT5
 Bf4S8XN4/L731Pl1F6F+qho5i6s8vBy37bUyMG6qb/Hfap+VOsLu1kU1o
 pm67wkXNrDnjJn6Fha8eRFFsNA+hvNATfMG+XaEg7S2/+u3SdpMyi6477
 C27CDHyyxccN38JTc0aiYG2Xhw+dvvKAjttxetGO/U5cZlkfYkhez0svb
 7HAcV+kT6EPw2Jy59EOKV+iDyAuJlTINsYOGzwm4tBLVj9bow/pGy5fVD
 ooFMaXt1f7k4hvT0CS5ZK9/+BwMpvVB9BdueK5giK0rZvRVOkwj8folrR w==;
X-CSE-ConnectionGUID: RXz6CV0vQiibEusp4CLldg==
X-CSE-MsgGUID: YH1rZbeKQ5uI4XQdnkbeSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="89064771"
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; d="scan'208";a="89064771"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Feb 2026 02:30:29 -0800
X-CSE-ConnectionGUID: 08r4QzA7Su2IXOVntaM7Ug==
X-CSE-MsgGUID: 7v29Ryo1QDK/Qq6LdSOWGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; d="scan'208";a="210447565"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa008.fm.intel.com with ESMTP; 05 Feb 2026 02:30:29 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH 04/10] net/idpf: prevent Rx path selection after device start
Date: Thu,  5 Feb 2026 10:30:02 +0000
Message-ID: <20260205103008.190493-5-ciara.loftus@intel.com>
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
 drivers/net/intel/idpf/idpf_rxtx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/intel/idpf/idpf_rxtx.c b/drivers/net/intel/idpf/idpf_rxtx.c
index cee454244f..de880bdc5f 100644
--- a/drivers/net/intel/idpf/idpf_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_rxtx.c
@@ -783,6 +783,10 @@ idpf_set_rx_function(struct rte_eth_dev *dev)
 	struct idpf_rx_queue *rxq;
 	int i;
 
+	/* If the device has started the function has already been selected. */
+	if (dev->data->dev_started)
+		goto out;
+
 	if (idpf_rx_vec_dev_check_default(dev) == IDPF_VECTOR_PATH &&
 	    rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_256)
 		req_features.simd_width = idpf_get_max_simd_bitwidth();
@@ -814,6 +818,7 @@ idpf_set_rx_function(struct rte_eth_dev *dev)
 	}
 #endif
 
+out:
 	dev->rx_pkt_burst = idpf_rx_path_infos[ad->rx_func_type].pkt_burst;
 	PMD_DRV_LOG(NOTICE, "Using %s Rx (port %d).",
 			idpf_rx_path_infos[ad->rx_func_type].info, dev->data->port_id);
-- 
2.43.0

