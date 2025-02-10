Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03FECC02198
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 21:51:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 43664402AB;
	Mon, 10 Feb 2025 22:51:15 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id E3B8F40156
 for <dev@dpdk.org>; Mon, 10 Feb 2025 22:51:13 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 3BB3C2107A91; Mon, 10 Feb 2025 13:51:13 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3BB3C2107A91
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1739224273;
 bh=PnyJZ9xcSgSlOsnN3tzs1T/gx+A8VhkdXNxYVPbkwVs=;
 h=From:To:Cc:Subject:Date:From;
 b=Jdt2UuGDKHPu+rLENu9arR0Pj2ZSdEZ08wNuv27GkoyqUJnvAfX+sssvYD3QhEvfJ
 kG1ZNmdLfHSaIJiz17eJufL7+QWX7b3uS1SMKpqqW3i1akn7tYVlqMy8fgehs4QXmN
 cZ1/onTsMJKeYFU/LtTAdIOFTlQhtqAYpUGX7uCA=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: 
Cc: dev@dpdk.org,
	Andre Muezerie <andremue@linux.microsoft.com>
Subject: [PATCH] mbuf: enable to be compiled with MSVC
Date: Mon, 10 Feb 2025 13:51:05 -0800
Message-Id: <1739224265-4158-1-git-send-email-andremue@linux.microsoft.com>
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

Now that the issues preventing this lib from be compiled with MSVC
are fixed it can be included in the compilation.

The "net" library will automatically get compiled as well as it
has a dependency on "mbuf" which will now get fulfilled.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 lib/mbuf/meson.build | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/lib/mbuf/meson.build b/lib/mbuf/meson.build
index 2cee9057a5..0435c5e628 100644
--- a/lib/mbuf/meson.build
+++ b/lib/mbuf/meson.build
@@ -1,12 +1,6 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(c) 2017 Intel Corporation
 
-if is_ms_compiler
-    build = false
-    reason = 'not supported building with Visual Studio Toolset'
-    subdir_done()
-endif
-
 sources = files(
         'rte_mbuf.c',
         'rte_mbuf_ptype.c',
-- 
2.47.2.vfs.0.1

