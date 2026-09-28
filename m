Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F37CA5FA2
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Sep 2026 09:48:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 094F640A84;
	Mon, 28 Sep 2026 11:48:57 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 235ED40041;
 Mon, 28 Sep 2026 11:48:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790588935; x=1822124935;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=fJ1Xh/oUMoLtsE8xjKCFjuiUEg28hp9etIdSbvOgTP4=;
 b=UrDTIUtciXhlmL36/K2tVmGYGJRVUm/GwkV5mJO3kk769ISzcyuVNWkU
 FzXv2kXGismN5SkE4KZ+2xT/n5bRCtuMBDFAGFafSfV+B+PdVmxckBXMH
 EAVuQNYBZM/JGXZeUTCISuD5wop8oBxxiEr9HUJh1A8RpAziDSKSK+4ET
 AO04h7JZx1bXG1+0JiYNLPu5TEXfQnpFoX62uiVCxEy7NZ3nzT1BnTb2h
 ecBERZ3Y7zqWYExNqLkk8G0oR9H7cqsALotix4y3qw0/F9Ab+S/jY8D/B
 vQo4CCs+DsyWKq0/JmtkVRrs9oaD7XOCERk8v7mgCtyMSRd2sxbFF1RNW w==;
X-CSE-ConnectionGUID: u7MCT0xrRaezy1cDmvxslQ==
X-CSE-MsgGUID: 380w6TT0RumZi6eaBfKmDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="90152505"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; d="scan'208";a="90152505"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2026 02:48:54 -0700
X-CSE-ConnectionGUID: qkm5AjS0Sa+gV2YW1QLwMw==
X-CSE-MsgGUID: 6mC2ddZuQRy8vHU5BbQ2KA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; d="scan'208";a="301287608"
Received: from unknown (HELO localhost.localdomain.iind.intel.com)
 ([10.49.105.104])
 by fmviesa002.fm.intel.com with ESMTP; 28 Sep 2026 02:48:52 -0700
From: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
To: dev@dpdk.org
Cc: Anatoly Burakov <anatoly.burakov@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Carolyn Wyborny <carolyn.wyborny@intel.com>,
 Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
 Jedrzej Jagielski <jedrzej.jagielski@intel.com>, stable@dpdk.org,
 Sandeep Penigalapati <sandeep.penigalapati@intel.com>
Subject: [PATCH] net/ixgbe: fix null dereference on EEPROM write for E610
Date: Mon, 28 Sep 2026 12:50:54 -0400
Message-Id: <20260928165054.20913-1-sandeep.penigalapati@intel.com>
X-Mailer: git-send-email 2.27.0
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

E610 does not support EEPROM writes and leaves eeprom.ops.write_buffer
as NULL. ixgbe_set_eeprom() calls this pointer without checking it,
causing a NULL pointer dereference when a set-eeprom request is issued
on an E610 port.

Check the op for NULL and return -ENOTSUP instead.

Fixes: 316637762a5f ("net/ixgbe/base: enable E610 device")
Cc: stable@dpdk.org

Signed-off-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_ethdev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
index 78e19f94c0..c653951858 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
@@ -7370,6 +7370,9 @@ ixgbe_set_eeprom(struct rte_eth_dev *dev,
 
 	in_eeprom->magic = hw->vendor_id | (hw->device_id << 16);
 
+	if (eeprom->ops.write_buffer == NULL)
+		return -ENOTSUP;
+
 	return eeprom->ops.write_buffer(hw,  first, length, data);
 }
 
-- 
2.27.0

