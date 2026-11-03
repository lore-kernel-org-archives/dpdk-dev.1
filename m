Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A81606A7AD
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=s4sbKxzD
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A8C3942F93;
	Tue,  3 Nov 2026 16:20:46 +0100 (CET)
Received: from mta1.migadu.com (out-197.mta1.migadu.com [95.215.58.197])
 by mails.dpdk.org (Postfix) with ESMTPS id 31ED642F95
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:20:46 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=34tNLmPZVT20JL5ZKesYX58zfDShdjmTIpSPnt/Q3e4=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793719246; v=1; x=1794324046;
 b=s4sbKxzDeDnf/YHhAnIuvKorFKaF9DrAZLmlrd+eM4BDhTykRQnT6cxLYIdUEq1PjJXFjepq
 DV2xJMtx6enMWI384uVsJsr5mVK5ROSMG01+CLkXq8KD05sFwYXshmaPqyIeaxni+BGedCIsdT/
 KHAXn9y4amirSZzRp/fMyF4Y=
X-Envelope-To: dev@dpdk.org
Received: by mta12.migadu.com with ESMTPS id 1a63b78b42244b6c;
 Tue, 03 Nov 2026 15:20:45 +0000
X-Mizu-Trace-ID: 1a63b78b42244b6c
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 175/227] app/dumpcap: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:52:13 +0800
Message-ID: <20261103145306.487255-176-chengwen.feng@linux.dev>
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
 app/dumpcap/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/app/dumpcap/main.c b/app/dumpcap/main.c
index 46a6cb251e..0d285cfb09 100644
--- a/app/dumpcap/main.c
+++ b/app/dumpcap/main.c
@@ -701,7 +701,7 @@ static struct rte_ring *create_ring(void)
 		 "dumpcap-%d", getpid());
 
 	ring = rte_ring_create(ring_name, ring_size,
-			       rte_socket_id(), 0);
+			       rte_numa_id(), 0);
 	if (ring == NULL)
 		rte_exit(EXIT_FAILURE, "Could not create ring :%s\n",
 			 rte_strerror(rte_errno));
@@ -730,7 +730,7 @@ static struct rte_mempool *create_mempool(void)
 	mp = rte_pktmbuf_pool_create_by_ops(pool_name, num_mbufs,
 					    MBUF_POOL_CACHE_SIZE, 0,
 					    data_size,
-					    rte_socket_id(), "ring_mp_mc");
+					    rte_numa_id(), "ring_mp_mc");
 	if (mp == NULL)
 		rte_exit(EXIT_FAILURE,
 			 "Mempool (%s) creation failed: %s\n", pool_name,
-- 
2.55.0

