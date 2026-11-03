Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD46606A326
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=b1XiOyvg
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CF63243326;
	Tue,  3 Nov 2026 16:28:17 +0100 (CET)
Received: from mta0.migadu.com (out-191.mta0.migadu.com [91.218.175.191])
 by mails.dpdk.org (Postfix) with ESMTPS id 5BB7542EBC
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:28:16 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=PEmm0MrnBdbV55rivggyzdnlVBTuHs/2aCdH1WDsVFg=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793719696; v=1; x=1794324496;
 b=b1XiOyvgyJxfYVPNBh/vO6u8lhS8pT3/3a/OWnmF7MV0YplkambSWPZeTL1hM1woC7gwQV+a
 zDbUDM8dbNR8HIxA1xbhNrz+C+a0dLLLmKm8V4ho9oKegAguNWJS93fVScNRr1Y+mN4BGppc1Ge
 KpPb2mPXQWEcioGqkse0clX8=
X-Envelope-To: dev@dpdk.org
Received: by mta12.migadu.com with ESMTPS id 3e37a9a4ddcbefc5;
 Tue, 03 Nov 2026 15:28:15 +0000
X-Mizu-Trace-ID: 3e37a9a4ddcbefc5
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 222/227] examples/vmdq_dcb: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:53:00 +0800
Message-ID: <20261103145306.487255-223-chengwen.feng@linux.dev>
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
 examples/vmdq_dcb/main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/examples/vmdq_dcb/main.c b/examples/vmdq_dcb/main.c
index 563b4f9ce1..a41362984e 100644
--- a/examples/vmdq_dcb/main.c
+++ b/examples/vmdq_dcb/main.c
@@ -303,7 +303,7 @@ port_init(uint16_t port, struct rte_mempool *mbuf_pool)
 
 	for (q = 0; q < num_queues; q++) {
 		retval = rte_eth_rx_queue_setup(port, q, rxRingSize,
-					rte_eth_dev_socket_id(port),
+					rte_eth_dev_numa_id(port),
 					NULL,
 					mbuf_pool);
 		if (retval < 0) {
@@ -316,7 +316,7 @@ port_init(uint16_t port, struct rte_mempool *mbuf_pool)
 	txq_conf.offloads = port_conf.txmode.offloads;
 	for (q = 0; q < num_queues; q++) {
 		retval = rte_eth_tx_queue_setup(port, q, txRingSize,
-					rte_eth_dev_socket_id(port),
+					rte_eth_dev_numa_id(port),
 					&txq_conf);
 		if (retval < 0) {
 			printf("initialize tx queue %d failed\n", q);
@@ -687,7 +687,7 @@ main(int argc, char *argv[])
 
 	mbuf_pool = rte_pktmbuf_pool_create("MBUF_POOL",
 		NUM_MBUFS_PER_PORT * nb_ports, MBUF_CACHE_SIZE,
-		0, RTE_MBUF_DEFAULT_BUF_SIZE, rte_socket_id());
+		0, RTE_MBUF_DEFAULT_BUF_SIZE, rte_numa_id());
 	if (mbuf_pool == NULL)
 		rte_exit(EXIT_FAILURE, "Cannot create mbuf pool\n");
 
-- 
2.55.0

