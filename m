Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644E5606F60E
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=RdarzfW1
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3AFDC42E0B;
	Tue,  3 Nov 2026 16:07:02 +0100 (CET)
Received: from mta0.migadu.com (out-75.mta0.migadu.com [91.218.175.75])
 by mails.dpdk.org (Postfix) with ESMTPS id C91F542C24
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:07:00 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=X5WHHhEraCDDm5z/Uu8/U5+Rxtndh9A+qZ+Q3gXcBI4=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718420; v=1; x=1794323220;
 b=RdarzfW1Ggn7EnL95Q+Hge1DMYqbuH1adnWD4inyye7Bf7KTRnipD5qc2VLBHWPk7WavWmYE
 Hg+13ktb4oAfdM2eglu3SUmeDsB6ZDmkd0ARp5bRgnVVhV/zmYiDhdCeD6ZyVsYENt5nqWFSgjx
 uuffZBheKqbDQrnWfl2gNh4o=
X-Envelope-To: dev@dpdk.org
Received: by mta11.migadu.com with ESMTPS id d54710f60553d755;
 Tue, 03 Nov 2026 15:07:00 +0000
X-Mizu-Trace-ID: d54710f60553d755
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 082/227] dma/cnxk: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:50:40 +0800
Message-ID: <20261103145306.487255-83-chengwen.feng@linux.dev>
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

Rename socket_id parameters, internal structure fields, variables
and comments to the NUMA node terminology, and switch calls to
the NUMA-named APIs.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/dma/cnxk/cnxk_dmadev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/cnxk/cnxk_dmadev.c b/drivers/dma/cnxk/cnxk_dmadev.c
index db177afd6f..2f0100ab2b 100644
--- a/drivers/dma/cnxk/cnxk_dmadev.c
+++ b/drivers/dma/cnxk/cnxk_dmadev.c
@@ -151,7 +151,7 @@ cnxk_dmadev_chunk_pool_create(struct rte_dma_dev *dev, uint32_t nb_chunks, uint3
 
 	nb_chunks += (CNXK_DPI_POOL_MAX_CACHE_SZ * rte_lcore_count());
 	dpivf->chunk_pool = rte_mempool_create_empty(
-		pool_name, nb_chunks, chunk_sz, CNXK_DPI_POOL_MAX_CACHE_SZ, 0, rte_socket_id(), 0);
+		pool_name, nb_chunks, chunk_sz, CNXK_DPI_POOL_MAX_CACHE_SZ, 0, rte_numa_id(), 0);
 
 	if (dpivf->chunk_pool == NULL) {
 		plt_err("Unable to create chunkpool.");
-- 
2.55.0

