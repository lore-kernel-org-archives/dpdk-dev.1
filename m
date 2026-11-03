Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC416606FCF5
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=GQ5rmta7
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ADD23427DD;
	Tue,  3 Nov 2026 16:01:38 +0100 (CET)
Received: from mta1.migadu.com (out-239.mta1.migadu.com [95.215.58.239])
 by mails.dpdk.org (Postfix) with ESMTPS id 220F8427BE
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:01:37 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=pvb/LTkRoUaxfDDQCoWp+/7EngRnaogLe9jv6gXZ5R8=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718096; v=1; x=1794322896;
 b=GQ5rmta717aCiW1d+lDZR0qYhsFt2HZsxLI1eRnFLFWzT6QONjzCdb7tyllncGsPXLR3hNIt
 tJb5YIC3h4zxeSqcfwrwpgEouxrZQRQ4XAkNr3Mi5A0LyECi3chr4LnBVWQlVyu4ebWFRyFaSY3
 5tYof6nYvLZ2L1QgOoYR4op8=
X-Envelope-To: dev@dpdk.org
Received: by mta10.migadu.com with ESMTPS id a1270d1ca80ce786;
 Tue, 03 Nov 2026 15:01:36 +0000
X-Mizu-Trace-ID: a1270d1ca80ce786
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 052/227] common/cnxk: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:50:10 +0800
Message-ID: <20261103145306.487255-53-chengwen.feng@linux.dev>
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
 drivers/common/cnxk/roc_platform.c | 2 +-
 drivers/common/cnxk/roc_platform.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/common/cnxk/roc_platform.c b/drivers/common/cnxk/roc_platform.c
index 59d662fab4..7d3b9518d7 100644
--- a/drivers/common/cnxk/roc_platform.c
+++ b/drivers/common/cnxk/roc_platform.c
@@ -305,7 +305,7 @@ roc_plt_init(void)
 		if (mz == NULL) {
 			mz = rte_memzone_reserve(PLT_MODEL_MZ_NAME,
 						 sizeof(struct roc_model),
-						 SOCKET_ID_ANY, 0);
+						 RTE_NUMA_ID_ANY, 0);
 			if (mz == NULL) {
 				plt_err("Failed to reserve mem for roc_model");
 				return -ENOMEM;
diff --git a/drivers/common/cnxk/roc_platform.h b/drivers/common/cnxk/roc_platform.h
index 70937e8b3a..4003794b8f 100644
--- a/drivers/common/cnxk/roc_platform.h
+++ b/drivers/common/cnxk/roc_platform.h
@@ -406,7 +406,7 @@ plt_lmt_region_reserve_aligned(const char *name, size_t len, uint32_t align)
 	/* To ensure returned memory is physically contiguous, bounding
 	 * the start and end address in 2M range.
 	 */
-	return rte_memzone_reserve_bounded(name, len, SOCKET_ID_ANY,
+	return rte_memzone_reserve_bounded(name, len, RTE_NUMA_ID_ANY,
 					   RTE_MEMZONE_IOVA_CONTIG,
 					   align, RTE_PGSIZE_2M);
 }
-- 
2.55.0

