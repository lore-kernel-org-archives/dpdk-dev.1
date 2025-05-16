Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41AB5C3ABD8
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 May 2025 17:36:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AC8B140395;
	Fri, 16 May 2025 19:36:51 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 4261D402ED
 for <dev@dpdk.org>; Fri, 16 May 2025 19:36:49 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 09CEF201DB33; Fri, 16 May 2025 10:36:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 09CEF201DB33
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1747417008;
 bh=SKQfkupy89zuYfKAFQDB36AQ1ZV7afEo43PHcr1wqQk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=V4CwriUoGStT5lx72MCTXEJ/WB2mRbNQrVxEbFOzKTlE4+/aImqg+fUrwx5tQ9+mZ
 pOKZVryr8LJVDFvO1+fWXnLZTrMBt4lCNG+m1pVj/o+M9kJQWqiKvjgkn7oti0ihnC
 ApRdSCVp0fhaE6dWcmyFXFxF9rr6I4qwLuhhCc0U=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: bruce.richardson@intel.com,
	dev@dpdk.org,
	vladimir.medvedkin@intel.com
Subject: [PATCH v2 2/2] lib/lpm: enable lpm to be compiled with MSVC
Date: Fri, 16 May 2025 10:36:42 -0700
Message-Id: <1747417002-28419-3-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1747417002-28419-1-git-send-email-andremue@linux.microsoft.com>
References: <1733278801-19296-1-git-send-email-andremue@linux.microsoft.com>
 <1747417002-28419-1-git-send-email-andremue@linux.microsoft.com>
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

Now that all issues related to lpm are addressed it can be enabled
for MSVC.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 lib/lpm/meson.build | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/lib/lpm/meson.build b/lib/lpm/meson.build
index fae4f79fb9..cff8fed473 100644
--- a/lib/lpm/meson.build
+++ b/lib/lpm/meson.build
@@ -1,12 +1,6 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(c) 2017 Intel Corporation
 
-if is_ms_compiler
-    build = false
-    reason = 'not supported building with Visual Studio Toolset'
-    subdir_done()
-endif
-
 sources = files('rte_lpm.c', 'rte_lpm6.c')
 headers = files('rte_lpm.h', 'rte_lpm6.h')
 # since header files have different names, we can install all vector headers
-- 
2.49.0.vfs.0.3

