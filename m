Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB67EDEBF0
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Mar 2026 20:54:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A37A0410F2;
	Tue,  3 Mar 2026 21:54:23 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 45D064064C;
 Tue,  3 Mar 2026 21:54:21 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1202)
 id B2B6920B6F03; Tue,  3 Mar 2026 12:54:20 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B2B6920B6F03
From: Long Li <longli@microsoft.com>
To: dev@dpdk.org
Cc: stephen@networkplumber.org, longli@microsoft.com, weh@microsoft.com,
 stable@dpdk.org
Subject: [PATCH v4 2/6] net/netvsc: fix double-free of primary Rx queue on
 uninit
Date: Tue,  3 Mar 2026 12:54:05 -0800
Message-ID: <20260303205411.325585-3-longli@microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260303205411.325585-1-longli@microsoft.com>
References: <20260303205411.325585-1-longli@microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

eth_hn_dev_uninit() calls hn_dev_close() which calls hn_dev_free_queues()
that frees all rx queues including hv->primary via hn_rx_queue_free(rxq,
false). After that, eth_hn_dev_uninit() calls rte_free(hv->primary) again,
resulting in a double-free.

Remove the redundant rte_free(hv->primary) since hn_dev_free_queues()
already handles freeing it.

Fixes: 4e9c73e96e83 ("net/netvsc: add Hyper-V network device")
Cc: stable@dpdk.org
Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/net/netvsc/hn_ethdev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/netvsc/hn_ethdev.c b/drivers/net/netvsc/hn_ethdev.c
index 798b4c9023..9f61f3a1a5 100644
--- a/drivers/net/netvsc/hn_ethdev.c
+++ b/drivers/net/netvsc/hn_ethdev.c
@@ -1455,7 +1455,6 @@ eth_hn_dev_uninit(struct rte_eth_dev *eth_dev)
 	}
 
 	rte_vmbus_chan_close(hv->channels[0]);
-	rte_free(hv->primary);
 	ret = rte_eth_dev_owner_delete(hv->owner.id);
 	if (ret != 0)
 		return ret;
-- 
2.43.0

