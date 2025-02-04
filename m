Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D450C02196
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 15:15:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AB1AE42DA7;
	Tue,  4 Feb 2025 16:12:21 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id BF20A427B7
 for <dev@dpdk.org>; Tue,  4 Feb 2025 16:12:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738681927; x=1770217927;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=sn6fQTbSLjrlJwpwH2Hm0uDNEvq4acd6oze7Fw/D5ds=;
 b=CVBCARDEIPOBtkEi/wpGo79aTxAVVWEDAJ+EiyyKNg5pEb3A6dMWwTdB
 gg+G8SX2ctyhBeidOMVt2nzMXftSreomoev5uYiEbids0C7twhFkzQclw
 dxIfspAtTC4kbCiB/2XEx1ZAhLs3lobxPVp/346sYoNCXc+K/PggctUZf
 C0dVjiP1EshNJh9sStmAbGSPA+/Dy1i8g+cwPLcJjVc3IkxL4hfgVLDJ4
 +gY8cbBFst7NQHNSUdx7yPHQOpP1gGiZbz0OHnWH1HmFDs0ZyAfolda0a
 yAW1PCa7hRemplmMrsmniAIgt4AwKxQ5CeaVAT+TBZ19nZSfk/zdQLeE1 g==;
X-CSE-ConnectionGUID: S7kZy04ZSEumiNBk6zFung==
X-CSE-MsgGUID: FhXb7AaBSDCiuOMjQdyxjQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39097147"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="39097147"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2025 07:12:07 -0800
X-CSE-ConnectionGUID: i7H7J1LrRB+h8BsN1AZxog==
X-CSE-MsgGUID: s0TDbpxjRhOX6e5jzN6wHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="110792710"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa008.fm.intel.com with ESMTP; 04 Feb 2025 07:12:05 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com
Subject: [PATCH v2 31/54] net/e1000/base: add queue select definitions
Date: Tue,  4 Feb 2025 15:10:37 +0000
Message-ID: <24d29d54a9d90e9c6dc99c33b6e3a00266b800d0.1738681726.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1738681725.git.anatoly.burakov@intel.com>
References: <cover.1738328106.git.anatoly.burakov@intel.com>
 <cover.1738681725.git.anatoly.burakov@intel.com>
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

From: Sasha Neftin <sasha.neftin@intel.com>

Add definitions for address select mask (selects source address to be
used in the address filtering), as well as queue select (indicates which
Rx queue should get the packet matching this MAC address).

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/e1000_defines.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/intel/e1000/base/e1000_defines.h b/drivers/net/intel/e1000/base/e1000_defines.h
index 2c3b806c92..c311858d35 100644
--- a/drivers/net/intel/e1000/base/e1000_defines.h
+++ b/drivers/net/intel/e1000/base/e1000_defines.h
@@ -685,6 +685,13 @@
  */
 #define E1000_RAR_ENTRIES	15
 #define E1000_RAH_AV		0x80000000 /* Receive descriptor valid */
+#define E1000_RAH_RAH_MASK	0x0000FFFF
+#define E1000_RAH_ASEL_MASK	0x00030000
+#define E1000_RAH_ASEL_SRC_ADD	0x00010000
+#define E1000_RAH_QSEL_MASK	0x000C0000
+#define E1000_RAH_QSEL_SHIFT	18
+#define E1000_RAH_ASEL_SRC_ADDR	0x00010000
+#define E1000_RAH_QSEL_ENABLE	0x10000000
 #define E1000_RAL_MAC_ADDR_LEN	4
 #define E1000_RAH_MAC_ADDR_LEN	2
 #define E1000_RAH_QUEUE_MASK_82575	0x000C0000
-- 
2.43.5

