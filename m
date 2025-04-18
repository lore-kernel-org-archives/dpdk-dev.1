Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53BE6C369AB
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Apr 2025 19:33:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CEAD54066F;
	Fri, 18 Apr 2025 21:33:14 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id CEE8840662;
 Fri, 18 Apr 2025 21:33:12 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1202)
 id 2FB9B20BCAD3; Fri, 18 Apr 2025 12:33:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2FB9B20BCAD3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
 s=default; t=1745004792;
 bh=jcrLEtpisZmh+2SS0FLG1wGwpD45uFQYmIh3Lv1oggk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jyOVyzX17fXznEESsiLyb6BMBe88BT4JHgeFfI2oiNNT5y7FsYb94zJzvemjuoEFZ
 mHxn3k75UPSA9a4mDbyyjKp7eZLF5LaAha5F0R9hp4vt6Qf1w/iYPZ0Bwga0CDe2vg
 p+Ju+dh2Duqf+fNncYMnsiUrNDJ4mIL9fnsJjKbI=
From: longli@linuxonhyperv.com
To: Stephen Hemminger <stephen@networkplumber.org>, Wei Hu <weh@microsoft.com>
Cc: dev@dpdk.org,
	Long Li <longli@microsoft.com>,
	stable@dpdk.org
Subject: [PATCH 3/4] bus/vmbus: Use Hyper-V page size for mapping to UIO pages
Date: Fri, 18 Apr 2025 12:32:49 -0700
Message-Id: <1745004770-9795-4-git-send-email-longli@linuxonhyperv.com>
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

The interrupt and monitor pages mapped from Hyper-V via kernel are always
4k in sizes. Use Hyper-V page size to map them.

Fixes: 831dba47bd ("bus/vmbus: add Hyper-V virtual bus support")
Cc: stable@dpdk.org
Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/bus/vmbus/linux/vmbus_uio.c  | 2 +-
 drivers/bus/vmbus/vmbus_common_uio.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/vmbus/linux/vmbus_uio.c b/drivers/bus/vmbus/linux/vmbus_uio.c
index 8edec869ac..fbafc5027d 100644
--- a/drivers/bus/vmbus/linux/vmbus_uio.c
+++ b/drivers/bus/vmbus/linux/vmbus_uio.c
@@ -268,7 +268,7 @@ static int vmbus_uio_map_subchan(const struct rte_vmbus_device *dev,
 	}
 	file_size = sb.st_size;
 
-	if (file_size == 0 || (file_size & (rte_mem_page_size() - 1))) {
+	if (file_size == 0 || (file_size & (HYPERV_PAGE_SIZE - 1))) {
 		VMBUS_LOG(ERR, "incorrect size %s: %zu",
 			  ring_path, file_size);
 
diff --git a/drivers/bus/vmbus/vmbus_common_uio.c b/drivers/bus/vmbus/vmbus_common_uio.c
index d55aee6537..c6e7e07302 100644
--- a/drivers/bus/vmbus/vmbus_common_uio.c
+++ b/drivers/bus/vmbus/vmbus_common_uio.c
@@ -204,7 +204,7 @@ vmbus_uio_map_resource(struct rte_vmbus_device *dev)
 	}
 
 	dev->int_page = (uint32_t *)((char *)uio_res->maps[HV_INT_PAGE_MAP].addr
-				     + (rte_mem_page_size() >> 1));
+				     + (HYPERV_PAGE_SIZE >> 1));
 	dev->monitor_page = uio_res->maps[HV_MON_PAGE_MAP].addr;
 	return 0;
 }
-- 
2.34.1

