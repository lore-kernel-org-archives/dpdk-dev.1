Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA412606CC5B
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Nov 2026 09:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZDfiOSOl
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A35C0427C2;
	Thu,  5 Nov 2026 10:53:21 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTPS id 63C5E427A7;
 Thu,  5 Nov 2026 10:53:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793872401; x=1825408401;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=MpTHujcQWYqR/0htBI9ekW1cJO8K76fF9JqmKPKP4xA=;
 b=ZDfiOSOlXSge8xu0F3Nl9ugsrdLhTn5kZLmMr6wHIYN+TMdNQ55dQdqD
 4x/WUGP4/gx/clc47nSKeEPo9LwstRinUNvEDTb7V7p+fcX1jd5xqUtM+
 4dBriZAyowa6lGuwhw7I6+Wc3s00EIM5cT+jfcpWLlZ/HLo+V+JapWBCd
 37UM644OdTr5cfCPHkz2T5Ac4FdHSlkOawKxC4reWJJLRycaw+mbTu6of
 YHYDnBbHt81q5XOvGmQfSaie8JddIJu2dbKG1w6Cz29o3gf1+y4Ed+bh3
 INQB+AGkRzFpi7ewj2sMvavZnIpDt9NhPklHBhM8G6g7ojpGk7GwtmA2F Q==;
X-CSE-ConnectionGUID: vD6LXIIDQ/+3Ri5asmVA3A==
X-CSE-MsgGUID: gtnzwLUoQ0a4v6qUbQrWjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2683978"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2683978"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 01:53:20 -0800
X-CSE-ConnectionGUID: EnKqpfzCT/K/VvRnIVicVQ==
X-CSE-MsgGUID: 2JjKIudHQAiUzOmCNp/R+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7034326"
Received: from pae.iind.intel.com (HELO PAE-35.iind.intel.com) ([10.49.105.82])
 by orviesa006.jf.intel.com with ESMTP; 05 Nov 2026 01:53:18 -0800
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, anatoly.burakov@intel.com,
 Anurag Mandal <anurag.mandal@intel.com>, stable@dpdk.org
Subject: [PATCH 8/8] net/ice: fix DCF port leak on probe failure
Date: Thu,  5 Nov 2026 09:47:25 +0000
Message-Id: <06b0de0e409a4679915ddd88abf64f41add54280.1793871697.git.anurag.mandal@intel.com>
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

When representors are requested, eth_ice_dcf_pci_probe() creates
the DCF port before handling them.
If a later step fails, such as an unsupported representor type,
an invalid VF ID or a failed representor creation, the probe
returns an error but leaves the DCF port and any representors
already created in place.
As the probe failed, the PCI bus also unmaps the device, so
these ports are leaked and cannot be closed safely.

Check the representor type before creating the DCF port, and
on later failures destroy the representors created so far and
remove the DCF port.

Fixes: 5674465a32c8 ("net/ice: add DCF VLAN handling")
Fixes: d654167641bf ("ethdev: introduce representor type")
Cc: stable@dpdk.org

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
---
 drivers/net/intel/ice/ice_dcf_ethdev.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/net/intel/ice/ice_dcf_ethdev.c b/drivers/net/intel/ice/ice_dcf_ethdev.c
index 26c22265eb..b4e81433ba 100644
--- a/drivers/net/intel/ice/ice_dcf_ethdev.c
+++ b/drivers/net/intel/ice/ice_dcf_ethdev.c
@@ -2060,13 +2060,14 @@ eth_ice_dcf_pci_probe(__rte_unused struct rte_pci_driver *pci_drv,
 	if (ret < 0)
 		return ret;
 
+	if (eth_da.nb_representor_ports && eth_da.type != RTE_ETH_REPRESENTOR_VF)
+		return -ENOTSUP;
+
 	ret = rte_eth_dev_pci_generic_probe(pci_dev,
 					    sizeof(struct ice_dcf_adapter),
 					    ice_dcf_dev_init);
 	if (ret || !eth_da.nb_representor_ports)
 		return ret;
-	if (eth_da.type != RTE_ETH_REPRESENTOR_VF)
-		return -ENOTSUP;
 
 	dcf_ethdev = rte_eth_dev_allocated(pci_dev->device.name);
 	if (dcf_ethdev == NULL)
@@ -2075,14 +2076,14 @@ eth_ice_dcf_pci_probe(__rte_unused struct rte_pci_driver *pci_drv,
 	dcf_adapter = dcf_ethdev->data->dev_private;
 	ret = ice_dcf_init_repr_info(dcf_adapter);
 	if (ret)
-		return ret;
+		goto err_remove_dcf;
 
 	if (eth_da.nb_representor_ports > dcf_adapter->real_hw.num_vfs ||
 	    eth_da.nb_representor_ports >= RTE_MAX_ETHPORTS) {
 		PMD_DRV_LOG(ERR, "the number of port representors is too large: %u",
 			    eth_da.nb_representor_ports);
-		ice_dcf_free_repr_info(dcf_adapter);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_remove_dcf;
 	}
 
 	dcf_vsi_id = dcf_adapter->real_hw.vsi_id | VIRTCHNL_DCF_VF_VSI_VALID;
@@ -2133,6 +2134,20 @@ eth_ice_dcf_pci_probe(__rte_unused struct rte_pci_driver *pci_drv,
 		dcf_adapter->num_reprs++;
 	}
 
+	if (ret == 0)
+		return 0;
+
+	for (i = 0; i < dcf_adapter->real_hw.num_vfs; i++) {
+		struct rte_eth_dev *vf_rep_eth_dev =
+			dcf_adapter->repr_infos[i].vf_rep_eth_dev;
+
+		if (vf_rep_eth_dev != NULL)
+			rte_eth_dev_destroy(vf_rep_eth_dev, ice_dcf_vf_repr_uninit);
+	}
+
+err_remove_dcf:
+	rte_eth_dev_pci_generic_remove(pci_dev, ice_dcf_dev_uninit);
+
 	return ret;
 }
 
-- 
2.25.1

