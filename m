Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 593BDCDE002
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 10:44:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5EC0B40A67;
	Wed, 24 Jun 2026 12:44:20 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 2277740A67
 for <dev@dpdk.org>; Wed, 24 Jun 2026 12:44:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782297858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZuoijZNf2BsY3ItAGBUJkjXcDNXMYZaorZVpCxbhVFc=;
 b=BcnKeyOpB3ogkB9DVMOOhhzHDy9baDvphBzVuUKPeuNI1kHydhYKQhTPTTkTA3pnZhe/Bj
 rbhFgi/GmWkx5Dy9YNgq5J2LmhemkBUpcHEucMMSaMGnV8V1lcKCnWK+YrBeL7tKoqj9RU
 CtE5zo29SWJol0Fx7+AqiM4pXSprMWc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-eu_gJPS1NmygoZngDspWFw-1; Wed,
 24 Jun 2026 06:44:13 -0400
X-MC-Unique: eu_gJPS1NmygoZngDspWFw-1
X-Mimecast-MFC-AGG-ID: eu_gJPS1NmygoZngDspWFw_1782297852
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BB5F11956063; Wed, 24 Jun 2026 10:44:11 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.48.202])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3F30C180049F; Wed, 24 Jun 2026 10:44:09 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, stephen@networkplumber.org,
 bruce.richardson@intel.com, fengchengwen@huawei.com, longli@microsoft.com,
 hemant.agrawal@nxp.com, Wei Hu <weh@microsoft.com>
Subject: [PATCH v4 07/12] bus/vmbus: allocate interrupt during probing
Date: Wed, 24 Jun 2026 12:43:18 +0200
Message-ID: <20260624104324.3576408-8-david.marchand@redhat.com>
In-Reply-To: <20260624104324.3576408-1-david.marchand@redhat.com>
References: <20260611094551.1514962-1-david.marchand@redhat.com>
 <20260624104324.3576408-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OVoPKZh5BExJFq_3EBCIEDx5kcBveGCBblRJ4hX9yXk_1782297852
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

Allocating the interrupt handle is a waste of memory if no device is
probed later (like for example, if a allowlist is passed).
Instead, allocate this handle at the time probe_device is called.

Signed-off-by: David Marchand <david.marchand@redhat.com>
Reviewed-by: Long Li <longli@microsoft.com>
---
Changes since v1:
- fixed/reordered interrupt handle allocation,

---
 drivers/bus/vmbus/linux/vmbus_bus.c |  6 ------
 drivers/bus/vmbus/vmbus_common.c    | 18 ++++++++++++++++--
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/bus/vmbus/linux/vmbus_bus.c b/drivers/bus/vmbus/linux/vmbus_bus.c
index 0af10f6a69..77d904ad6d 100644
--- a/drivers/bus/vmbus/linux/vmbus_bus.c
+++ b/drivers/bus/vmbus/linux/vmbus_bus.c
@@ -345,12 +345,6 @@ vmbus_scan_one(const char *name)
 		}
 	}
 
-	/* Allocate interrupt handle instance */
-	dev->intr_handle =
-		rte_intr_instance_alloc(RTE_INTR_INSTANCE_F_PRIVATE);
-	if (dev->intr_handle == NULL)
-		goto error;
-
 	/* device is valid, add in list (sorted) */
 	VMBUS_LOG(DEBUG, "Adding vmbus device %s", name);
 
diff --git a/drivers/bus/vmbus/vmbus_common.c b/drivers/bus/vmbus/vmbus_common.c
index 74c1ddff69..bfb45e963c 100644
--- a/drivers/bus/vmbus/vmbus_common.c
+++ b/drivers/bus/vmbus/vmbus_common.c
@@ -100,10 +100,16 @@ vmbus_probe_device(struct rte_driver *drv, struct rte_device *dev)
 		return 1;
 	}
 
+	/* allocate interrupt handle instance */
+	vmbus_dev->intr_handle =
+		rte_intr_instance_alloc(RTE_INTR_INSTANCE_F_PRIVATE);
+	if (vmbus_dev->intr_handle == NULL)
+		return -ENOMEM;
+
 	/* map resources for device */
 	ret = rte_vmbus_map_device(vmbus_dev);
 	if (ret != 0)
-		return ret;
+		goto free_intr;
 
 	if (vmbus_dev->device.numa_node < 0 && rte_socket_count() > 1)
 		VMBUS_LOG(INFO, "Device %s is not NUMA-aware", guid);
@@ -112,7 +118,15 @@ vmbus_probe_device(struct rte_driver *drv, struct rte_device *dev)
 	VMBUS_LOG(INFO, "  probe driver: %s", vmbus_drv->driver.name);
 	ret = vmbus_drv->probe(vmbus_drv, vmbus_dev);
 	if (ret != 0)
-		rte_vmbus_unmap_device(vmbus_dev);
+		goto unmap;
+
+	return 0;
+
+unmap:
+	rte_vmbus_unmap_device(vmbus_dev);
+free_intr:
+	rte_intr_instance_free(vmbus_dev->intr_handle);
+	vmbus_dev->intr_handle = NULL;
 
 	return ret;
 }
-- 
2.54.0

