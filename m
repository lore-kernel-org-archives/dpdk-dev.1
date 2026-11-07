Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5BE606A32E
	for <dpdk-dev@archiver.kernel.org>; Sat,  7 Nov 2026 23:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TgbsX1dR
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2680440697;
	Sun,  8 Nov 2026 00:57:25 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTPS id 333B240609;
 Sun,  8 Nov 2026 00:57:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794095844; x=1825631844;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=BAyM55Ix2sTunT6wxxwVtk+sfHX8YUzRI0n8m+QvSwQ=;
 b=TgbsX1dRaABtyt9Fh/lxpxvvFdwn9Ls7FuA0tdoMklJRfWtQUhKuuq75
 sSX9gVKcIARfSK3UTet/k05B5NcpMu3MWjBCcpqhN0/29HA6hWyCe2bmm
 mCfgQDN1SMzybhiCsnCHstFwKSYh4VX+in7b/v1NqIhvoQpuV4iTBQntZ
 JxYUSoCZ13PkVvxXZg6ZBsBsMhApwUJRTUhIeWQ/8Le4kf9pO7clb5ow/
 bhxDNQlX5OuQhAthPowA+DxMCxBL4NXGCEzUn1SwlVrkGaCCvmO+1WV0v
 QWH5XKvpnWAP5kEKXf9acnj+8Q521xX/pmkt01n0YcOlLYKt7JfDbGjG9 Q==;
X-CSE-ConnectionGUID: hVSOafAzS7eFBjqz06fM6Q==
X-CSE-MsgGUID: lhPp0QszSXep5PYN4tYtfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11959"; a="2885084"
X-IronPort-AV: E=Sophos;i="6.27,200,1787036400"; 
   d="scan'208";a="2885084"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2026 15:57:24 -0800
X-CSE-ConnectionGUID: uNxuA0QGSSeLJu3paC+/Dg==
X-CSE-MsgGUID: gUiArLEfSQ6qB+iX79XipA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,200,1787036400"; 
   d="scan'208";a="7464629"
Received: from pae.iind.intel.com (HELO PAE-35.iind.intel.com) ([10.49.105.82])
 by orviesa005.jf.intel.com with ESMTP; 07 Nov 2026 15:57:22 -0800
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, anatoly.burakov@intel.com,
 Anurag Mandal <anurag.mandal@intel.com>, stable@dpdk.org
Subject: [PATCH v2 1/8] net/ice: fix DCF hardware init error path
Date: Sat,  7 Nov 2026 23:52:11 +0000
Message-Id: <e18eeb05f37a44c7b6145c93b38f0b40b94f41f1.1794094943.git.anurag.mandal@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1794094943.git.anurag.mandal@intel.com>
References: <cover.1794094943.git.anurag.mandal@intel.com>
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

ice_dcf_init_hw() never frees the VF VSI map on its error paths,
so it leaks when any step after getting the map fails.

Similarly, when getting the VLAN offload V2 capabilities fails,
the error path leaves the interrupt callback registered and
enabled, and leaks the QoS bandwidth config array.
As the DCF hardware structure passed to the callback is freed
with the port when probe fails, a later interrupt would use
freed memory.

Free the VSI map, and add an error label that disables the
interrupt, unregisters the callback and frees the QoS array.

Fixes: 9a7980cfdf67 ("net/ice: complete VLAN offload capability for DCF")
Fixes: 8e1cf1823191 ("net/ice: init RSS and supported RXDID in DCF")
Fixes: 7564d5509611 ("net/ice: add DCF hardware initialization")
Cc: stable@dpdk.org

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/ice/ice_dcf.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/intel/ice/ice_dcf.c b/drivers/net/intel/ice/ice_dcf.c
index 976f2ed260..0295ebe4fe 100644
--- a/drivers/net/intel/ice/ice_dcf.c
+++ b/drivers/net/intel/ice/ice_dcf.c
@@ -853,14 +853,23 @@ ice_dcf_init_hw(struct rte_eth_dev *eth_dev, struct ice_dcf_hw *hw)
 
 	if ((hw->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_VLAN_V2) &&
 	    dcf_get_vlan_offload_caps_v2(hw))
-		goto err_rss;
+		goto err_intr;
 
 	return 0;
 
+err_intr:
+	ice_dcf_disable_irq0(hw);
+	rte_intr_disable(pci_dev->intr_handle);
+	rte_intr_callback_unregister_sync(pci_dev->intr_handle,
+				     ice_dcf_dev_interrupt_handler, hw);
+	rte_free(hw->qos_bw_cfg);
+	hw->qos_bw_cfg = NULL;
 err_rss:
 	rte_free(hw->rss_key);
 	rte_free(hw->rss_lut);
 err_alloc:
+	rte_free(hw->vf_vsi_map);
+	hw->vf_vsi_map = NULL;
 	rte_free(hw->vf_res);
 err_api:
 	iavf_shutdown_adminq(&hw->avf);
-- 
2.25.1

