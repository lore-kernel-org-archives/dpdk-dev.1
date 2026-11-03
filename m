Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001F2606B259
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 14:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=pxbHth3+
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CD227410FC;
	Tue,  3 Nov 2026 15:57:23 +0100 (CET)
Received: from mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
 by mails.dpdk.org (Postfix) with ESMTPS id 5B57C4161A
 for <dev@dpdk.org>; Tue,  3 Nov 2026 15:57:22 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=DHg+BAhMG3CXy2xEPsGqEYkDsikPnAMh/pZYD/RJNqg=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793717842; v=1; x=1794322642;
 b=pxbHth3+xPtQtP9evMGuGQJkKu/59o5JDcKCiFem529NViqxqM+sbPvjbnxBDu0jzs+JG8k5
 PQqEAydw2RT0AxtlDm/s5Iugp+H1KCt+E59u/AFqZ8e+KaPz4KOaOibjp5gay2UXfDZ+Nyd2Lmx
 BVgrbaXRhUxHBVyCfXC5N8l4=
X-Envelope-To: dev@dpdk.org
Received: by mta11.migadu.com with ESMTPS id 3aa532e5f35afe42;
 Tue, 03 Nov 2026 14:57:22 +0000
X-Mizu-Trace-ID: 3aa532e5f35afe42
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 026/227] regexdev: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:49:44 +0800
Message-ID: <20261103145306.487255-27-chengwen.feng@linux.dev>
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
 lib/regexdev/rte_regexdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/regexdev/rte_regexdev.c b/lib/regexdev/rte_regexdev.c
index 8ba797b278..6b6052ca4e 100644
--- a/lib/regexdev/rte_regexdev.c
+++ b/lib/regexdev/rte_regexdev.c
@@ -59,7 +59,7 @@ regexdev_shared_data_prepare(void)
 		/* Allocate port data and ownership shared memory. */
 		mz = rte_memzone_reserve(MZ_RTE_REGEXDEV_DATA,
 					 sizeof(*rte_regexdev_shared_data),
-					 rte_socket_id(), flags);
+					 rte_numa_id(), flags);
 		if (mz == NULL)
 			return -ENOMEM;
 
-- 
2.55.0

