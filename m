Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E4BBC02194
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 20:57:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 41734402E1;
	Tue,  4 Feb 2025 21:57:27 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 1D5CF40265
 for <dev@dpdk.org>; Tue,  4 Feb 2025 21:57:22 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id ECE262054926; Tue,  4 Feb 2025 12:57:20 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com ECE262054926
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1738702640;
 bh=YzGc7hhQtj8BdrIVxvCHYME5w8BEBaj2w46xJ9lYvTk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=lM8e1IVOMFlPOf36zsdDLDruK9SIWX8Bq/zsrGXD0SnP2OxrRzKbKqKV0eelCvfk0
 HnvclXp6HeZ9k3LzL59qY4Vr87s2ZC59sHSiL8OEQFOJqTBV9SSNgvyolgsDYGoOpj
 AOhE0+mqPLj+mJRXLVVRJPMu9dgXgDd5zbitqdqo=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: dev@dpdk.org
Cc: konstantin.ananyev@huawei.com, thomas@monjalon.net,
 david.marchand@redhat.com, Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [PATCH v21 01/27] eal: include header required for alloca
Date: Tue,  4 Feb 2025 12:56:52 -0800
Message-Id: <1738702638-22363-2-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1738702638-22363-1-git-send-email-andremue@linux.microsoft.com>
References: <1713397319-26135-1-git-send-email-roretzla@linux.microsoft.com>
 <1738702638-22363-1-git-send-email-andremue@linux.microsoft.com>
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

From: Tyler Retzlaff <roretzla@linux.microsoft.com>

Include alloca.h for Linux and malloc.h for Windows to get declaration
of alloca().

Signed-off-by: Tyler Retzlaff <roretzla@linux.microsoft.com>
---
 lib/eal/freebsd/include/rte_os.h | 1 +
 lib/eal/linux/include/rte_os.h   | 1 +
 lib/eal/windows/include/rte_os.h | 1 +
 3 files changed, 3 insertions(+)

diff --git a/lib/eal/freebsd/include/rte_os.h b/lib/eal/freebsd/include/rte_os.h
index 62e70dc15b..94b9275beb 100644
--- a/lib/eal/freebsd/include/rte_os.h
+++ b/lib/eal/freebsd/include/rte_os.h
@@ -11,6 +11,7 @@
  */
 
 #include <pthread_np.h>
+#include <stdlib.h>            /* Declares alloca() */
 #include <sys/queue.h>
 
 /* These macros are compatible with system's sys/queue.h. */
diff --git a/lib/eal/linux/include/rte_os.h b/lib/eal/linux/include/rte_os.h
index 35c07c70cb..20eff0409a 100644
--- a/lib/eal/linux/include/rte_os.h
+++ b/lib/eal/linux/include/rte_os.h
@@ -10,6 +10,7 @@
  * which is not supported natively or named differently in Linux.
  */
 
+#include <alloca.h>
 #include <sched.h>
 #include <sys/queue.h>
 
diff --git a/lib/eal/windows/include/rte_os.h b/lib/eal/windows/include/rte_os.h
index 9d69467aaa..d09adeb3b4 100644
--- a/lib/eal/windows/include/rte_os.h
+++ b/lib/eal/windows/include/rte_os.h
@@ -13,6 +13,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#include <malloc.h>
 
 #include <sched.h>
 
-- 
2.47.2.vfs.0.1

