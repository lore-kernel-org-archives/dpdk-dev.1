Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F9ECA5FA5
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 14:07:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E464542EA9;
	Tue, 29 Sep 2026 16:04:47 +0200 (CEST)
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12]) by mails.dpdk.org (Postfix) with ESMTP id 6D2BA42E63
 for <dev@dpdk.org>; Tue, 29 Sep 2026 16:04:37 +0200 (CEST)
Received: by mail-pz2-f12.google.com with SMTP id
 41be03b00d2f7-cc1cebcb8d7so1007380a12.0
 for <dev@dpdk.org>; Tue, 29 Sep 2026 07:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790690676;
 x=1791295476; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+0lNVThOYvKlOHLKbzaPubzFPKBCgRP7BQ7sQsrvDw4=;
 b=gYD4byrX00MA8stkDLya9U01cG5LlaTVa3iAwExXJa1roS6sBFrNS8W0WVt3MPrXfG
 TDyMZSi3D0Wio7hGwIjT2wg7FMEAmK453Scoz+UKyuOcc1uXNQH97bm6SUVr9mjP7RIx
 WXkUbL+xlsjM3/Pn+zj4fjsVdTcPYKZ/5V1SbDw29Bjkowppw2mYm1on1bBcHAN/w61o
 7UFLnW04pQV1/vRnSPh+zV3RANbcG649R4TAPUnHSTSXHPKMvtr1YyHB39l8RfqEwtAE
 pdeg7juvgt9XoVelurta4tUFiKbghkhxWISnaIIR2PSOHemIdIwKMAzfCfyg9nZCTJDI
 B11g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790690676; x=1791295476;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+0lNVThOYvKlOHLKbzaPubzFPKBCgRP7BQ7sQsrvDw4=;
 b=jNi51vEPTaKgU8eev6WWpRAcRtAFGtT14g5Jc8GBh43a124z/IBP63MjEhiOf8+IXr
 7e4iTgyWU6tu77nqclwltkFjj+gZ+MKMBoLTSXMebEdMKPpUnfaaPmLueR+a9hQGWIQ9
 +zfICelMWCwwl8dnrFcxmnS2DgU2pCORe2Dqa2+7+Fd9gVerkAUvXT1L1X+jsyeRS28S
 Txj+IFEr4b3ujOP3/K5nVQLm+IU8+lcLLj94q+7snybN5lZF0OcUeHZz6P1bmw//kJVG
 AvcRLWa+LzxnNagZjD2T/0gs2RygY2in6fa4JoDCnMImbHOcFbaat+FIWBZN1fH8MxOj
 SVug==
X-Gm-Message-State: AFuF++mXtvZhmNp2Em8UIn1ti4uAT4M8qXHFOReGyhmAZtaMQQ7jr7OM
 pZ3mhgUeoGwjwqjL2GrZ06iiBZy1qWcg3ZCFW24C1sYSsczxaFTrmSFWQNQxcjw1fDMtwIVj2F5
 dHAWTblA=
X-Gm-Gg: AYBFou2q2tnW0IE3x0kVrEmCCyFk0g3LfVG1HrpSnijlehTxtkxwMJCM61nnRuhpJpA
 8V0AyvAG0vBnwy1jacJ/zfly7rTrn3misuF5R97kxJk21cSE4MOE1WUXTaFWjOWU/0znOLuIWM1
 fDzthmL1gx5vEDNOhfl1QNEclCJjW/0rumCfxX9nwQ9WSc8RgfbibzQo0oUdnljLQiO95GmXqQz
 bnFaSf1kXPnjSmCFxMvHH453Yy8qANLOY5TCb6g2A7j4cds+ZgdK5yOLK8jbKNEqdrTgTRMgu1K
 LTtsNJksYn/kXLb9oDUugFo0FMzeXhLRmUasEenD31G9rJAOXHBIs8i6DEPUCX2CN7z129Ie4ra
 LxddA39+8jlJbq4AgwIQRcnQpnLHrhuCzi6G+NCzExCVyqDxRUHG2lf/17x41Z/hoHMRmnMmPTo
 QWM+jX2grcXHJIQcM2ZnbftQ8xRmPGBrTwieBrbYY2k6idPab8jkaTzQly2p7GuFDkh00JZKTn3
 WNk4vlTg//lFLZiFVxpAHVZDzLwohkjPqjMcQ==
X-Received: by 2002:a05:6300:8d:b0:3dd:85a8:4c4d with SMTP id
 adf61e73a8af0-3de7cb4e485mr1969417637.17.1790690676468; 
 Tue, 29 Sep 2026 07:04:36 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-885e1066470sm998330b3a.18.2026.09.29.07.04.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 07:04:35 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v9 23/25] vdpa/ifc: replace rte_atomic32 with stdatomic
Date: Tue, 29 Sep 2026 07:02:09 -0700
Message-ID: <20260929140409.234453-24-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929140409.234453-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260929140409.234453-1-stephen@networkplumber.org>
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

