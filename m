Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F60606C805
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 14:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=uREUGjhc
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CEF9D427A0;
	Tue,  3 Nov 2026 15:58:26 +0100 (CET)
Received: from mta1.migadu.com (out-227.mta1.migadu.com [95.215.58.227])
 by mails.dpdk.org (Postfix) with ESMTPS id 3A46C4279F
 for <dev@dpdk.org>; Tue,  3 Nov 2026 15:58:25 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=tM9s3sBFUnfbBQALicWVYVtIIz9i86i7Fq/EjsfIYBY=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793717905; v=1; x=1794322705;
 b=uREUGjhcELQ7t4B/49C9KPPbVMrvh0TDoMxKU/khR15Te6/WDtTdCSl8EyPezBdgjoQO+Cfa
 VqOPLYz/CKTRVDg/bLWq7Gz0zKEc1q8ezZMHcKrfA0340ZDslVc/aEWbawfsai5a5Xlop0FuM8S
 p7gt34akZeRewexzRRr7Iveo=
X-Envelope-To: dev@dpdk.org
Received: by mta11.migadu.com with ESMTPS id 1744fd83bfa9c9c6;
 Tue, 03 Nov 2026 14:58:24 +0000
X-Mizu-Trace-ID: 1744fd83bfa9c9c6
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 035/227] gpudev: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:49:53 +0800
Message-ID: <20261103145306.487255-36-chengwen.feng@linux.dev>
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
 lib/gpudev/gpudev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/gpudev/gpudev.c b/lib/gpudev/gpudev.c
index 4a2335834c..6d70a28387 100644
--- a/lib/gpudev/gpudev.c
+++ b/lib/gpudev/gpudev.c
@@ -169,7 +169,7 @@ gpu_shared_mem_init(void)
 		memzone = rte_memzone_reserve(GPU_MEMZONE,
 				sizeof(*gpu_shared_mem) +
 				sizeof(*gpu_shared_mem->gpus) * gpu_max,
-				SOCKET_ID_ANY, 0);
+				RTE_NUMA_ID_ANY, 0);
 	} else {
 		memzone = rte_memzone_lookup(GPU_MEMZONE);
 	}
-- 
2.55.0

