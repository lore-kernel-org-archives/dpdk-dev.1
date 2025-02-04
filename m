Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD3AAC02192
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 01:58:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 571474003C;
	Tue,  4 Feb 2025 02:58:50 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id EE833402D2
 for <dev@dpdk.org>; Tue,  4 Feb 2025 02:58:46 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id EFC38205493E; Mon,  3 Feb 2025 17:58:45 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EFC38205493E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1738634325;
 bh=8tRWn7u7NebefTW4G5KS4dImBg6x3jRm99JUNh/wX8c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=SeiQnAYLSJbzAYVnTg29juDM+COGVdcvRWiU1GeSAMdViNjJr/EdPq+Gnbt5YDgLw
 hRQ5lMMl4qrWKNPYIptscCSc3WzDBOqCMrbJWv8y40FybAQtji1icOGVsWNtamIA1h
 Zo8WRqBkBpLDyN2Kc85QnaPbsoSHFg3eL5qKHkWY=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: dev@dpdk.org,
	david.marchand@redhat.com
Subject: [PATCH v3 1/2] test: disable non-C11 atomic tests for MSVC
Date: Mon,  3 Feb 2025 17:58:37 -0800
Message-Id: <1738634318-12876-2-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1738634318-12876-1-git-send-email-andremue@linux.microsoft.com>
References: <1733848355-19048-1-git-send-email-andremue@linux.microsoft.com>
 <1738634318-12876-1-git-send-email-andremue@linux.microsoft.com>
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

In general, non-C11 atomics are not to be used with MSVC.
This patch skips the non-C11 atomic tests when using MSVC.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 app/test/test_atomic.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/app/test/test_atomic.c b/app/test/test_atomic.c
index db07159e81..3f26ce88d9 100644
--- a/app/test/test_atomic.c
+++ b/app/test/test_atomic.c
@@ -20,6 +20,7 @@
 
 #include "test.h"
 
+#ifndef RTE_TOOLCHAIN_MSVC
 /*
  * Atomic Variables
  * ================
@@ -632,3 +633,4 @@ test_atomic(void)
 	return 0;
 }
 REGISTER_FAST_TEST(atomic_autotest, false, true, test_atomic);
+#endif /* RTE_TOOLCHAIN_MSVC */
-- 
2.47.2.vfs.0.1

