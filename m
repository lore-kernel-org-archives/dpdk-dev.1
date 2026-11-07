Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B19606A326
	for <dpdk-dev@archiver.kernel.org>; Sat,  7 Nov 2026 23:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Nv4Pu3eZ
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 978DE40ED2;
	Sun,  8 Nov 2026 00:57:43 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTPS id 03FA840ED2;
 Sun,  8 Nov 2026 00:57:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794095863; x=1825631863;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=WLN9Xkr+fjx2oSoE2lnjD2FS3oBL2oR0tU6EgFFHNpY=;
 b=Nv4Pu3eZxO8wdxdHWOPLJqKeGXmGl83LGJ5XsdQmy933DVCAWksqeL9j
 qtsuVvq6ap7JZTkXMZ/saF47LBXq2BTPGG8E8VHjegN6PJBL4COZBRATn
 j3cM84CIWw1T3JWUAGsblU8jjnhpX8Jrowxb+oWkztwvIPffEbMBo0Md7
 V47e5ITCuraL7+XpEMu1MFtmFJI2wtMPc4+g+KvLAo4eHc2CfEA4bTiw1
 5nPTfN/QRu++zhFychFCoSAEYCBoK7wnnvTtNYR9E2VKPfSdDNiVVIO6v
 TrTZExMH9P8kNOErkJLhmzsPfQmZBhkl0lQRluAAMbVGylYVpBHW2ocqJ A==;
X-CSE-ConnectionGUID: OqGST1VMS1Oj9dv77ZpsYA==
X-CSE-MsgGUID: cyw/b6uyRuqCjjWjWZEBfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11959"; a="2885099"
X-IronPort-AV: E=Sophos;i="6.27,200,1787036400"; 
   d="scan'208";a="2885099"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2026 15:57:42 -0800
X-CSE-ConnectionGUID: Tz+dJjQsTBq1eXgFv75/VQ==
X-CSE-MsgGUID: xd08H2BSSZ2wbdnAX7SdDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,200,1787036400"; 
   d="scan'208";a="7464682"
Received: from pae.iind.intel.com (HELO PAE-35.iind.intel.com) ([10.49.105.82])
 by orviesa005.jf.intel.com with ESMTP; 07 Nov 2026 15:57:40 -0800
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, anatoly.burakov@intel.com,
 Anurag Mandal <anurag.mandal@intel.com>, stable@dpdk.org
Subject: [PATCH v2 8/8] net/ice: fix DCF port leak on probe failure
Date: Sat,  7 Nov 2026 23:52:18 +0000
Message-Id: <f7452dc3ec78c252cf98b9d8c02e94004688ff06.1794094943.git.anurag.mandal@intel.com>
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
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
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

