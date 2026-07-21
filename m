Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7483AC44532
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Jul 2026 15:13:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9478F406A2;
	Tue, 21 Jul 2026 17:13:34 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 15CAC40294
 for <dev@dpdk.org>; Tue, 21 Jul 2026 17:13:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784646811; x=1816182811;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=W7ZFYkO0qPf2g9sKQksU4gXa3azim2IzVkGN1nIJ89Y=;
 b=M1Tn4Px8Y0K704DmHyNOYlEJxWxdNFKah+xIm6XSKhpfx47iQ24o5QKy
 X+JFnEAmNfmxr2UNA0gB6FgEe5yl57ermWgyit6WCaKtKIEU6sCHZuzg3
 eSN39PK6d4M19VQJDk/yC5ZE6XF6GDk223ZThjHGQFrbVdznwx5vXlsQ/
 ZFnfl7Gbmc8j8Rwm1rzi6T7Ac30SwV/bnGvBjEWyovVc+gNXANJSWlNo7
 jUKWC9IOAKNc4p6TDsCwPQcYbZfopumuUc0p6CuWQjZztBT/v10zH6kII
 fNMF5Lm3W3Yj3q4Hk418gpBN8Saltpeoz0v4/t/wr7Wc991mWfeK1qfoT g==;
X-CSE-ConnectionGUID: NbzbIDTkReuVnjogIeAN3Q==
X-CSE-MsgGUID: BkXAnvh7TsCTnj8CODBC9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="85107714"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; d="scan'208";a="85107714"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2026 08:13:30 -0700
X-CSE-ConnectionGUID: aXJErmZQTTCx4pGehvCLoQ==
X-CSE-MsgGUID: bifOpjsESFK2DFvrLLLn5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; d="scan'208";a="281070936"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa002.fm.intel.com with ESMTP; 21 Jul 2026 08:13:29 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 2/6] doc/rel_notes: move mempool change to first item
Date: Tue, 21 Jul 2026 16:13:21 +0100
Message-ID: <20260721151325.2698283-3-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260721151325.2698283-1-bruce.richardson@intel.com>
References: <20260721151325.2698283-1-bruce.richardson@intel.com>
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

The change in mempool behaviour is the change in this release with the
largest impact, so call that out first in the release notes, so as to
get maximum visibility for it.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 doc/guides/rel_notes/release_26_07.rst | 28 +++++++++++++-------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index 83610938bd..f301a8444c 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -55,20 +55,6 @@ New Features
      Also, make sure to start the actual text at the margin.
      =======================================================
 
-* **Added option to change memory limits per page size.**
-
-  Added the EAL option ``--pagesz-mem``
-  to override the default per-page-size memory limits.
-  Each maximum can be configured with a pair ``<pagesz>:<limit>``.
-
-* **Added option to disable auto probing.**
-
-  Added EAL options affecting the initial bus probing.
-
-  * ``-A`` or ``--no-auto-probing`` disable the initial bus probing: no device is probed during
-    ``rte_eal_init`` and the application is responsible for probing each device,
-  * ``--auto-probing`` enables the initial bus probing, which is the current default behavior.
-
 * **Changed mempool cache behaviour.**
 
   * The mempool cache flush/refill algorithm was improved,
@@ -83,6 +69,20 @@ New Features
   * The size of the ``struct rte_mempool_cache`` was kept
     for API/ABI compatibility purposes.
 
+* **Added option to change memory limits per page size.**
+
+  Added the EAL option ``--pagesz-mem``
+  to override the default per-page-size memory limits.
+  Each maximum can be configured with a pair ``<pagesz>:<limit>``.
+
+* **Added option to disable device auto probing.**
+
+  Added EAL options affecting the initial bus probing to find devices.
+
+  * ``-A`` or ``--no-auto-probing`` disables the initial bus probing: no device is probed during
+    ``rte_eal_init`` and the application is responsible for probing each device,
+  * ``--auto-probing`` enables the initial bus probing, which is the current default behavior.
+
 * **Added RISC-V vector paths.**
 
   * Increased the default SIMD bitwidth to allow using the vector extension.
-- 
2.53.0

