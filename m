Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A45C83F17
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Jul 2025 08:57:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1554A4014F;
	Fri, 18 Jul 2025 10:57:46 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 8B3634013F;
 Fri, 18 Jul 2025 10:57:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752829065; x=1784365065;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=SxLugZSTF9Gj5C1DXuudlDbMg6FUaXuX8wUslTI0Yfo=;
 b=TechJ7qtl8YGjzh6jXOQXL1BXEyqJtZHDYqBXNwHBZ9DYvzhnh/xyD63
 S+HqMqRMAHKwiPfZXJA76Ch9BKqL4cEgOV2ejOWcklVJZK3C34a2S3fF+
 VUrIUyedC62dzT0t0OTJ35BffKAYSC734WMeUcd/TW8zLX1UsthfPG21D
 QVGm11lmXLbUNNMs8HSojCcvHAOWIzQJO/afbSFlfWJOZFVa3BcAyAVSq
 jV7BeQScHsBeLqsrKvu73sjw9FnkLrmDw33NRevnR0yoCA9530A14u6mJ
 X6yCLPUuH8KBNgLytPj1yor6zv55OAWRQNAjyl7yLuNZtP9Q62kAqHJS/ g==;
X-CSE-ConnectionGUID: 16L3ZXSFRL+jcZ1mOGMpYg==
X-CSE-MsgGUID: 0CmlPINtQwu8G1Ng7SLgGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="55242598"
X-IronPort-AV: E=Sophos;i="6.16,321,1744095600"; d="scan'208";a="55242598"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2025 01:57:43 -0700
X-CSE-ConnectionGUID: Xtw0D08yRx6kFoZnZoc2NQ==
X-CSE-MsgGUID: aSDTwAHRQmW6QyMRHBdG6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,321,1744095600"; d="scan'208";a="157681055"
Received: from unknown (HELO localhost.localdomain) ([10.239.252.210])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2025 01:57:41 -0700
From: Yuan Wang <yuanx.wang@intel.com>
To: anatoly.burakov@intel.com,
	vladimir.medvedkin@intel.com
Cc: dev@dpdk.org,
	Yuan Wang <yuanx.wang@intel.com>,
	stable@dpdk.org
Subject: [PATCH] net/ixgbe: fix SCTP port support on E610
Date: Fri, 18 Jul 2025 16:53:35 +0800
Message-ID: <20250718085335.648078-1-yuanx.wang@intel.com>
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

E610 supports SCTP port in FDIR filter, so add it to the support list.

Fixes: 86e19565f5e2 (net/ixgbe: fix SCTP port support)
Cc: stable@dpdk.org

Signed-off-by: Yuan Wang <yuanx.wang@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_flow.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index 6278646720..1bf0af330f 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -2114,7 +2114,8 @@ ixgbe_parse_fdir_filter_normal(struct rte_eth_dev *dev,
 		/* only x550 family only support sctp port */
 		if (hw->mac.type == ixgbe_mac_X550 ||
 		    hw->mac.type == ixgbe_mac_X550EM_x ||
-		    hw->mac.type == ixgbe_mac_X550EM_a) {
+		    hw->mac.type == ixgbe_mac_X550EM_a ||
+		    hw->mac.type == ixgbe_mac_E610) {
 			/**
 			 * Only care about src & dst ports,
 			 * others should be masked.
-- 
2.47.1

