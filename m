Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7791606A7A0
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=NHm7Z8av
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6558042FC5;
	Tue,  3 Nov 2026 16:22:04 +0100 (CET)
Received: from mta1.migadu.com (out-5.mta1.migadu.com [95.215.58.5])
 by mails.dpdk.org (Postfix) with ESMTPS id 8257B42FA5
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:22:03 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=kEGHUYEzWYXIYoa5Dcn5jj7x5GjzkcsGQ34h7P8Vj58=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793719323; v=1; x=1794324123;
 b=NHm7Z8avArUFDYoDp0/iaxxNcKHKz6UnyRf14/qYqLni+GgC75cj8VRmdQc0/tvy29zUsWd9
 ah+bUwxJOPZRexJrcrhbNM6avozY92IoRJDMcvK0TkRW4AZnrImsqvVLJnvn2j2caxNbSSl+ETc
 /gJZFaAIa4GqtpkiaGtxWD58=
X-Envelope-To: dev@dpdk.org
Received: by mta12.migadu.com with ESMTPS id c0eac15014c4e1f6;
 Tue, 03 Nov 2026 15:22:03 +0000
X-Mizu-Trace-ID: c0eac15014c4e1f6
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 182/227] app/test-regex: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:52:20 +0800
Message-ID: <20261103145306.487255-183-chengwen.feng@linux.dev>
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
 app/test-regex/main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/app/test-regex/main.c b/app/test-regex/main.c
index 81719f2e04..3b9a21bc92 100644
--- a/app/test-regex/main.c
+++ b/app/test-regex/main.c
@@ -425,7 +425,7 @@ run_regex(void *args)
 			0, 0, (nb_segs == 1) ? MBUF_SIZE :
 			(rte_align32pow2(job_len + (data_len % nb_jobs)) /
 			 nb_segs + RTE_PKTMBUF_HEADROOM),
-			rte_socket_id());
+			rte_numa_id());
 	if (mbuf_mp == NULL) {
 		printf("Error, can't create memory pool\n");
 		return -ENOMEM;
@@ -689,8 +689,8 @@ distribute_qps_to_lcores(uint32_t nb_cores, uint32_t nb_qps,
 		if (detected_lcores >= nb_cores)
 			break;
 		qps_per_lcore[detected_lcores].lcore_id = lcore_id;
-		socket = rte_lcore_to_socket_id(lcore_id);
-		if (socket == SOCKET_ID_ANY)
+		socket = rte_lcore_to_numa_id(lcore_id);
+		if (socket == RTE_NUMA_ID_ANY)
 			socket = 0;
 		qps_per_lcore[detected_lcores].socket = socket;
 		qps_per_lcore[detected_lcores].qp_id_base = min_qp_id;
-- 
2.55.0

