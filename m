Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6912606C810
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 14:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=WpZLYxHD
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9BEE142798;
	Tue,  3 Nov 2026 15:58:36 +0100 (CET)
Received: from mta1.migadu.com (out-238.mta1.migadu.com [95.215.58.238])
 by mails.dpdk.org (Postfix) with ESMTPS id 932AA410FC
 for <dev@dpdk.org>; Tue,  3 Nov 2026 15:58:35 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=qCyemH2AXkngWZJtJV9zWDOaiJ5BUJFv/zRTBRuQ7yA=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793717915; v=1; x=1794322715;
 b=WpZLYxHDS78q0jhOhOCxWliBJrzMyeooRhDcDm1LrGHhmRbXiCCCBL3cDSp2ZPtj4I8biTde
 TBs3RBhufk3b5Y+vpEgbbjfOOMGBssfeJtTW5WyvSDcaTlFK4WvgRg9LsH6D2AeJuq6CfHCRoRE
 SbllNzRR329rvJ9NEV7dhQyg=
X-Envelope-To: dev@dpdk.org
Received: by mta10.migadu.com with ESMTPS id d512bb13b1e0e21c;
 Tue, 03 Nov 2026 14:58:35 +0000
X-Mizu-Trace-ID: d512bb13b1e0e21c
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 036/227] dmadev: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:49:54 +0800
Message-ID: <20261103145306.487255-37-chengwen.feng@linux.dev>
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

Rename socket_id parameters, internal variables and comments to
the NUMA node terminology, and switch internal calls to
rte_zmalloc_numa(), rte_numa_id() and RTE_NUMA_ID_ANY.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 lib/dmadev/rte_dmadev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/dmadev/rte_dmadev.c b/lib/dmadev/rte_dmadev.c
index 2311f01906..f8f2974ef8 100644
--- a/lib/dmadev/rte_dmadev.c
+++ b/lib/dmadev/rte_dmadev.c
@@ -200,7 +200,7 @@ dma_shared_data_prepare(void)
 		sizeof(struct rte_dma_dev_data) * dma_devices_max;
 
 	if (rte_eal_process_type() == RTE_PROC_PRIMARY)
-		mz = rte_memzone_reserve(mz_name, size, rte_socket_id(), 0);
+		mz = rte_memzone_reserve(mz_name, size, rte_numa_id(), 0);
 	else
 		mz = rte_memzone_lookup(mz_name);
 	if (mz == NULL)
@@ -269,7 +269,7 @@ dma_allocate_primary(const char *name, int numa_node, size_t private_data_size)
 		return NULL;
 	}
 
-	dev_private = rte_zmalloc_socket(name, private_data_size,
+	dev_private = rte_zmalloc_numa(name, private_data_size,
 					 RTE_CACHE_LINE_SIZE, numa_node);
 	if (dev_private == NULL) {
 		RTE_DMA_LOG(ERR, "Cannot allocate private data");
-- 
2.55.0

