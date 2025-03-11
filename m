Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74148C282EC
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Mar 2025 19:17:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9E7364025A;
	Tue, 11 Mar 2025 20:17:41 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id A9EB84014F
 for <dev@dpdk.org>; Tue, 11 Mar 2025 20:17:40 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 0DC942045FE4; Tue, 11 Mar 2025 12:17:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0DC942045FE4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1741720660;
 bh=x1B/Q03AgTYYCQM9xQFYAvAOJGRAZkouIpsmC+fwXvQ=;
 h=From:To:Cc:Subject:Date:From;
 b=PC0C7zxJ9+4PQ6sY0p9E+2ofpPfKdhmKpyCIH5U0xZ9Fg9VXLUtIcFpUinTITWeQ+
 RPqte/Gycr5QTo0NtjyR9Hhb9nFbWaGq+ybEtwLp6ccGXgpoH0dLCUuUQY1Kdw/HXD
 DundQRrzDlk8sGnCPo2Zp1PbscmJkHTDfsM3Z88Q=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Nicolas Chautru <nicolas.chautru@intel.com>
Cc: dev@dpdk.org,
	Andre Muezerie <andremue@linux.microsoft.com>
Subject: [PATCH] bbdev: enable to be compiled with MSVC
Date: Tue, 11 Mar 2025 12:17:26 -0700
Message-Id: <1741720646-22892-1-git-send-email-andremue@linux.microsoft.com>
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

The errors below popped up when compiling with MSVC:

../lib/bbdev/rte_bbdev.c(79): error C2061:
    syntax error: identifier 'TAILQ_ENTRY'
../lib/bbdev/rte_bbdev.c(85): error C2059:
    syntax error: '}'

This was caused by a missing include.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 lib/bbdev/meson.build | 6 ------
 lib/bbdev/rte_bbdev.c | 1 +
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/lib/bbdev/meson.build b/lib/bbdev/meson.build
index d8b95a400e..2e48d5f3da 100644
--- a/lib/bbdev/meson.build
+++ b/lib/bbdev/meson.build
@@ -1,12 +1,6 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(c) 2017 Intel Corporation
 
-if is_windows
-    build = false
-    reason = 'not supported on Windows'
-    subdir_done()
-endif
-
 sources = files('rte_bbdev.c',
         'bbdev_trace_points.c')
 headers = files('rte_bbdev.h',
diff --git a/lib/bbdev/rte_bbdev.c b/lib/bbdev/rte_bbdev.c
index d7901cd29d..2c626806f3 100644
--- a/lib/bbdev/rte_bbdev.c
+++ b/lib/bbdev/rte_bbdev.c
@@ -16,6 +16,7 @@
 #include <rte_lcore.h>
 #include <rte_spinlock.h>
 #include <rte_interrupts.h>
+#include <sys/queue.h>
 
 #include "rte_bbdev_op.h"
 #include "rte_bbdev.h"
-- 
2.48.1.vfs.0.1

