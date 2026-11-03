Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C1E606A324
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=JPo3ubDQ
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E757B40616;
	Tue,  3 Nov 2026 16:00:39 +0100 (CET)
Received: from mta0.migadu.com (out-117.mta0.migadu.com [91.218.175.117])
 by mails.dpdk.org (Postfix) with ESMTPS id 8025A4013F
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:00:38 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=qbeCzwkhPoc+nkAVncHhuzxXW8Ue0BAjnVkeI8wZfi4=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718038; v=1; x=1794322838;
 b=JPo3ubDQF6bfVIdJJtc/4hnfNiYLAN/GWakEyjYh2jda1aTAT+iLyCTOeRBZ3YCrcoxxfuGK
 A0pcpNEBNbyAAIVP8ctUu+rZL9q7tk0/Igvq1pVqguCeBVUc5lIHar9vHS7LGr0lp5Y0TZY5Ct4
 2FWnw9IKRfJJMLm4MPY4Ogvo=
X-Envelope-To: dev@dpdk.org
Received: by mta10.migadu.com with ESMTPS id 664ff7407c144206;
 Tue, 03 Nov 2026 15:00:20 +0000
X-Mizu-Trace-ID: 664ff7407c144206
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 044/227] bus/auxiliary: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:50:02 +0800
Message-ID: <20261103145306.487255-45-chengwen.feng@linux.dev>
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
 drivers/bus/auxiliary/auxiliary_common.c | 2 +-
 drivers/bus/auxiliary/linux/auxiliary.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/auxiliary/auxiliary_common.c b/drivers/bus/auxiliary/auxiliary_common.c
index 016d124f0b..622e03345e 100644
--- a/drivers/bus/auxiliary/auxiliary_common.c
+++ b/drivers/bus/auxiliary/auxiliary_common.c
@@ -84,7 +84,7 @@ auxiliary_probe_device(struct rte_driver *drv, struct rte_device *dev)
 	if (!auxiliary_dev_exists(dev->name))
 		return -ENOENT;
 
-	if (aux_dev->device.numa_node < 0 && rte_socket_count() > 1)
+	if (aux_dev->device.numa_node < 0 && rte_numa_count() > 1)
 		AUXILIARY_LOG(INFO, "Device %s is not NUMA-aware", aux_dev->name);
 
 	iova_mode = rte_eal_iova_mode();
diff --git a/drivers/bus/auxiliary/linux/auxiliary.c b/drivers/bus/auxiliary/linux/auxiliary.c
index 3a2dca2865..475db6caf8 100644
--- a/drivers/bus/auxiliary/linux/auxiliary.c
+++ b/drivers/bus/auxiliary/linux/auxiliary.c
@@ -43,7 +43,7 @@ auxiliary_scan_one(const char *dirname, const char *name)
 	    eal_parse_sysfs_value(filename, &tmp) == 0)
 		dev->device.numa_node = tmp;
 	else
-		dev->device.numa_node = SOCKET_ID_ANY;
+		dev->device.numa_node = RTE_NUMA_ID_ANY;
 
 	auxiliary_on_scan(dev);
 
-- 
2.55.0

