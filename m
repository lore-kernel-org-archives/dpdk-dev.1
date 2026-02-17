Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AADA5E6817B
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 12:17:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 86F7340B90;
	Tue, 17 Feb 2026 13:15:25 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 0A52940B9E
 for <dev@dpdk.org>; Tue, 17 Feb 2026 13:15:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771330508; x=1802866508;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=WrOaDXFvbyE0AfywkAwOngN2DN1zizbB75MK9dt9lKw=;
 b=TQw7IfJJik0IdUaSYqkBppaPyYQfMCUChEMw6H/WghL/da6FufYwpjfE
 Vu/SQws4pOpDkNJt3trIQxB9arqG49ApiF9HYv6RZfMVBDRR6+EbVGuTc
 oHIunbffLPtXypF/eC0RouK4eC2h5W01bhV5cvYpRLZ1i7mMDULiKZqQN
 7u0YF3HZRjTg4kl2vakt+jqHZM1W9Dxsq77x+7/1d/mXxn5MwjTNbNRsF
 T27LCENm4J9mys40XsEms9zptnMvnFlyCixKXClnoKfi4S8GDQBkFebRv
 bk1jCM/YTaqirIgkWXzmxL2cpdgBMcNpIcV+VYitLrCSSCXTBqTfJBn6J A==;
X-CSE-ConnectionGUID: N4yf5EIkRQe8NySfhMoz1Q==
X-CSE-MsgGUID: an/zQSaQRpuo7kyeVmclyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="74996072"
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; d="scan'208";a="74996072"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2026 04:15:08 -0800
X-CSE-ConnectionGUID: zkq0B3QlT8uvgM/GaCld2Q==
X-CSE-MsgGUID: j6dmfA3LTMK8KhVPIy+GEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; d="scan'208";a="218396854"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa004.jf.intel.com with ESMTP; 17 Feb 2026 04:15:07 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v5 25/27] net/ice: avoid rte malloc in MAC address operations
Date: Tue, 17 Feb 2026 12:14:14 +0000
Message-ID: <22c6aeb85d14778c49e9dcdcc1f53cada6f90efc.1771330391.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1771330390.git.anatoly.burakov@intel.com>
 <cover.1771330390.git.anatoly.burakov@intel.com>
References: 
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

Currently, when adding or deleting MAC addresses, we are using
rte_zmalloc followed by an immediate rte_free. This is not needed as this
memory is not being stored anywhere, so replace it with regular
calloc/free.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ice/ice_dcf_ethdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/ice/ice_dcf_ethdev.c b/drivers/net/intel/ice/ice_dcf_ethdev.c
index 037382b336..d2a7a2847b 100644
--- a/drivers/net/intel/ice/ice_dcf_ethdev.c
+++ b/drivers/net/intel/ice/ice_dcf_ethdev.c
@@ -936,7 +936,7 @@ dcf_add_del_mc_addr_list(struct ice_dcf_hw *hw,
 	len = sizeof(struct virtchnl_ether_addr_list);
 	len += sizeof(struct virtchnl_ether_addr) * mc_addrs_num;
 
-	list = rte_zmalloc(NULL, len, 0);
+	list = calloc(1, len);
 	if (!list) {
 		PMD_DRV_LOG(ERR, "fail to allocate memory");
 		return -ENOMEM;
@@ -961,7 +961,7 @@ dcf_add_del_mc_addr_list(struct ice_dcf_hw *hw,
 		PMD_DRV_LOG(ERR, "fail to execute command %s",
 			    add ? "OP_ADD_ETHER_ADDRESS" :
 			    "OP_DEL_ETHER_ADDRESS");
-	rte_free(list);
+	free(list);
 	return err;
 }
 
-- 
2.47.3

