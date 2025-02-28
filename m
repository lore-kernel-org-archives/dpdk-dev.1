Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E2D9C19F32
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Feb 2025 01:09:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7C08440E25;
	Fri, 28 Feb 2025 02:09:11 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 10B254027F
 for <dev@dpdk.org>; Fri, 28 Feb 2025 02:09:08 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1202)
 id 7087A210EAC3; Thu, 27 Feb 2025 17:09:07 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7087A210EAC3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
 s=default; t=1740704947;
 bh=WV2TDwvRsMn5thrDCl0mOpcIjrHwp4o5VevAzW9dmEs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=LPhqjlyuG5elmWRXS+F8nEg4hLJ2ykoRfAGw27IzGqXpb3w7LaVeZFEEZNOjQi0Rr
 isQ8f7ues2xrIHNnh+ZmRwW4ynnqJ2rgfGIAS3yV4pzp6rQV4pFQNb6GMWCjcATSbH
 ykJ4lsbmGVmi0Z3rt/ZGQZdgz3W0GPwLN/IVnW3o=
From: longli@linuxonhyperv.com
To: Stephen Hemminger <stephen@networkplumber.org>, Wei Hu <weh@microsoft.com>
Cc: dev@dpdk.org,
	Long Li <longli@microsoft.com>
Subject: [PATCH 3/6] bus/vmbus: store UIO fd for secondary process
Date: Thu, 27 Feb 2025 17:08:58 -0800
Message-Id: <1740704941-1631-4-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1740704941-1631-2-git-send-email-longli@linuxonhyperv.com>
References: <1740704941-1631-2-git-send-email-longli@linuxonhyperv.com>
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

