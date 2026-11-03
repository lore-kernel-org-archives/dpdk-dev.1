Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E22606C84C
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 14:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=LxpG23qj
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3056E4279D;
	Tue,  3 Nov 2026 15:58:09 +0100 (CET)
Received: from mta0.migadu.com (out-51.mta0.migadu.com [91.218.175.51])
 by mails.dpdk.org (Postfix) with ESMTPS id A02FC410FC
 for <dev@dpdk.org>; Tue,  3 Nov 2026 15:58:08 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=nEfUmUEq3AMFUFHEJjMxB/3wytyylMvxaWgVpNLJwdw=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793717888; v=1; x=1794322688;
 b=LxpG23qjBXT/sSg2EUJEuS+RjFqq0Iy/2dtThnoYXNVtor8VeO6o27qKJaiMXR0HMW4zkvew
 Xqpgxtjd4r1MmSH3qhDrh8ZKpf86cyk3wauXkJ9SD7KNYfQDbEE/aqFOzVcbNSR2iSCisN1rvs6
 MCebRm2nA5xN172GcJc3gh1M=
X-Envelope-To: dev@dpdk.org
Received: by mta12.migadu.com with ESMTPS id 26917f9237ef281e;
 Tue, 03 Nov 2026 14:58:08 +0000
X-Mizu-Trace-ID: 26917f9237ef281e
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 033/227] pdcp: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:49:51 +0800
Message-ID: <20261103145306.487255-34-chengwen.feng@linux.dev>
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
 lib/pdcp/rte_pdcp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/pdcp/rte_pdcp.c b/lib/pdcp/rte_pdcp.c
index d21df8ab43..21c77296d2 100644
--- a/lib/pdcp/rte_pdcp.c
+++ b/lib/pdcp/rte_pdcp.c
@@ -145,8 +145,8 @@ rte_pdcp_entity_establish(const struct rte_pdcp_entity_conf *conf)
 		return NULL;
 	}
 
-	entity = rte_zmalloc_socket("pdcp_entity", entity_layout.total_size, RTE_CACHE_LINE_SIZE,
-				    SOCKET_ID_ANY);
+	entity = rte_zmalloc_numa("pdcp_entity", entity_layout.total_size, RTE_CACHE_LINE_SIZE,
+				    RTE_NUMA_ID_ANY);
 	if (entity == NULL) {
 		rte_errno = ENOMEM;
 		return NULL;
-- 
2.55.0

