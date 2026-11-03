Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B753B606BA0B
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=eZlwYIs8
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7CB0F4279D;
	Tue,  3 Nov 2026 16:09:44 +0100 (CET)
Received: from mta0.migadu.com (out-165.mta0.migadu.com [91.218.175.165])
 by mails.dpdk.org (Postfix) with ESMTPS id 3463440616
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:09:43 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=vyyJDJUKaMtvQTBaPzONS0c9WLXTRnIk4czdtClYBWY=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718583; v=1; x=1794323383;
 b=eZlwYIs86nO00fNF9wiv0/n3ZI5FUzvkKUMX0UaWLIRFpjVL5bx5Vl1p6/V10Z3bzEPLsO16
 msYOgK3JCAlHBf3OtsbkrRK5pJ+Ooudun2g1Df2B74L9/yRdMJ5kty8Z/nR4nyHPSpW4oDgk4jX
 uGikc9pt4mMwn5ATU9cN43J0=
X-Envelope-To: dev@dpdk.org
Received: by mta10.migadu.com with ESMTPS id 9ac29ae0ca867192;
 Tue, 03 Nov 2026 15:09:42 +0000
X-Mizu-Trace-ID: 9ac29ae0ca867192
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 100/227] mempool/cnxk: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:50:58 +0800
Message-ID: <20261103145306.487255-101-chengwen.feng@linux.dev>
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
 drivers/mempool/cnxk/cn10k_mempool_ops.c | 2 +-
 drivers/mempool/cnxk/cnxk_mempool.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mempool/cnxk/cn10k_mempool_ops.c b/drivers/mempool/cnxk/cn10k_mempool_ops.c
index 09f900a850..472144da8b 100644
--- a/drivers/mempool/cnxk/cn10k_mempool_ops.c
+++ b/drivers/mempool/cnxk/cn10k_mempool_ops.c
@@ -47,7 +47,7 @@ batch_op_data_table_create(void)
 			sz = maxpools * sizeof(struct batch_op_data *);
 
 			mz = rte_memzone_reserve_aligned(
-				BATCH_OP_DATA_TABLE_MZ_NAME, sz, SOCKET_ID_ANY,
+				BATCH_OP_DATA_TABLE_MZ_NAME, sz, RTE_NUMA_ID_ANY,
 				0, ROC_ALIGN);
 		}
 		if (mz == NULL) {
diff --git a/drivers/mempool/cnxk/cnxk_mempool.c b/drivers/mempool/cnxk/cnxk_mempool.c
index 6939fccff4..8a6a1b8c4c 100644
--- a/drivers/mempool/cnxk/cnxk_mempool.c
+++ b/drivers/mempool/cnxk/cnxk_mempool.c
@@ -108,7 +108,7 @@ npa_init(struct rte_pci_device *pci_dev)
 	int rc = -ENOMEM;
 
 	mz = rte_memzone_reserve_aligned(npa_dev_to_name(pci_dev, name),
-					 sizeof(*dev), SOCKET_ID_ANY, 0,
+					 sizeof(*dev), RTE_NUMA_ID_ANY, 0,
 					 RTE_CACHE_LINE_SIZE);
 	if (mz == NULL)
 		goto error;
-- 
2.55.0

