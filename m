Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69711606A79C
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=E/s6HY6L
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8020742E9E;
	Tue,  3 Nov 2026 16:23:15 +0100 (CET)
Received: from mta1.migadu.com (out-67.mta1.migadu.com [95.215.58.67])
 by mails.dpdk.org (Postfix) with ESMTPS id B846642EA9
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:23:13 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=Fx9Fpn0wMyMtlAi5FslvZdSHcIMQJB/o5jZ1XWXVjDk=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793719393; v=1; x=1794324193;
 b=E/s6HY6L58opsiWkkW0Z9D2xTwC5Z2kvvFUD0IVxD+dq9Qfu/z7IRByA/P7eSfpv3icMQbtm
 gPaL3cMmr01cqeDH84ocLLvaeqGJ4pb6UpVArToeYgHnNW2NHwIQvK6jYGvSYDZszTNTN3VMVFQ
 RkQpMsNokABMM6SRgtBZtoFA=
X-Envelope-To: dev@dpdk.org
Received: by mta11.migadu.com with ESMTPS id b0c372083c217028;
 Tue, 03 Nov 2026 15:23:13 +0000
X-Mizu-Trace-ID: b0c372083c217028
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 191/227] examples/flow_filtering: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:52:29 +0800
Message-ID: <20261103145306.487255-192-chengwen.feng@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261103145306.487255-1-chengwen.feng@linux.dev>
References: <20261103145306.487255-1-chengwen.feng@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Chengwen Feng <fengchengwen@huawei.com>

Rename socket_id parameters, local variables and comments to the
NUMA node terminology, and switch calls to the NUMA-named APIs.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 examples/flow_filtering/main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/examples/flow_filtering/main.c b/examples/flow_filtering/main.c
index b4ccaacea1..b29feeb5ab 100644
--- a/examples/flow_filtering/main.c
+++ b/examples/flow_filtering/main.c
@@ -191,7 +191,7 @@ init_port(void)
 	/* Configuring number of RX and TX queues connected to single port. */
 	for (i = 0; i < NR_QUEUES; i++) {
 		ret = rte_eth_rx_queue_setup(port_id, i, 512,
-					 rte_eth_dev_socket_id(port_id),
+					 rte_eth_dev_numa_id(port_id),
 					 &rxq_conf,
 					 mbuf_pool);
 		if (ret < 0) {
@@ -206,7 +206,7 @@ init_port(void)
 
 	for (i = 0; i < NR_QUEUES; i++) {
 		ret = rte_eth_tx_queue_setup(port_id, i, 512,
-				rte_eth_dev_socket_id(port_id),
+				rte_eth_dev_numa_id(port_id),
 				&txq_conf);
 		if (ret < 0) {
 			rte_exit(EXIT_FAILURE,
@@ -334,7 +334,7 @@ main(int argc, char **argv)
 	/* Allocates a mempool to hold the mbufs. 8< */
 	mbuf_pool = rte_pktmbuf_pool_create("mbuf_pool", 4096, 128, 0,
 						RTE_MBUF_DEFAULT_BUF_SIZE,
-						rte_socket_id());
+						rte_numa_id());
 	/* >8 End of allocating a mempool to hold the mbufs. */
 	if (mbuf_pool == NULL)
 		rte_exit(EXIT_FAILURE, "Cannot init mbuf pool\n");
-- 
2.55.0

