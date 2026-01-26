Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E2FD19502
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Jan 2026 16:45:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6F1FB40276;
	Mon, 26 Jan 2026 17:45:29 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 8B546400D7
 for <dev@dpdk.org>; Mon, 26 Jan 2026 17:45:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769445928; x=1800981928;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=O1JtCxPCI949W8hUoHbu6uZ00aaXWAZRdnlUGLTAIWs=;
 b=QK0GgW+R6RBBx7xsPFags7IxXeNfPfby44y+ZEZZ3FTxiT4IHW0hiaN5
 I0OHeR4EQycEcI6yqvLtRsMx/wUJyr0kiEUJ30w1iBRgNGe0gPPdEWACr
 woNXEq95CxF7eItSfVSjidUTl0cRWKUyghPCJJ/85Yon990ioSfn/QOi/
 RA1mAhaivG7HuysA0X19R33r+xy6U1aWD4WKU3y1WY9/AwQal8TpuvyYT
 ge5yP5OtwyghVHCt4zURX1JjMjupIprvk21uwdQtwg9c/9ICaanPbZFv5
 cSFg1up01wTmsg4c6+U1qRvsAlFB4WifaYgAQDF43f1KkcQyU4xLAhjoN g==;
X-CSE-ConnectionGUID: KitaPh4/Q92zND3TNIZj7A==
X-CSE-MsgGUID: rJXe8FmsT8G2a5aNP+5Byw==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="70531516"
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; d="scan'208";a="70531516"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jan 2026 08:45:27 -0800
X-CSE-ConnectionGUID: 7/njNyCsTVi7n8KXyByUEQ==
X-CSE-MsgGUID: 2xVNVtCASImlxGVj/hthVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; d="scan'208";a="206838140"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa006.jf.intel.com with ESMTP; 26 Jan 2026 08:45:26 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 1/2] eal: add location info to interrupt error message
Date: Mon, 26 Jan 2026 16:45:18 +0000
Message-ID: <20260126164519.3029952-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
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

The error message about the interrupt being unallocated is called from
multiple positions, so if seen in the logs the user cannot tell which
function is actually generating the message. Add function name and line
number info to the message to clarify things.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eal/common/eal_common_interrupts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/eal/common/eal_common_interrupts.c b/lib/eal/common/eal_common_interrupts.c
index b42fa862f3..a2a310750a 100644
--- a/lib/eal/common/eal_common_interrupts.c
+++ b/lib/eal/common/eal_common_interrupts.c
@@ -17,7 +17,7 @@
 /* Macros to check for valid interrupt handle */
 #define CHECK_VALID_INTR_HANDLE(intr_handle) do { \
 	if (intr_handle == NULL) { \
-		EAL_LOG(DEBUG, "Interrupt instance unallocated"); \
+		EAL_LOG(DEBUG, "%s, ln %d: Interrupt instance unallocated", __func__, __LINE__); \
 		rte_errno = EINVAL; \
 		goto fail; \
 	} \
-- 
2.51.0

