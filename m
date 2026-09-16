Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD725C88E5C
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Sep 2026 12:20:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A198E42F13;
	Wed, 16 Sep 2026 14:18:54 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id A213942EF8
 for <dev@dpdk.org>; Wed, 16 Sep 2026 14:18:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789561131; x=1821097131;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=rmYfrxQacHVaaJHhOehwSH1dUH5gVqf3vIrQEs96DsA=;
 b=bolIWjbTfWqi2qQyc3sJ9feMiaF4YbDUaZIZn0W5UY19x0Bq+k1N3mPv
 JvrZABhBcqtGv65LJESOthhEncp/4QAze81rUAeis1Mg1fbF3TEifPfY4
 CAJBfpAesgPb0vdzjXjc0IMv66AHvzZl8+6wphemvAAR0qAa8ra4NpDxd
 CmNQRrsDjt6mo8lbbOJPvnWdgm/yzwifPaEdfDxokxhjOcxev0tUlosq9
 GEMwiCGwYo80cbp6kvvZrLBpZm3/AqtN18yPxBCTLVJ+m+lmHN4URFXCT
 2PI55RIGWckogeCC4vXkOCJDDTyHSewp2jZm3m+OUIUP0SJTBurQCudsn g==;
X-CSE-ConnectionGUID: NNSO4c7VQZm7ssoEXHHBpQ==
X-CSE-MsgGUID: InxqH41bRQmgzYytQVp33A==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="112702959"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="112702959"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 05:18:50 -0700
X-CSE-ConnectionGUID: gs2XjZNYQGOxLyeGmUV9Kg==
X-CSE-MsgGUID: CkdpfH3xSD2YYza5c6NPNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="272850277"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa008.jf.intel.com with ESMTP; 16 Sep 2026 05:18:50 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v3 12/19] net/ixgbe: advertise flow keep capability
Date: Wed, 16 Sep 2026 13:18:18 +0100
Message-ID: <2b8b1ef8b636d23db9a9741f38ece4e31bf3997a.1789560946.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1789560943.git.anatoly.burakov@intel.com>
 <cover.1789560943.git.anatoly.burakov@intel.com>
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

The ixgbe driver's rte_flow implementation has always endeavored to keep
flows across device restart, however it never advertised this capability.
Advertise it explicitly.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_ethdev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
index 78f3ab57aea..48b1957ea94 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
@@ -4002,6 +4002,9 @@ ixgbe_dev_info_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 	dev_info->reta_size = ixgbe_reta_size_get(hw->mac.type);
 	dev_info->flow_type_rss_offloads = IXGBE_RSS_OFFLOAD_ALL;
 
+	/* rte_flow rules are kept across dev_stop/dev_start and replayed on start */
+	dev_info->dev_capa |= RTE_ETH_DEV_CAPA_FLOW_RULE_KEEP;
+
 	dev_info->speed_capa = RTE_ETH_LINK_SPEED_1G | RTE_ETH_LINK_SPEED_10G;
 	if (hw->device_id == IXGBE_DEV_ID_X550EM_A_1G_T ||
 			hw->device_id == IXGBE_DEV_ID_X550EM_A_1G_T_L)
-- 
2.52.0

