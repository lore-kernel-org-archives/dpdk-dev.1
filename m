Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFD3606A7A0
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=GVwAHco8
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A13EC43003;
	Tue,  3 Nov 2026 16:22:51 +0100 (CET)
Received: from mta1.migadu.com (out-47.mta1.migadu.com [95.215.58.47])
 by mails.dpdk.org (Postfix) with ESMTPS id 47A6A42FC7
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:22:50 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=WNepZzo8L/ivD3jSsifK3QR0NLmYpEmvyYFlT8x7wbU=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793719369; v=1; x=1794324169;
 b=GVwAHco8x4Ub/i3O6A174rG+tkJT8muSjuGpjjjcRtxn3n+Olfig3KWB++O3ZcjjuolrhGn8
 5UwZYRNA1CAek83yUdvbbSHQyKV+/0ChJcsPkNjrR6I3qERCE2tX4oNu2ut9I7xi4B/L8jYQc/0
 EzybmBWY8sxi1e8x0YIRyAiE=
X-Envelope-To: dev@dpdk.org
Received: by mta11.migadu.com with ESMTPS id 3c69b9d622432f20;
 Tue, 03 Nov 2026 15:22:49 +0000
X-Mizu-Trace-ID: 3c69b9d622432f20
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 188/227] examples/ethtool: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:52:26 +0800
Message-ID: <20261103145306.487255-189-chengwen.feng@linux.dev>
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
 examples/ethtool/ethtool-app/main.c | 6 +++---
 examples/ethtool/lib/rte_ethtool.c  | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/examples/ethtool/ethtool-app/main.c b/examples/ethtool/ethtool-app/main.c
index ddd256cd7b..bd87e5430d 100644
--- a/examples/ethtool/ethtool-app/main.c
+++ b/examples/ethtool/ethtool-app/main.c
@@ -118,7 +118,7 @@ static void setup_ports(struct app_config *ptr_cfg, int cnt_ports)
 			size_pktpool, PKTPOOL_CACHE,
 			0,
 			RTE_MBUF_DEFAULT_BUF_SIZE,
-			rte_socket_id()
+			rte_numa_id()
 			);
 		if (ptr_port->pkt_pool == NULL)
 			rte_exit(EXIT_FAILURE,
@@ -140,14 +140,14 @@ static void setup_ports(struct app_config *ptr_cfg, int cnt_ports)
 
 		if (rte_eth_rx_queue_setup(
 			    idx_port, 0, nb_rxd,
-			    rte_eth_dev_socket_id(idx_port), NULL,
+			    rte_eth_dev_numa_id(idx_port), NULL,
 			    ptr_port->pkt_pool) < 0)
 			rte_exit(EXIT_FAILURE,
 				 "rte_eth_rx_queue_setup failed"
 				);
 		if (rte_eth_tx_queue_setup(
 			    idx_port, 0, nb_txd,
-			    rte_eth_dev_socket_id(idx_port), NULL) < 0)
+			    rte_eth_dev_numa_id(idx_port), NULL) < 0)
 			rte_exit(EXIT_FAILURE,
 				 "rte_eth_tx_queue_setup failed"
 				);
diff --git a/examples/ethtool/lib/rte_ethtool.c b/examples/ethtool/lib/rte_ethtool.c
index 0b88a27e7d..b3edbc71ad 100644
--- a/examples/ethtool/lib/rte_ethtool.c
+++ b/examples/ethtool/lib/rte_ethtool.c
@@ -444,12 +444,12 @@ rte_ethtool_set_ringparam(uint16_t port_id,
 		return stat;
 
 	stat = rte_eth_tx_queue_setup(port_id, 0, ring_param->tx_pending,
-		rte_eth_dev_socket_id(port_id), NULL);
+		rte_eth_dev_numa_id(port_id), NULL);
 	if (stat != 0)
 		return stat;
 
 	stat = rte_eth_rx_queue_setup(port_id, 0, ring_param->rx_pending,
-		rte_eth_dev_socket_id(port_id), NULL, rx_qinfo.mp);
+		rte_eth_dev_numa_id(port_id), NULL, rx_qinfo.mp);
 	if (stat != 0)
 		return stat;
 
-- 
2.55.0

