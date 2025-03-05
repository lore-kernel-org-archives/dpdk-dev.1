Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A52CC021B8
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Mar 2025 00:37:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3947B402A0;
	Wed,  5 Mar 2025 01:37:45 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id ECA1540275
 for <dev@dpdk.org>; Wed,  5 Mar 2025 01:37:43 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1202)
 id 31F02210EAF8; Tue,  4 Mar 2025 16:37:43 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 31F02210EAF8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
 s=default; t=1741135063;
 bh=G0MX9cqU88ZL9VoZUmY4PTXqdJe9n303Hr0piq44eEA=;
 h=From:To:Cc:Subject:Date:From;
 b=Av25fmi5DE91Hn1VgSiqMjBdOHmx6/MAFW02A3QDPOTRLHWbAeTeb8rqUsCy22mTO
 cn9y5W3v8zm1NVsKijuKgjvQMOpre3C4lCGZ3flGTFfRdxV7XprdKsOP0CuyQYiSjB
 TXTDwQFPqiIvJLqXkGYa9Ts5FPa/Hp7m2Xs4H+YA=
From: longli@linuxonhyperv.com
To: Stephen Hemminger <stephen@networkplumber.org>, Wei Hu <weh@microsoft.com>
Cc: dev@dpdk.org,
	Long Li <longli@microsoft.com>
Subject: [PATCH] net/mana: avoid the use of variable length array
Date: Tue,  4 Mar 2025 16:37:32 -0800
Message-Id: <1741135052-2039-1-git-send-email-longli@linuxonhyperv.com>
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

From: Long Li <longli@microsoft.com>

The pathname can be defined as name[MAX_PATH]. This makes the driver
compilable using MSVC.

Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/net/mana/mana.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/mana/mana.c b/drivers/net/mana/mana.c
index c37c4e3444..d12dff6ce1 100644
--- a/drivers/net/mana/mana.c
+++ b/drivers/net/mana/mana.c
@@ -36,11 +36,8 @@ static rte_spinlock_t mana_shared_data_lock = RTE_SPINLOCK_INITIALIZER;
 
 /* Allocate a buffer on the stack and fill it with a printf format string. */
 #define MANA_MKSTR(name, ...) \
-	int mkstr_size_##name = snprintf(NULL, 0, "" __VA_ARGS__); \
-	char name[mkstr_size_##name + 1]; \
-	\
-	memset(name, 0, mkstr_size_##name + 1); \
-	snprintf(name, sizeof(name), "" __VA_ARGS__)
+	char name[PATH_MAX]; \
+	snprintf(name, PATH_MAX, "" __VA_ARGS__)
 
 int mana_logtype_driver;
 int mana_logtype_init;
-- 
2.34.1

