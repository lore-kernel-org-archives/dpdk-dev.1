Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A092DC3ABC9
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 May 2025 21:52:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 63B964025D;
	Fri,  9 May 2025 23:52:27 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 20D8D4025A
 for <dev@dpdk.org>; Fri,  9 May 2025 23:52:25 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 1C11221199FB; Fri,  9 May 2025 14:52:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1C11221199FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1746827544;
 bh=DWt2fS9vaA7tqlTA7zfykd7znnrPYYmfMkPtINeuj58=;
 h=From:To:Cc:Subject:Date:From;
 b=nBK5BqL1Lrnr0QdfBeoyopsUGYvAOORqkFktjikc2Bt0xnqgq57Q548l1dAKGxuDL
 rkYUJRiGdEF698NZYlHWClM/cQR+IrGMmk9dnQPuXRiE4EYMGeWSNNLyVGbg4uNFSN
 7Rplcv8PoihJQqR95KtCA5fZr0p9MZN9Zp55kYCw=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Ori Kam <orika@nvidia.com>
Cc: dev@dpdk.org,
	Andre Muezerie <andremue@linux.microsoft.com>
Subject: [PATCH] regexdev: enable to be compiled on Windows
Date: Fri,  9 May 2025 14:52:14 -0700
Message-Id: <1746827534-19881-1-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
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

Now that mbuf is compiling on Windows, this library can be enabled as
well.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 lib/regexdev/meson.build | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/lib/regexdev/meson.build b/lib/regexdev/meson.build
index 426e764ece..7e12d8cd6d 100644
--- a/lib/regexdev/meson.build
+++ b/lib/regexdev/meson.build
@@ -1,12 +1,6 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright 2020 Mellanox Technologies, Ltd
 
-if is_windows
-    build = false
-    reason = 'not supported on Windows'
-    subdir_done()
-endif
-
 sources = files('rte_regexdev.c')
 headers = files('rte_regexdev.h', 'rte_regexdev_driver.h')
 indirect_headers += files('rte_regexdev_core.h')
-- 
2.49.0.vfs.0.2

