Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 392F9CD342C
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 May 2026 15:55:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4A47640DC9;
	Wed,  6 May 2026 17:54:57 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 7B96040A75
 for <dev@dpdk.org>; Wed,  6 May 2026 17:54:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778082895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+6xFiROy13aqjA4GGReEAY7APBThSZLWvVO4jFTAq/U=;
 b=IYN9tsKosCtih3AszmiIkYUFwT5bTRfo1YJSua7J5gbpD6YZVvVEF+aQr/qtnHTlq9kG/X
 4Vl+7Q9vm2vLQvbQ8I3x74MNUEgBQzUd52GYez3bFmXN44M16NXN1eEyQUzfGIKmf2zQ/I
 +48uPfuK3ETh+nUtZqW8FPjos4NEQG8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-196-bHjul-FfOP6B9Ld2Z5opOg-1; Wed,
 06 May 2026 11:54:47 -0400
X-MC-Unique: bHjul-FfOP6B9Ld2Z5opOg-1
X-Mimecast-MFC-AGG-ID: bHjul-FfOP6B9Ld2Z5opOg_1778082885
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9131918002EE; Wed,  6 May 2026 15:54:45 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.32.242])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ED9CF1800347; Wed,  6 May 2026 15:54:42 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, stephen@networkplumber.org,
 bruce.richardson@intel.com, Pavan Nikhilesh <pbhagavatula@marvell.com>,
 Shijith Thotton <sthotton@marvell.com>,
 Tirthendu Sarkar <tirthendu.sarkar@intel.com>,
 Jerin Jacob <jerinj@marvell.com>
Subject: [PATCH v2 22/23] eventdev: rename dev field to device
Date: Wed,  6 May 2026 17:51:54 +0200
Message-ID: <20260506155201.2709810-23-david.marchand@redhat.com>
In-Reply-To: <20260506155201.2709810-1-david.marchand@redhat.com>
References: <20260429114503.932575-1-david.marchand@redhat.com>
 <20260506155201.2709810-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dDeqZFwcgmPTNnGTthIEz6esTk4JljHNEuVwLgpj3fo_1778082885
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

Rename the rte_eventdev structure field from 'dev' to 'device' to align
with the naming convention used by all other device classes in DPDK
(ethdev, cryptodev, bbdev, compressdev, rawdev, regexdev, dmadev, gpudev,
and mldev).

This change provides consistency across all device classes: each device
class structure now contains a 'struct rte_device *device' field
pointing to the backing device.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/event/cnxk/cn10k_eventdev.c        |  8 ++++----
 drivers/event/cnxk/cn20k_eventdev.c        |  8 ++++----
 drivers/event/cnxk/cn9k_eventdev.c         |  6 +++---
 drivers/event/cnxk/cnxk_eventdev.c         |  2 +-
 drivers/event/dlb2/pf/dlb2_pf.c            |  2 +-
 drivers/event/skeleton/skeleton_eventdev.c |  2 +-
 lib/eventdev/eventdev_pmd.h                |  2 +-
 lib/eventdev/eventdev_pmd_pci.h            |  4 ++--
 lib/eventdev/eventdev_pmd_vdev.h           |  2 +-
 lib/eventdev/rte_eventdev.c                | 14 +++++++-------
 10 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/event/cnxk/cn10k_eventdev.c b/drivers/event/cnxk/cn10k_eventdev.c
index 2e4b8aab92..8289fc44d6 100644
--- a/drivers/event/cnxk/cn10k_eventdev.c
+++ b/drivers/event/cnxk/cn10k_eventdev.c
@@ -921,7 +921,7 @@ static int
 cn10k_crypto_adapter_caps_get(const struct rte_eventdev *event_dev,
 			      const struct rte_cryptodev *cdev, uint32_t *caps)
 {
-	CNXK_VALID_DEV_OR_ERR_RET(event_dev->dev, "event_cn10k", ENOTSUP);
+	CNXK_VALID_DEV_OR_ERR_RET(event_dev->device, "event_cn10k", ENOTSUP);
 	CNXK_VALID_DEV_OR_ERR_RET(cdev->device, "crypto_cn10k", ENOTSUP);
 
 	*caps = RTE_EVENT_CRYPTO_ADAPTER_CAP_INTERNAL_PORT_OP_FWD |
@@ -939,7 +939,7 @@ cn10k_crypto_adapter_qp_add(const struct rte_eventdev *event_dev,
 {
 	int ret;
 
-	CNXK_VALID_DEV_OR_ERR_RET(event_dev->dev, "event_cn10k", EINVAL);
+	CNXK_VALID_DEV_OR_ERR_RET(event_dev->device, "event_cn10k", EINVAL);
 	CNXK_VALID_DEV_OR_ERR_RET(cdev->device, "crypto_cn10k", EINVAL);
 
 	cn10k_sso_fp_fns_set((struct rte_eventdev *)(uintptr_t)event_dev);
@@ -954,7 +954,7 @@ static int
 cn10k_crypto_adapter_qp_del(const struct rte_eventdev *event_dev, const struct rte_cryptodev *cdev,
 			    int32_t queue_pair_id)
 {
-	CNXK_VALID_DEV_OR_ERR_RET(event_dev->dev, "event_cn10k", EINVAL);
+	CNXK_VALID_DEV_OR_ERR_RET(event_dev->device, "event_cn10k", EINVAL);
 	CNXK_VALID_DEV_OR_ERR_RET(cdev->device, "crypto_cn10k", EINVAL);
 
 	return cnxk_crypto_adapter_qp_del(cdev, queue_pair_id);
@@ -973,7 +973,7 @@ cn10k_crypto_adapter_vec_limits(const struct rte_eventdev *event_dev,
 				const struct rte_cryptodev *cdev,
 				struct rte_event_crypto_adapter_vector_limits *limits)
 {
-	CNXK_VALID_DEV_OR_ERR_RET(event_dev->dev, "event_cn10k", EINVAL);
+	CNXK_VALID_DEV_OR_ERR_RET(event_dev->device, "event_cn10k", EINVAL);
 	CNXK_VALID_DEV_OR_ERR_RET(cdev->device, "crypto_cn10k", EINVAL);
 
 	limits->log2_sz = false;
diff --git a/drivers/event/cnxk/cn20k_eventdev.c b/drivers/event/cnxk/cn20k_eventdev.c
index ff3aaac16a..9d34168c32 100644
--- a/drivers/event/cnxk/cn20k_eventdev.c
+++ b/drivers/event/cnxk/cn20k_eventdev.c
@@ -1125,7 +1125,7 @@ static int
 cn20k_crypto_adapter_caps_get(const struct rte_eventdev *event_dev,
 			      const struct rte_cryptodev *cdev, uint32_t *caps)
 {
-	CNXK_VALID_DEV_OR_ERR_RET(event_dev->dev, "event_cn20k", ENOTSUP);
+	CNXK_VALID_DEV_OR_ERR_RET(event_dev->device, "event_cn20k", ENOTSUP);
 	CNXK_VALID_DEV_OR_ERR_RET(cdev->device, "crypto_cn20k", ENOTSUP);
 
 	*caps = RTE_EVENT_CRYPTO_ADAPTER_CAP_INTERNAL_PORT_OP_FWD |
@@ -1142,7 +1142,7 @@ cn20k_crypto_adapter_qp_add(const struct rte_eventdev *event_dev, const struct r
 {
 	int ret;
 
-	CNXK_VALID_DEV_OR_ERR_RET(event_dev->dev, "event_cn20k", EINVAL);
+	CNXK_VALID_DEV_OR_ERR_RET(event_dev->device, "event_cn20k", EINVAL);
 	CNXK_VALID_DEV_OR_ERR_RET(cdev->device, "crypto_cn20k", EINVAL);
 
 	cn20k_sso_fp_fns_set((struct rte_eventdev *)(uintptr_t)event_dev);
@@ -1157,7 +1157,7 @@ static int
 cn20k_crypto_adapter_qp_del(const struct rte_eventdev *event_dev, const struct rte_cryptodev *cdev,
 			    int32_t queue_pair_id)
 {
-	CNXK_VALID_DEV_OR_ERR_RET(event_dev->dev, "event_cn20k", EINVAL);
+	CNXK_VALID_DEV_OR_ERR_RET(event_dev->device, "event_cn20k", EINVAL);
 	CNXK_VALID_DEV_OR_ERR_RET(cdev->device, "crypto_cn20k", EINVAL);
 
 	return cnxk_crypto_adapter_qp_del(cdev, queue_pair_id);
@@ -1175,7 +1175,7 @@ cn20k_crypto_adapter_vec_limits(const struct rte_eventdev *event_dev,
 				const struct rte_cryptodev *cdev,
 				struct rte_event_crypto_adapter_vector_limits *limits)
 {
-	CNXK_VALID_DEV_OR_ERR_RET(event_dev->dev, "event_cn20k", EINVAL);
+	CNXK_VALID_DEV_OR_ERR_RET(event_dev->device, "event_cn20k", EINVAL);
 	CNXK_VALID_DEV_OR_ERR_RET(cdev->device, "crypto_cn20k", EINVAL);
 
 	limits->log2_sz = false;
diff --git a/drivers/event/cnxk/cn9k_eventdev.c b/drivers/event/cnxk/cn9k_eventdev.c
index 5f24366770..313dcbb384 100644
--- a/drivers/event/cnxk/cn9k_eventdev.c
+++ b/drivers/event/cnxk/cn9k_eventdev.c
@@ -1038,7 +1038,7 @@ static int
 cn9k_crypto_adapter_caps_get(const struct rte_eventdev *event_dev, const struct rte_cryptodev *cdev,
 			     uint32_t *caps)
 {
-	CNXK_VALID_DEV_OR_ERR_RET(event_dev->dev, "event_cn9k", ENOTSUP);
+	CNXK_VALID_DEV_OR_ERR_RET(event_dev->device, "event_cn9k", ENOTSUP);
 	CNXK_VALID_DEV_OR_ERR_RET(cdev->device, "crypto_cn9k", ENOTSUP);
 
 	*caps = RTE_EVENT_CRYPTO_ADAPTER_CAP_INTERNAL_PORT_OP_FWD |
@@ -1055,7 +1055,7 @@ cn9k_crypto_adapter_qp_add(const struct rte_eventdev *event_dev,
 {
 	int ret;
 
-	CNXK_VALID_DEV_OR_ERR_RET(event_dev->dev, "event_cn9k", EINVAL);
+	CNXK_VALID_DEV_OR_ERR_RET(event_dev->device, "event_cn9k", EINVAL);
 	CNXK_VALID_DEV_OR_ERR_RET(cdev->device, "crypto_cn9k", EINVAL);
 
 	cn9k_sso_fp_fns_set((struct rte_eventdev *)(uintptr_t)event_dev);
@@ -1070,7 +1070,7 @@ static int
 cn9k_crypto_adapter_qp_del(const struct rte_eventdev *event_dev, const struct rte_cryptodev *cdev,
 			   int32_t queue_pair_id)
 {
-	CNXK_VALID_DEV_OR_ERR_RET(event_dev->dev, "event_cn9k", EINVAL);
+	CNXK_VALID_DEV_OR_ERR_RET(event_dev->device, "event_cn9k", EINVAL);
 	CNXK_VALID_DEV_OR_ERR_RET(cdev->device, "crypto_cn9k", EINVAL);
 
 	return cnxk_crypto_adapter_qp_del(cdev, queue_pair_id);
diff --git a/drivers/event/cnxk/cnxk_eventdev.c b/drivers/event/cnxk/cnxk_eventdev.c
index 8eff2ba8e0..6f000ff49e 100644
--- a/drivers/event/cnxk/cnxk_eventdev.c
+++ b/drivers/event/cnxk/cnxk_eventdev.c
@@ -654,7 +654,7 @@ cnxk_sso_init(struct rte_eventdev *event_dev)
 		return -ENOMEM;
 	}
 
-	pci_dev = RTE_BUS_DEVICE(event_dev->dev, *pci_dev);
+	pci_dev = RTE_BUS_DEVICE(event_dev->device, *pci_dev);
 	dev->sso.pci_dev = pci_dev;
 
 	*(uint64_t *)mz->addr = (uint64_t)dev;
diff --git a/drivers/event/dlb2/pf/dlb2_pf.c b/drivers/event/dlb2/pf/dlb2_pf.c
index a498ba8c41..82075bbf0b 100644
--- a/drivers/event/dlb2/pf/dlb2_pf.c
+++ b/drivers/event/dlb2/pf/dlb2_pf.c
@@ -784,7 +784,7 @@ dlb2_eventdev_pci_init(struct rte_eventdev *eventdev)
 
 	dlb2_pf_iface_fn_ptrs_init();
 
-	pci_dev = RTE_BUS_DEVICE(eventdev->dev, *pci_dev);
+	pci_dev = RTE_BUS_DEVICE(eventdev->device, *pci_dev);
 
 	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
 		dlb2 = dlb2_pmd_priv(eventdev); /* rte_zmalloc_socket mem */
diff --git a/drivers/event/skeleton/skeleton_eventdev.c b/drivers/event/skeleton/skeleton_eventdev.c
index e07744d2f1..4292644fde 100644
--- a/drivers/event/skeleton/skeleton_eventdev.c
+++ b/drivers/event/skeleton/skeleton_eventdev.c
@@ -332,7 +332,7 @@ skeleton_eventdev_init(struct rte_eventdev *eventdev)
 	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
 		return 0;
 
-	pci_dev = RTE_BUS_DEVICE(eventdev->dev, *pci_dev);
+	pci_dev = RTE_BUS_DEVICE(eventdev->device, *pci_dev);
 
 	skel->reg_base = (uintptr_t)pci_dev->mem_resource[0].addr;
 	if (!skel->reg_base) {
diff --git a/lib/eventdev/eventdev_pmd.h b/lib/eventdev/eventdev_pmd.h
index d13cc433a7..9309dce5e1 100644
--- a/lib/eventdev/eventdev_pmd.h
+++ b/lib/eventdev/eventdev_pmd.h
@@ -156,7 +156,7 @@ struct __rte_cache_aligned rte_eventdev {
 	/**< Pointer to device data */
 	struct eventdev_ops *dev_ops;
 	/**< Functions exported by PMD */
-	struct rte_device *dev;
+	struct rte_device *device;
 	/**< Device info. supplied by probing */
 
 	uint8_t attached : 1;
diff --git a/lib/eventdev/eventdev_pmd_pci.h b/lib/eventdev/eventdev_pmd_pci.h
index 5cb5916a84..ebc7d12b1d 100644
--- a/lib/eventdev/eventdev_pmd_pci.h
+++ b/lib/eventdev/eventdev_pmd_pci.h
@@ -68,7 +68,7 @@ rte_event_pmd_pci_probe_named(struct rte_pci_driver *pci_drv,
 					"device data");
 	}
 
-	eventdev->dev = &pci_dev->device;
+	eventdev->device = &pci_dev->device;
 
 	/* Invoke PMD device initialization function */
 	retval = devinit(eventdev);
@@ -150,7 +150,7 @@ rte_event_pmd_pci_remove(struct rte_pci_device *pci_dev,
 	/* Free event device */
 	rte_event_pmd_release(eventdev);
 
-	eventdev->dev = NULL;
+	eventdev->device = NULL;
 
 	return 0;
 }
diff --git a/lib/eventdev/eventdev_pmd_vdev.h b/lib/eventdev/eventdev_pmd_vdev.h
index 4eaefa0b0b..ae1c950bed 100644
--- a/lib/eventdev/eventdev_pmd_vdev.h
+++ b/lib/eventdev/eventdev_pmd_vdev.h
@@ -67,7 +67,7 @@ rte_event_pmd_vdev_init(const char *name, size_t dev_private_size,
 			rte_panic("Cannot allocate memzone for private device"
 					" data");
 	}
-	eventdev->dev = &vdev->device;
+	eventdev->device = &vdev->device;
 
 	return eventdev;
 }
diff --git a/lib/eventdev/rte_eventdev.c b/lib/eventdev/rte_eventdev.c
index b921142d7b..572cd5bd7d 100644
--- a/lib/eventdev/rte_eventdev.c
+++ b/lib/eventdev/rte_eventdev.c
@@ -68,8 +68,8 @@ rte_event_dev_get_dev_id(const char *name)
 	for (i = 0; i < eventdev_globals.nb_devs; i++) {
 		cmp = (strncmp(rte_event_devices[i].data->name, name,
 				RTE_EVENTDEV_NAME_MAX_LEN) == 0) ||
-			(rte_event_devices[i].dev ? (strncmp(
-				rte_event_devices[i].dev->driver->name, name,
+			(rte_event_devices[i].device ? (strncmp(
+				rte_event_devices[i].device->driver->name, name,
 					 RTE_EVENTDEV_NAME_MAX_LEN) == 0) : 0);
 		if (cmp && (rte_event_devices[i].attached ==
 					RTE_EVENTDEV_ATTACHED)) {
@@ -114,9 +114,9 @@ rte_event_dev_info_get(uint8_t dev_id, struct rte_event_dev_info *dev_info)
 
 	dev_info->dequeue_timeout_ns = dev->data->dev_conf.dequeue_timeout_ns;
 
-	dev_info->dev = dev->dev;
-	if (dev->dev != NULL && dev->dev->driver != NULL)
-		dev_info->driver_name = dev->dev->driver->name;
+	dev_info->dev = dev->device;
+	if (dev->device != NULL && dev->device->driver != NULL)
+		dev_info->driver_name = dev->device->driver->name;
 
 	rte_eventdev_trace_info_get(dev_id, dev_info, dev_info->dev);
 
@@ -1812,8 +1812,8 @@ handle_dev_info(const char *cmd __rte_unused,
 
 	rte_tel_data_start_dict(d);
 	rte_tel_data_add_dict_int(d, "dev_id", dev_id);
-	rte_tel_data_add_dict_string(d, "dev_name", dev->dev->name);
-	rte_tel_data_add_dict_string(d, "dev_driver", dev->dev->driver->name);
+	rte_tel_data_add_dict_string(d, "dev_name", dev->device->name);
+	rte_tel_data_add_dict_string(d, "dev_driver", dev->device->driver->name);
 	rte_tel_data_add_dict_string(d, "state",
 		dev->data->dev_started ? "started" : "stopped");
 	rte_tel_data_add_dict_int(d, "socket_id", dev->data->socket_id);
-- 
2.53.0

