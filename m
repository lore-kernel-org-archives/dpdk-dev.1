Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FC7C02199
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 12:47:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6984442E63;
	Fri,  7 Feb 2025 13:46:07 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 24AD042E4F
 for <dev@dpdk.org>; Fri,  7 Feb 2025 13:46:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738932364; x=1770468364;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=vnoMMDbJ9NF4wb5IWU18lhAVTYfIK6fGoUykdXD1ics=;
 b=lfzP9MYndYOnV9Px/dt1o7zweToxDkjNSAnNZ6KXGZlyOn+nziAcd4nM
 tejjjcXVzV70D2OM+AvGbNvIB8kKgv61fIQJjQxhThuvod0eNGheeSrX4
 ZuN4DWkpESQLYc7KHWz1yoZ27jBQTatexhGeMhvlqhrvo/NXFLJl7xXWn
 FX9PaiLeMCvKmuQyonv5hbywvxhLjg/o6BeCXufcTo7mc9zdSGznErZDH
 ftmixXbaaQWOofUfU3YWtzPjZGpLfaiKhhJQEa8DhO1e4RZ98vrTY0+9g
 D9JQcauRfIXB/PmCOh1yizIqIof2ROBILYGj3UZPIuhqHBJcF5Uw6y1Lh A==;
X-CSE-ConnectionGUID: lHsDrfF0SEuTFiaT+lEKQA==
X-CSE-MsgGUID: 7bMrDvzXTCS/RnT4exkhGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="43331733"
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; d="scan'208";a="43331733"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2025 04:46:03 -0800
X-CSE-ConnectionGUID: RGEoQ0ICQHWHr3kD0Wxk8Q==
X-CSE-MsgGUID: QOcekyKtR1C+mX7zd18aPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="111953536"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by orviesa007.jf.intel.com with ESMTP; 07 Feb 2025 04:46:01 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v3 10/36] net/e1000/base: read PCIe bus info in i225
Date: Fri,  7 Feb 2025 12:45:02 +0000
Message-ID: <2b02ad5624d9b6a17a71a3b742d1da236e27f540.1738932115.git.anatoly.burakov@intel.com>
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

From: Dima Ruinskiy <dima.ruinskiy@intel.com>

Call e1000_get_bus_info_pcie_generic from i225 to read PCIe bus info.

Signed-off-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/e1000_i225.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/intel/e1000/base/e1000_i225.c b/drivers/net/intel/e1000/base/e1000_i225.c
index 5f2a084696..36cbe65ccd 100644
--- a/drivers/net/intel/e1000/base/e1000_i225.c
+++ b/drivers/net/intel/e1000/base/e1000_i225.c
@@ -94,7 +94,8 @@ static s32 e1000_init_mac_params_i225(struct e1000_hw *hw)
 	mac->mta_reg_count = 128;
 	/* Set rar entry count */
 	mac->rar_entry_count = E1000_RAR_ENTRIES_BASE;
-
+	/* bus type/speed/width */
+	mac->ops.get_bus_info = e1000_get_bus_info_pcie_generic;
 	/* reset */
 	mac->ops.reset_hw = e1000_reset_hw_i225;
 	/* hw initialization */
-- 
2.43.5

