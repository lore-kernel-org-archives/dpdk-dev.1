Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2247C282DE
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Mar 2025 21:43:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 620FE40658;
	Mon, 10 Mar 2025 22:43:11 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id D28D8400D7
 for <dev@dpdk.org>; Mon, 10 Mar 2025 22:43:07 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1202)
 id 1C9A92038F53; Mon, 10 Mar 2025 14:43:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1C9A92038F53
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
 s=default; t=1741642987;
 bh=WV2TDwvRsMn5thrDCl0mOpcIjrHwp4o5VevAzW9dmEs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=cJP0/7DJdBoDJqZq+OTVsP0WSWpcMlllPUSZALnycpdx65um2xav7CRvoeFwQQz3k
 Z5wJLWXG514EGXnTz8ZfME/8O8Kew1bn86eLRHfEgW4q8iJQPFCA5m1Zkz3T4+jUu1
 OJdn1L+7iuZE8X3J0FKYsClKFRZkQL+HKD/kyRao=
From: longli@linuxonhyperv.com
To: Stephen Hemminger <stephen@networkplumber.org>, Wei Hu <weh@microsoft.com>
Cc: dev@dpdk.org,
	Long Li <longli@microsoft.com>
Subject: [patch v2 3/6] bus/vmbus: store UIO fd for secondary process
Date: Mon, 10 Mar 2025 14:42:54 -0700
Message-Id: <1741642977-14297-4-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1741642977-14297-1-git-send-email-longli@linuxonhyperv.com>
References: <1741642977-14297-1-git-send-email-longli@linuxonhyperv.com>
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

