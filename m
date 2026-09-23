Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C88C98302
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Sep 2026 04:23:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1FCAF4028C;
	Wed, 23 Sep 2026 06:23:24 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id AA7F040270;
 Wed, 23 Sep 2026 06:23:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790137403; x=1821673403;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=OfstuVFkTHX7FtBp7PZiAgl53ihy8a4owKHPHPhB2G8=;
 b=h/99mNYjPftAlHOwQb7JSFnRO8i6g0rgz68dxLNRGf0RUbfvEHJWBWVa
 hf/yR8GC+OceS/L7BkAHbiAu3eipHk7EuqMLIElS4xUQf09Bp0kUYoDBk
 Una0yOug0neMP7G5L0O1pYI9tYUtvIFdl0SRoyMGY0Hvzqu585ejPerXH
 CBpOnQjKUcmLfkz6r1AZtVnkWn66I0KDh2m3ycgFJ+bcXTtsMDg0C1p9Y
 jRqPdMhVzBk1a0qOiluaTeuYG4xO+UnEUm2QTm7dbOXKh/R8pI+cvltcb
 e/nhVlkMSppCMYUCYmUGpFKLXk2CzItUGX/VpBqIVBZCah6C/TI2pnnnY w==;
X-CSE-ConnectionGUID: bkzWYKn5RmWnb7Bk6houCw==
X-CSE-MsgGUID: LeMIevrJQeKE5tkAKEDXvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="101459811"
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; d="scan'208";a="101459811"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 21:23:22 -0700
X-CSE-ConnectionGUID: +rvmJ5oDTXGTlCtgU15p3g==
X-CSE-MsgGUID: WSYEOfTfRaCdT58UDlgqfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; d="scan'208";a="273613849"
Received: from unknown (HELO localhost.localdomain.iind.intel.com)
 ([10.49.105.104])
 by fmviesa008.fm.intel.com with ESMTP; 22 Sep 2026 21:23:18 -0700
From: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
To: dev@dpdk.org
Cc: Anatoly Burakov <anatoly.burakov@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
 Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
 Carolyn Wyborny <carolyn.wyborny@intel.com>, stable@dpdk.org,
 Sandeep Penigalapati <sandeep.penigalapati@intel.com>
Subject: [PATCH] net/ixgbe: fix spurious MACsec event on E610
Date: Wed, 23 Sep 2026 07:25:19 -0400
Message-Id: <20260923112519.10600-1-sandeep.penigalapati@intel.com>
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

On 82599 and X5xx, EICR bit 0x00200000 is the MACsec PN-threshold cause
(IXGBE_EICR_LINKSEC). On E610 the very same bit is redefined as the
asynchronous firmware event cause (IXGBE_EICR_FW_EVENT). The interrupt
handler decoded this bit unconditionally as LINKSEC and raised
RTE_ETH_EVENT_MACSEC.

As E610 does not support MACsec, every firmware event (for example a
link change) was reported to the application as a spurious MACsec event.
In addition, the firmware events posted on the Admin Command Interface
(ACI) receive queue were never drained, so the cause was not cleared.

Decode the bit per MAC type: on E610 treat it as a firmware event and
drain the ACI receive queue until empty; keep the MACsec handling for
the other MAC types. Link changes continue to be handled through the
existing IXGBE_EICR_LSC path.

Fixes: 316637762a5f ("net/ixgbe/base: enable E610 device")
Cc: stable@dpdk.org
Signed-off-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_ethdev.c | 46 ++++++++++++++++++++++++--
 drivers/net/intel/ixgbe/ixgbe_ethdev.h |  1 +
 2 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
index c5010f623c..43fefc636c 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
@@ -39,6 +39,7 @@
 #include "base/ixgbe_api.h"
 #include "base/ixgbe_vf.h"
 #include "base/ixgbe_common.h"
+#include "base/ixgbe_e610.h"
 #include "ixgbe_ethdev.h"
 #include "ixgbe_bypass.h"
 #include "ixgbe_rxtx.h"
@@ -4655,8 +4656,17 @@ ixgbe_dev_interrupt_get_status(struct rte_eth_dev *dev)
 	if (eicr & IXGBE_EICR_MAILBOX)
 		intr->flags |= IXGBE_FLAG_MAILBOX;
 
-	if (eicr & IXGBE_EICR_LINKSEC)
-		intr->flags |= IXGBE_FLAG_MACSEC;
+	/*
+	 * Bit 0x00200000 is LINKSEC (MACsec) on 82599/X5xx, but FW_EVENT
+	 * (async firmware event) on E610, which has no MACsec. Decode it per
+	 * MAC type to avoid reporting a spurious RTE_ETH_EVENT_MACSEC on E610.
+	 */
+	if (eicr & IXGBE_EICR_LINKSEC) {
+		if (hw->mac.type == ixgbe_mac_E610)
+			intr->flags |= IXGBE_FLAG_FW_EVENT;
+		else
+			intr->flags |= IXGBE_FLAG_MACSEC;
+	}
 
 	if (hw->mac.type ==  ixgbe_mac_X550EM_x &&
 	    hw->phy.type == ixgbe_phy_x550em_ext_t &&
@@ -4701,6 +4711,33 @@ ixgbe_dev_link_status_print(struct rte_eth_dev *dev)
 				pci_dev->addr.function);
 }
 
+static void
+ixgbe_dev_handle_fw_event(struct rte_eth_dev *dev)
+{
+	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	uint8_t buf[IXGBE_ACI_MAX_BUFFER_SIZE];
+	struct ixgbe_aci_event event;
+	bool pending = false;
+	s32 status;
+
+	memset(&event, 0, sizeof(event));
+	event.buf_len = sizeof(buf);
+	event.msg_buf = buf;
+
+	do {
+		status = ixgbe_aci_get_event(hw, &event, &pending);
+		if (status) {
+			if (status != IXGBE_ERR_ACI_NO_EVENTS)
+				PMD_DRV_LOG(DEBUG,
+					"Failed to read FW event from ACI: %d",
+					status);
+			break;
+		}
+		PMD_DRV_LOG(DEBUG, "Received FW event, opcode 0x%04x",
+			rte_le_to_cpu_16(event.desc.opcode));
+	} while (pending);
+}
+
 /*
  * It executes link_update after knowing an interrupt occurred.
  *
@@ -4732,6 +4769,11 @@ ixgbe_dev_interrupt_action(struct rte_eth_dev *dev)
 		intr->flags &= ~IXGBE_FLAG_PHY_INTERRUPT;
 	}
 
+	if (intr->flags & IXGBE_FLAG_FW_EVENT) {
+		ixgbe_dev_handle_fw_event(dev);
+		intr->flags &= ~IXGBE_FLAG_FW_EVENT;
+	}
+
 	if (intr->flags & IXGBE_FLAG_NEED_LINK_UPDATE) {
 		struct rte_eth_link link;
 
diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.h b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
index 5d3243cb4d..ec6eeffeb1 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.h
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
@@ -28,6 +28,7 @@
 #define IXGBE_FLAG_PHY_INTERRUPT    (uint32_t)(1 << 2)
 #define IXGBE_FLAG_MACSEC           (uint32_t)(1 << 3)
 #define IXGBE_FLAG_NEED_LINK_CONFIG (uint32_t)(1 << 4)
+#define IXGBE_FLAG_FW_EVENT         (uint32_t)(1 << 5)
 
 /*
  * Defines that were not part of ixgbe_type.h as they are not used by the
-- 
2.27.0

