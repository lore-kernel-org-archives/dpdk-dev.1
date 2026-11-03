Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3BE60A383E
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=B3bpVTw1
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9EA8242F3F;
	Tue,  3 Nov 2026 16:19:07 +0100 (CET)
Received: from mta1.migadu.com (out-96.mta1.migadu.com [95.215.58.96])
 by mails.dpdk.org (Postfix) with ESMTPS id B0EB2427E0
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:19:06 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=t0609EJmA4lIn/Ogi1cygD2qG6CWBk5ijHTQQ8ReMwI=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793719146; v=1; x=1794323946;
 b=B3bpVTw1hDohOdRjOTfTztu4ADv6xPycW/t2ca65rd+bGV5y7UgDn95kiFAVCBTSvvAO4/Kg
 X/BatHgarpU5E/PnN8GrO2BZSrfL/Y3OShCGZBw4awlXkunp9dPseLOWcr685YbGqY598OLIY3C
 nRA61Yio9m7/ePerfq+m2cKY=
X-Envelope-To: dev@dpdk.org
Received: by mta10.migadu.com with ESMTPS id 99d2f4be7b4ddc03;
 Tue, 03 Nov 2026 15:19:06 +0000
X-Mizu-Trace-ID: 99d2f4be7b4ddc03
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 165/227] regex/cn9k: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:52:03 +0800
Message-ID: <20261103145306.487255-166-chengwen.feng@linux.dev>
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
 drivers/regex/cn9k/cn9k_regexdev.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/regex/cn9k/cn9k_regexdev.c b/drivers/regex/cn9k/cn9k_regexdev.c
index 5abc7e22bc..74a2aa6421 100644
--- a/drivers/regex/cn9k/cn9k_regexdev.c
+++ b/drivers/regex/cn9k/cn9k_regexdev.c
@@ -99,7 +99,7 @@ ree_qp_create(const struct rte_regexdev *dev, uint16_t qp_id)
 	qp_memzone_name_get(name, RTE_MEMZONE_NAMESIZE, dev->data->dev_id,
 			    qp_id);
 
-	lf_mem = rte_memzone_reserve_aligned(name, len, rte_socket_id(),
+	lf_mem = rte_memzone_reserve_aligned(name, len, rte_numa_id(),
 			RTE_MEMZONE_SIZE_HINT_ONLY | RTE_MEMZONE_256MB,
 			RTE_CACHE_LINE_SIZE);
 	if (lf_mem == NULL) {
@@ -204,10 +204,10 @@ ree_dev_register(const char *name)
 	/* allocate private device structure */
 	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
 		dev->data->dev_private =
-				rte_zmalloc_socket("regexdev device private",
+				rte_zmalloc_numa("regexdev device private",
 						sizeof(struct cn9k_ree_data),
 						RTE_CACHE_LINE_SIZE,
-						rte_socket_id());
+						rte_numa_id());
 
 		if (dev->data->dev_private == NULL) {
 			cn9k_err("Cannot allocate memory for dev %s private data",
-- 
2.55.0

