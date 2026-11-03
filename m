Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1BC606B24D
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=jcwbLBEN
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E1B4642FE9;
	Tue,  3 Nov 2026 16:22:25 +0100 (CET)
Received: from mta0.migadu.com (out-27.mta0.migadu.com [91.218.175.27])
 by mails.dpdk.org (Postfix) with ESMTPS id 6673142FA5
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:22:24 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=s4u/V6A4ioQmSUTNj6RsVgHy7fLTrSm/O7Q/PTr+Kos=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793719344; v=1; x=1794324144;
 b=jcwbLBENi6kzV2baN5WZp5V4L7kJdqnnc6FNSGxrgiXGHEaLcD9F4Ws8eGsZUyYxNUDHHWRZ
 gJUFlzeq5t3ni9rgDGJyP3nwMPjg9EjhOdU44S8bryrKoCWrFLj54xe+zOZ923MXXWHmSjqUnl/
 AULCdJpQdiX54vW+MFruC/lw=
X-Envelope-To: dev@dpdk.org
Received: by mta12.migadu.com with ESMTPS id e85fe82a174867e1;
 Tue, 03 Nov 2026 15:22:24 +0000
X-Mizu-Trace-ID: e85fe82a174867e1
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 185/227] examples/bond: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:52:23 +0800
Message-ID: <20261103145306.487255-186-chengwen.feng@linux.dev>
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
 examples/bond/main.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/examples/bond/main.c b/examples/bond/main.c
index 99359cd6fb..ef1b074f37 100644
--- a/examples/bond/main.c
+++ b/examples/bond/main.c
@@ -166,7 +166,7 @@ member_port_init(uint16_t portid)
 	rxq_conf = dev_info.default_rxconf;
 	rxq_conf.offloads = local_port_conf.rxmode.offloads;
 	retval = rte_eth_rx_queue_setup(portid, 0, nb_rxd,
-					rte_eth_dev_socket_id(portid),
+					rte_eth_dev_numa_id(portid),
 					&rxq_conf,
 					mbuf_pool);
 	if (retval < 0)
@@ -177,7 +177,7 @@ member_port_init(uint16_t portid)
 	txq_conf = dev_info.default_txconf;
 	txq_conf.offloads = local_port_conf.txmode.offloads;
 	retval = rte_eth_tx_queue_setup(portid, 0, nb_txd,
-				rte_eth_dev_socket_id(portid), &txq_conf);
+				rte_eth_dev_numa_id(portid), &txq_conf);
 
 	if (retval < 0)
 		rte_exit(retval, "port %u: TX queue 0 setup failed (res=%d)",
@@ -216,7 +216,7 @@ bond_port_init(void)
 	uint16_t wait_counter = 20;
 
 	retval = rte_eth_bond_create("net_bonding0", BONDING_MODE_ALB,
-			0 /*SOCKET_ID_ANY*/);
+			0 /*RTE_NUMA_ID_ANY*/);
 	if (retval < 0)
 		rte_exit(EXIT_FAILURE,
 				"Failed to create bond port\n");
@@ -253,7 +253,7 @@ bond_port_init(void)
 	rxq_conf = dev_info.default_rxconf;
 	rxq_conf.offloads = local_port_conf.rxmode.offloads;
 	retval = rte_eth_rx_queue_setup(BOND_PORT, 0, nb_rxd,
-					rte_eth_dev_socket_id(BOND_PORT),
+					rte_eth_dev_numa_id(BOND_PORT),
 					&rxq_conf, mbuf_pool);
 	if (retval < 0)
 		rte_exit(retval, " port %u: RX queue 0 setup failed (res=%d)",
@@ -263,7 +263,7 @@ bond_port_init(void)
 	txq_conf = dev_info.default_txconf;
 	txq_conf.offloads = local_port_conf.txmode.offloads;
 	retval = rte_eth_tx_queue_setup(BOND_PORT, 0, nb_txd,
-				rte_eth_dev_socket_id(BOND_PORT), &txq_conf);
+				rte_eth_dev_numa_id(BOND_PORT), &txq_conf);
 
 	if (retval < 0)
 		rte_exit(retval, "port %u: TX queue 0 setup failed (res=%d)",
@@ -698,7 +698,7 @@ main(int argc, char *argv[])
 		rte_exit(EXIT_FAILURE, "You can have max 4 ports\n");
 
 	mbuf_pool = rte_pktmbuf_pool_create("MBUF_POOL", NB_MBUF, 32,
-		0, RTE_MBUF_DEFAULT_BUF_SIZE, rte_socket_id());
+		0, RTE_MBUF_DEFAULT_BUF_SIZE, rte_numa_id());
 	if (mbuf_pool == NULL)
 		rte_exit(EXIT_FAILURE, "Cannot create mbuf pool\n");
 
-- 
2.55.0

