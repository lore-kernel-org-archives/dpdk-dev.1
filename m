Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F297606A326
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=bOkUt36p
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 68C2643285;
	Tue,  3 Nov 2026 16:25:05 +0100 (CET)
Received: from mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
 by mails.dpdk.org (Postfix) with ESMTPS id A3DAF4326A
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:25:03 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=Al9AMivSZvfjhF1AkE5+iCfkxYCDSmZvVOgdVS9CsXs=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793719503; v=1; x=1794324303;
 b=bOkUt36pHCSx7ZbBnlOd/0ikq0qXG+Z/wZTljpLkcL1biScPfWCwb6OjY7TyokHWJMLoL9RF
 ibUD0XktHVg4eXi0VM5p3XS5VML4V9GXqt1pqM75TBciye/E3a1kW+o2NV8bwUs3milD/IZqIX+
 lgwm0kl2bHWGPeNEAhfTHsPg=
X-Envelope-To: dev@dpdk.org
Received: by mta12.migadu.com with ESMTPS id 43e43adf54a4b674;
 Tue, 03 Nov 2026 15:25:02 +0000
X-Mizu-Trace-ID: 43e43adf54a4b674
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 201/227] examples/l2fwd-keepalive: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:52:39 +0800
Message-ID: <20261103145306.487255-202-chengwen.feng@linux.dev>
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
 examples/l2fwd-keepalive/main.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/examples/l2fwd-keepalive/main.c b/examples/l2fwd-keepalive/main.c
index 889274ddae..e6865ae541 100644
--- a/examples/l2fwd-keepalive/main.c
+++ b/examples/l2fwd-keepalive/main.c
@@ -560,7 +560,7 @@ main(int argc, char **argv)
 
 	l2fwd_pktmbuf_pool = rte_pktmbuf_pool_create("mbuf_pool",
 		total_nb_mbufs,	32, 0, RTE_MBUF_DEFAULT_BUF_SIZE,
-		rte_socket_id());
+		rte_numa_id());
 	if (l2fwd_pktmbuf_pool == NULL)
 		rte_exit(EXIT_FAILURE, "Cannot init mbuf pool\n");
 
@@ -670,7 +670,7 @@ main(int argc, char **argv)
 		rxq_conf = dev_info.default_rxconf;
 		rxq_conf.offloads = local_port_conf.rxmode.offloads;
 		ret = rte_eth_rx_queue_setup(portid, 0, nb_rxd,
-					     rte_eth_dev_socket_id(portid),
+					     rte_eth_dev_numa_id(portid),
 					     &rxq_conf,
 					     l2fwd_pktmbuf_pool);
 		if (ret < 0)
@@ -683,7 +683,7 @@ main(int argc, char **argv)
 		txq_conf = dev_info.default_txconf;
 		txq_conf.offloads = local_port_conf.txmode.offloads;
 		ret = rte_eth_tx_queue_setup(portid, 0, nb_txd,
-				rte_eth_dev_socket_id(portid),
+				rte_eth_dev_numa_id(portid),
 				&txq_conf);
 		if (ret < 0)
 			rte_exit(EXIT_FAILURE,
@@ -691,9 +691,9 @@ main(int argc, char **argv)
 				ret, portid);
 
 		/* Initialize TX buffers */
-		tx_buffer[portid] = rte_zmalloc_socket("tx_buffer",
+		tx_buffer[portid] = rte_zmalloc_numa("tx_buffer",
 				RTE_ETH_TX_BUFFER_SIZE(MAX_PKT_BURST), 0,
-				rte_eth_dev_socket_id(portid));
+				rte_eth_dev_numa_id(portid));
 		if (tx_buffer[portid] == NULL)
 			rte_exit(EXIT_FAILURE, "Cannot allocate buffer for tx on port %u\n",
 						portid);
-- 
2.55.0

