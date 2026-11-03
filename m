Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A8D606A326
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=uaReAQHz
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 30A59432C2;
	Tue,  3 Nov 2026 16:26:29 +0100 (CET)
Received: from mta0.migadu.com (out-139.mta0.migadu.com [91.218.175.139])
 by mails.dpdk.org (Postfix) with ESMTPS id C30F1432BC
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:26:28 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=cXd9FitHJ48WhvXeAdb7cWP+HqIHco2g/3Pr4S0jxhk=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793719588; v=1; x=1794324388;
 b=uaReAQHzSjXkowC1w91oEk5Q0FQwscfPvItcMMuCw227dW47Nri857qGR4bQbkxFCrt45lr2
 UZ1jyWT0AOnPVVBrZefv58rTe+z9XqEVldq9xT3kVxSjSYgrE2D06hlyMudYumQcxd6iw+UYlFf
 9TnBLv40UuFuEHjdNvX/y3KY=
X-Envelope-To: dev@dpdk.org
Received: by mta11.migadu.com with ESMTPS id 84df33973925547f;
 Tue, 03 Nov 2026 15:26:28 +0000
X-Mizu-Trace-ID: 84df33973925547f
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 211/227] examples/ptpclient: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:52:49 +0800
Message-ID: <20261103145306.487255-212-chengwen.feng@linux.dev>
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
 examples/ptpclient/ptpclient.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/examples/ptpclient/ptpclient.c b/examples/ptpclient/ptpclient.c
index 59ce892742..acfe31f636 100644
--- a/examples/ptpclient/ptpclient.c
+++ b/examples/ptpclient/ptpclient.c
@@ -181,7 +181,7 @@ port_init(uint16_t port, struct rte_mempool *mp)
 		rxconf->offloads = port_conf.rxmode.offloads;
 
 		retval = rte_eth_rx_queue_setup(port, q, nb_rxd,
-				rte_eth_dev_socket_id(port), rxconf, mp);
+				rte_eth_dev_numa_id(port), rxconf, mp);
 
 		if (retval < 0)
 			return retval;
@@ -195,7 +195,7 @@ port_init(uint16_t port, struct rte_mempool *mp)
 		txconf->offloads = port_conf.txmode.offloads;
 
 		retval = rte_eth_tx_queue_setup(port, q, nb_txd,
-				rte_eth_dev_socket_id(port), txconf);
+				rte_eth_dev_numa_id(port), txconf);
 		if (retval < 0)
 			return retval;
 	}
@@ -736,7 +736,7 @@ main(int argc, char *argv[])
 
 	/* Creates a new mempool in memory to hold the mbufs. 8< */
 	mbuf_pool = rte_pktmbuf_pool_create("MBUF_POOL", NUM_MBUFS * nb_ports,
-		MBUF_CACHE_SIZE, 0, RTE_MBUF_DEFAULT_BUF_SIZE, rte_socket_id());
+		MBUF_CACHE_SIZE, 0, RTE_MBUF_DEFAULT_BUF_SIZE, rte_numa_id());
 	/* >8 End of a new mempool in memory to hold the mbufs. */
 
 	if (mbuf_pool == NULL)
-- 
2.55.0

