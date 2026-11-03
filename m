Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1D3606BA23
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 14:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=UDdqSMZc
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E40E642708;
	Tue,  3 Nov 2026 15:57:41 +0100 (CET)
Received: from mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
 by mails.dpdk.org (Postfix) with ESMTPS id 88143410FC
 for <dev@dpdk.org>; Tue,  3 Nov 2026 15:57:40 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=WVm9PkYqCybA8ZxVYY8fH1EXTGnyRt6cgQA6WW/KiIs=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793717860; v=1; x=1794322660;
 b=UDdqSMZcp00zSUr1kjvVLeGH30N9e4kXeBEoH2MT4WdJ35s0DhHq3CGyN/ghIfy+uP+nnQKF
 dIa+BXQZ4w4pQ7QgsB3+QZJVnTyIhDKKlnhVREGvvKDqE1sfZt7lGy2WcSdi6nkgXBWTP2JKSIl
 qbajcXVEK2RsznZSJ4JVUvPs=
X-Envelope-To: dev@dpdk.org
Received: by mta10.migadu.com with ESMTPS id 1635fe5fdc946ff8;
 Tue, 03 Nov 2026 14:57:40 +0000
X-Mizu-Trace-ID: 1635fe5fdc946ff8
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 029/227] timer: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:49:47 +0800
Message-ID: <20261103145306.487255-30-chengwen.feng@linux.dev>
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
 lib/timer/rte_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/timer/rte_timer.c b/lib/timer/rte_timer.c
index b349c2abbc..150fffdfec 100644
--- a/lib/timer/rte_timer.c
+++ b/lib/timer/rte_timer.c
@@ -151,7 +151,7 @@ rte_timer_subsystem_init(void)
 	mz = rte_memzone_lookup(mz_name);
 	if (mz == NULL) {
 		mz = rte_memzone_reserve_aligned(mz_name, mem_size,
-				SOCKET_ID_ANY, 0, RTE_CACHE_LINE_SIZE);
+				RTE_NUMA_ID_ANY, 0, RTE_CACHE_LINE_SIZE);
 		if (mz == NULL) {
 			rte_mcfg_timer_unlock();
 			return -ENOMEM;
-- 
2.55.0

