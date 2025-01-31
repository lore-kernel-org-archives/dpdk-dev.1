Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F9DC0218F
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jan 2025 13:01:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 60FCF42E59;
	Fri, 31 Jan 2025 13:59:52 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 0406342E0C
 for <dev@dpdk.org>; Fri, 31 Jan 2025 13:59:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738328385; x=1769864385;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=uIIIbQhZ5IWTlzJOpYxqxeNcNMf2OKF9aEZ80rJvChk=;
 b=c1F5gDnmGKfbA6rKJvoTQ5S2DssycKKHwATitb31ddBkiBp668SOmVlc
 0QjPxIFGr2MwGMvTt8LDsn2AinreN/z94v7nHiEkCQK5+Ho3rheEi0EZi
 aiuUJUgc868qR3XgeKBZmAoxQ/OzJ/etZnlBM+R6eqQ4VNQ8sJa51DaGd
 r28E99T6dJQMcRVED/mcyWSZLiJ8OYvocDOG4afH6ADaZE61H31P9RnZ+
 VB6iC4vM+zOmMnXlu5vtfkfXFhXjQVA7Zzf7ImnBUWlrNreRMPXz++qDz
 1LsGAeM+S1Nygh7EAdMS34Wcg/W9Z17SUWoHYAQi81wmvpCx1dMMT5j6z g==;
X-CSE-ConnectionGUID: MclUi/6fR0q8aPgzzGDH8Q==
X-CSE-MsgGUID: +1IUdGrESlKrlMnBzDxxYw==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="50315639"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="50315639"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2025 04:59:45 -0800
X-CSE-ConnectionGUID: WvgPigyNROqGi6BMVuMYmg==
X-CSE-MsgGUID: mXldlSjPSuKWQqIivZdpPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="140503399"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa001.fm.intel.com with ESMTP; 31 Jan 2025 04:59:44 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 19/42] net/e1000/base: add queue select definitions
Date: Fri, 31 Jan 2025 12:58:32 +0000
Message-ID: <595b36050510bb9602734a811ca0c332754e5a84.1738328107.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1738328106.git.anatoly.burakov@intel.com>
References: <cover.1738328106.git.anatoly.burakov@intel.com>
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
index 4a5559d0ca..bfc65fd17c 100644
--- a/drivers/net/intel/e1000/base/e1000_defines.h
+++ b/drivers/net/intel/e1000/base/e1000_defines.h
@@ -684,6 +684,13 @@
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

