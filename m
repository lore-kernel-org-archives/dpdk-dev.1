Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4BA0C7EE39
	for <dpdk-dev@archiver.kernel.org>; Mon, 30 Jun 2025 10:49:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C76B240264;
	Mon, 30 Jun 2025 12:49:58 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 5EAA54025D
 for <dev@dpdk.org>; Mon, 30 Jun 2025 12:49:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751280597; x=1782816597;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=OXFsKwsY1Smcptxz4dMa3fQJ/5EYNNQOF6K/aOL9Mg8=;
 b=WLPgUWW3yEhxg2c0BpS5aZQntXxMz0GYVfYQjEjHqg87oG1qP6IuRre/
 0wEovzKBFEHd6JTC8kX73TipI/SlxXCTtVdsUdELEe3cO3rNf7TWmAQYo
 x6y2ZKI/7EdFJ54NJesy/rIp5jUBlElpP7nCjYdGxiV34zeszDgD/VwwP
 g0x4pkmHB5/sL9muQBd0zc5KK7eLmfYWw5oEXHYDFwQLgSv9V7Hu3yBXH
 iUH9i5qkrVx+3N5RfHakzYCnD/YCC6xZ9sG/5Jqc7+dTBYIlzmEPT1opk
 3lTPL/EhYhNsDc/3he0LiYIARgJ/U4p5Md4aFZh/iE03eSf1aLIRMxk8l g==;
X-CSE-ConnectionGUID: pYqnIi3PRLOOSp31HC3t5w==
X-CSE-MsgGUID: wB3Q8XBUQgS9Bm40i0Wyiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11479"; a="64555352"
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; d="scan'208";a="64555352"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2025 03:49:56 -0700
X-CSE-ConnectionGUID: 4Bx3Dq1ORECMQg75tuJrFQ==
X-CSE-MsgGUID: T0sZdOh8QYG0ztACP9aCpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; d="scan'208";a="184348965"
Received: from silpixa00401385.ir.intel.com ([10.237.214.33])
 by fmviesa001.fm.intel.com with ESMTP; 30 Jun 2025 03:49:55 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH] node: fix C++ compatibility errors (option 1)
Date: Mon, 30 Jun 2025 11:49:40 +0100
Message-ID: <20250630104939.2265866-2-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
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

C++ does not allow zero-sized unions - they end up being of size 1-byte,
which leads to C/C++ compatibility issues, flagged by the compiler.

  lib/node/rte_node_mbuf_dynfield.h:78:2: error: union has size 0 in C, size 1 in C++ [-Werror,-Wextern-c-compat]
   78 |         union {
	         |         ^
		 1 error generated.

Fix the error by defaulting to a having a 1-byte sized union rather than
zero-sized.

Fixes: 746e8736da70 ("node: add global mbuf dynfield")

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/node/rte_node_mbuf_dynfield.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/node/rte_node_mbuf_dynfield.h b/lib/node/rte_node_mbuf_dynfield.h
index b77fdbb94f..35674ca263 100644
--- a/lib/node/rte_node_mbuf_dynfield.h
+++ b/lib/node/rte_node_mbuf_dynfield.h
@@ -26,12 +26,13 @@ extern "C" {

 #ifndef RTE_NODE_MBUF_PERSISTENT_FIELDS_SIZE
 /** Size of persistent mbuf fields */
-#define RTE_NODE_MBUF_PERSISTENT_FIELDS_SIZE          (0)
+#define RTE_NODE_MBUF_PERSISTENT_FIELDS_SIZE      (1)  /* Must be non-zero to avoid a zero-sized
+                                                        * union, which causes C++ compat issues*/
 #endif /* !RTE_NODE_MBUF_PERSISTENT_FIELDS_SIZE */

 #ifndef RTE_NODE_MBUF_OVERLOADABLE_FIELDS_SIZE
 /** Size of overloadable mbuf fields */
-#define RTE_NODE_MBUF_OVERLOADABLE_FIELDS_SIZE        (8)
+#define RTE_NODE_MBUF_OVERLOADABLE_FIELDS_SIZE   (8)
 #endif /* !RTE_NODE_MBUF_OVERLOADABLE_FIELDS_SIZE */

 /** Size of node mbuf dynamic field */
--
2.48.1

