Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A610CA1005
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Sep 2025 17:28:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3DDAD40A82;
	Tue,  2 Sep 2025 19:27:40 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id AAF1B40687
 for <dev@dpdk.org>; Tue,  2 Sep 2025 19:27:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756834051; x=1788370051;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=m0Def9rMk2E0Aw7woLj5bMJTiMWBUHwKkkKT4xuepM8=;
 b=k07QHndQJJ2Oo5DHu3ElA1CtuKk3afzkUYJwTGQXvnpPoXVOMPFnsWl6
 AMYbSQPfgwVk/JkXhiYu5T7uLMx7wNO/JXS/maRCFe8+yNfHZ4eNMphy7
 0C8EQkyuu46X6jz0l3Z/RjfO1irAtLTqriVqvHtnqFQAapJMFGzjfV7nr
 mSbcGOfaT8UNGJtb0jGugaHA8fLaOoK7GsUiu27lu0m6JEDMjmhMsbXM+
 Lra7V3q/y9dFHmmRm4gTUl5F34Iwe6+Uzy6eYMSZvROvcx1FtX2ekBzyt
 HBYx8Q2tMlfeZJhp9Not6LksOb7kmf4VArbFFnBORPjcexmMn6d7oApuk A==;
X-CSE-ConnectionGUID: 7O8Vi8HpT6u001N6Dp7bAQ==
X-CSE-MsgGUID: eq5KNXgOSPCVkjeQoD4WDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="69732039"
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; d="scan'208";a="69732039"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2025 10:27:30 -0700
X-CSE-ConnectionGUID: RT5lbiB+TsqdA2qkNBBSbw==
X-CSE-MsgGUID: zLLeKXA5SGuuFwgAlHzt+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; d="scan'208";a="171229148"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by orviesa007.jf.intel.com with ESMTP; 02 Sep 2025 10:27:30 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v1 12/12] net/ice: update README
Date: Tue,  2 Sep 2025 18:27:02 +0100
Message-ID: <188e136f855d4089bc2733ba00db3f986d3ef50f.1756833701.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1756833701.git.anatoly.burakov@intel.com>
References: 
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Update the README with date of latest driver snapshot.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ice/base/README | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/ice/base/README b/drivers/net/intel/ice/base/README
index 86f69d1d04..98182a8da6 100644
--- a/drivers/net/intel/ice/base/README
+++ b/drivers/net/intel/ice/base/README
@@ -1,12 +1,12 @@
 /* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2020-2024 Intel Corporation
+ * Copyright(c) 2020-2025 Intel Corporation
  */
 
 Intel® ICE driver
 ==================
 
 This directory contains source code of ice base driver generated on
-2025-05-23 released by the team which develops
+2025-09-01 released by the team which develops
 basic drivers for any ice NIC. The directory of base/ contains the
 original source package.
 This driver is valid for the product(s) listed below
-- 
2.47.3

