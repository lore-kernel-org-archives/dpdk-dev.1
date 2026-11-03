Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2854606D816
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 14:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Sa1Y65ej
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7AB904161A;
	Tue,  3 Nov 2026 15:58:02 +0100 (CET)
Received: from mta0.migadu.com (out-48.mta0.migadu.com [91.218.175.48])
 by mails.dpdk.org (Postfix) with ESMTPS id 26FF5410FC
 for <dev@dpdk.org>; Tue,  3 Nov 2026 15:58:01 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=T43z/+UQj2QvX72PqTCCFaUHWkgN0mIFHfGtLqYzPTU=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793717881; v=1; x=1794322681;
 b=Sa1Y65ej3QUyrm7oqJqJo4sJHsWVSYuXZ2Puxcf0Z9m+pu24Iwvn2Q92AedaDR1X7Le1QtCH
 EpQPoMjfbcYzKn7xO3DYOqiC22BhBCqTxcGjfEhYq4Eidba0OHXYxyujNrQQiNl8ccFsoc2mL8h
 WXyivOoekNuvHLXCcTaGvH9s=
X-Envelope-To: dev@dpdk.org
Received: by mta11.migadu.com with ESMTPS id b5272ef250f58d32;
 Tue, 03 Nov 2026 14:58:00 +0000
X-Mizu-Trace-ID: b5272ef250f58d32
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 032/227] pdump: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:49:50 +0800
Message-ID: <20261103145306.487255-33-chengwen.feng@linux.dev>
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
 lib/pdump/rte_pdump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/pdump/rte_pdump.c b/lib/pdump/rte_pdump.c
index ac94efe7ff..10d195e39a 100644
--- a/lib/pdump/rte_pdump.c
+++ b/lib/pdump/rte_pdump.c
@@ -636,7 +636,7 @@ rte_pdump_init(void)
 			return -1;
 
 		mz = rte_memzone_reserve(MZ_RTE_PDUMP_STATS, sizeof(*pdump_stats),
-					 SOCKET_ID_ANY, 0);
+					 RTE_NUMA_ID_ANY, 0);
 		if (mz == NULL) {
 			PDUMP_LOG_LINE(ERR, "cannot allocate pdump statistics");
 			rte_mp_action_unregister(PDUMP_MP);
-- 
2.55.0

