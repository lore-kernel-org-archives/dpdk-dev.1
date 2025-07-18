Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65FB6C83F17
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Jul 2025 09:13:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4EC884014F;
	Fri, 18 Jul 2025 11:13:46 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id C90DF4013F;
 Fri, 18 Jul 2025 11:13:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752830025; x=1784366025;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=gDWG0V6EOSTr4sI9NGThV55mWe34dkKBGqZrOXcTz6Q=;
 b=MJ3sND3fkr1VeqjBGPxZZElap2KuT7eX6rM9n3wQZ8p4sN35zRO3hCqz
 QEy/BOW5FofX09nlv92Her20WL15Q1v2p3ow8LMQJwZM8BKbLGHGZQXbI
 Ybq7JA/J+fvCGIYPgO4GJPwtzU5qQCzBq49bt0NXi1bf7m5pVthv6Gfio
 PWjuprBRNo0S7OjL9WYiTE6I8SyM0nZpRdTgUFH+uEDbI2nTJs+A8E7bK
 UULlL2fvYFsa8FGgtiy1mJ5gfOhe8WijnKLRsBR+5zvO2fr9CoMV8i6Ey
 2l0kzXIcgV1OwnFMgkdcDb+8nnQolXb5HIh69q/l4qNYiqy1PE5IuSxdb Q==;
X-CSE-ConnectionGUID: ZCEmX8PrRhCT9+kIPaFn/A==
X-CSE-MsgGUID: L9nv3KSySu28nyaa7WSOow==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="72687688"
X-IronPort-AV: E=Sophos;i="6.16,321,1744095600"; d="scan'208";a="72687688"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2025 02:13:44 -0700
X-CSE-ConnectionGUID: OjoxqFqlS6WsEpHayTCH3g==
X-CSE-MsgGUID: asdYAF+USsKmvwcSa0H5yA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,321,1744095600"; d="scan'208";a="157399349"
Received: from unknown (HELO localhost.localdomain) ([10.239.252.210])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2025 02:13:40 -0700
From: Yuan Wang <yuanx.wang@intel.com>
To: anatoly.burakov@intel.com,
	vladimir.medvedkin@intel.com
Cc: dev@dpdk.org,
	Yuan Wang <yuanx.wang@intel.com>,
	stable@dpdk.org
Subject: [PATCH] net/ixgbe: fix port mask default value on E610
Date: Fri, 18 Jul 2025 17:09:07 +0800
Message-ID: <20250718090907.649202-1-yuanx.wang@intel.com>
X-Mailer: git-send-email 2.47.1
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

Modification of default values should be limited to E610,
as 82599 handles raw IP well.

Fixes: c81daae2383a (net/ixgbe: fix port mask default value in filter)
Cc: stable@dpdk.org

Signed-off-by: Yuan Wang <yuanx.wang@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_flow.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index 1bf0af330f..71b11f9e70 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -1644,8 +1644,10 @@ ixgbe_parse_fdir_filter_normal(struct rte_eth_dev *dev,
 	memset(&rule->mask, 0xFF, sizeof(struct ixgbe_hw_fdir_mask));
 	rule->mask.vlan_tci_mask = 0;
 	rule->mask.flex_bytes_mask = 0;
-	rule->mask.dst_port_mask = 0;
-	rule->mask.src_port_mask = 0;
+	if (hw->mac.type == ixgbe_mac_E610) {
+		rule->mask.dst_port_mask = 0;
+		rule->mask.src_port_mask = 0;
+	}
 
 	/**
 	 * The first not void item should be
-- 
2.47.1

