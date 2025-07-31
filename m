Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7969C87FCC
	for <dpdk-dev@archiver.kernel.org>; Thu, 31 Jul 2025 16:15:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CE841402E2;
	Thu, 31 Jul 2025 18:15:18 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 6DCC8402CC
 for <dev@dpdk.org>; Thu, 31 Jul 2025 18:15:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753978517; x=1785514517;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=abFwou7Cb1/HjBJzaAworplcl9dGWC+/loBqS/aGUUA=;
 b=WDAN2R2n2wKQu1u2FX81i+SqOnN4djB4lf4v1qHnDzcinN7Nn1mtlIKk
 i4ey8NdlqFb3SCY7RvBcUqpaHYJJnmDZiPq3ed5dUk4j13ZVwZQHn8yYB
 +UTvRfcI61O3Kbz8EjQ+9BWwU8A5hEMpbs5vJF4batPUu4jl4D+TK4tax
 CfMMR2Emp/r1rHrRlFoc042ZDzu10TyTzftpJhvqFVzRRORWQYC+cMQB7
 euouurMwVXn3r8lIbk7m+LQBSxrC2KbQJe7W/ZdhMekP53s+ShA7R5YCu
 4zXLrV3qPPOZTPakYQX5ApUWtO57yhlcJyKyAQ7ElYnl/cBu2QxqoZ0AV A==;
X-CSE-ConnectionGUID: rY1xbXRtRRKgoMZ1ztkmjg==
X-CSE-MsgGUID: dIJEhdU8RdOvJOW5co/PjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11508"; a="56240170"
X-IronPort-AV: E=Sophos;i="6.17,254,1747724400"; d="scan'208";a="56240170"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2025 09:15:16 -0700
X-CSE-ConnectionGUID: L5NF0eE9QVeGW9e9sJK5Yg==
X-CSE-MsgGUID: GzMZitL9TaaRcuOCis3QAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,254,1747724400"; d="scan'208";a="162884116"
Received: from silpixa00401874.ir.intel.com (HELO
 silpixa00401874.ger.corp.intel.com) ([10.55.129.54])
 by fmviesa007.fm.intel.com with ESMTP; 31 Jul 2025 09:15:16 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: stephen@networkplumber.org, Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH] doc/testpmd: add missing entry for enable-rss flag
Date: Thu, 31 Jul 2025 16:15:10 +0000
Message-ID: <20250731161510.923049-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250728211919.75320c85@hermes.local>
References: <20250728211919.75320c85@hermes.local>
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

Add a one-line description about the new flag.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
FYI: fix should be merged into commit f5da751 on next-net tree.
---
 doc/guides/testpmd_app_ug/run_app.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/doc/guides/testpmd_app_ug/run_app.rst b/doc/guides/testpmd_app_ug/run_app.rst
index 82f61b133c..35a0c5528c 100644
--- a/doc/guides/testpmd_app_ug/run_app.rst
+++ b/doc/guides/testpmd_app_ug/run_app.rst
@@ -206,6 +206,10 @@ The command line options are:
 
     Enable per-queue packet drop for packets with no descriptors.
 
+*   ``--enable-rss``
+
+    Enable RSS (Receive Side Scaling) even in case of a single-queue configuration.
+
 *   ``--disable-rss``
 
     Disable RSS (Receive Side Scaling).
-- 
2.48.1

