Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 895C8CAC592
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Sep 2025 18:51:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 822DB402C9;
	Tue, 16 Sep 2025 20:51:22 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 718A640288
 for <dev@dpdk.org>; Tue, 16 Sep 2025 20:51:20 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1094)
 id C309920154F0; Tue, 16 Sep 2025 11:51:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C309920154F0
From: mamcgove@microsoft.com
To: dev@dpdk.org
Cc: Matthew G McGovern <mamcgove@microsoft.com>
Subject: [PATCH v3 1/1] examples/mp_server: warn on promisc enable failure
Date: Tue, 16 Sep 2025 11:51:14 -0700
Message-Id: <d7e617594063d3675636125ec9413ac4cbdc7e51.1758045692.git.mamcgove@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1747766224-31511-1-git-send-email-mamcgove@microsoft.com>
References: <1747766224-31511-1-git-send-email-mamcgove@microsoft.com>
In-Reply-To: <cover.1758045692.git.mamcgove@microsoft.com>
References: <cover.1758045692.git.mamcgove@microsoft.com>
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

Problem: Some devices do not allow promiscuous mode.

Testpmd handles this by warning and ignoring failures from
rte_eth_promiscuous_enable.

Changes: make mp example apps warn if promiscuous mode cannot be
enabled, rather than failing.

Signed-off-by: Matthew G McGovern <mamcgove@microsoft.com>

---

v3:
* fix incorrect statement in v2 2/2 commit message
* squash small changes to a single commit

 examples/multi_process/client_server_mp/mp_server/init.c | 4 +++-
 examples/multi_process/symmetric_mp/main.c               | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

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
diff --git a/examples/multi_process/symmetric_mp/main.c b/examples/multi_process/symmetric_mp/main.c
index f7d8439cd4..22ede756fd 100644
--- a/examples/multi_process/symmetric_mp/main.c
+++ b/examples/multi_process/symmetric_mp/main.c
@@ -275,7 +275,9 @@ smp_port_init(uint16_t port, struct rte_mempool *mbuf_pool,
 
 	retval = rte_eth_promiscuous_enable(port);
 	if (retval != 0)
-		return retval;
+		fprintf(stderr,
+			"Error during enabling promiscuous mode for port %u: %s - ignore\n",
+			retval, rte_strerror(-retval));
 
 	retval  = rte_eth_dev_start(port);
 	if (retval < 0)
-- 
2.34.1

