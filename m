Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDCB606A326
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=UMpg72Rr
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C9F1E4333A;
	Tue,  3 Nov 2026 16:28:55 +0100 (CET)
Received: from mta1.migadu.com (out-138.mta1.migadu.com [95.215.58.138])
 by mails.dpdk.org (Postfix) with ESMTPS id BDD394332A
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:28:54 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=pee2j3D+2SdEucTjVFfTeUKqCTZ87bQy1lg+nAqqSPY=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793719734; v=1; x=1794324534;
 b=UMpg72RrH+dsUPEEXb7n0shPUaI5Y4+T084A5xJAUrBC1P6elFHWk1+DBMTs8I9xcpcbkYQL
 IJSk/RZ/tB6Kqx3lJrdMvHK48eoySTEkpEbLZnZx+DnJ7jpRv4FATnKsrD1ADgN0SIQE64fTX4J
 7AuZxV4OylBs6adkJLEm7p1E=
X-Envelope-To: dev@dpdk.org
Received: by mta11.migadu.com with ESMTPS id 38cfd9b544015b6a;
 Tue, 03 Nov 2026 15:28:54 +0000
X-Mizu-Trace-ID: 38cfd9b544015b6a
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 226/227] test/memzone: fix NUMA node terminology rename
Date: Tue,  3 Nov 2026 22:53:04 +0800
Message-ID: <20261103145306.487255-227-chengwen.feng@linux.dev>
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

One socket variable in the memzone tests was missed by the
terminology renames; rename it to numa_id.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 app/test/test_memzone.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/app/test/test_memzone.c b/app/test/test_memzone.c
index 1ebbf6286b..b3e76b6e4f 100644
--- a/app/test/test_memzone.c
+++ b/app/test/test_memzone.c
@@ -576,7 +576,7 @@ test_memzone_reserve_max_aligned(void)
 		const unsigned int align = 1 << ((rte_rand() % 8) + 5); /* from 128 up to 4k alignment */
 
 		/* memzone size may be between size and size - align */
-		minlen = find_max_block_free_size(align, socket);
+		minlen = find_max_block_free_size(align, numa_id);
 		maxlen = find_max_block_free_size(0, numa_id);
 
 		if (minlen == 0 || maxlen == 0) {
@@ -587,7 +587,7 @@ test_memzone_reserve_max_aligned(void)
 
 		mz = rte_memzone_reserve_aligned(
 				TEST_MEMZONE_NAME("max_zone_aligned"),
-				0, socket, 0, align);
+				0, numa_id, 0, align);
 		if (mz == NULL) {
 			printf("Failed to reserve a big chunk of memory - %s\n",
 					rte_strerror(rte_errno));
@@ -1053,9 +1053,9 @@ test_memzone_basic(void)
 					memzone3->iova, memzone3->len))
 		return -1;
 
-	printf("check socket ID\n");
+	printf("check numa_id ID\n");
 
-	/* memzone2 must be on socket id 0 and memzone3 on socket 1 */
+	/* memzone2 must be on numa_id id 0 and memzone3 on numa_id 1 */
 	if (memzone2->numa_id != 0)
 		return -1;
 	if (memzone3 != NULL && memzone3->numa_id != 1)
-- 
2.55.0

