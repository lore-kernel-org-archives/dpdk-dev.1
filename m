Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE641CD5BD5
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 May 2026 23:28:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4C7DA40E09;
	Wed, 27 May 2026 01:26:23 +0200 (CEST)
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
 by mails.dpdk.org (Postfix) with ESMTP id 4381340B91
 for <dev@dpdk.org>; Wed, 27 May 2026 01:26:13 +0200 (CEST)
Received: by mail-dl1-f51.google.com with SMTP id
 a92af1059eb24-12ddbe104ccso8332821c88.0
 for <dev@dpdk.org>; Tue, 26 May 2026 16:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779837972;
 x=1780442772; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+0lNVThOYvKlOHLKbzaPubzFPKBCgRP7BQ7sQsrvDw4=;
 b=lvLHjIXm9jBRx8neKOTmoY3YCdfmRSvOkgfzx8APsC4NjHpDFB1qSjfhsoaBC4w0KH
 8ixt42LQisCAI1OOIVMuXoSxSM/o9lRV1ViYFEOjAcyTlH//4FNwxcfiYEk94/yzQ0CI
 15kDG1YlXOBBj+AsugwUI2z6GpNvZjbB33skvuwZcMTa+pWS1tWelUwHw2t0e3cC0Lf4
 gqxIviE5XZ3IyfmU36D2FNWZMOHMuGA33D87nYmJ3UjoCj3eU+TLB4RzYagaLkflvcq7
 xXvaDT58xsH4+mOfRXEPv7AG18swkqh0dKzosiqubhDrCfACbHAvt6yt2xHXsiHCYuQX
 HVmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779837972; x=1780442772;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+0lNVThOYvKlOHLKbzaPubzFPKBCgRP7BQ7sQsrvDw4=;
 b=cFlOW/jQAlKJexdqS+ZVcwt1RYMUsKf1yo+XWvZUOUFFFfCwCV+aUtp/ZPgRl/6Qcq
 YNjIz52z8SziOut67k3Dh8iOWxVbfrSKIjyPqq2YppvbFKa/qiww16En94MkCbEGfjzz
 BNToR6vkzHzV5DhB/3+iqrdOR9agBmxTjJ8AQujjpQqfuRDKoYtxBICRYOdpWIWABi8M
 9iVBc8ryHedk8hasdh8uCOUF2BGg0jFSyT9BiqPJwKuK2xJ61cn8Q704ZS+Mv6hFWAIp
 BPkQu/EWmfgySKWiEiiWeMz2PM5XKB7tZuyIkSmXoVRzJbcy04/tXAxjmCIRymV23t7W
 xfag==
X-Gm-Message-State: AOJu0YyT9W36ELw27rCoM3MIdF8ciYRWGii/HB5qzn0Q2yIoTOCwXxpv
 nK/kalvxV7g+zBNoZ6KGub0Vwd+kiPBYcJ83Rjbyg2sr1MIu4YAMeFCWywPZX2BEoJkqw0HhcXO
 xpjfp
X-Gm-Gg: Acq92OG4yb+EEsdhKtdfqzcDvPeUDMa9YQRpNbDx2w0DDZ8RvDlESQ5D9N2XPHb5w42
 KmHBkDaqNRd+U2JoL7HN13Ztixyvwgxs3tC2dZv4keHMtgTUQyQvztbJOELlypqTxxmV32pdoZn
 Ck+bjr3zZS0NZK8Ry0XZR0iKYwosUo4xgXu9Fc3ge26mfDNMitnnjmhcZUE31WAd4GsDJZaVsiK
 UH9EdhB73+4p0NGRqIGk+/aD0UgvtSp+jynygNhuTHOBa/SaRXOacWqOvU9G+jZ7cRjZMtjfDgn
 ST1u+qUsSwcH/Wwe2X/K03t5FOfEM8Y+THkHd9Gb/Wmoi4JF1uFe+6gC59Zo9fMB7kCaDgRuYgn
 heR7ha0wzttUpQGBb4o1iNayCFav5XCZ+MYV8kp+1HQp9JjQqJ81ZDUYj9RKHUFh+hFH77lxk0b
 0beoUrTxw8OIGnwAU9yQbRtaEHQt/Gm02zS1Pwhd6sYisrJBtcsXl70dbnTmvE68/vTBO+EVPtI
 3J/sR/qIUg=
X-Received: by 2002:a05:7301:100e:b0:304:b883:3d3d with SMTP id
 5a478bee46e88-304b88343ecmr380125eec.1.1779837972324; 
 Tue, 26 May 2026 16:26:12 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30452230f1bsm11296132eec.14.2026.05.26.16.26.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 16:26:11 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v4 25/27] vdpa/ifc: replace rte_atomic32 with stdatomic
Date: Tue, 26 May 2026 16:24:15 -0700
Message-ID: <20260526232542.620966-26-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260526232542.620966-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260526232542.620966-1-stephen@networkplumber.org>
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

