Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B3D606A327
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ihNXEPU/
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C43BF42F73;
	Tue,  3 Nov 2026 16:20:06 +0100 (CET)
Received: from mta0.migadu.com (out-226.mta0.migadu.com [91.218.175.226])
 by mails.dpdk.org (Postfix) with ESMTPS id D148542F73
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:20:05 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=LItoHsxz5NHbAltPStdS52PLhRwS4EfwJUUUN23n8eY=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793719205; v=1; x=1794324005;
 b=ihNXEPU/xh//9nS9w7OcWF16B3fsRcaSCxDolOcYiuhP7VqFFOvokv6/8EJ8dPWv0Ndrc8Ev
 8JOthpwPB/EOGQQHA4dzFr7TGVEgcXwLAM0GxpIeZ5Fi45az43UB34p+VwzizYi+HmBQ/rWKQOk
 2H7rkV4tJsMdbDn5LE19LkXQ=
X-Envelope-To: dev@dpdk.org
Received: by mta10.migadu.com with ESMTPS id 93c2d8b3c31ee0a6;
 Tue, 03 Nov 2026 15:20:05 +0000
X-Mizu-Trace-ID: 93c2d8b3c31ee0a6
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 172/227] app/proc-info: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:52:10 +0800
Message-ID: <20261103145306.487255-173-chengwen.feng@linux.dev>
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

Rename socket_id parameters, local variables and comments to the
NUMA node terminology, and switch calls to the NUMA-named APIs.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 app/proc-info/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/app/proc-info/main.c b/app/proc-info/main.c
index 1e5eee6787..8e8cc923ce 100644
--- a/app/proc-info/main.c
+++ b/app/proc-info/main.c
@@ -1034,7 +1034,7 @@ show_port(void)
 
 		printf("\t  -- driver %s device %s socket %d\n",
 		       dev_info.driver_name, rte_dev_name(dev_info.device),
-		       rte_eth_dev_socket_id(i));
+		       rte_eth_dev_numa_id(i));
 
 		ret = rte_eth_dev_owner_get(i, &owner);
 		if (ret == 0 && owner.id != RTE_ETH_DEV_NO_OWNER)
@@ -1631,7 +1631,7 @@ show_mempool(char *name)
 				"\t  -- No IOVA config (%c)\n"
 				"\t  -- Not used for IO (%c)\n",
 				ptr->name,
-				ptr->socket_id,
+				ptr->numa_id,
 				(flags & RTE_MEMPOOL_F_NO_SPREAD) ? 'y' : 'n',
 				(flags & RTE_MEMPOOL_F_NO_CACHE_ALIGN) ? 'y' : 'n',
 				(flags & RTE_MEMPOOL_F_SP_PUT) ? 'y' : 'n',
-- 
2.55.0

