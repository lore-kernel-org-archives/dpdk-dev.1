Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9036C83F03
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Jul 2025 05:04:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BB0114021E;
	Wed,  9 Jul 2025 07:04:40 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 954264013F
 for <dev@dpdk.org>; Wed,  9 Jul 2025 07:04:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752037480; x=1783573480;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=2vC+9lJXlTK8j1inJ9X8eNWyiIw8eDlyGRrkvVT1r8g=;
 b=Xio4snx29ko+yRIZQrxg3D6+VUZy+llKvLdKwOqaHfGhImmVe4V17Hwl
 vMHQHk9Azr4ysxzEe3yJvtDmat3WFm/bo3swbQ9tjsipCPh/toOdcihXY
 /Xu1mIblNextItXQ8mc9BhiST1EDGxlVBJ4LGA3uGXqxem6LP0o8v5gHJ
 LbhA8UN+EcMAsT4yIzktMj6IVFjt0/qVvpOCuaPSOyReS4cGMMWgmOie9
 hpALm6sV2SbYDeQY/dfPyZ2HEoq3Ty/xTbqX2viichOsHbR6foGfSqQ3G
 D7eARxlrxapZepa5QeSO7iZYBjqvehX14mzvN5zyXTZyOHO95buc84GLH A==;
X-CSE-ConnectionGUID: RzEvOAG6QHyFESjkc0I+FA==
X-CSE-MsgGUID: XS1NrfZRRfqMacLVQBVHSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="58052932"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; d="scan'208";a="58052932"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2025 22:04:39 -0700
X-CSE-ConnectionGUID: psTga4DeQ6OYzKM/U0lvsQ==
X-CSE-MsgGUID: PvU+L1dUSEuf3jvlMq6yTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; d="scan'208";a="186680891"
Received: from srf-bkc.iind.intel.com ([10.49.110.107])
 by orviesa002.jf.intel.com with ESMTP; 08 Jul 2025 22:04:37 -0700
From: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, pravin.pathak@intel.com,
 Tirthendu Sarkar <tirthendu.sarkar@intel.com>
Subject: [PATCH] maintainers: update for dlb2
Date: Wed,  9 Jul 2025 01:04:34 -0400
Message-ID: <20250709050434.1296690-1-tirthendu.sarkar@intel.com>
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

Add myself as maintainer for dlb2.

Signed-off-by: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0e9357f3a3..7270475021 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1464,7 +1464,7 @@ M: Pavan Nikhilesh <pbhagavatula@marvell.com>
 F: drivers/event/octeontx/timvf_*
 
 Intel DLB2
-M: Pravin Pathak <pravin.pathak@intel.com>
+M: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
 F: drivers/event/dlb2/
 F: doc/guides/eventdevs/dlb2.rst
 
-- 
2.47.1

