Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE8FAC982D0
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 20:13:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5853643260;
	Thu, 17 Sep 2026 22:11:50 +0200 (CEST)
Received: from mail-pj2-f33.google.com (mail-pj2-f33.google.com
 [74.125.227.161])
 by mails.dpdk.org (Postfix) with ESMTP id 82ADC4327E
 for <dev@dpdk.org>; Thu, 17 Sep 2026 22:11:43 +0200 (CEST)
Received: by mail-pj2-f33.google.com with SMTP id
 d9443c01a7336-2d747ed1368so425095ad.1
 for <dev@dpdk.org>; Thu, 17 Sep 2026 13:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789675903;
 x=1790280703; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+0lNVThOYvKlOHLKbzaPubzFPKBCgRP7BQ7sQsrvDw4=;
 b=YPtACfriEVLbLfiY2OAl/2BbjPnyK0RKixP6NRGU5DOMV7mdLBUZFEFq64Fi2DYIH0
 8UUJStHxJAUtYOzkUdGtMA+4hKuYiqLwry8xOpFztgwiVCRU99y+mZsbXu/jQTWgCfYD
 tTWGPj1KVH6A3V4jEkwmnx6uF9SlXpbUuaTSmTkQFZEl6d4a7TF0pFE5M/nWM2STGCYU
 CzqtCi2Zt6oCnaZ8X0bNYj0LgEFGzCNZ+ZJr979IC3OB+2ddrKZtiiF8YzjSaOWD+Tuq
 Lkl7g0vRBW4WzWvC6KSrt+q+i0wD7XN2XaDYexScVh5N9RQ1Ikvq0Hdw2EzSOHPp8XQX
 PgpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789675903; x=1790280703;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+0lNVThOYvKlOHLKbzaPubzFPKBCgRP7BQ7sQsrvDw4=;
 b=w7umPOBxWJT3gYvvjxp7pVcNKB8BW303aTLViFDKr/sGioRU7gwvKIb8WJkMYKl6Ge
 M/ocH+g1/DQpbynH5n4b0pcNMn7sPhS672rU6FUA9rWtT9nqX8LN6waOnJbDpi4CoDGj
 xelGxyYOaGYuqXpYW3LEZQvDNcgj3fxDKGydbDyEjGFIyvWyzJf2Cx1QnB8Mvc0p6Jsz
 aAVZkd/r8aFz4WRw+0TUdJ8dzeh7ZT8gZycZx0Iv8jWvh+59jrMWcRYHKkmfic1oyJRn
 hgcPDotKrq2+tzgMqJXz03/VAORDXPuAGqeN1lUc8nNc46jS23emubFKb414KofrIlXW
 lkJw==
X-Gm-Message-State: AFuF++nkrYb8QAmkaDNAdCAQKVeUPMk9GAyWUf++BMh0S4MDVREZ2sKx
 Pt2I9cVEpESbNLcgXacocArAHhirsF+6CO22Tj5hiBL+8gqgYufT2gTr+9FcZjOLwSmdV9VE/L9
 x20fN
X-Gm-Gg: AYBFou3h4d6lcy75GBUXYlwRwWtoJoVlKx1TgwCFdL3WlHq9yJ98mPnHdvitRW2lBEa
 HcEO7ebdq8EFqjUPFjd6qdnzn+sHKzDNxKyvsHtai/3ww17HJmH4xznA/Vi1g+nmKih3q8oO95H
 LUru5QzwriRyALld/78bKxGm0wup8AwHSmgfZBbONQ/F2ZZupEZdvZ08MBgLojrV9ux7pwyMPWc
 7D5PagOFOAyJQ1Jxsx2vt86D1hHLlq03Xii1YMZ2tfO4BKJe5tkGZLsxCTY0kIANbhgox4LbPPJ
 XXtpCCp4Q9LgeNTdZAdxkJ/FWH94Hxf0OYb3bkQv7MqXcKzt8x4XyU8Zy07UONqoMZ63jk8QT4G
 CM8aTGc+QKoH9ElwSQG6bO698r7CQNME6461V0DxiLBMkz5zIn/+B449pYHqBRzrTw4spJpYOAp
 NaYKTLoGc51xOSwNHrwVnWKsOnKkf8XE9WqfIDkG3vitF6DdKl6m+ZkYnd4Dq/8nPP0f8OvAAXN
 IcVA88cLUdWG5h4GKi98vzoyji720Er93TmKw==
X-Received: by 2002:a17:903:f87:b0:2d8:d4d0:792e with SMTP id
 d9443c01a7336-2ddb1b82c11mr5816445ad.18.1789675902606; 
 Thu, 17 Sep 2026 13:11:42 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2dd89f0870bsm31368345ad.63.2026.09.17.13.11.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 13:11:42 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v8 23/25] vdpa/ifc: replace rte_atomic32 with stdatomic
Date: Thu, 17 Sep 2026 13:10:27 -0700
Message-ID: <20260917201119.2168234-24-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917201119.2168234-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260917201119.2168234-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Last in-tree caller of rte_atomic32_*(), blocking deprecation of the
rte_atomicNN_*() family.

Replace rte_atomic32_read/set() with rte_atomic_load_explicit() and
rte_atomic_store_explicit() on the started, dev_attached, and running
flags. Narrow them to bool (only ever hold 0/1) and group with the
existing bools to reduce padding in struct ifcvf_internal.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/vdpa/ifc/ifcvf_vdpa.c | 37 ++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/vdpa/ifc/ifcvf_vdpa.c b/drivers/vdpa/ifc/ifcvf_vdpa.c
index f319d455ba..e5da11a2ba 100644
--- a/drivers/vdpa/ifc/ifcvf_vdpa.c
+++ b/drivers/vdpa/ifc/ifcvf_vdpa.c
@@ -25,6 +25,7 @@
 #include <rte_log.h>
 #include <rte_kvargs.h>
 #include <rte_devargs.h>
+#include <rte_stdatomic.h>
 
 #include "base/ifcvf.h"
 
@@ -68,10 +69,10 @@ struct ifcvf_internal {
 	struct rte_vdpa_device *vdev;
 	uint16_t max_queues;
 	uint64_t features;
-	rte_atomic32_t started;
-	rte_atomic32_t dev_attached;
-	rte_atomic32_t running;
 	rte_spinlock_t lock;
+	RTE_ATOMIC(bool) started;
+	RTE_ATOMIC(bool) dev_attached;
+	RTE_ATOMIC(bool) running;
 	bool sw_lm;
 	bool sw_fallback_running;
 	/* mediated vring for sw fallback */
@@ -712,9 +713,9 @@ update_datapath(struct ifcvf_internal *internal)
 
 	rte_spinlock_lock(&internal->lock);
 
-	if (!rte_atomic32_read(&internal->running) &&
-	    (rte_atomic32_read(&internal->started) &&
-	     rte_atomic32_read(&internal->dev_attached))) {
+	if (!rte_atomic_load_explicit(&internal->running, rte_memory_order_seq_cst) &&
+	    (rte_atomic_load_explicit(&internal->started, rte_memory_order_seq_cst) &&
+	     rte_atomic_load_explicit(&internal->dev_attached, rte_memory_order_seq_cst))) {
 		ret = ifcvf_dma_map(internal, true);
 		if (ret)
 			goto err;
@@ -735,10 +736,10 @@ update_datapath(struct ifcvf_internal *internal)
 		if (ret)
 			goto err;
 
-		rte_atomic32_set(&internal->running, 1);
-	} else if (rte_atomic32_read(&internal->running) &&
-		   (!rte_atomic32_read(&internal->started) ||
-		    !rte_atomic32_read(&internal->dev_attached))) {
+		rte_atomic_store_explicit(&internal->running, true, rte_memory_order_seq_cst);
+	} else if (rte_atomic_load_explicit(&internal->running, rte_memory_order_seq_cst) &&
+		   (!rte_atomic_load_explicit(&internal->started, rte_memory_order_seq_cst) ||
+		    !rte_atomic_load_explicit(&internal->dev_attached, rte_memory_order_seq_cst))) {
 		unset_intr_relay(internal);
 
 		ret = unset_notify_relay(internal);
@@ -755,7 +756,7 @@ update_datapath(struct ifcvf_internal *internal)
 		if (ret)
 			goto err;
 
-		rte_atomic32_set(&internal->running, 0);
+		rte_atomic_store_explicit(&internal->running, false, rte_memory_order_seq_cst);
 	}
 
 	rte_spinlock_unlock(&internal->lock);
@@ -1058,7 +1059,7 @@ ifcvf_sw_fallback_switchover(struct ifcvf_internal *internal)
 
 	vdpa_disable_vfio_intr(internal);
 
-	rte_atomic32_set(&internal->running, 0);
+	rte_atomic_store_explicit(&internal->running, false, rte_memory_order_seq_cst);
 
 	ret = rte_vhost_host_notifier_ctrl(vid, RTE_VHOST_QUEUE_ALL, false);
 	if (ret && ret != -ENOTSUP)
@@ -1113,11 +1114,11 @@ ifcvf_dev_config(int vid)
 
 	internal = list->internal;
 	internal->vid = vid;
-	rte_atomic32_set(&internal->dev_attached, 1);
+	rte_atomic_store_explicit(&internal->dev_attached, true, rte_memory_order_seq_cst);
 	if (update_datapath(internal) < 0) {
 		DRV_LOG(ERR, "failed to update datapath for vDPA device %s",
 			vdev->device->name);
-		rte_atomic32_set(&internal->dev_attached, 0);
+		rte_atomic_store_explicit(&internal->dev_attached, false, rte_memory_order_seq_cst);
 		return -1;
 	}
 
@@ -1166,7 +1167,7 @@ ifcvf_dev_close(int vid)
 
 		internal->sw_fallback_running = false;
 	} else {
-		rte_atomic32_set(&internal->dev_attached, 0);
+		rte_atomic_store_explicit(&internal->dev_attached, false, rte_memory_order_seq_cst);
 		if (update_datapath(internal) < 0) {
 			DRV_LOG(ERR, "failed to update datapath for vDPA device %s",
 				vdev->device->name);
@@ -1782,10 +1783,10 @@ ifcvf_pci_probe(struct rte_pci_driver *pci_drv __rte_unused,
 		goto error;
 	}
 
-	rte_atomic32_set(&internal->started, 1);
+	rte_atomic_store_explicit(&internal->started, true, rte_memory_order_seq_cst);
 	if (update_datapath(internal) < 0) {
 		DRV_LOG(ERR, "failed to update datapath %s", pci_dev->name);
-		rte_atomic32_set(&internal->started, 0);
+		rte_atomic_store_explicit(&internal->started, false, rte_memory_order_seq_cst);
 		rte_vdpa_unregister_device(internal->vdev);
 		pthread_mutex_lock(&internal_list_lock);
 		TAILQ_REMOVE(&internal_list, list, next);
@@ -1819,7 +1820,7 @@ ifcvf_pci_remove(struct rte_pci_device *pci_dev)
 	}
 
 	internal = list->internal;
-	rte_atomic32_set(&internal->started, 0);
+	rte_atomic_store_explicit(&internal->started, false, rte_memory_order_seq_cst);
 	if (update_datapath(internal) < 0)
 		DRV_LOG(ERR, "failed to update datapath %s", pci_dev->name);
 
-- 
2.53.0

