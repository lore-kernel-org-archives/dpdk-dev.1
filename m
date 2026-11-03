Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F249606A324
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=MVVRYDvR
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1A01843338;
	Tue,  3 Nov 2026 16:28:50 +0100 (CET)
Received: from mta1.migadu.com (out-135.mta1.migadu.com [95.215.58.135])
 by mails.dpdk.org (Postfix) with ESMTPS id 7C6A24332A
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:28:48 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=twRZFyCVjjN5GDekM4KFj/gGcyQMDerx8On5YdLLCT4=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793719728; v=1; x=1794324528;
 b=MVVRYDvR4MJ4gpGlICksiyb4ir8jIiyZFdcsxqXIT7M2O0S2XdsY0wI2xwW+O+de7vhhY2eD
 Y44t5OP4UfyGibZNerUdkkfo4Q9OVs0ysCHsBZn3+NO9Iu2P/FFMWfL+GqvKX4JDXBh/lHR9CtE
 N0h8OQDnaIRZQlNxYTc3jT7g=
X-Envelope-To: dev@dpdk.org
Received: by mta11.migadu.com with ESMTPS id 17b833d818a6479b;
 Tue, 03 Nov 2026 15:28:48 +0000
X-Mizu-Trace-ID: 17b833d818a6479b
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 225/227] test-dma-perf: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:53:03 +0800
Message-ID: <20261103145306.487255-226-chengwen.feng@linux.dev>
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

Use the NUMA node terminology in the dma-perf application.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 app/test-dma-perf/benchmark.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/app/test-dma-perf/benchmark.c b/app/test-dma-perf/benchmark.c
index c0ffc859bd..686e241c18 100644
--- a/app/test-dma-perf/benchmark.c
+++ b/app/test-dma-perf/benchmark.c
@@ -550,13 +550,13 @@ setup_memory_env(struct test_configure *cfg, uint32_t nr_buf,
 	unsigned int cur_buf_size = cfg->buf_size.cur;
 	unsigned int buf_size = cur_buf_size + RTE_PKTMBUF_HEADROOM;
 	bool is_src_numa_incorrect, is_dst_numa_incorrect;
-	unsigned int nr_sockets;
+	unsigned int nr_numas;
 	uintptr_t ops;
 	uint32_t i;
 
-	nr_sockets = rte_socket_count();
-	is_src_numa_incorrect = (cfg->src_numa_node >= nr_sockets);
-	is_dst_numa_incorrect = (cfg->dst_numa_node >= nr_sockets);
+	nr_numas = rte_numa_count();
+	is_src_numa_incorrect = (cfg->src_numa_node >= nr_numas);
+	is_dst_numa_incorrect = (cfg->dst_numa_node >= nr_numas);
 
 	if (is_src_numa_incorrect || is_dst_numa_incorrect) {
 		PRINT_ERR("Error: Incorrect NUMA config for %s.\n",
-- 
2.55.0

