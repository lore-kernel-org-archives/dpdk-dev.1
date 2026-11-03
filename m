Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E835606A7A0
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=lbkFtEN0
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 18EC942FDF;
	Tue,  3 Nov 2026 16:22:13 +0100 (CET)
Received: from mta0.migadu.com (out-18.mta0.migadu.com [91.218.175.18])
 by mails.dpdk.org (Postfix) with ESMTPS id 4496A42FD9
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:22:11 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=8uK711yhbcuyMwEHcpv6JsfseF7nq9eIHxEXx3wNWXo=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793719331; v=1; x=1794324131;
 b=lbkFtEN0ACdiV+o1sid/kS4Uncf1/1uaerEKyEtjWbLP7iHVOlQ5XhRIOJSBpwlaK2oHnldP
 YJ9/+NvgsGToANcLg5et1EQPlTIvyedQ1hbMDfYwlz2qouJ4KXN+rdiOUbHir3d6G6riq8v9aM/
 qmnrOYcBlC9XFUTkjtB+tNpU=
X-Envelope-To: dev@dpdk.org
Received: by mta11.migadu.com with ESMTPS id 3254c9e76eb4564b;
 Tue, 03 Nov 2026 15:22:10 +0000
X-Mizu-Trace-ID: 3254c9e76eb4564b
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 183/227] app/test-flow-perf: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:52:21 +0800
Message-ID: <20261103145306.487255-184-chengwen.feng@linux.dev>
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
 app/test-flow-perf/main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/app/test-flow-perf/main.c b/app/test-flow-perf/main.c
index db7269315c..5f83713a98 100644
--- a/app/test-flow-perf/main.c
+++ b/app/test-flow-perf/main.c
@@ -2088,7 +2088,7 @@ init_port(void)
 	mbuf_mp = rte_pktmbuf_pool_create("mbuf_pool",
 					total_mbuf_num, mbuf_cache_size,
 					0, mbuf_size,
-					rte_socket_id());
+					rte_numa_id());
 	if (mbuf_mp == NULL)
 		rte_exit(EXIT_FAILURE, "Error: can't init mbuf pool\n");
 
@@ -2136,7 +2136,7 @@ init_port(void)
 		rxq_conf = dev_info.default_rxconf;
 		for (std_queue = 0; std_queue < rx_queues_count; std_queue++) {
 			ret = rte_eth_rx_queue_setup(port_id, std_queue, rxd_count,
-					rte_eth_dev_socket_id(port_id),
+					rte_eth_dev_numa_id(port_id),
 					&rxq_conf,
 					mbuf_mp);
 			if (ret < 0)
@@ -2148,7 +2148,7 @@ init_port(void)
 		txq_conf = dev_info.default_txconf;
 		for (std_queue = 0; std_queue < tx_queues_count; std_queue++) {
 			ret = rte_eth_tx_queue_setup(port_id, std_queue, txd_count,
-					rte_eth_dev_socket_id(port_id),
+					rte_eth_dev_numa_id(port_id),
 					&txq_conf);
 			if (ret < 0)
 				rte_exit(EXIT_FAILURE,
-- 
2.55.0

