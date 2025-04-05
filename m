Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC72C3601E
	for <dpdk-dev@archiver.kernel.org>; Sat,  5 Apr 2025 00:36:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 49AE640613;
	Sat,  5 Apr 2025 02:35:48 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id D878640430
 for <dev@dpdk.org>; Sat,  5 Apr 2025 02:35:46 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1202)
 id BA15B2027E0F; Fri,  4 Apr 2025 17:35:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BA15B2027E0F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
 s=default; t=1743813345;
 bh=WV2TDwvRsMn5thrDCl0mOpcIjrHwp4o5VevAzW9dmEs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=K9xNs/XSk71XjqYi8sSL8b4nEAGkeUxzTD1cx19U5rOkBKuKPxvUohNdbHxZD6O9F
 foQrYyty+ZT7gDx38e0+kAVDHXuF7Uk7X0e5zz2MB5kS1o63Ak2s0bfOITEuCBCZS5
 T87gJEDkTwFFsZydnBCitvmDsjoxDLgYptUMNCEM=
From: longli@linuxonhyperv.com
To: Stephen Hemminger <stephen@networkplumber.org>, Wei Hu <weh@microsoft.com>
Cc: dev@dpdk.org,
	Long Li <longli@microsoft.com>
Subject: [Patch v3 3/6] bus/vmbus: store UIO fd for secondary process
Date: Fri,  4 Apr 2025 17:35:35 -0700
Message-Id: <1743813338-28238-4-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1743813338-28238-1-git-send-email-longli@linuxonhyperv.com>
References: <1743813338-28238-1-git-send-email-longli@linuxonhyperv.com>
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

Secondary process will get access to vmbus device and this UIO fd for
signaling hyperv host on channels without monitoring support.

Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/bus/vmbus/vmbus_common_uio.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/bus/vmbus/vmbus_common_uio.c b/drivers/bus/vmbus/vmbus_common_uio.c
index 4d4613513c..d55aee6537 100644
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
2.34.1

