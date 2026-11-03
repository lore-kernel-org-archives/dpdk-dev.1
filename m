Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB98606FCC0
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Y8r0jxXt
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0CB35427B2;
	Tue,  3 Nov 2026 16:08:48 +0100 (CET)
Received: from mta0.migadu.com (out-142.mta0.migadu.com [91.218.175.142])
 by mails.dpdk.org (Postfix) with ESMTPS id 60557410FC
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:08:46 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=dlJepQyOZHVkwKFfSpPeZhlJWOeJpXJx/OsxA05/5H0=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718526; v=1; x=1794323326;
 b=Y8r0jxXtJVbHqDg0KTPxxuY1/c8cK2VHUr8Wc7AjtRstYziexny/ie7EBPcw7Hi2aXRs6PGl
 zHkrBD1VucwR8W5E4cnB/CmSmaZgwDV8hIYF4MgT3WOkVljuY876nQUYiZTqaQU3p8BR+0ftbIl
 zIU6mf9vxz0cbFbBjRL6V7KY=
X-Envelope-To: dev@dpdk.org
Received: by mta12.migadu.com with ESMTPS id 5052af2fd5f22e6d;
 Tue, 03 Nov 2026 15:08:46 +0000
X-Mizu-Trace-ID: 5052af2fd5f22e6d
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 097/227] event/skeleton: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:50:55 +0800
Message-ID: <20261103145306.487255-98-chengwen.feng@linux.dev>
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
 drivers/event/skeleton/skeleton_eventdev.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/event/skeleton/skeleton_eventdev.c b/drivers/event/skeleton/skeleton_eventdev.c
index 9eccf61cad..0893fac541 100644
--- a/drivers/event/skeleton/skeleton_eventdev.c
+++ b/drivers/event/skeleton/skeleton_eventdev.c
@@ -220,7 +220,7 @@ skeleton_eventdev_port_setup(struct rte_eventdev *dev, uint8_t port_id,
 	}
 
 	/* Allocate event port memory */
-	sp = rte_zmalloc_socket("eventdev port",
+	sp = rte_zmalloc_numa("eventdev port",
 			sizeof(struct skeleton_port), RTE_CACHE_LINE_SIZE,
 			dev->data->numa_id);
 	if (sp == NULL) {
@@ -351,7 +351,7 @@ skeleton_eventdev_init(struct rte_eventdev *eventdev)
 			pci_dev->addr.domain, pci_dev->addr.bus,
 			pci_dev->addr.devid, pci_dev->addr.function);
 
-	PMD_DRV_LOG(INFO, "dev_id=%d socket_id=%d (%x:%x)",
+	PMD_DRV_LOG(INFO, "dev_id=%d numa_id=%d (%x:%x)",
 		eventdev->data->dev_id, eventdev->data->numa_id,
 		skel->vendor_id, skel->device_id);
 
@@ -401,12 +401,12 @@ RTE_PMD_REGISTER_PCI_TABLE(event_skeleton_pci, pci_id_skeleton_map);
 /* VDEV based event device */
 
 static int
-skeleton_eventdev_create(const char *name, int socket_id, struct rte_vdev_device *vdev)
+skeleton_eventdev_create(const char *name, int numa_id, struct rte_vdev_device *vdev)
 {
 	struct rte_eventdev *eventdev;
 
 	eventdev = rte_event_pmd_vdev_init(name,
-			sizeof(struct skeleton_eventdev), socket_id, vdev);
+			sizeof(struct skeleton_eventdev), numa_id, vdev);
 	if (eventdev == NULL) {
 		PMD_DRV_ERR("Failed to create eventdev vdev %s", name);
 		goto fail;
@@ -428,8 +428,8 @@ skeleton_eventdev_probe(struct rte_vdev_device *vdev)
 	const char *name;
 
 	name = rte_vdev_device_name(vdev);
-	PMD_DRV_LOG(INFO, "Initializing %s on NUMA node %d", name, rte_socket_id());
-	return skeleton_eventdev_create(name, rte_socket_id(), vdev);
+	PMD_DRV_LOG(INFO, "Initializing %s on NUMA node %d", name, rte_numa_id());
+	return skeleton_eventdev_create(name, rte_numa_id(), vdev);
 }
 
 static int
@@ -438,7 +438,7 @@ skeleton_eventdev_remove(struct rte_vdev_device *vdev)
 	const char *name;
 
 	name = rte_vdev_device_name(vdev);
-	PMD_DRV_LOG(INFO, "Closing %s on NUMA node %d", name, rte_socket_id());
+	PMD_DRV_LOG(INFO, "Closing %s on NUMA node %d", name, rte_numa_id());
 
 	return rte_event_pmd_vdev_uninit(name);
 }
-- 
2.55.0

