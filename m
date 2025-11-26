Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0BCD1118A
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Nov 2025 16:59:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 69A3D40A79;
	Wed, 26 Nov 2025 17:59:53 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id F302C402D1
 for <dev@dpdk.org>; Wed, 26 Nov 2025 17:59:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764176392; x=1795712392;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=/P6UeZVLOBr5fU0HmD54eqIrqD7SRNk9qEyY7Cst+Ig=;
 b=MgGHTjj05aoCtnedtvU+AmX4R5olIrKKmf804AC1fQzOmfm2OO6BhbxW
 BDoY2V36ay8JMK1D1BdRYpGS4Dz0AHooHsTEe0jC8PtmHksujgnwfzUo2
 QgNB5bqan78R6O6SWVQWJZbr3fIbTclVFdRuFoT4LsQKIS6LYJY4tIPUx
 ODwv/ywcS1bB29HxopbbBbLdqaSIBsY0brSyJbcGVnO4XaWPH4gmcuJ7W
 V5QTf0bKxVXJLlf3TS/DLdbntrp3mkUuJjGGBvemJ6xAj32LQ1/ynImek
 sCiYfFgl/3zPvcyqxCgYuF8y4Sy072O1nk9MbHOpo2/yJAzycO70ZLxUL g==;
X-CSE-ConnectionGUID: WSXDoR1yRD2iQbLzC6ZQSw==
X-CSE-MsgGUID: mxYe/uZ9TS6SztJaXbQcqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11625"; a="66382854"
X-IronPort-AV: E=Sophos;i="6.20,228,1758610800"; d="scan'208";a="66382854"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2025 08:59:50 -0800
X-CSE-ConnectionGUID: IUc/HCBmQoaqMmcZ8jibrw==
X-CSE-MsgGUID: vYCp5JW4Tw6fRucoiXHcZg==
X-ExtLoop1: 1
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa003.fm.intel.com with ESMTP; 26 Nov 2025 08:59:49 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: soumyadeep.hore@intel.com, Bruce Richardson <bruce.richardson@intel.com>,
 Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH] Revert "net/iavf: fix check for PF Rx timestamp support"
Date: Wed, 26 Nov 2025 16:59:43 +0000
Message-ID: <20251126165943.1536164-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
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

This reverts commit d21c2fe6e5a1ef1e7cc9490f54f359db1cfd5283.
While fixing an issue with enabling Rx timestamping on PFs which don't
report Rx timestamping, the offending commit broke PFs which do support
Rx timestamping.

Fixes: d21c2fe6e5a1 ("net/iavf: fix check for PF Rx timestamp support")

Suggested-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/iavf/iavf_ethdev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index 3ef766de47..15e49fe248 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -1177,8 +1177,7 @@ iavf_dev_info_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 	if (vf->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_CRC)
 		dev_info->rx_offload_capa |= RTE_ETH_RX_OFFLOAD_KEEP_CRC;
 
-	if (vf->vf_res->vf_cap_flags & VIRTCHNL_VF_CAP_PTP &&
-	    vf->ptp_caps & VIRTCHNL_1588_PTP_CAP_RX_TSTAMP)
+	if (vf->vf_res->vf_cap_flags & VIRTCHNL_VF_CAP_PTP)
 		dev_info->rx_offload_capa |= RTE_ETH_RX_OFFLOAD_TIMESTAMP;
 
 	if (vf->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_VLAN_V2 &&
-- 
2.48.1

