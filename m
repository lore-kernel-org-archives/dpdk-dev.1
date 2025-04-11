Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE74C369A2
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Apr 2025 19:59:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 083E240B91;
	Fri, 11 Apr 2025 21:59:49 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 76EF04025F
 for <dev@dpdk.org>; Fri, 11 Apr 2025 21:59:47 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 77D5C21165AA; Fri, 11 Apr 2025 12:59:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 77D5C21165AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1744401586;
 bh=a33LMy25lBaslQlLuryhx/mBo/vlnMew2Ll+SgC1LrE=;
 h=From:To:Cc:Subject:Date:From;
 b=s+O/FgFuGstwsa+vzLQW2ysp0vrUerHADew7bV1FczN9gcuPrvniwNUsdO4Y5ykYB
 eKFN2NgFmNC3yGbVoa5RWnonO6IzLNcgJ1LthnW4tHaKKGrD08Wkxx20OXpM9GRGa/
 9ueWErHD7CxXoKLBO9Vts+W2H2wAPETea9EoY4Eg=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Srikanth Yalavarthi <syalavarthi@marvell.com>
Cc: dev@dpdk.org,
	Andre Muezerie <andremue@linux.microsoft.com>
Subject: [PATCH] mldev: enable to be compiled with msvc
Date: Fri, 11 Apr 2025 12:59:38 -0700
Message-Id: <1744401578-30459-1-git-send-email-andremue@linux.microsoft.com>
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

Now that the issues preventing this lib from being compiled with MSVC
are solved, it can be enabled.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 lib/mldev/meson.build | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/lib/mldev/meson.build b/lib/mldev/meson.build
index 2c933baad6..0079ccd205 100644
--- a/lib/mldev/meson.build
+++ b/lib/mldev/meson.build
@@ -1,12 +1,6 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright (c) 2022 Marvell.
 
-if is_ms_compiler
-    build = false
-    reason = 'not supported building with Visual Studio Toolset'
-    subdir_done()
-endif
-
 sources = files(
         'rte_mldev_pmd.c',
         'rte_mldev.c',
-- 
2.49.0.vfs.0.0

