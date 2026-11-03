Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E22606A32F
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=mA75OH8j
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C3F504279D;
	Tue,  3 Nov 2026 16:08:13 +0100 (CET)
Received: from mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
 by mails.dpdk.org (Postfix) with ESMTPS id B9D71410FC
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:08:11 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=rEjssfbqRs/5ElW28fhXA/TrgRriuv7s0lO/UYXOqFg=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718484; v=1; x=1794323284;
 b=mA75OH8j8ONlkWrdOXpwZ5JBXg88qJBJMqvdrTwvOof56hF1CjtBodBjMWJFs2y9Ug3f4c6C
 rSCsSUN1GYE/WaKS+6zjQb2gCb2Tgt/fu9EIhSQasqfbzpdMl1hltdUMRM3U2X8+hlZew3V5otd
 ntVcvDsayoCF8yN3e41WVXpY=
X-Envelope-To: dev@dpdk.org
Received: by mta11.migadu.com with ESMTPS id f9876a9ca738530d;
 Tue, 03 Nov 2026 15:08:04 +0000
X-Mizu-Trace-ID: f9876a9ca738530d
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 092/227] event/dpaa: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:50:50 +0800
Message-ID: <20261103145306.487255-93-chengwen.feng@linux.dev>
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
 drivers/event/dpaa/dpaa_eventdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/event/dpaa/dpaa_eventdev.c b/drivers/event/dpaa/dpaa_eventdev.c
index e5d93afca2..085a2cd69c 100644
--- a/drivers/event/dpaa/dpaa_eventdev.c
+++ b/drivers/event/dpaa/dpaa_eventdev.c
@@ -984,7 +984,7 @@ dpaa_event_dev_create(const char *name, const char *params, struct rte_vdev_devi
 
 	eventdev = rte_event_pmd_vdev_init(name,
 					   sizeof(struct dpaa_eventdev),
-					   rte_socket_id(), vdev);
+					   rte_numa_id(), vdev);
 	if (eventdev == NULL) {
 		DPAA_EVENTDEV_ERR("Failed to create eventdev vdev %s", name);
 		goto fail;
-- 
2.55.0

