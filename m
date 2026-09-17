Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15671C982C1
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 07:50:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 124E842D83;
	Thu, 17 Sep 2026 09:49:50 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 99BF542D83
 for <dev@dpdk.org>; Thu, 17 Sep 2026 09:49:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789631388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pTO1Gjo7vj0zW1vMQJ/ApcXsgKidUP9QpEwXFuHW8Vw=;
 b=K3BKvLJWVWH5uGXU43Nu8Mk2K6LXZlt6ap1QO3EORADZt8zJ7mGNy26TWeXPuZX9EheCSi
 sAsNPZH6a1HKwZcEyrECM8Lkr/dQinhSHdwAFZkiUadGlvFyWJtJgT2rrs7lzIhuKdhW3a
 b/f3fKFeLZdqZYDN1Jwki3PeOjDi+qQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-cpz1Br37PGysEJVzFzTMHA-1; Thu,
 17 Sep 2026 03:49:44 -0400
X-MC-Unique: cpz1Br37PGysEJVzFzTMHA-1
X-Mimecast-MFC-AGG-ID: cpz1Br37PGysEJVzFzTMHA_1789631383
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 75AD819540C8; Thu, 17 Sep 2026 07:49:43 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 950131800345; Thu, 17 Sep 2026 07:49:41 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: hemant.agrawal@nxp.com,
	dev@dpdk.org
Cc: stable@dpdk.org, Sachin Saxena <sachin.saxena@nxp.com>,
 Ferruh Yigit <ferruh.yigit@amd.com>,
 Santosh Shukla <santosh.shukla@caviumnetworks.com>,
 Shreyansh Jain <shreyansh.jain@nxp.com>
Subject: [RFC v2 05/16] bus/fslmc: fix device name leak
Date: Thu, 17 Sep 2026 09:49:05 +0200
Message-ID: <20260917074917.595603-6-david.marchand@redhat.com>
In-Reply-To: <20260917074917.595603-1-david.marchand@redhat.com>
References: <20260723135400.3621271-1-david.marchand@redhat.com>
 <20260917074917.595603-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MV2UiPpldYymmd-mIyXkki3oMzsMVrl7Y2L51DknJZM_1789631383
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

The device name allocated during scan was never freed.
Store it to the (unused) name field in the rte_dpaa2_device.

This simplifies the device freeing to a simple free() call later.

Fixes: 828d51d8fc3e ("bus/fslmc: refactor scan and probe functions")
Cc: stable@dpdk.org

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/bus/fslmc/bus_fslmc_driver.h | 4 +---
 drivers/bus/fslmc/fslmc_bus.c        | 8 ++++----
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/bus/fslmc/bus_fslmc_driver.h b/drivers/bus/fslmc/bus_fslmc_driver.h
index 44f81cf662..ead9d6613c 100644
--- a/drivers/bus/fslmc/bus_fslmc_driver.h
+++ b/drivers/bus/fslmc/bus_fslmc_driver.h
@@ -39,8 +39,6 @@ extern "C" {
 
 struct vfio_device_info;
 
-#define FSLMC_OBJECT_MAX_LEN 32   /**< Length of each device on bus */
-
 #define DPAA2_INVALID_MBUF_SEQN        0
 
 typedef uint32_t dpaa2_seqn_t;
@@ -101,7 +99,7 @@ struct rte_dpaa2_device {
 	uint16_t ep_object_id;                 /**< Endpoint DPAA2 Object ID */
 	char ep_name[RTE_DEV_NAME_MAX_LEN];
 	struct rte_intr_handle *intr_handle; /**< Interrupt handle */
-	char name[FSLMC_OBJECT_MAX_LEN];    /**< DPAA2 Object name*/
+	char name[RTE_DEV_NAME_MAX_LEN];
 };
 
 typedef int (*rte_dpaa2_obj_create_t)(int vdev_fd,
diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.c
index 94ae96f942..4b0896e42e 100644
--- a/drivers/bus/fslmc/fslmc_bus.c
+++ b/drivers/bus/fslmc/fslmc_bus.c
@@ -179,12 +179,12 @@ scan_one_fslmc_device(char *dev_name)
 	}
 
 	sscanf(t_ptr, "%hu", &dev->object_id);
-	dev->device.name = strdup(dev_name);
-	if (!dev->device.name) {
-		DPAA2_BUS_ERR("Unable to clone device name. Out of memory");
-		ret = -ENOMEM;
+	if (rte_strscpy(dev->name, dev_name, sizeof(dev->name)) < 0) {
+		DPAA2_BUS_ERR("Unable to copy device name: %s", rte_strerror(rte_errno));
+		ret = -rte_errno;
 		goto cleanup;
 	}
+	dev->device.name = dev->name;
 	dev->device.devargs = rte_bus_find_devargs(&rte_fslmc_bus, dev_name);
 
 	/* Update the device found into the device_count table */
-- 
2.54.0

