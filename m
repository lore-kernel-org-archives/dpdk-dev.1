Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0577C369AB
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Apr 2025 19:33:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7C6A54065F;
	Fri, 18 Apr 2025 21:33:12 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id CFA8D40647;
 Fri, 18 Apr 2025 21:33:10 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1202)
 id 26A3020BCAD3; Fri, 18 Apr 2025 12:33:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 26A3020BCAD3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
 s=default; t=1745004790;
 bh=oCDgA4JPo3Zy+xmC6zGG8wMJU4O/cuvOLvE0ZIYA1V8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=juE1ukdVcKJHT/xocScuS4fXJ33K7rFIZMdJIl/kaf6yQ4IcN0VB2UbrWbd75HlY6
 VbItLT2jJcomIjvvjXOQg/cdYDRWGKSbgHr6eRl5sN79rd07yrCr1djBUjAlbVUprT
 tf+7yEbPS0JiZm8S9jNSAxvg6Ziq1UDZVErtsEKI=
From: longli@linuxonhyperv.com
To: Stephen Hemminger <stephen@networkplumber.org>, Wei Hu <weh@microsoft.com>
Cc: dev@dpdk.org,
	Long Li <longli@microsoft.com>,
	stable@dpdk.org
Subject: [PATCH 2/4] bus/vmbus: Define Hyper-V page size
Date: Fri, 18 Apr 2025 12:32:48 -0700
Message-Id: <1745004770-9795-3-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1745004770-9795-1-git-send-email-longli@linuxonhyperv.com>
References: <1745004770-9795-1-git-send-email-longli@linuxonhyperv.com>
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

Hyper-V uses 4k page size, regardless of the system page size used. Define
Hyper-V page size for use in drivers.

Fixes: 831dba47bd ("bus/vmbus: add Hyper-V virtual bus support")
Cc: stable@dpdk.org
Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/bus/vmbus/bus_vmbus_driver.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/bus/vmbus/bus_vmbus_driver.h b/drivers/bus/vmbus/bus_vmbus_driver.h
index bc394208de..0a56275437 100644
--- a/drivers/bus/vmbus/bus_vmbus_driver.h
+++ b/drivers/bus/vmbus/bus_vmbus_driver.h
@@ -14,6 +14,10 @@
 extern "C" {
 #endif
 
+#define HYPERV_PAGE_SHIFT 12
+#define HYPERV_PAGE_SIZE (1 << HYPERV_PAGE_SHIFT)
+#define HYPERV_PAGE_MASK (HYPERV_PAGE_SIZE - 1)
+
 struct vmbus_channel;
 struct vmbus_mon_page;
 
-- 
2.34.1

