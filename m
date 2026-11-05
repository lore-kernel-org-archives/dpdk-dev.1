Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC67606A331
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Nov 2026 09:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=l6yG8dGT
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DB99740E03;
	Thu,  5 Nov 2026 10:52:34 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTPS id C2DB540281;
 Thu,  5 Nov 2026 10:52:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793872354; x=1825408354;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=J4HqaZsdrfoTFPoGGdmsBwu5Yw4hb4SnwfbJTpQYW/s=;
 b=l6yG8dGTB6RjfqjeLahJVaXI9OAgiK6V0ve/rY2NTfNvuaLPFlNt/+xk
 kynfiL0wTKYHqbBojPWmbT0x82/MWHt1f8yKOkIX0s4k488drk5O9Nokb
 1Re7zGozfoCbxpBJFbr/ZsRAPJiS2x5clo9ezWTmsRULxcO1GMbjXAfV6
 88qsGYl9bkykYAGgB9gmspL9oBS1qEiO4qPBEkUjKV2QHWkH0qteZeKK5
 zMtiybOoWxEdYfqVONlWqY5WMrX5r3wzwMGLU2bfugh+gB4dbv+w8chhg
 s8d2m84KyYfVzZRSvAdqCByBPvaawNkai7NEoOam0GqxOVgIpldNxxECT g==;
X-CSE-ConnectionGUID: hnWzSPpURC+/5xE9kBRErA==
X-CSE-MsgGUID: rVUefkY1RjCryg4ZJZV3kQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2683954"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2683954"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 01:52:34 -0800
X-CSE-ConnectionGUID: 5tWKgeK/QNePHkRu9DuHHQ==
X-CSE-MsgGUID: 9Eu7Mb1LQCOhBb0kQJoW/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7034189"
Received: from pae.iind.intel.com (HELO PAE-35.iind.intel.com) ([10.49.105.82])
 by orviesa006.jf.intel.com with ESMTP; 05 Nov 2026 01:52:32 -0800
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, anatoly.burakov@intel.com,
 Anurag Mandal <anurag.mandal@intel.com>, stable@dpdk.org
Subject: [PATCH 1/8] net/ice: fix DCF hardware init error path
Date: Thu,  5 Nov 2026 09:47:18 +0000
Message-Id: <a248ef94491e9ae863ece11f316d400989c8880c.1793871697.git.anurag.mandal@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1793871697.git.anurag.mandal@intel.com>
References: <cover.1793871697.git.anurag.mandal@intel.com>
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
---
 drivers/net/intel/ice/ice_dcf.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/intel/ice/ice_dcf.c b/drivers/net/intel/ice/ice_dcf.c
index 976f2ed260..d87655c11d 100644
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
+	rte_intr_callback_unregister(pci_dev->intr_handle,
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

