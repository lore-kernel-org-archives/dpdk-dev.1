Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82753CAC598
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Sep 2025 17:44:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B555940673;
	Tue, 16 Sep 2025 19:44:49 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id E6320402E8
 for <dev@dpdk.org>; Tue, 16 Sep 2025 19:44:47 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1094)
 id 274A0201551F; Tue, 16 Sep 2025 10:44:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 274A0201551F
From: mamcgove@microsoft.com
To: dev@dpdk.org
Cc: Matthew G McGovern <mamcgove@microsoft.com>
Subject: [PATCH 2/2] examples/mp_server: warn on promisc enable failure
Date: Tue, 16 Sep 2025 10:44:10 -0700
Message-Id: <c6b47c91266b5fe62f4c869206b972d2280ce052.1758043370.git.mamcgove@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1758043370.git.mamcgove@microsoft.com>
References: <1747766224-31511-1-git-send-email-mamcgove@microsoft.com>
 <cover.1758043370.git.mamcgove@microsoft.com>
In-Reply-To: <cover.1758043370.git.mamcgove@microsoft.com>
References: <cover.1758043370.git.mamcgove@microsoft.com>
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

Change to treat promiscuous enablement failures as nonfatal in the
client_mp/server_mp examples.

Some devices (mana) support promiscuous mode; but require
a cloud networking configuration change to enable it.

This change will allow examples/multi_process applications
to run in these environments.

Signed-off-by: Matthew G McGovern <mamcgove@microsoft.com>
---
 examples/multi_process/client_server_mp/mp_server/init.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/examples/multi_process/client_server_mp/mp_server/init.c b/examples/multi_process/client_server_mp/mp_server/init.c
index 65713dbea8..87acc38101 100644
--- a/examples/multi_process/client_server_mp/mp_server/init.c
+++ b/examples/multi_process/client_server_mp/mp_server/init.c
@@ -134,7 +134,9 @@ init_port(uint16_t port_num)
 
 	retval = rte_eth_promiscuous_enable(port_num);
 	if (retval < 0)
-		return retval;
+		fprintf(stderr,
+			"Error during enabling promiscuous mode for port %u: %s - ignore\n",
+			retval, rte_strerror(-retval));
 
 	retval  = rte_eth_dev_start(port_num);
 	if (retval < 0) return retval;
-- 
2.34.1

