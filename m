Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2212B606A32E
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=nzy+hmAN
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7FC13427A8;
	Tue,  3 Nov 2026 16:08:14 +0100 (CET)
Received: from mta0.migadu.com (out-119.mta0.migadu.com [91.218.175.119])
 by mails.dpdk.org (Postfix) with ESMTPS id 7C93F410FC
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:08:12 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=x1FCOhyeXF4PAJRgCd56m1q8Uf2CurMj4vVvD9RBTxM=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718490; v=1; x=1794323290;
 b=nzy+hmANXuqpH8KQw+neS4sQeN3zfBnw+PM/ncU1jTyspeCk/A1p1jqDGSK3whOGCTh4KrLQ
 2vkyBeL5KVC5uVr369/soadfYf88RBubIr/ZhtrAjhC3n2TXYjCfYcjwZqrE7fZGPHFGjInwVfx
 Eq2FsN7rJ4Du5k/021SiIEPA=
X-Envelope-To: dev@dpdk.org
Received: by mta11.migadu.com with ESMTPS id 79266fb32b0244d7;
 Tue, 03 Nov 2026 15:08:10 +0000
X-Mizu-Trace-ID: 79266fb32b0244d7
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 093/227] event/dpaa2: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:50:51 +0800
Message-ID: <20261103145306.487255-94-chengwen.feng@linux.dev>
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
 drivers/event/dpaa2/dpaa2_eventdev.c          | 2 +-
 drivers/event/dpaa2/dpaa2_eventdev_selftest.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/event/dpaa2/dpaa2_eventdev.c b/drivers/event/dpaa2/dpaa2_eventdev.c
index 95d9154b11..2530d9a271 100644
--- a/drivers/event/dpaa2/dpaa2_eventdev.c
+++ b/drivers/event/dpaa2/dpaa2_eventdev.c
@@ -1084,7 +1084,7 @@ dpaa2_eventdev_create(const char *name, struct rte_vdev_device *vdev)
 
 	eventdev = rte_event_pmd_vdev_init(name,
 					   sizeof(struct dpaa2_eventdev),
-					   rte_socket_id(), vdev);
+					   rte_numa_id(), vdev);
 	if (eventdev == NULL) {
 		DPAA2_EVENTDEV_ERR("Failed to create Event device %s", name);
 		goto fail;
diff --git a/drivers/event/dpaa2/dpaa2_eventdev_selftest.c b/drivers/event/dpaa2/dpaa2_eventdev_selftest.c
index b1e4bf6855..079825ed58 100644
--- a/drivers/event/dpaa2/dpaa2_eventdev_selftest.c
+++ b/drivers/event/dpaa2/dpaa2_eventdev_selftest.c
@@ -124,7 +124,7 @@ _eventdev_setup(int mode)
 					0 /*MBUF_CACHE_SIZE*/,
 					0,
 					512, /* Use very small mbufs */
-					rte_socket_id());
+					rte_numa_id());
 	if (!eventdev_test_mempool) {
 		dpaa2_evdev_err("ERROR creating mempool");
 		return -1;
-- 
2.55.0

