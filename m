Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10D7606F62B
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=XAV146Y0
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3CCDB427D7;
	Tue,  3 Nov 2026 16:01:06 +0100 (CET)
Received: from mta0.migadu.com (out-130.mta0.migadu.com [91.218.175.130])
 by mails.dpdk.org (Postfix) with ESMTPS id 7FC20427D8
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:01:04 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=Tf9CpzBz+UFHZc15RBm5GMB2+Utpfi5OMUKMryOsxN4=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718064; v=1; x=1794322864;
 b=XAV146Y0Yd3EW9gdgaigozbjvFom1WmGPDyI45pE5vp0AKychH4iG8LsK9jEW5PvawufH9th
 svcPvJqTYIKBv+Jb1YVyrT1krPUDq8h8MJJA/JmGXaco48WE2kfQCKq1D2PEV5WQtbm0/sqLkdd
 XGYR+bku3MO8KuMbkc0aFKgg=
X-Envelope-To: dev@dpdk.org
Received: by mta12.migadu.com with ESMTPS id ce761ad2841ca998;
 Tue, 03 Nov 2026 15:01:03 +0000
X-Mizu-Trace-ID: ce761ad2841ca998
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 048/227] bus/pci: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:50:06 +0800
Message-ID: <20261103145306.487255-49-chengwen.feng@linux.dev>
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
 drivers/bus/pci/bsd/pci.c     | 2 +-
 drivers/bus/pci/linux/pci.c   | 2 +-
 drivers/bus/pci/pci_common.c  | 2 +-
 drivers/bus/pci/windows/pci.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/pci/bsd/pci.c b/drivers/bus/pci/bsd/pci.c
index 2d29f8d2e2..57cc01cb70 100644
--- a/drivers/bus/pci/bsd/pci.c
+++ b/drivers/bus/pci/bsd/pci.c
@@ -257,7 +257,7 @@ pci_scan_one(int dev_pci_fd, struct pci_conf *conf)
 	dev->max_vfs = 0;
 
 	/* FreeBSD has no NUMA support (yet) */
-	dev->device.numa_node = SOCKET_ID_ANY;
+	dev->device.numa_node = RTE_NUMA_ID_ANY;
 
 	pci_common_set(dev);
 
diff --git a/drivers/bus/pci/linux/pci.c b/drivers/bus/pci/linux/pci.c
index 28949e3720..063fbbce0a 100644
--- a/drivers/bus/pci/linux/pci.c
+++ b/drivers/bus/pci/linux/pci.c
@@ -291,7 +291,7 @@ pci_scan_one(const char *dirname, const struct rte_pci_addr *addr)
 	    eal_parse_sysfs_value(filename, &tmp) == 0)
 		dev->device.numa_node = tmp;
 	else
-		dev->device.numa_node = SOCKET_ID_ANY;
+		dev->device.numa_node = RTE_NUMA_ID_ANY;
 
 	pci_common_set(dev);
 
diff --git a/drivers/bus/pci/pci_common.c b/drivers/bus/pci/pci_common.c
index 3770b4ad75..02edeb7e40 100644
--- a/drivers/bus/pci/pci_common.c
+++ b/drivers/bus/pci/pci_common.c
@@ -192,7 +192,7 @@ pci_probe_device(struct rte_driver *drv, struct rte_device *dev)
 		loc->domain, loc->bus, loc->devid, loc->function,
 		pci_dev->device.numa_node);
 
-	if (pci_dev->device.numa_node < 0 && rte_socket_count() > 1)
+	if (pci_dev->device.numa_node < 0 && rte_numa_count() > 1)
 		PCI_LOG(INFO, "Device %s is not NUMA-aware", pci_dev->name);
 
 	already_probed = (pci_dev->intr_handle != NULL);
diff --git a/drivers/bus/pci/windows/pci.c b/drivers/bus/pci/windows/pci.c
index 383c6bdc2f..aa328eb75f 100644
--- a/drivers/bus/pci/windows/pci.c
+++ b/drivers/bus/pci/windows/pci.c
@@ -286,7 +286,7 @@ get_device_resource_info(HDEVINFO dev_info,
 	}
 
 	/* Get NUMA node using DEVPKEY_Device_Numa_Node */
-	dev->device.numa_node = SOCKET_ID_ANY;
+	dev->device.numa_node = RTE_NUMA_ID_ANY;
 	res = SetupDiGetDevicePropertyW(dev_info, dev_info_data,
 		&DEVPKEY_Device_Numa_Node, &property_type,
 		(BYTE *)&numa_node, sizeof(numa_node), NULL, 0);
-- 
2.55.0

