Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD65AC83F1A
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Jul 2025 18:18:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 053BC4026C;
	Mon, 21 Jul 2025 20:18:37 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 822474021E
 for <dev@dpdk.org>; Mon, 21 Jul 2025 20:18:35 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id B2A222117640; Mon, 21 Jul 2025 11:18:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B2A222117640
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1753121914;
 bh=6sk49fPVUdDpkJY7pNenA7vVmZyKVdsH76JDXOeI4Iw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=p0NS1JhTkUcwd2ElhBI2xtaH1zpbvCYigvmQirFT4Ua7k+B4ntXfX9EmBDsLGT+JC
 mwDEA5VRAJDkHB5LLBl9daf7glP+0oX0D/gNzWD/lvL7BHfYjEQ+xYfI9eqiilOJNb
 vtldlMHbjJoqJy21mUprY07lHLTtW0pIN/RsWY90=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: dev@dpdk.org
Subject: [PATCH v2] app/test-cmdline: add test to Windows build
Date: Mon, 21 Jul 2025 11:18:32 -0700
Message-Id: <1753121912-31321-1-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1734982541-8248-1-git-send-email-andremue@linux.microsoft.com>
References: <1734982541-8248-1-git-send-email-andremue@linux.microsoft.com>
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

Header termios.h was not found on Windows, which was probably the
reason this test was originally excluded from the Windows build.
However, ir turns out this header is not needed for this test, so it
can be removed and then test can be added to the Windows build
without negative consequences.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
Acked-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test-cmdline/cmdline_test.c | 1 -
 app/test-cmdline/commands.c     | 1 -
 app/test-cmdline/meson.build    | 6 ------
 3 files changed, 8 deletions(-)

diff --git a/app/test-cmdline/cmdline_test.c b/app/test-cmdline/cmdline_test.c
index 89f4260cbf..21b4a4278d 100644
--- a/app/test-cmdline/cmdline_test.c
+++ b/app/test-cmdline/cmdline_test.c
@@ -8,7 +8,6 @@
 #include <stdarg.h>
 #include <stdlib.h>
 #include <errno.h>
-#include <termios.h>
 #include <ctype.h>
 #include <sys/queue.h>
 
diff --git a/app/test-cmdline/commands.c b/app/test-cmdline/commands.c
index a13e1d1afd..62b4e5dfa7 100644
--- a/app/test-cmdline/commands.c
+++ b/app/test-cmdline/commands.c
@@ -4,7 +4,6 @@
 
 #include <stdio.h>
 #include <stdlib.h>
-#include <termios.h>
 #include <inttypes.h>
 
 #include <rte_common.h>
diff --git a/app/test-cmdline/meson.build b/app/test-cmdline/meson.build
index 6027f67919..9d0a9aeb6e 100644
--- a/app/test-cmdline/meson.build
+++ b/app/test-cmdline/meson.build
@@ -1,11 +1,5 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(c) 2019 Intel Corporation
 
-if is_windows
-    build = false
-    reason = 'not supported on Windows'
-    subdir_done()
-endif
-
 sources = files('commands.c', 'cmdline_test.c')
 deps += 'cmdline'
-- 
2.50.1.vfs.0.0

