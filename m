Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08771EC01C4
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Mar 2026 10:54:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 438AE4067E;
	Mon, 23 Mar 2026 11:54:00 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 6FC4D402D6
 for <dev@dpdk.org>; Mon, 23 Mar 2026 11:53:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774263238;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LxEHt933ZHaQfp+j3f2a7/1KB0Rywhsh1gWgK8VXnxI=;
 b=XftGmJR2r+u5eviPxhJi91wjX/76wsKHfbxePnWUsyv99FWQmrtzeGHHpuw1RI0FRe5lKW
 qpwuPZheH2S7JaNbNwaRtUFAdF+wGZtJoid/17hver3Ay6foOzsyk/dUHmiv8OOCZdQvgo
 OYkysEMIOc7atoWYzy/kdqjIgyHQBpc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-DlXzbwcCMjS6yzGpKFnQQA-1; Mon,
 23 Mar 2026 06:53:56 -0400
X-MC-Unique: DlXzbwcCMjS6yzGpKFnQQA-1
X-Mimecast-MFC-AGG-ID: DlXzbwcCMjS6yzGpKFnQQA_1774263236
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EFF9B1800365
 for <dev@dpdk.org>; Mon, 23 Mar 2026 10:53:55 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.173])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3924A1800107
 for <dev@dpdk.org>; Mon, 23 Mar 2026 10:53:54 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Subject: [PATCH 7/8] bus: remove per bus scan mode
Date: Mon, 23 Mar 2026 11:53:01 +0100
Message-ID: <20260323105306.1531689-8-david.marchand@redhat.com>
In-Reply-To: <20260323105306.1531689-1-david.marchand@redhat.com>
References: <20260323105306.1531689-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Fs9ToOW0uyTq8XCygZYPQs3iymjd_VfqDHgTnz9Z6ms_1774263236
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

Following the refactoring of device selection, it becomes more apparent
that there is no need for a per bus scan mode.
-a / -b options are mutually exclusive.
--vdev option works in parallel of allow/block list scan mode.

Remove this (internal) notion.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 lib/eal/common/eal_common_bus.c     | 20 ++++++++++++++++++-
 lib/eal/common/eal_common_devargs.c |  8 +++-----
 lib/eal/common/eal_private.h        | 31 +++++++++++++++++++++++++++++
 lib/eal/include/bus_driver.h        | 18 -----------------
 4 files changed, 53 insertions(+), 24 deletions(-)

diff --git a/lib/eal/common/eal_common_bus.c b/lib/eal/common/eal_common_bus.c
index 2ca0af7914..27a31bbefa 100644
--- a/lib/eal/common/eal_common_bus.c
+++ b/lib/eal/common/eal_common_bus.c
@@ -18,6 +18,8 @@
 static struct rte_bus_list rte_bus_list =
 	TAILQ_HEAD_INITIALIZER(rte_bus_list);
 
+static enum rte_bus_scan_mode bus_scan_mode;
+
 RTE_EXPORT_SYMBOL(rte_bus_name)
 const char *
 rte_bus_name(const struct rte_bus *bus)
@@ -252,7 +254,7 @@ rte_bus_is_ignored_device(const struct rte_bus *bus, const char *dev_name)
 {
 	struct rte_devargs *devargs = rte_bus_find_devargs(bus, dev_name);
 
-	switch (bus->conf.scan_mode) {
+	switch (rte_bus_scan_mode_get()) {
 	case RTE_BUS_SCAN_ALLOWLIST:
 		if (devargs && devargs->policy == RTE_DEV_ALLOWED)
 			return false;
@@ -266,6 +268,22 @@ rte_bus_is_ignored_device(const struct rte_bus *bus, const char *dev_name)
 	return true;
 }
 
+enum rte_bus_scan_mode
+rte_bus_scan_mode_get(void)
+{
+	return bus_scan_mode;
+}
+
+int
+rte_bus_scan_mode_set(enum rte_bus_scan_mode scan_mode)
+{
+	if (bus_scan_mode != RTE_BUS_SCAN_UNDEFINED)
+		return -EINVAL;
+
+	bus_scan_mode = scan_mode;
+	return 0;
+}
+
 /*
  * Get iommu class of devices on the bus.
  */
diff --git a/lib/eal/common/eal_common_devargs.c b/lib/eal/common/eal_common_devargs.c
index c523429d67..8083bdebc2 100644
--- a/lib/eal/common/eal_common_devargs.c
+++ b/lib/eal/common/eal_common_devargs.c
@@ -330,7 +330,6 @@ int
 rte_devargs_add(enum rte_devtype devtype, const char *devargs_str)
 {
 	struct rte_devargs *devargs = NULL;
-	struct rte_bus *bus = NULL;
 	const char *dev = devargs_str;
 
 	/* use calloc instead of rte_zmalloc as it's called early at init */
@@ -341,14 +340,13 @@ rte_devargs_add(enum rte_devtype devtype, const char *devargs_str)
 	if (rte_devargs_parse(devargs, dev))
 		goto fail;
 	devargs->type = devtype;
-	bus = devargs->bus;
 	if (devargs->type == RTE_DEVTYPE_BLOCKED)
 		devargs->policy = RTE_DEV_BLOCKED;
-	if (bus->conf.scan_mode == RTE_BUS_SCAN_UNDEFINED) {
+	if (rte_bus_scan_mode_get() == RTE_BUS_SCAN_UNDEFINED) {
 		if (devargs->policy == RTE_DEV_ALLOWED)
-			bus->conf.scan_mode = RTE_BUS_SCAN_ALLOWLIST;
+			rte_bus_scan_mode_set(RTE_BUS_SCAN_ALLOWLIST);
 		else if (devargs->policy == RTE_DEV_BLOCKED)
-			bus->conf.scan_mode = RTE_BUS_SCAN_BLOCKLIST;
+			rte_bus_scan_mode_set(RTE_BUS_SCAN_BLOCKLIST);
 	}
 	TAILQ_INSERT_TAIL(&devargs_list, devargs, next);
 	return 0;
diff --git a/lib/eal/common/eal_private.h b/lib/eal/common/eal_private.h
index e032dd10c9..12db04dce2 100644
--- a/lib/eal/common/eal_private.h
+++ b/lib/eal/common/eal_private.h
@@ -469,6 +469,37 @@ int rte_eal_memory_detach(void);
  */
 struct rte_bus *rte_bus_find_by_device_name(const char *str);
 
+/**
+ * Bus scan policies
+ */
+enum rte_bus_scan_mode {
+	RTE_BUS_SCAN_UNDEFINED,
+	RTE_BUS_SCAN_ALLOWLIST,
+	RTE_BUS_SCAN_BLOCKLIST,
+};
+
+/**
+ * Retrieve the current bus scanning mode.
+ *
+ * @return
+ *   The current bus scanning mode.
+ */
+enum rte_bus_scan_mode rte_bus_scan_mode_get(void);
+
+/**
+ * Change the bus scanning mode.
+ * Changing the mode can only be done once from undefined to allow list or to block list.
+ * No change from allow to block (or vice versa) is allowed.
+ *
+ * @param scan_mode
+ *   The scanning mode to apply.
+ *
+ * @return
+ *   0 on successful change.
+ *   < 0 on failure.
+ */
+int rte_bus_scan_mode_set(enum rte_bus_scan_mode scan_mode);
+
 /**
  * For each device on the buses, call the driver-specific function for
  * device cleanup.
diff --git a/lib/eal/include/bus_driver.h b/lib/eal/include/bus_driver.h
index e67e052404..9045d64816 100644
--- a/lib/eal/include/bus_driver.h
+++ b/lib/eal/include/bus_driver.h
@@ -232,23 +232,6 @@ typedef int (*rte_bus_sigbus_handler_t)(const void *failure_addr);
  */
 typedef int (*rte_bus_cleanup_t)(void);
 
-/**
- * Bus scan policies
- */
-enum rte_bus_scan_mode {
-	RTE_BUS_SCAN_UNDEFINED,
-	RTE_BUS_SCAN_ALLOWLIST,
-	RTE_BUS_SCAN_BLOCKLIST,
-};
-
-/**
- * A structure used to configure bus operations.
- */
-struct rte_bus_conf {
-	enum rte_bus_scan_mode scan_mode; /**< Scan policy. */
-};
-
-
 /**
  * Get common iommu class of the all the devices on the bus. The bus may
  * check that those devices are attached to iommu driver.
@@ -277,7 +260,6 @@ struct rte_bus {
 	rte_bus_devargs_parse_t devargs_parse; /**< Parse bus devargs */
 	rte_dev_dma_map_t dma_map;   /**< DMA map for device in the bus */
 	rte_dev_dma_unmap_t dma_unmap; /**< DMA unmap for device in the bus */
-	struct rte_bus_conf conf;    /**< Bus configuration */
 	rte_bus_get_iommu_class_t get_iommu_class; /**< Get iommu class */
 	rte_dev_iterate_t dev_iterate; /**< Device iterator. */
 	rte_bus_hot_unplug_handler_t hot_unplug_handler;
-- 
2.53.0

