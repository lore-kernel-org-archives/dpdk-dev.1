Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD299C021A4
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Feb 2025 18:58:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E8D8040615;
	Thu, 13 Feb 2025 19:58:38 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id E717840609;
 Thu, 13 Feb 2025 19:58:35 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1202)
 id 351AF203F3C2; Thu, 13 Feb 2025 10:58:35 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 351AF203F3C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
 s=default; t=1739473115;
 bh=SxuhN6dJGndD5PiFXiPtSIzUVIQpsn6cwh82Xs0De0w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=dE0H4qgWDvrPPiF8RUpwQLnczr8DvI3J/Oxqs9SRDwNOUaMNKmwz+Tv84qLRLj0XD
 nqPCqp1A6N8UGla3icEl50ZVDUq0Blg3ZgBjOgam1QQZ5wnzCBAakVotllZPbaXCES
 AiToa+5Hzb6eCGMJbeK6iiRa8ln5c/eNMGMEAHe4=
From: longli@linuxonhyperv.com
To: Ferruh Yigit <ferruh.yigit@amd.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Wei Hu <weh@microsoft.com>
Cc: dev@dpdk.org,
	Long Li <longli@microsoft.com>,
	stable@dpdk.org
Subject: [Patch v2 2/3] net/netvsc: remove RTE device if all its net devices
 are removed
Date: Thu, 13 Feb 2025 10:58:24 -0800
Message-Id: <1739473105-17797-3-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1739473105-17797-1-git-send-email-longli@linuxonhyperv.com>
References: <1739473105-17797-1-git-send-email-longli@linuxonhyperv.com>
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

An RTE device can have multiple Ethernet devices. On hot plug events, it
can't be removed until all its Ethernet devices have been removed.

Fixes: a2a23a794b3a ("net/netvsc: support VF device hot add/remove")
Cc: stable@dpdk.org
Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/net/netvsc/hn_vf.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/netvsc/hn_vf.c b/drivers/net/netvsc/hn_vf.c
index b664beaa5d..5d8058774d 100644
--- a/drivers/net/netvsc/hn_vf.c
+++ b/drivers/net/netvsc/hn_vf.c
@@ -102,6 +102,7 @@ static void hn_remove_delayed(void *args)
 	uint16_t port_id = hv->vf_ctx.vf_port;
 	struct rte_device *dev = rte_eth_devices[port_id].device;
 	int ret;
+	bool all_eth_removed;
 
 	/* Tell VSP to switch data path to synthetic */
 	hn_vf_remove(hv);
@@ -138,7 +139,17 @@ static void hn_remove_delayed(void *args)
 		PMD_DRV_LOG(ERR, "rte_eth_dev_close failed port_id=%u ret=%d",
 			    port_id, ret);
 
-	ret = rte_dev_remove(dev);
+	/* Remove the rte device when all its eth devices are removed */
+	all_eth_removed = true;
+	RTE_ETH_FOREACH_DEV_OF(port_id, dev) {
+		if (rte_eth_devices[port_id].state != RTE_ETH_DEV_UNUSED) {
+			all_eth_removed = false;
+			break;
+		}
+	}
+	if (all_eth_removed)
+		ret = rte_dev_remove(dev);
+
 	hv->vf_ctx.vf_state = vf_removed;
 
 	rte_rwlock_write_unlock(&hv->vf_lock);
-- 
2.34.1

