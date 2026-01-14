Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83608D37E56
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 15:46:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0E6DA40E1C;
	Wed, 14 Jan 2026 16:45:26 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id E944A40E17;
 Wed, 14 Jan 2026 16:45:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768405525; x=1799941525;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=G/zgzM58Zsmx0reFA/PtYjUa8pn0rDrmQqw9mKZ8XoM=;
 b=UqeH5O4uYz0oCwq9bAD8X6LxJSfcPd3RAXQfQcr54vDJ5vVdRbopt2y/
 hGq/01Gesmr4PlJADrvJAI+UvdpwUsN8IULJUOIdbcOGUvY3PD9udFWWH
 32lo6me1Uea/Og94cZ17oUcr895P1hex3AZK/wx/K7uU8Knae/zFadRBo
 YoHA8+qCpyryTS1DzDST0qV+zIhq0ZcDUlkHusgliAzQvrH02T19Q+9g/
 Os24wwe9rUZqlvbxOCpA5Omy33GdgOcFBmfAup8jKWiaFIguiIzHGXWJO
 UyWp3ZBh+Ur6Ci9LV/6V6bqA7OXmcl1H8W5t9l+cQYpg+o/4X5lPLrgQ4 w==;
X-CSE-ConnectionGUID: qR9mfgVZRF2D7fcDkkjk8A==
X-CSE-MsgGUID: ARTJifcSSnutDzP96TeMQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="69870872"
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; d="scan'208";a="69870872"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2026 07:45:24 -0800
X-CSE-ConnectionGUID: f0raESZWT6aXqndrArqx4g==
X-CSE-MsgGUID: GR6l45jHSjOu7xw3AX9yLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; d="scan'208";a="203925012"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa010.jf.intel.com with ESMTP; 14 Jan 2026 07:45:22 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Stephen Hemminger <stephen@networkplumber.org>,
 Beilei Xing <beilei.xing@intel.com>, Qi Zhang <qi.z.zhang@intel.com>
Subject: [PATCH v4 14/31] net/i40e: fix build with shadow warnings enabled
Date: Wed, 14 Jan 2026 15:44:28 +0000
Message-ID: <20260114154450.2969716-15-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114154450.2969716-1-bruce.richardson@intel.com>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
 <20260114154450.2969716-1-bruce.richardson@intel.com>
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

The local variables defined with the I40E_WRITE_GLB_REG macro are
shadowing other variables. Rename the vars to start with "_" to avoid
this shadowing.

Fixes: 2bedd7277a10 ("net/i40e: print real global changes")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/intel/i40e/i40e_ethdev.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_ethdev.h b/drivers/net/intel/i40e/i40e_ethdev.h
index 3fca089d6c..70dc506037 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.h
+++ b/drivers/net/intel/i40e/i40e_ethdev.h
@@ -92,11 +92,11 @@
 #define I40E_WRITE_GLB_REG(hw, reg, value)				\
 	do {								\
 		uint32_t ori_val;					\
-		struct rte_eth_dev *dev;				\
-		struct rte_eth_dev_data *dev_data;			\
+		struct rte_eth_dev *_dev;				\
+		struct rte_eth_dev_data *_dev_data;			\
 		ori_val = I40E_READ_REG((hw), (reg));			\
-		dev_data = ((struct i40e_adapter *)hw->back)->pf.dev_data; \
-		dev = &rte_eth_devices[dev_data->port_id];		\
+		_dev_data = ((struct i40e_adapter *)hw->back)->pf.dev_data; \
+		_dev = &rte_eth_devices[_dev_data->port_id];		\
 		I40E_PCI_REG_WRITE(I40E_PCI_REG_ADDR((hw),		\
 						     (reg)), (value));	\
 		if (ori_val != value)					\
@@ -104,7 +104,7 @@
 				    "i40e device %s changed global "	\
 				    "register [0x%08x]. original: 0x%08x, " \
 				    "new: 0x%08x ",			\
-				    (dev->device->name), (reg),		\
+				    (_dev->device->name), (reg),		\
 				    (ori_val), (value));		\
 	} while (0)
 
-- 
2.51.0

