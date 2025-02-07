Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 699F1C02194
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 12:48:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B76E742E57;
	Fri,  7 Feb 2025 13:46:23 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id A284A42E8F
 for <dev@dpdk.org>; Fri,  7 Feb 2025 13:46:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738932378; x=1770468378;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=sn6fQTbSLjrlJwpwH2Hm0uDNEvq4acd6oze7Fw/D5ds=;
 b=QAK4jUawR3ULz0C9574W51JqZ2shnWWK3yqUkA5H7REbkS93MjuGrxfq
 NpFdQ7kX18kfCiA8ybSSckIma5UjQ2Zq6zVIJXElHEixdUSa/uk4zif5H
 cl9RRVQklFjupoBdujW/h3dtVH/F7+MrU+XOVB1muGaUa9uuAig4gBhiv
 pHG5V2IBWKi/B4zu6LFOL5qHSjIjI1ZkRJASlMXFcxalmso5t4h4D5aVg
 U19PMFFsnSZAT01KHGrwl9+bGf8klEcq0p2ACumtqZ/Ogty1WO9OiABjE
 +W/KniEJJokG91jojfwe4SsflB+Ic1GM7pK/mHHrhyUoeHbih7YRFrzar g==;
X-CSE-ConnectionGUID: nAp90+88QKCu++Hu8jTKWQ==
X-CSE-MsgGUID: F0d7kplrRqqa6K8TgZX6jA==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="43331848"
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; d="scan'208";a="43331848"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2025 04:46:18 -0800
X-CSE-ConnectionGUID: v1y+JT80QJen97w0ylJ8dg==
X-CSE-MsgGUID: Yyfk1mg0TgmbIjojhUHbyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="111953693"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by orviesa007.jf.intel.com with ESMTP; 07 Feb 2025 04:46:16 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v3 20/36] net/e1000/base: add queue select definitions
Date: Fri,  7 Feb 2025 12:45:12 +0000
Message-ID: <1bce06782af56f8f700358973e31e81179e9361e.1738932115.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1738932113.git.anatoly.burakov@intel.com>
References: <cover.1738328106.git.anatoly.burakov@intel.com>
 <cover.1738932113.git.anatoly.burakov@intel.com>
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

