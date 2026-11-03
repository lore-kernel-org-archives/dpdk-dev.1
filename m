Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACD660A6F6A
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=vofiFXUZ
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BAB9D410FC;
	Tue,  3 Nov 2026 16:01:32 +0100 (CET)
Received: from mta1.migadu.com (out-230.mta1.migadu.com [95.215.58.230])
 by mails.dpdk.org (Postfix) with ESMTPS id A504F410EA
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:01:31 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=bYqbT3LMPSf7jyxELflfvvYXAmLekEIMpQI0HU6jxfs=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718091; v=1; x=1794322891;
 b=vofiFXUZRdroK2oyqbzsItsZjeil0XJf1dSFVtUMXlEhDnVIwgo+S+qp4kNCX6QXqPnQ3uhf
 UlX/VJPhnt6Y6wgXTYCMREpKUmUskYvWcLQ8Pm7YtSWvJJtrSLzlZ2ztYWOG6/a2tJ9vazdxC4w
 iRhawTdlrDiFEv6N28CTymfQ=
X-Envelope-To: dev@dpdk.org
Received: by mta12.migadu.com with ESMTPS id ffe24dfd34a5839e;
 Tue, 03 Nov 2026 15:01:31 +0000
X-Mizu-Trace-ID: ffe24dfd34a5839e
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 051/227] bus/vmbus: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:50:09 +0800
Message-ID: <20261103145306.487255-52-chengwen.feng@linux.dev>
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
 drivers/bus/vmbus/linux/vmbus_bus.c | 2 +-
 drivers/bus/vmbus/vmbus_channel.c   | 2 +-
 drivers/bus/vmbus/vmbus_common.c    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/bus/vmbus/linux/vmbus_bus.c b/drivers/bus/vmbus/linux/vmbus_bus.c
index 779ea50b92..86276eb564 100644
--- a/drivers/bus/vmbus/linux/vmbus_bus.c
+++ b/drivers/bus/vmbus/linux/vmbus_bus.c
@@ -330,7 +330,7 @@ vmbus_scan_one(const char *name)
 
 	dev->device.devargs = rte_bus_find_devargs(&rte_vmbus_bus, dev->name);
 
-	dev->device.numa_node = SOCKET_ID_ANY;
+	dev->device.numa_node = RTE_NUMA_ID_ANY;
 	if (vmbus_use_numa(dev)) {
 		/* get numa node (if present) */
 		snprintf(filename, sizeof(filename), "%s/numa_node",
diff --git a/drivers/bus/vmbus/vmbus_channel.c b/drivers/bus/vmbus/vmbus_channel.c
index 90ba3d1ef6..d25db272b3 100644
--- a/drivers/bus/vmbus/vmbus_channel.c
+++ b/drivers/bus/vmbus/vmbus_channel.c
@@ -345,7 +345,7 @@ int vmbus_chan_create(const struct rte_vmbus_device *device,
 	struct vmbus_channel *chan;
 	int err;
 
-	chan = rte_zmalloc_socket("VMBUS", sizeof(*chan), RTE_CACHE_LINE_SIZE,
+	chan = rte_zmalloc_numa("VMBUS", sizeof(*chan), RTE_CACHE_LINE_SIZE,
 				  device->device.numa_node);
 	if (!chan)
 		return -ENOMEM;
diff --git a/drivers/bus/vmbus/vmbus_common.c b/drivers/bus/vmbus/vmbus_common.c
index 4c64856abb..755e47fc91 100644
--- a/drivers/bus/vmbus/vmbus_common.c
+++ b/drivers/bus/vmbus/vmbus_common.c
@@ -104,7 +104,7 @@ vmbus_probe_device(struct rte_driver *drv, struct rte_device *dev)
 	if (ret != 0)
 		goto free_intr;
 
-	if (vmbus_dev->device.numa_node < 0 && rte_socket_count() > 1)
+	if (vmbus_dev->device.numa_node < 0 && rte_numa_count() > 1)
 		VMBUS_LOG(INFO, "Device %s is not NUMA-aware", guid);
 
 	/* call the driver probe() function */
-- 
2.55.0

