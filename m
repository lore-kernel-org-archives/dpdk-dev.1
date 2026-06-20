Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F6FCD98F8
	for <dpdk-dev@archiver.kernel.org>; Sat, 20 Jun 2026 02:33:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E575F40E38;
	Sat, 20 Jun 2026 04:32:11 +0200 (CEST)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com
 [209.85.128.182])
 by mails.dpdk.org (Postfix) with ESMTP id 53CBF40E28
 for <dev@dpdk.org>; Sat, 20 Jun 2026 04:32:09 +0200 (CEST)
Received: by mail-yw1-f182.google.com with SMTP id
 00721157ae682-7fd6b4d5d49so23044487b3.0
 for <dev@dpdk.org>; Fri, 19 Jun 2026 19:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781922729;
 x=1782527529; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+0lNVThOYvKlOHLKbzaPubzFPKBCgRP7BQ7sQsrvDw4=;
 b=BxB9nTHlQ+hllJ4CJG5hSWSAajAEO53lniWfhLO4Nv+pICO77ljF3odK023HdKixWF
 tpP6aaIZ8VdCjMNM40bhyq1pgfFGQYLVzypp0xsVX3/TSGmJClOsqywACxCTSqlAOID+
 9pd0l+mnfvpbdEuvl8b0B5P2ZxPALrG+k6p0Q79+6BhcnCFjW74Gj+tQwtk75+Zm1gj/
 kQlsO1aNov+CZAmaKU+DgKFElisZQI0YldLbgL/qFhWu2kYzmQHdz/xq0r2k5THWpj+N
 IY3SqedxXqr/tyrr8MLnjtwNt9kd6lejPUC5IM6v6pfM+csvNimEXqytQdZqsg0wMFtT
 urlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781922729; x=1782527529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+0lNVThOYvKlOHLKbzaPubzFPKBCgRP7BQ7sQsrvDw4=;
 b=Z2bUt5b6xUztYWCm9XLALkKMpypPBS/OIX8EdFFZg2lqle76gdDdW6mmhbwZh8f0Fu
 PxrAmwea3GLYcN182bkmdGlsQ3EGX6sHsBWQ15KxsIllAdQhUwPw9GAMzoTiXn1Ee4E5
 9QO/FDATa9H2gjyzy0y8qjXTELaCD+Q2bCFM7VepRXybOyuGjYE4urtDuKJwWb1MapJW
 JuUklV7maC7Ji0gPCsqTnzQIjfgB8plYk153el2y77Z5ySPplycznDzWQoJiPgaTGokx
 Cn+XiiRefqwq5jKiLK+T6OuIi0s2KF9pvo3EPzW04M2zAVQI/g4YheGfKl4h0JQCgFSh
 idEA==
X-Gm-Message-State: AOJu0Yyuley9DT3ohrgbndJ8sKfzUTM3knFEpFrLsb1HlyhOdjMdD0QJ
 lD4THBgQxrTqXxBuyEtu1edaPdIxVC9qikZ3BwDFofMzM0J9yFGOyn6tLLExVe/kRV5nHsw16Of
 PvQy3
X-Gm-Gg: AfdE7cl2CDpypfg3ZCdTtOWas/Xca/nvtXDL14/L1xF6lsvcWvWQzqfSS3b02vMJE0k
 TCvqlZXEVe+KmKCUTkQ5iolcrP3Zwt2WuldPASl/weZcqVBTyUBEGQ+PmI+5H/lSRw5+YHhzsIk
 q8kxYKySRiH2Senj5J5hjpq/CViNxicRRofXaGopNIFPZYEba1gKW7teoPVpEJBehvwe1mWskeQ
 15pFB/tSXZh5ajqSe1jSeuQG385A5WTx5uCDkjTKuceF6srTBkvKOfkZqqOswUiQmHMqAVKUoRX
 sNJ4GlzmRbu3v/AagFLRlsZ0Dtg2C/hUQrx1fzjjwyr0qBZjnramErDtqw9jkp41aQ0g1RaLJbT
 pcsolMjFLc5tyRLDOYMAAhZsWmJfh07VDxKe5kVPV99D4CVzWZrCZ966o/3NL5C7mPGnjfJJLAI
 4gCsQ+j9pczsDKcv6En3D5bCeu5bsdjOF7BV7t33LdzXq2vjL+fTE=
X-Received: by 2002:a05:690c:6b12:b0:7f0:16e3:42c3 with SMTP id
 00721157ae682-80123a8ba1dmr51352247b3.29.1781922728527; 
 Fri, 19 Jun 2026 19:32:08 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8025c96ffd5sm6045897b3.9.2026.06.19.19.32.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 19:32:08 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 22/24] vdpa/ifc: replace rte_atomic32 with stdatomic
Date: Fri, 19 Jun 2026 19:28:47 -0700
Message-ID: <20260620023134.42877-23-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260620023134.42877-1-stephen@networkplumber.org>
References: <https://inbox.dpdk.org/dev/20260521042043.1590536-1-stephen@networkplumber.org>
 <20260620023134.42877-1-stephen@networkplumber.org>
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

