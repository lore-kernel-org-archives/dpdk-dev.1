Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA91C87FC9
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Jul 2025 00:09:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6AD2940A89;
	Wed, 30 Jul 2025 02:09:50 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 3026A406FF
 for <dev@dpdk.org>; Wed, 30 Jul 2025 02:09:49 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1202)
 id 89E18202187F; Tue, 29 Jul 2025 17:09:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 89E18202187F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
 s=default; t=1753834188;
 bh=3NvBXgVAmJ4HBd32L4rLY9QyIxWOP3Vk2l3Y2H5QbaA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
 b=dOaA15Fh1OESzZxlhQEYKqF3lUFUn49H5KlGhr7wq9SNOU8gxm05MDKIB4L8BONUA
 hwS6eusfqKvfsjc5REwU+JVVW85RICTPi915N7LwjVfokajvC9KeP/X+U9MR9NRbHW
 Hcs0p60LohvoFRz4L2mAlx/GCwP5gUufrzFnOPc0=
From: longli@linuxonhyperv.com
To: Stephen Hemminger <stephen@networkplumber.org>, Wei Hu <weh@microsoft.com>
Cc: dev@dpdk.org,
	Long Li <longli@microsoft.com>
Subject: [Patch v7 1/4] bus/vmbus: store UIO fd for secondary process
Date: Tue, 29 Jul 2025 17:09:40 -0700
Message-Id: <1753834183-22244-2-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1753834183-22244-1-git-send-email-longli@linuxonhyperv.com>
References: <1753834183-22244-1-git-send-email-longli@linuxonhyperv.com>
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
Reply-To: longli@microsoft.com
Errors-To: dev-bounces@dpdk.org

From: Long Li <longli@microsoft.com>

Secondary process will get access to vmbus device and this UIO fd for
signaling hyperv host on channels without monitoring support.

Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/bus/vmbus/vmbus_common_uio.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/bus/vmbus/vmbus_common_uio.c b/drivers/bus/vmbus/vmbus_common_uio.c
index 13289cd9a4..c6e7e07302 100644
--- a/drivers/bus/vmbus/vmbus_common_uio.c
+++ b/drivers/bus/vmbus/vmbus_common_uio.c
@@ -86,8 +86,11 @@ vmbus_uio_map_secondary(struct rte_vmbus_device *dev)
 		return -1;
 	}
 
-	/* fd is not needed in secondary process, close it */
-	close(fd);
+	if (rte_intr_fd_set(dev->intr_handle, fd))
+		return -1;
+
+	if (rte_intr_type_set(dev->intr_handle, RTE_INTR_HANDLE_UIO_INTX))
+		return -1;
 
 	/* Create and map primary channel */
 	if (vmbus_chan_create(dev, dev->relid, 0,
@@ -256,7 +259,7 @@ vmbus_uio_unmap_resource(struct rte_vmbus_device *dev)
 	/* free uio resource */
 	rte_free(uio_res);
 
-	/* close fd if in primary process */
+	/* close fd */
 	if (rte_intr_fd_get(dev->intr_handle) >= 0)
 		close(rte_intr_fd_get(dev->intr_handle));
 
-- 
2.25.1

