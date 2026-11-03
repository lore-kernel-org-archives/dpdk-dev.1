Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6CF606B24E
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 14:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=oZG6Ecvu
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8DA8C427A6;
	Tue,  3 Nov 2026 15:57:52 +0100 (CET)
Received: from mta0.migadu.com (out-43.mta0.migadu.com [91.218.175.43])
 by mails.dpdk.org (Postfix) with ESMTPS id 8D58041143
 for <dev@dpdk.org>; Tue,  3 Nov 2026 15:57:51 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=g5APoadwAtRh5UYBPRWO1E22oSsHoXZZC8dc5pQe0NI=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793717871; v=1; x=1794322671;
 b=oZG6EcvuF1X6IngAjTu2BgO6/2wwrdH2goRUkWkTSu/IDb4nDexDh+6sC0Ki3+knIhLnfYGF
 SdfKTZcWnheESScIIPDvuFX6QrMDSE/XaBU56rhcO+KSwFNlWjGC6VQfiaXfYfx35CpS5rTkNSZ
 npznCzk3F3zq6rw7MPmDsmmE=
X-Envelope-To: dev@dpdk.org
Received: by mta11.migadu.com with ESMTPS id 8893a01893a1aaa3;
 Tue, 03 Nov 2026 14:57:51 +0000
X-Mizu-Trace-ID: 8893a01893a1aaa3
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 031/227] rcu: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:49:49 +0800
Message-ID: <20261103145306.487255-32-chengwen.feng@linux.dev>
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
 lib/rcu/rte_rcu_qsbr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/rcu/rte_rcu_qsbr.c b/lib/rcu/rte_rcu_qsbr.c
index ac6d464b7f..835c351641 100644
--- a/lib/rcu/rte_rcu_qsbr.c
+++ b/lib/rcu/rte_rcu_qsbr.c
@@ -298,7 +298,7 @@ rte_rcu_qsbr_dq_create(const struct rte_rcu_qsbr_dq_parameters *params)
 	/* Add token size to ring element size */
 	dq->r = rte_ring_create_elem(params->name,
 			__RTE_QSBR_TOKEN_SIZE + params->esize,
-			qs_fifo_size, SOCKET_ID_ANY, flags);
+			qs_fifo_size, RTE_NUMA_ID_ANY, flags);
 	if (dq->r == NULL) {
 		RCU_LOG(ERR, "defer queue create failed");
 		rte_free(dq);
-- 
2.55.0

