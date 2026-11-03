Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839B1606A7AA
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=bKGbKNrE
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4CA8143278;
	Tue,  3 Nov 2026 16:24:54 +0100 (CET)
Received: from mta0.migadu.com (out-98.mta0.migadu.com [91.218.175.98])
 by mails.dpdk.org (Postfix) with ESMTPS id CAD9942E9A
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:24:52 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=USbSGHsqiP8zH/mnaFifYgY4mSZE47BGc9NcZMaEy4A=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793719492; v=1; x=1794324292;
 b=bKGbKNrEQlT1SyzUxC3hZHVFdjS29CO95GxKfy1DCKXCYbnU5e2ok3T1Qfy0vrH05wQp21Y8
 2ZChUzjYF/bDV/07Na7Ey9jOotmOcawsApU9G6trVPyRLjCKvZUR234U5pzOKHoniHT+yqECjWV
 NIiHqf2kjKZCE8UzyPaakHkE=
X-Envelope-To: dev@dpdk.org
Received: by mta10.migadu.com with ESMTPS id 4075d8cee6052fad;
 Tue, 03 Nov 2026 15:24:52 +0000
X-Mizu-Trace-ID: 4075d8cee6052fad
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 200/227] examples/l2fwd-jobstats: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:52:38 +0800
Message-ID: <20261103145306.487255-201-chengwen.feng@linux.dev>
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
 examples/l2fwd-jobstats/main.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/examples/l2fwd-jobstats/main.c b/examples/l2fwd-jobstats/main.c
index f654831897..0f5117f587 100644
--- a/examples/l2fwd-jobstats/main.c
+++ b/examples/l2fwd-jobstats/main.c
@@ -781,7 +781,7 @@ main(int argc, char **argv)
 	/* Create the mbuf pool. 8< */
 	l2fwd_pktmbuf_pool =
 		rte_pktmbuf_pool_create("mbuf_pool", NB_MBUF, 32,
-			0, RTE_MBUF_DEFAULT_BUF_SIZE, rte_socket_id());
+			0, RTE_MBUF_DEFAULT_BUF_SIZE, rte_numa_id());
 	if (l2fwd_pktmbuf_pool == NULL)
 		rte_exit(EXIT_FAILURE, "Cannot init mbuf pool\n");
 	/* >8 End of creation of mbuf pool. */
@@ -897,7 +897,7 @@ main(int argc, char **argv)
 		rxq_conf.offloads = local_port_conf.rxmode.offloads;
 		/* RX queue initialization. 8< */
 		ret = rte_eth_rx_queue_setup(portid, 0, nb_rxd,
-					     rte_eth_dev_socket_id(portid),
+					     rte_eth_dev_numa_id(portid),
 					     &rxq_conf,
 					     l2fwd_pktmbuf_pool);
 		if (ret < 0)
@@ -910,7 +910,7 @@ main(int argc, char **argv)
 		txq_conf.offloads = local_port_conf.txmode.offloads;
 		fflush(stdout);
 		ret = rte_eth_tx_queue_setup(portid, 0, nb_txd,
-				rte_eth_dev_socket_id(portid),
+				rte_eth_dev_numa_id(portid),
 				&txq_conf);
 		if (ret < 0)
 			rte_exit(EXIT_FAILURE,
@@ -919,9 +919,9 @@ main(int argc, char **argv)
 		/* >8 End of init one TX queue on each port. */
 
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

