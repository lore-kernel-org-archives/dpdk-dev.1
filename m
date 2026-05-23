Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84839CD5BB1
	for <dpdk-dev@archiver.kernel.org>; Sat, 23 May 2026 20:00:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4AEB0406B7;
	Sat, 23 May 2026 21:59:11 +0200 (CEST)
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172]) by mails.dpdk.org (Postfix) with ESMTP id 8186940E0A
 for <dev@dpdk.org>; Sat, 23 May 2026 21:59:08 +0200 (CEST)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-304545e6c7fso1893558eec.0
 for <dev@dpdk.org>; Sat, 23 May 2026 12:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779566348;
 x=1780171148; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+0lNVThOYvKlOHLKbzaPubzFPKBCgRP7BQ7sQsrvDw4=;
 b=uUaUzyx9aUQC2N3wTaGTW9EB/iu/8sxb55YQz1/JqWuDITwXGBkN7oQrBv8iheQBzx
 lQdZCpZrriXZA2F2TK6DrBCCJOtDnyKj9KGN4FwE7sJ700piyxl5GXhraK1h5asaxggG
 UT1CmQesbr1l19zeMiKcoyQJ6if6O0VkHUkWNBq/yrFjpIchTXqeIjvGpmmL1vIkJG5o
 AqPpvO8X9uNfDZ52dRDwdrKbfqUvlVLDF94XXkX1KR2nL3IWidDE7Xyt99NfMsFDumIT
 cdWw48JjJpQDKk7atwPqzEkh8XsQQgdNnK+RfzyxtNsv9+pGiK+nxpWdZZhvMfvue0MV
 o6/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779566348; x=1780171148;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+0lNVThOYvKlOHLKbzaPubzFPKBCgRP7BQ7sQsrvDw4=;
 b=bQhM5GKr+O6bVxjwZ8e68xQBMFt8LG8TZyHRYZpymU+1qw2uKjcHUVNn6ybupO4GP1
 fOkDuddEH4XAFtQRRUfwZ/HtQkDxgCBiG9fJd3+SOWXML4PSF7+tpq86OsJevytSai3U
 NAF+dshw+dbv+ga8+knKrt/rWRagcq+o3U+viIj3ZymWGmkkwZhpBjBm6bAMg2+i/u7x
 UeAGUP+zhP2Em12wyzjAL9imTCHJKR6MvfwIrjX26RFMK+9irLAuztm4JyRLPBremniJ
 7+t/Lyn9ZEdoH7hLgw1FMrdFlfujtoM33Dbzr3ZRjKJ4QhG/L1vn0updJWPKYiJi8CNg
 RQig==
X-Gm-Message-State: AOJu0YzeoaG1IQevl9I6v2o+GVzZv9TF3swupsbH7OSUaQ1MBxlMB12H
 EE33CDelMak288kdj9aaBeegjyhKcOOS7B5gOVRVB7s7DiYhQ4nlUcerWb8vO37XoI52A+vJZYm
 RPe8b
X-Gm-Gg: Acq92OFhcX6EtsXZiKhNMJxr11gIJh1/YX0jj81Qc9bBu9zV9doh3U+SL7tJpw6Bigc
 SjAhTt9v/heZPeJAdS2Eq67qjwhnx4DG6gbIjY9hWiK9zJNfaqb9SNv0QrRgurbY9qyJGQiBrr4
 qu1V9y6U0EHnG9XrqBbMA2at3O4csyofHagPYYzlQ2h2aH268bSHaoeYbnKznFqPeShCbZ010dh
 uu74/lH9hnyp+ZGvFZOMfc/jhIfiT8ni4KvilSaX6kyOMQCkbClyIqYfe/CbbZwqjJn5KrfJ0/K
 beubPLhf2gsrjylYTg9V61OveeqcHkky3eJh+LA/As3oZFQf8iqpN5E2GZsg+HVOq2p/r/hU4rT
 MpVyVZmLZ++WUa2+xEQlNJRA63tF1OgX1fucnZUELLw13/UcEBRUGqz+ds3iN0RoaXCEV7NIlRD
 l1cpmR+XdillRgN5b0Fz4qKsyiXf1Xck+1woF4rHmluB51AQSsln/RoHf9u0EDPmwjGuRGBCoJe
 mIf5C0E73w=
X-Received: by 2002:a05:7301:6446:b0:2f8:42b0:e63d with SMTP id
 5a478bee46e88-30448f363demr4135822eec.2.1779566347620; 
 Sat, 23 May 2026 12:59:07 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30452255234sm4838428eec.20.2026.05.23.12.59.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2026 12:59:07 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 25/27] vdpa/ifc: replace rte_atomic32 with stdatomic
Date: Sat, 23 May 2026 12:56:39 -0700
Message-ID: <20260523195839.454952-26-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260523195839.454952-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260523195839.454952-1-stephen@networkplumber.org>
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

