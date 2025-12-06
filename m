Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F22D3B7DB
	for <dpdk-dev@archiver.kernel.org>; Sat,  6 Dec 2025 19:11:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C085340268;
	Sat,  6 Dec 2025 20:11:44 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 016744014F;
 Sat,  6 Dec 2025 20:11:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765048303; x=1796584303;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=CQsmjWDPdTJA7Bb4fuyxg+oJuqqpPabvrRfJxpSq4rU=;
 b=h/2MoMrIZr1bbqPSKbA4Vj3o4ENCUuLLFSMcbqaxL+8Q+Ev8y6DXSCwV
 obYc3zoiWp5Oihka/FEok2RdZeRC7gByHaiifiMg+PRgmVu26DBarYwVB
 g0MSXl8EN0tdF48It3trAmIfrgGutDIdIjUjrmZyKSmaaaA+3GaAsty4M
 gNqFDwhkBa+4S7DearKqHXOBCpYZDFUy9R+5/kl5h5xKMJkPSoffTVfmY
 dooTwI53+31YBz9DErKnRkJgnq3RgedsI3NBejDaeYYFKL1q2D/cfNdkQ
 xzCY+bcx54P72YIA4QbD0pCxOCT+0Ditjl0H97cPd/AZ8srCfZeNkC6PD Q==;
X-CSE-ConnectionGUID: M6r9P11iTaaXsBesfjh/xQ==
X-CSE-MsgGUID: sfncGcUoRyClXkcGWewrXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11634"; a="78406239"
X-IronPort-AV: E=Sophos;i="6.20,255,1758610800"; d="scan'208";a="78406239"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Dec 2025 11:11:42 -0800
X-CSE-ConnectionGUID: NyHPQMCDRRqK3/c6iRvEXQ==
X-CSE-MsgGUID: NEAkMK4aQQShOwpxrAaGmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,255,1758610800"; d="scan'208";a="226226958"
Received: from client-08.iind.intel.com ([10.190.203.57])
 by orviesa002.jf.intel.com with ESMTP; 06 Dec 2025 11:11:41 -0800
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, Anurag Mandal <anurag.mandal@intel.com>,
 stable@dpdk.org
Subject: [PATCH] net/i40e: fix QinQ stripping
Date: Sat,  6 Dec 2025 18:24:41 +0000
Message-ID: <20251206182441.68354-1-anurag.mandal@intel.com>
X-Mailer: git-send-email 2.43.0
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

Outer VLAN strip gets disabled when inner VLAN
stripping is enabled/disabled after enabling outer
VLAN stripping.
This happens because the respective register of
gets overridden by the VSI params update of
inner VLAN stripping.

This patch fixes the issue by re-enabling outer
VLAN stripping after modification of inner
VLAN stripping.

Fixes: c52ff36686a4 ("net/i40e: enable QinQ stripping")
Cc: stable@dpdk.org

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
---
 drivers/net/intel/i40e/i40e_ethdev.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
index b8ce79061b..c8153f3351 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.c
+++ b/drivers/net/intel/i40e/i40e_ethdev.c
@@ -4150,6 +4150,16 @@ i40e_vlan_offload_set(struct rte_eth_dev *dev, int mask)
 			i40e_vsi_config_vlan_stripping(vsi, TRUE);
 		else
 			i40e_vsi_config_vlan_stripping(vsi, FALSE);
+
+		/* When VLAN strip is enabled/disabled
+		 * after enabling outer VLAN stripping,
+		 * outer VLAN stripping gets disabled
+		 * as the register gets overridden by
+		 * VLAN's strip vsi param update.
+		 * Hence, re-enable outer VLAN stripping.
+		 */
+		if (rxmode->offloads & RTE_ETH_RX_OFFLOAD_QINQ_STRIP)
+			i40e_vsi_config_outer_vlan_stripping(vsi, TRUE);
 	}
 
 	if (mask & RTE_ETH_VLAN_EXTEND_MASK) {
-- 
2.43.0

