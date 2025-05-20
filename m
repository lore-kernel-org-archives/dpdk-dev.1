Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23762C3ABDD
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 May 2025 18:37:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E11E940A4B;
	Tue, 20 May 2025 20:37:28 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id C58FC4064C
 for <dev@dpdk.org>; Tue, 20 May 2025 20:37:26 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1094)
 id A81C7206789F; Tue, 20 May 2025 11:37:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A81C7206789F
From: mamcgove@microsoft.com
To: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org,
	Matthew G McGovern <mamcgove@microsoft.com>
Subject: [PATCH] examples/symmetric_mp: log/ignore promiscuous fail
Date: Tue, 20 May 2025 11:37:04 -0700
Message-Id: <1747766224-31511-1-git-send-email-mamcgove@microsoft.com>
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

From: Matthew G McGovern <mamcgove@microsoft.com>

The example apps have a few different failure modes when enabling promiscuous mode:

- testpmd will warn about the failure and continue.

- l3fwd has a flag '-P' to explicitly require promiscuous mode.

- symmetric_mp will exit with an error code

This patch changes symmetric_mp to warn and continue.

Signed-off-by: Matthew G McGovern <mamcgove@microsoft.com>
---
 examples/multi_process/symmetric_mp/main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/examples/multi_process/symmetric_mp/main.c b/examples/multi_process/symmetric_mp/main.c
index f7d8439cd4..974fed2cd5 100644
--- a/examples/multi_process/symmetric_mp/main.c
+++ b/examples/multi_process/symmetric_mp/main.c
@@ -275,7 +275,8 @@ smp_port_init(uint16_t port, struct rte_mempool *mbuf_pool,
 
 	retval = rte_eth_promiscuous_enable(port);
 	if (retval != 0)
-		return retval;
+		printf("Error during enabling promiscuous mode for port %u: %s - ignore\n",
+			port, rte_strerror(-retval));
 
 	retval  = rte_eth_dev_start(port);
 	if (retval < 0)
-- 
2.34.1

